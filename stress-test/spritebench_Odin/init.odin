package main

import "shared:Toxin"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import "core:math"

init:: proc ()  {
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets


    Toxin.myMainLoopCallbacks.startup_func = MainLoopStartupCallback
    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    Toxin.myMainLoopCallbacks.shutdown_func = MainLoopShutdownCallback
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)

    //Register custom class.
    THIS_CLASS_NAME_deets.required.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object
root:^Toxin.Object

//Using these class methods.
texture: Classes.Texture2D
Texture_Class: Classes.Sprite2D_MethodBind_List
Node2D_Class: Classes.Node2D_MethodBind_List
Node_Class: Classes.Node_MethodBind_List
SceneTree_Class: Classes.SceneTree_MethodBind_List
image_Class: Classes.Image_MethodBind_List
texture_Class: Classes.ImageTexture_MethodBind_List

printonce:bool=true
sprite_count::20000
frame_count_amout::1000
frame_times:[frame_count_amout]f64
frame_current:int=0

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()

    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.SceneTree_Init_(&SceneTree_Class)
    Classes.ImageTexture_Init_(&texture_Class)
    Classes.Image_Init_(&image_Class)
    
    //Doing it this way otherwise need to run an import from the editor in order to get the icon file.
    image: Classes.Image
    path:Toxin.gdstring
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(&path, raw_data(string("./icon.svg")), len("./icon.svg"))
    image_Class.load_from_file->m_call(nil, {&path}, &image)
    GDW.gdstring_M_List.Destroy(&path)
    texture_Class.create_from_image->m_call(nil, {&image}, &texture)
    gdAPI.Object_Utils.Destroy(image)

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = GDW.getMainLoop()
    //Fetch the root of the current sceneTree
    root= GDW.getRoot()
    scene:= GDW.get_current_scene()
    Classes.Window_Init_(&Window_MethodBind_List)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //A scene is not added when running editor mode unless there is already a default scene. Check for the scene before trying to add the child to it.
    if root != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<sprite_count {
            root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            GDW.addChild(root, &root_node_instance)
        }
    };

    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback2
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)
    
}

//no need to do an if check.
MainLoopFrameCallback2 :: proc "c" () {
    context = runtime.default_context()
    perf:Toxin.float=0
    Node_Class.get_process_delta_time->m_call(root, r_ret = &perf)
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
        SceneTree_Class.quit->m_call(scene_tree_obj, {&exit_code})
    }
}

//If running directly from the script this does not run.
MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
};;

MainLoopShutdownCallback :: proc "c" () {
    context = runtime.default_context()
    gdAPI.Object_Utils.Destroy(texture)
}