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
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)

    //Register custom class.
    THIS_CLASS_NAME_deets.required.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object
root:^Toxin.Object

//Using these class methods.
Texture_Class: Classes.Sprite2D_MethodBind_List
Node_Class: Classes.Node_MethodBind_List
Node2D_Class: Classes.Node2D_MethodBind_List
Viewport_Class: Classes.Viewport_MethodBind_List
CanvasItem_Class: Classes.CanvasItem_MethodBind_List
CanvasGroup_Class: Classes.CanvasGroup_MethodBind_List
SceneTree_Class: Classes.SceneTree_MethodBind_List

Phys2D_Server: Classes.PhysicsServer2D_MethodBind_List
World2D_Class: Classes.World2D_MethodBind_List
Texture2D_Class: Classes.Texture2D_MethodBind_List
image_Class: Classes.Image_MethodBind_List
texture_Class: Classes.ImageTexture_MethodBind_List

printonce:bool=true
frame_count_amout::2000
frame_times:[frame_count_amout]f64
frame_current:int=0

MainLoopFrameCallback :: proc "c" () {
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

MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    /////////////////////////////////////////////////
    //DO NOT USE THIS WITH OPTIMIZED CODE!!!!!
    //Will take 5 minutes to compile because it loads all the init procs ._.
    /////////////////////////////////////////////////
    //Classes.INIT_ALL_OF_THEM()
    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.PhysicsServer2D_Init_(&Phys2D_Server)
    Classes.Viewport_Init_(&Viewport_Class)
    Classes.World2D_Init_(&World2D_Class)
    Classes.CanvasItem_Init_(&CanvasItem_Class)
    Classes.Texture2D_Init_(&Texture2D_Class)
    Classes.CanvasGroup_Init_(&CanvasGroup_Class)
    Classes.SceneTree_Init_(&SceneTree_Class)
    Classes.ImageTexture_Init_(&texture_Class)
    Classes.Image_Init_(&image_Class)
    
    path:Toxin.gdstring
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(&path, raw_data(string("./icon.svg")), len("./icon.svg"))
    image_Class.load_from_file->m_call(nil, {&path}, &image)
    GDW.gdstring_M_List.Destroy(&path)

    //indx_ret: Variant
    //default_Array_class->GetIndex(0, &indx_ret)
    //TODO: fix the singleton getters.
    Toxin.getPhysServer2dObj()
    //GDW.getRenderServer2dObj()
    //GDW.class_get_method_list()
    //GDW.getInputSingleton()
    //Setup an object to hold the MainLoop object.
    scene_tree_obj = GDW.getMainLoop()
    //GDW.init_InputEvent()
    //Fetch the root of the current sceneTree
    root= GDW.getRoot()
    scene:= GDW.get_current_scene()
    Classes.Window_Init_(&Window_MethodBind_List)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
    GDW.addChild(root, &root_node_instance)

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
};;

MainLoopShutdownCallback :: proc "c" () {
    context = runtime.default_context()
    gdAPI.Object_Utils.Destroy(image)
}