package main

import "../../Toxin"
import "../../Toxin/classes"
import Classes "../../GD_Classes"
import GDW "../../GDWrapper"
import GDE "../../GDWrapper/gdAPI/gdextension"
import "../../GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import Math "core:math"
import rand "core:math/rand"

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

Performance: ^Toxin.Object

printonce:bool=true
sprite_count::20000
frame_count_amout::1000
frame_times:[frame_count_amout]f64
frame_current:int=0

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    perf:Toxin.float = classes.Node_get_process_delta_time( root )
/*
    is_centered:Toxin.Bool=true
    for class in class_list {
        //fmt.println(class)
        class.class.position.x+=Math.cos_f32(f32(class.class.angle))*f32(perf)*f32(class.class.speed)
        class.class.position.y+=Math.sin_f32(f32(class.class.angle))*f32(perf)*f32(class.class.speed)
        Node2D_Class.set_position->m_call(class.self, {&class.class.position})
        if class.class.position.x > class.class.window.x - class.class.size.x || class.class.position.x < class.class.size.x do class.class.angle = Math.PI - class.class.angle
        if class.position.y > class.window.y - class.size.y || class.position.y < class.size.y do class.angle = -class.angle
        //Texture_Class.is_centered->m_call(class.self, r_ret= &is_centered)
    }
*/
    //fmt.println(is_centered)
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
}

root:^Toxin.Object
main_loop_startup :: proc "c" () {
    context = runtime.default_context()
    /////////////////////////////////////////////////
    //DO NOT USE THIS WITH OPTIMIZED CODE!!!!!
    //Will take 5 minutes to compile because it loads all the init procs ._.
    /////////////////////////////////////////////////
    //Classes.INIT_ALL_OF_THEM()
    Classes.Sprite2D_Init_()
    Classes.Node2D_Init_()
    Classes.Node_Init_()
    Classes.Performance_Init_()

    //TODO: fix the singleton getters.
    //GDW.getPhysServer2dObj()
    //GDW.getRenderServer2dObj()
    //GDW.class_get_method_list()
    //GDW.getInputSingleton()
    //Hold the MainLoop object.
    scene_tree_obj = Toxin.getMainLoop()
    //GDW.init_InputEvent()

    //Fetch the root of the current sceneTree
    root= Toxin.getRoot()
    scene:= Toxin.get_current_scene()
    Classes.Window_Init_()

    //Performance = GDW.getPerformance()
    //fmt.println("Performance ", Performance)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
    if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<sprite_count {
            root_node_instance := gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            readable:Toxin.Bool
            internal_mode:Classes.Node_InternalMode=.INTERNAL_MODE_DISABLED
            classes.Node_add_child(root, &root_node_instance, &readable, &internal_mode)
        }
        fmt.println(len(class_list))
    };
};;