package main

import "../../Toxin"
import Classes "../../GD_Classes"
//import Classes "../../GD_Classes"
import GDW "../../GDWrapper"
import GDE "../../GDWrapper/gdAPI/gdextension"
import "../../GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import class "../../Toxin/classes"


@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) -> b8 {
    context = runtime.default_context()
    return Toxin.toxin_entry(p_get_proc_address, p_library, initialization, &core_setup)
}

//@(rodata)
core_setup: Toxin.inits_deinits= {
    nil,
    core_init,
    servers_init,
    scene_init,
    editor_init,
    core_deinit,
    servers_deinit,
    scene_deinit,
    editor_deinit,
    {},
}
core_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()

    Toxin.register_mainloop_callbacks({main_loop_startup, main_loop_shutdown, MainLoopFrameCallback,})
}

servers_init :: proc "c" (userdata: rawptr) {

}

scene_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
    append(&core_setup.classes.scene, &THIS_CLASS_NAME_deets)
}
editor_init :: proc "c" (userdata: rawptr) {

}
core_deinit :: proc "c" (userdata: rawptr) {

}
servers_deinit :: proc "c" (userdata: rawptr) {

}
scene_deinit :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
}
editor_deinit :: proc "c" (userdata: rawptr) {

}

main_loop_shutdown :: proc "c" () {
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object


last_delta:Toxin.float //Each class is assigning their delta time to this, probably a better way. Might be affecting performance. It is the simple way.
printonce:bool=true
sprite_count::20000
frame_count_amout::3000
frame_times:[frame_count_amout]f64
frame_current:int=0


is_center_: is_center
is_center :: struct {
    using _is_center : ^GDW.MethodBind,
    is_center : proc"c" (p_method_bind: ^GDW.MethodBind, p_instance: GDE.ObjectPtr, p_args: rawptr=nil, #by_ptr r_ret: Toxin.Bool),
}

set_position_ :set_position
set_position:: struct {
    using _set_position: ^GDW.MethodBind,
    set_position: proc "c" (p_method_bind: ^GDW.MethodBind, p_instance: GDE.ObjectPtr, #by_ptr p_args: struct{_:^Toxin.Vector2}, r_ret: GDE.TypePtr = nil),
}


MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    r_ret:Toxin.Vector2
    vec2:Toxin.Vector2 = {32, 73}
    indx:Toxin.Int=0
    set:Toxin.Vector2={0, 32}
    args:=[?]rawptr{&indx, &set}
    ref:Toxin.Object
    barl: Toxin.Bool
    varintttt:Toxin.Variant
    arg:=[?]rawptr{&vec2}
    murray: Toxin.PackedVector2Array

    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)refcounted.init_ref, &ref, nil, &barl)
    //GDW.new_variant_from_methods(&varintttt, &murray)
    //GDW.PackedVector2Array_M_List.Create1(&murray, &murray)
    
    //fmt.println("murray: ", murray)
    //fmt.println("address: ", &murray)
    //GDW.PackedVector2Array_M_List.append(&murray, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedVector2Array_M_List.append(&murray, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedVector2Array_M_List.append(&murray, raw_data(arg[:]),&r_ret, 1)
    //fmt.println("address: ", &murray)
    //GDW.PackedVector2Array_M_List.set(&murray, raw_data(args[:]),&r_ret, 2)
    //fmt.println(r_ret)
    //GDW.PackedVector2Array_M_List.get(&murray, raw_data(args[:]),&r_ret, 1)
    //fmt.println("address: ", &murray)
    //fmt.println(r_ret)
    //fmt.println("address: ", &murray)
    //fmt.println("gone.")
    //fmt.println("murray: ", murray)
    //fmt.println("rptr: ", r_ret)
    perf:Toxin.float=0
    perf = class.Node_get_process_delta_time(root)

    if frame_current < frame_count_amout {
        frame_times[frame_current] = perf
        frame_current+=1
    } else if printonce {
        printonce = false
        total:f64

        for t in frame_times[:] do total+=t

        fmt.println(frame_times[:])
        fmt.println(total/frame_count_amout)
    }

}
root:^Toxin.Object

main_loop_startup :: proc "c" () {
    context = runtime.default_context()

    Classes.Sprite2D_Init_()
    Classes.Node2D_Init_()
    Classes.Node_Init_()
    Classes.Window_Init_()

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = Toxin.getMainLoop()
    //Fetch the root of the current sceneTree
    root= Toxin.getRoot()
    //scene:= Toxin.get_current_scene()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.

};