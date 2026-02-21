package main

import "shared:Toxin"
//import Classes "shared:Godot_Odin_Binds/GD_Classes"
import Classes "../../GD_Classes"
import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"

init:: proc ()  {

    Toxin.myMainLoopCallbacks.startup_func = MainLoopStartupCallback
    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)

    //Register custom class.
    THIS_CLASS_NAME_deets.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object

//Using these class methods.
texture: Classes.Texture2D
Texture_Class: Classes.Sprite2D_MethodBind_List
Node2D_Class: Classes.Node2D_MethodBind_List
Node_Class: Classes.Node_MethodBind_List
Window_MethodBind_List: Classes.Window_MethodBind_List
refcounted: Classes.RefCounted_MethodBind_List


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
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_Class.get_process_delta_time, root, nil, &perf)

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
MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()

    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.Window_Init_(&Window_MethodBind_List)


    is_center_.is_center = cast(type_of(is_center_.is_center))gdAPI.Object_Utils.MethodBindPtrcall
    is_center_._is_center = Texture_Class.is_centered
    Classes.Window_Init_(&Window_MethodBind_List)
    set_position_.set_position = cast(type_of(set_position_.set_position))gdAPI.Object_Utils.MethodBindPtrcall
    set_position_._set_position = Texture_Class.is_centered

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = GDW.getMainLoop()
    //Fetch the root of the current sceneTree
    root= GDW.getRoot()
    //scene:= GDW.get_current_scene()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.

};;