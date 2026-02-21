package main

import "../../src/Toxin"
import Classes "../../GD_Classes"
//import Classes "shared:Godot_Odin_Binds/GD_Classes"
import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import Math "core:math"
import rand "core:math/rand"

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

Performance: ^Toxin.Object
Performance_Class: Classes.Performance_MethodBind_List

last_delta:Toxin.float
printonce:bool=true
time_desired:Classes.Monitor_Performance=.TIME_PROCESS

call :: proc "c" (p_method_bind: GDE.MethodBindPtr, p_instance: GDE.ObjectPtr, #by_ptr p_args: struct{_:^Toxin.Vector2}, r_ret: GDE.TypePtr)
callit:call
is_center_T :: proc"c" (p_method_bind: GDE.MethodBindPtr, p_instance: GDE.ObjectPtr, p_args: rawptr=nil, #by_ptr r_ret: Toxin.Bool)
is_center:is_center_T
//args: ^struct{_:^Toxin.Int},
passthrough :: #force_inline proc(obj: ^GDE.Object,  r_ret: ^Toxin.Bool) {
    #force_inline gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Texture_Class.is_centered, obj, nil, r_ret)
}
passthrough2 :: #force_inline proc(obj: ^GDE.Object, args: ^struct{_:^Toxin.Vector2}) {
    #force_inline gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node2D_Class.set_position, obj, cast([^]rawptr)args, nil)
}

is_center_: struct {
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
    perf:Toxin.float=0
    //want:=[1]rawptr{&time_desired}
    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Performance_Class.get_monitor, Performance, raw_data(want[:]), &perf)
    #force_inline gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_Class.get_process_delta_time, root, nil, &perf)
    //get_process_delta_time
    //if last_delta != perf {
        //fmt.printfln("mismatch: delta %v, perf %v", last_delta, perf)
    //}
    //pos:Toxin.Vector2 = {24, 24}
    //data:=[1]rawptr {&pos}
    //fmt.println(data)

    is_centered:Toxin.Bool=true
//    for class in class_list {
//        //fmt.println(class)
//        //passthrough(class.self, &is_centered)
//        //set:=[?]rawptr{&class.class.position}
//        class.class.position.x+=Math.cos_f32(f32(class.class.angle))*f32(perf)*f32(class.class.speed)
//        class.class.position.y+=Math.sin_f32(f32(class.class.angle))*f32(perf)*f32(class.class.speed)
////
//        ////gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node2D_Class.set_position, class.self, raw_data(set[:]), nil)
//        //callit(cast(GDE.MethodBindPtr)Node2D_Class.set_position, class.self, {&class.class.position}, nil)
//        passthrough2(class.self, &({&class.position}))
//        if class.class.position.x > class.class.window.x - class.class.size.x || class.class.position.x < class.class.size.x do class.class.angle = Math.PI - class.class.angle
//        if class.position.y > class.window.y - class.size.y || class.position.y < class.size.y do class.angle = -class.angle
//        //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Texture_Class.is_centered, class.self, nil, &is_centered)
//        //is_center(cast(GDE.MethodBindPtr)Texture_Class.is_centered, class.self, r_ret= is_centered)
//        //is_center_->is_center(class.self, r_ret= is_centered)
//        
//        //fmt.println(is_centered)
//        //is_centered=false
//    }
    //fmt.println(is_centered)
    if frame_current < 3000 {
        frame_times[frame_current] = perf
        frame_current+=1
    } else if printonce {
        printonce = false
        total:f64
        for t in frame_times[:] {
            total+=t
        }
        fmt.println(frame_times[:])
        fmt.println(total/3000)
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
    Classes.Performance_Init_(&Performance_Class)

    set_position_.set_position = cast(type_of(set_position_.set_position))gdAPI.Object_Utils.MethodBindPtrcall
    set_position_._set_position = Node2D_Class.set_position
    
    callit=cast(call)gdAPI.get_Interface_Address("object_method_bind_ptrcall")
    //fmt.println("callit: ",callit)
    //fmt.println("gdAPI MBcall: ",gdAPI.Object_Utils.MethodBindPtrcall)
    is_center=cast(is_center_T)gdAPI.Object_Utils.MethodBindPtrcall
    is_center_.is_center = cast(type_of(is_center_.is_center))gdAPI.Object_Utils.MethodBindPtrcall
    is_center_._is_center = Texture_Class.is_centered
    fmt.println(callit)
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

    Performance = GDW.getPerformance()
    fmt.println("Performance ", Performance)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
    if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<frame_count {
            root_node_instance := gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            GDW.addChild(root, &root_node_instance)
        }
        fmt.println(len(class_list))
    };
};;