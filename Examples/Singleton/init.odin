package main

import "shared:Toxin"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:fmt"
import "base:runtime"
import "core:math"

init:: proc ()  {
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets

    Toxin.myMainLoopCallbacks.startup_func = MainLoopStartupCallback
    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)

    ClassDB:Toxin.StringName
    gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "Engine", false)
    defer(GDW.StringName_M_List.Destroy(&ClassDB))
    myEngine= gdAPI.GlobalGetSingleton(&ClassDB)

    Classes.Engine_Init_(&Engine_Class)

    //Register custom class.
    THIS_CLASS_NAME_deets.registerer->self_register(.INITIALIZATION_SCENE)
    THIS_CLASS_NAME_deets2.registerer->self_register(.INITIALIZATION_SCENE)


    this_class= THIS_CLASS_NAME_deets.create(&THIS_CLASS_NAME_deets,true)
    fmt.println(myEngine)
    name_copy:Toxin.StringName
    GDW.StringConstruct(&name_copy, "muhsingle")
    Engine_Class.register_singleton->m_call(myEngine, {&name_copy, &this_class})
}


@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object
root:^Toxin.Object
myEngine: ^Toxin.Object
this_class: ^Toxin.Object

Engine_Class: Classes.Engine_MethodBind_List

printonce:bool=true
frame_count_amout::2000
frame_times:[frame_count_amout]f64
frame_current:int=0

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
}

MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    /////////////////////////////////////////////////
    //DO NOT USE THIS WITH OPTIMIZED CODE!!!!!
    //Will take 5 minutes to compile because it loads all the init procs ._.
    /////////////////////////////////////////////////
    //Classes.INIT_ALL_OF_THEM()

    scene_tree_obj = GDW.getMainLoop()
    //Fetch the root of the current sceneTree
    root= GDW.getRoot()
    scene:= GDW.get_current_scene()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
    //GDW.addChild(root, &root_node_instance)

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
};;