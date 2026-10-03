package main

import "../../Toxin"
import "../../Toxin/classes"
import Classes "../../GD_Classes"
import GDW "../../GDWrapper"
import "../../GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import "core:math"
import GDE "shared:Toxin/GDWrapper/gdAPI/gdextension"


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

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object
root:^Toxin.Object

printonce:bool=true
frame_count_amout::2000
frame_times:[frame_count_amout]f64
frame_current:int=0

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    perf : Toxin.float = classes.Node_get_process_delta_time(root)

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
        exit_code:Toxin.Int=0
        classes.SceneTree_quit(scene_tree_obj, &exit_code)
    }
}

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
    Classes.PhysicsServer2D_Init_()
    Classes.Viewport_Init_()
    Classes.World2D_Init_()
    Classes.CanvasItem_Init_()
    Classes.Texture2D_Init_()
    Classes.CanvasGroup_Init_()
    Classes.SceneTree_Init_()
    Classes.ImageTexture_Init_()
    Classes.Image_Init_()
    
    path:Toxin.gdstring
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(&path, raw_data(string("./icon.svg")), len("./icon.svg"))
    image = classes.Image_load_from_file(nil, &path)
    GDW.gdstring_M_List.Destroy(&path)

    //indx_ret: Variant
    //default_Array_class->GetIndex(0, &indx_ret)
    //TODO: fix the singleton getters.
    Toxin.init_PhysicsServer2D_procs()
    //GDW.getRenderServer2dObj()
    //GDW.class_get_method_list()
    //GDW.getInputSingleton()
    //Setup an object to hold the MainLoop object.
    scene_tree_obj = Toxin.getMainLoop()
    //GDW.init_InputEvent()
    //Fetch the root of the current sceneTree
    root= Toxin.getRoot()
    scene:= Toxin.get_current_scene()
    classes.Window_Init()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
    readable:Toxin.Bool
    internal_mode:Classes.Node_InternalMode=.INTERNAL_MODE_DISABLED
    classes.Node_add_child(root, &root_node_instance, &readable, &internal_mode)

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
};;

main_loop_shutdown :: proc "c" () {
    context = runtime.default_context()
    gdAPI.Object_Utils.Destroy(image)
}