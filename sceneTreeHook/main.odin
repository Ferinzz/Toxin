package main

import "core:fmt"
import sics "base:intrinsics"
import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import str "core:strings"
import s "core:slice"
import "core:unicode/utf8"
import "core:math/linalg"

/*
* This example shows one of the ways you can hook into the scentTree's loop.
* This method creates a sceneTree custom class and sets a connection to its own physics_frame signal.
* WARNING :: This does require overriding the mainLoop value in Godot's project settings. Project Settings -> Run -> Replace the SceneTree with treeHook. (Or whatever you name your sceneTree class)
* Key points.
* 1) Extensions load before the mainloop and scenetree get setup. Make sure to fetch mainLoop after it has been set by Godot.
* 2) Fetching the sceneTree with the Node's method returns a refCount object. Still not sure how to resolve this to the objectPtr itself.
* 3) Overriding the _process function will screw up Godot's logic. Do not do this unless you're replacing all the logic it would have.
* 4) Careful about versioning. I was pulling an older version of the api at first, then found out the connect method changed significantly with the new version I'm using.
* 5) There will be no success message when registering a Singleton, but there will be a warning when you register the same one twice.
* 6) Singletons are basically just a way to create globals. If you have some values you want to make public to GDScript, this would be the way. (variable and methods)
* 7) You won't see it printing from the callback unless you run the game directly from CLI. This is why there is "args": [ "--path ./TopDown"], in the .launch.json
* Main's init process is (in an abreviated description)
* Check what main_loop_type is specified in the setting.
* If no type is specified, use SceneTree.
* Checks if script isn't empty -> If not, will use the specifed script as the mainLoop
* Set mainLoop to class specified in main_loop_type.
* Check if class exists in classDB.
* If it does -> Instantiate (This is why we don't need to create it ourselves at any specific time.)
* Cast type to mainLoop.
* Set as singleton.
* Cast to SceneTree type.
*/

treeHook :: struct {
    selfPtr: GDE.ObjectPtr,
    refCount: u64
}


@export
godot_entry_init :: proc "c" (p_get_proc_address : GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, r_initialization: ^GDE.Initialization) {
    context = runtime.default_context()
    
    GDW.Library = p_library
    fmt.println(GDW.Library)
    GDW.loadAPI(p_get_proc_address)

    r_initialization.initialize     = initialize_gdexample_module
    r_initialization.deinitialize   = deinitialize_gdexample_module
    r_initialization.userdata     = nil
    r_initialization.minimum_initialization_level = .INITIALIZATION_SCENE

}

initialize_gdexample_module :: proc "c" (userdata: rawptr, p_level: GDE.InitializationLevel) {
    context = runtime.default_context()
    if p_level != .INITIALIZATION_SCENE{
        return
    }

    
    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "treeHook", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "SceneTree", false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    class_info: GDE.ClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &stringraw, //For some reason does not work with UTF8 strings??
        set_func = nil,
        get_func = nil,
        get_property_list_func = nil,
        free_property_list_func = nil,
        property_can_revert_func = nil,
        property_get_revert_func = nil,
        validate_property_func = nil,
        notification_func = nil,
        to_string_func = nil,
        reference_func = refinc,
        unreference_func = refdec,
        create_instance_func = treeHookCreate,
        free_instance_func = treeHookDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func = getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //GDW.makePublic(treeHook, "timePassed")
    treeBindMethod()

    //Yes, I was going a bit mad wondering if it had even created the class I told it to. Because it would claim that a certain thing didn't exist.
    /*
    dbmethodname:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&dbmethodname, "class_exists", false)
    defer(GDW.Destructors.stringNameDestructor(&dbmethodname))

    ClassDB:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&ClassDB, "ClassDB", false)
    defer(GDW.Destructors.stringNameDestructor(&ClassDB))

    class_exists: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassDB, &dbmethodname, 2619796661)

    arg:= [?]rawptr {&class_name}
    ret:bool=false
    GDW.gdAPI.objectMethodBindPtrCall(class_exists, cast(GDE.ObjectPtr)GDW.Library, raw_data(arg[:]), &ret)
    fmt.println(ret)*/
    //treeHookCreate(nil, false)

}

deinitialize_gdexample_module:: proc "c" (userdata: rawptr, p_level: GDE.InitializationLevel) {

}


treeHookCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "SceneTree", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    
    fmt.println("My own tree", object)

    //Create extension object.
    //Can replace mem_alloc with new(). Just need to create the struct and pass a pointer.
    self: ^treeHook = cast(^treeHook)GDW.gdAPI.mem_alloc(size_of(treeHook))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "treeHook", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    //At first was trying to register a singleton and do something in that way, but that kinda fell flat.
    //The extension loads before the sceneTree/mainLoop get initialized. Meaning that it's too soon to register to their signals.
    /*
    //Need to get the Engine singleton to be able to register your own singletons
    singleName:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&singleName, "Engine", false)
    defer(GDW.Destructors.stringNameDestructor(&singleName))
    myEngine:=GDW.Methods.getSingleton(&singleName)
    arg:= [?]rawptr {&class_name, self.selfPtr}
    ret:bool=false
    dbmethodname:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&dbmethodname, "register_singleton", false)
    defer(GDW.Destructors.stringNameDestructor(&dbmethodname))

    ClassDB:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&ClassDB, "Engine", false)
    defer(GDW.Destructors.stringNameDestructor(&ClassDB))

    regSingleton: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassDB, &dbmethodname, 965313290)
    */

    
    /*
    sn_SceneTree:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&sn_SceneTree, "SceneTree", false)
    defer(GDW.Destructors.stringNameDestructor(&sn_SceneTree))

    //signalList: GDE.Variant
    //GDW.gdAPI.objectMethodBindCall(connectList, object, nil, 0, &signalList, &ret_err)
    //GDW.gdAPI.objectMethodBindPtrCall(connectList, object, nil, nil) WARNING this one will error due to memory allocation issues. Only use with step debugging.

    
    //Since we already have our object and it is a SceneTree type we could connect our signal right here.
    Connect: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&Connect, "connect", false)
    defer(GDW.Destructors.stringNameDestructor(&Connect))
    connect_to: GDE.MethodBindPtr =GDW.gdAPI.classDBGetMethodBind(&sn_SceneTree, &Connect, 1518946055)


    rec_signal: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)myFunc,
	    token= GDW.Library,
	    
	    call_func= callableCustom,
    }
    
    myCallable:GDE.Callable
    GDW.Methods.makeCallable(&myCallable, &rec_signal)
    physicsSignal:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&physicsSignal, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&physicsSignal))

    ret2:GDE.CallErrorType
    flags:=0
    args:= [?]rawptr {&physicsSignal, &myCallable, &flags}
    GDW.gdAPI.objectMethodBindPtrCall(connect_to, object, raw_data(args[:]), &ret2)*/

    return object
}

//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}

treeBindMethod :: proc "c" () {

}


myFunc :: proc "c" () {
    context = runtime.default_context()
    fmt.println("Somethign rpinted wew.")
}

treeHookDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {

}

mainLoopInit :: proc "c" (self: ^treeHook) {
    
    ClassDB:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&ClassDB, "Engine", false)
    defer(GDW.Destructors.stringNameDestructor(&ClassDB))
    
    loopMain: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&loopMain, "get_main_loop", false)
    defer(GDW.Destructors.stringNameDestructor(&loopMain))
    getMainLoop: GDE.MethodBindPtr =GDW.gdAPI.classDBGetMethodBind(&ClassDB, &loopMain, 1016888095)

    myEngine:=GDW.Methods.getSingleton(&ClassDB)

    gdLoop:GDE.ObjectPtr
    GDW.gdAPI.objectMethodBindPtrCall(getMainLoop, myEngine, nil, &gdLoop)
    

    //fmt.println("engine loop", gdLoop)
    ret_err: GDE.CallError
    
    sn_SceneTree:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&sn_SceneTree, "Object", false)
    defer(GDW.Destructors.stringNameDestructor(&sn_SceneTree))
    
    //I used this to test and make sure that the object I was using was the correct one.
    //When fetching with get_scene_tree method from Node it would return a refCount object.
    //When using said recount object with connect methods I would only see the signals of refCount.
    //Unsure if the subsequent issues were simply due to refCount or if get_scene_tree is legit a diff object from mainLoop.
    /*
    siglist:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&siglist, "get_signal_list", false)
    defer(GDW.Destructors.stringNameDestructor(&siglist))
    connectList: GDE.MethodBindPtr =GDW.gdAPI.classDBGetMethodBind(&sn_SceneTree, &siglist, 3995934104)
    
    signalList: GDE.Variant
    GDW.gdAPI.objectMethodBindCall(connectList, gdLoop, nil, 0, &signalList, &ret_err)
    */
    
    
    Connect: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&Connect, "connect", false)
    defer(GDW.Destructors.stringNameDestructor(&Connect))
    connect_to: GDE.MethodBindPtr =GDW.gdAPI.classDBGetMethodBind(&sn_SceneTree, &Connect, 1518946055)


    rec_signal: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)myFunc,
	    token= GDW.Library,
	    
	    call_func= callableCustom,
    }
    
    myCallable:GDE.Callable
    GDW.Methods.makeCallable(&myCallable, &rec_signal)
    physicsSignal:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&physicsSignal, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&physicsSignal))

    ret2:GDE.CallErrorType
    flags:=0
    args:= [?]rawptr {&physicsSignal, &myCallable, &flags}
    GDW.gdAPI.objectMethodBindPtrCall(connect_to, gdLoop, raw_data(args[:]), &ret2)
}


classProcess :: proc "c" (self: ^treeHook) {
    context = runtime.default_context()

}


/*
*Godot will call this function to ask if there's any of its virtual functions that it should override(?) with our own.
*Will make a call for each virtual associated with the class our objectClass is associated/inheriting from.
*/
getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {
    context = runtime.default_context()


    if GDW.stringNameCompare(p_name, "_initialize"){
        return cast(rawptr)mainLoopInit
    }
    /*
    //Do not override _process unless you know how to replace SceneTree's process function. I dunno, it crashes...
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)classProcess
    }*/

    return nil
}

/*
* This is Godot telling us to use the function. So we need to call it.
* It doesn't give and argument count so we need to know it ahead of time?
*/
callVirtualFunctionWithData :: proc "c" (p_instance: rawptr, p_name: GDE.ConstStringNamePtr, p_virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    context = runtime.default_context()

    //Godot provides the exact pointer that we passed in getVirtualWithData for the function on our side.
    if p_virtualProcPtr == cast(rawptr)mainLoopInit {
        GDW.virtualProcCall(mainLoopInit, p_instance, p_args, r_ret)
    }
}


//These are never called?
refinc :: proc "c" (self: GDE.ClassInstancePtr) {
    context = runtime.default_context()

    (cast(^treeHook)self).refCount += 1
}

refdec :: proc "c" (self: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    
    if (cast(^treeHook)self).refCount > 1{
        (cast(^treeHook)self).refCount -= 1}
    else {
        treeHookDestroy(GDW.Library, self)
    }
}

callableCustom :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    if callable_userdata == cast(rawptr)myFunc {
        myFunc()
        r_error.error=.CALL_OK
        return
    }
    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}