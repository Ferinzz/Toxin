package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "core:fmt"
import sics "base:intrinsics"
import "base:runtime"
import str "core:strings"
import s "core:slice"

//Draw canvas item directly while in the sceneTree.
//This also shows that you can simply create a random class struct to hold the necessary data for rendering such as a texture.
//Makes sense considering resource returns a refcounted object?
//https://github.com/godotengine/godot-demo-projects/blob/master/2d/bullet_shower/bullets.gd
//Create a canvasItem then draw to it directly.
//https://docs.godotengine.org/en/stable/tutorials/performance/using_servers.html#creating-a-sprite

/*
Process to do this.
If the object isn't already inherited into a canvas item (part of the scene tree)
create a canvas item.
create the appropriate body/shape
if already part of a canvasItem can override draw function
If you create the canvasitem yourself you can directly update the transform.


*/

treeHook :: struct {
    selfPtr: GDE.ObjectPtr,
}

mySceneTree: GDE.ObjectPtr

@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, initialization: ^GDE.Initialization) {
    context = runtime.default_context()

    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    initialization.minimum_initialization_level = .INITIALIZATION_SCENE
    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit

}

extensionInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {

    context = runtime.default_context()
    if initLevel != .INITIALIZATION_SCENE{
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
        reference_func = nil,
        unreference_func = nil,
        create_instance_func = treeHookCreate,
        free_instance_func = treeHookDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    registerSprite()
    registerPlayer()


    //GDW.makePublic(treeHook, "timePassed")
    treeBindMethod()
}

extensionDeinit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}


treeBindMethod :: proc "c" () {

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
    mySceneTree = object
    return object

}

//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}

treeHookDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^treeHook = cast(^treeHook)p_instance
    class_destructor(self)
    GDW.gdAPI.mem_free(self)

}

class_destructor :: proc "c" (self: ^treeHook) {

}


getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_initialize"){
        return cast(rawptr)initializeMainLoop
    }
    return nil
}


callVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)initializeMainLoop {
        GDW.virtualProcCall(initializeMainLoop, p_instance, p_args, r_ret)
    }
}

initializeMainLoop :: proc "c" (self: ^treeHook) {
    context = runtime.default_context()

    mainLoop := GDW.getMainLoop()


    rec_signal: GDE.CallableCustomInfo2 = {
        callable_userdata= cast(rawptr)mainPhysTick,
	    token= GDW.Library,
	    
	    call_func= signalCalback,
    }

    signalName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&signalName, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&signalName))

    connectErr:= GDW.connectToSignal(&rec_signal, &signalName, self.selfPtr)
    fmt.println("was there a connection error: ", connectErr)

}

spriteClassCreated: bool= false

mainPhysTick :: proc "c" () {
    context = runtime.default_context()

    //fmt.println("My phys tick.")

    if !spriteClassCreated {
        printTree:= GDW.classDBGetMethodBind("Node", "get_tree", 2958820483)
        sceneTree: GDE.ObjectPtr
        //GDW.gdAPI.objectMethodBindPtrCall(printTree, GDW.getMainLoop(), nil, &sceneTree)

        /**********
        * If the sprite hasn't been created we create it then add it as a child to our SceneTree's root.
        * To see that it is added we load the default icon.svg as a texture and set it on our Sprite2D object's texture.
        ***********/

        mySprite:= SpriteCreate(nil, false)
        GDW.addChild(GDW.getRoot(), &mySprite)

        //newSprite2 := SpriteCreate(nil, false)
        //GDW.addChild(GDW.getRoot(), &newSprite2)
        
        /*
        newSprite = SpriteCreate(nil, false)
        GDW.addChild(GDW.getRoot(), &newSprite)
        
        newSprite = SpriteCreate(nil, false)
        GDW.addChild(GDW.getRoot(), &newSprite)*/

        //removeChild:= GDW.classDBGetMethodBind("Node", "remove_child", 1078189570)

        //arg:= [1]rawptr {&mySprite}
        //dummyReturn:rawptr
        //GDW.gdAPI.objectMethodBindPtrCall(removeChild, GDW.getRoot(), raw_data(arg[:]), dummyReturn)
        //SpriteDestroy(nil, mySprite)


        //GDW.gdAPI.objectMethodBindPtrCall(printTree, GDW.getMainLoop(), nil, &sceneTree)
        //player:= CreatePlayer(nil, false)
        //GDW.addChild(GDW.getRoot(), &player)

        spriteClassCreated = true
    }
}

signalCalback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    if callable_userdata == cast(rawptr)mainPhysTick {
        mainPhysTick()
        r_error.error=.CALL_OK
        return
    }

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}