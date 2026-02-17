package main

import "../../src/Toxin"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"

init:: proc ()  {
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets


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


last_delta:Toxin.float
printonce:bool=true
MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    if frame_current < 1000 {
        frame_times[frame_current] = last_delta
        frame_current+=1
    } else if printonce {
        printonce = false
        total:f64
        for t in frame_times[:] {
            total+=t
        }
        fmt.println(frame_times[:])
        fmt.println(total/1000)
    }
}
root:^Toxin.Object
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

    //indx_ret: Variant
    //default_Array_class->GetIndex(0, &indx_ret)
    //TODO: fix the singleton getters.
    //GDW.getPhysServer2dObj()
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
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
    if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<frame_count {
            root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            GDW.addChild(root, &root_node_instance)
        }
    };
};;