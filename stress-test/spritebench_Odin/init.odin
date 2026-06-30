package main

import "../../Toxin"
import Classes "../../GD_Classes"
import class "../../Toxin/classes"
import GDW "../../GDWrapper"
import GDE "../../GDWrapper/gdAPI/gdextension"
import "../../GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import "core:math"

@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) -> b8 {
    context = runtime.default_context()
    //Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets

    fmt.println("aaaaaaaa")

    myMainLoopCallbacks.startup_func = MainLoopStartupCallback
    myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    myMainLoopCallbacks.shutdown_func = MainLoopShutdownCallback
//
    ////Register custom class.
    append(&core_setup.classes.scene, &THIS_CLASS_NAME_deets)
    return Toxin.toxin_entry(p_get_proc_address, p_library, initialization, &core_setup)
    //return true
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
    Toxin.register_mainloop_callbacks(myMainLoopCallbacks)
}

servers_init :: proc "c" (userdata: rawptr) {

}

scene_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
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
w_size: Toxin.Vector2i
tex_size: Toxin.Vector2i
texture: Classes.Texture2D

printonce:bool=true
sprite_count::20000
frame_count_amout::1000
frame_times:[frame_count_amout]f64
frame_current:int=0

myMainLoopCallbacks:GDE.MainLoopCallbacks

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()

    fmt.println("frame callback")
    //Doing it this way otherwise need to run an import from the editor in order to get the icon file.
    image: Classes.Image
    path:Toxin.gdstring
    path=Toxin.gdstring_new("./icon.svg")
    //gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(&path, raw_data(string("./icon.svg")), len("./icon.svg"))
    image=class.Image_load_from_file(nil, &path)
    GDW.gdstring_M_List.Destroy(&path)
    texture=class.ImageTexture_create_from_image(nil, &image)

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = Toxin.getMainLoop()
    //Fetch the root of the current sceneTree
    root= Toxin.getRoot()
    scene:= Toxin.get_current_scene()
    w_size=class.Window_get_size(root)
    tex_size=class.Image_get_size(texture)
    if tex_size == {} {
        tex_size = {64,64}
    }
    fmt.println(tex_size)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //A scene is not added when running editor mode unless there is already a default scene. Check for the scene before trying to add the child to it.
    //if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<sprite_count {
            root_node_instance = Toxin.instantiate(&THIS_CLASS_NAME_deets.SN)
            readable:Toxin.Bool
            internal_mode:Classes.Node_InternalMode=.INTERNAL_MODE_DISABLED
            class.Node_add_child(root, &root_node_instance, &readable,&internal_mode)
        }
    //};

    myMainLoopCallbacks.frame_func = MainLoopFrameCallback2
    Toxin.register_mainloop_callbacks(myMainLoopCallbacks)
    
}

//no need to do an if check.
MainLoopFrameCallback2 :: proc "c" () {
    context = runtime.default_context()
    perf:Toxin.float=0
    perf=class.Node_get_process_delta_time(root,)
    if frame_current > 1000 {
        if frame_current < frame_count_amout + 1000 {
            frame_times[frame_current-1000]=class.Node_get_process_delta_time(root)
        } else if printonce {
            printonce = false
            total:f64
            for t in frame_times[:] {
                total+=t
            }
            fmt.println(frame_times[:])
            fmt.println(total/frame_count_amout)
            exit_code:Toxin.Int=0
            class.SceneTree_quit(scene_tree_obj, &exit_code)
        }
    }
    frame_current+=1
    //if frame_current <= 1000{
    //frame_current+=1}
}

//If running directly from the script this does not run.
MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    fmt.println("startup")
    class.Window_Init()
    class.Sprite2D_Init()
    class.Node2D_Init()
    class.Node_Init()
    class.SceneTree_Init()
    class.ImageTexture_Init()
    class.Image_Init()
    size:Toxin.Vector2i
};;

MainLoopShutdownCallback :: proc "c" () {
    context = runtime.default_context()
    Toxin.Destroy(texture)
}