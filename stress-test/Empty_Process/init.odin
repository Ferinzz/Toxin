package main

import "../../Toxin"
import Classes "../../GD_Classes"
import GDW "../../GDWrapper"
import "../../GDWrapper/gdAPI"
import GDE "../../GDWrapper/gdAPI/gdextension"
import class "../../Toxin/classes"
import "core:fmt"
import "base:runtime"
import "core:math"

@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) -> b8 {
    context = runtime.default_context()
    return Toxin.toxin_entry(p_get_proc_address, p_library, initialization, &core_setup)
}


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

//This is the best time to initialize the class methods as it will consistently be called after all classes have been added to the classDB
//Exception: if you're doing extension reloading this would not trigger
main_loop_startup :: proc "c" () {
    context = runtime.default_context()

    Classes.Sprite2D_Init_()
    Classes.Node2D_Init_()
    Classes.Node_Init_()

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = Toxin.getMainLoop()

    //Fetch the root of the current sceneTree
    root= Toxin.getRoot()
    scene:= Toxin.get_current_scene()
    Classes.Window_Init_()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
    if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<sprite_count {
            root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            readable:Toxin.Bool
            internal_mode:Classes.Node_InternalMode=.INTERNAL_MODE_DISABLED
            class.Node_add_child(root, &root_node_instance, &readable, &internal_mode)
        }
    };


    Classes.Node_Init_()
}

main_loop_shutdown :: proc "c" () {
}

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    perf:Toxin.float=0
    perf = class.Node_get_process_delta_time(root)
    if frame_current < frame_count_amout {
        frame_times[frame_current] = perf
        frame_current+=1
    } else if printonce {
        printonce = false
        total:f64
        for t in frame_times[:] {
            total+=t
        }
        fmt.println(frame_times[:])
        fmt.println(total/frame_count_amout)
    }
    //fmt.println("main")

}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object


printonce:bool=true
sprite_count::50000
frame_count_amout::2000
frame_times:[frame_count_amout]f64
frame_current:int=0
root:^Toxin.Object