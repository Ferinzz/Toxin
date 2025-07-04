package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "core:fmt"
import sics "base:intrinsics"
import "base:runtime"
import str "core:strings"
import s "core:slice"

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


    rec_signal: GDE.CallableCustomInfo2 ={
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

    /*,
				Node
                {
					"name": "add_child",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3863233950,
					"hash_compatibility": [
						3070154285
					],
					"arguments": [
						{
							"name": "node",
							"type": "Node"
						},
						{
							"name": "force_readable_name",
							"type": "bool",
							"default_value": "false"
						},
						{
							"name": "internal",
							"type": "enum::Node.InternalMode",
							"default_value": "0"
						}
					]
				},
                SceneTree
                {
					"name": "get_root",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1757182445,
					"return_value": {
						"type": "Window"
					}
				},
                {
					"name": "set_texture",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4051416890,
					"arguments": [
						{
							"name": "texture",
							"type": "Texture2D"
						}
					]
				},
                ResourceLoader
                ,
				{
					"name": "load",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3358495409,
					"hash_compatibility": [
						2622212233
					],
					"return_value": {
						"type": "Resource"
					},
					"arguments": [
						{
							"name": "path",
							"type": "String"
						},
						{
							"name": "type_hint",
							"type": "String",
							"default_value": "\"\""
						},
						{
							"name": "cache_mode",
							"type": "enum::ResourceLoader.CacheMode",
							"default_value": "1"
						}
					]
				},
                Sprite2d
                {
					"name": "set_texture",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4051416890,
					"arguments": [
						{
							"name": "texture",
							"type": "Texture2D"
						}
					]
				},*/
    //
    fmt.println("My phys tick.")

    if !spriteClassCreated {

        /**********
        * If the sprite hasn't been created we create it then add it as a child to our SceneTree's root.
        * To see that it is added we load the default icon.svg as a texture and set it on our Sprite2D object's texture.
        ***********/
        mySprite:= SpriteCreate(nil, false)
        
        ClassNamegr:GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&ClassNamegr, "SceneTree", false)
        defer(GDW.Destructors.stringNameDestructor(&ClassNamegr))
        
        methodNamegr: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&methodNamegr, "get_root", false)
        defer(GDW.Destructors.stringNameDestructor(&methodNamegr))
        getRoot: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassNamegr, &methodNamegr, 1757182445)
        
        r_ret:rawptr
        GDW.gdAPI.objectMethodBindPtrCall(getRoot, mySceneTree, nil, &r_ret)

        
        ClassNameres:GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&ClassNameres, "ResourceLoader", false)
        defer(GDW.Destructors.stringNameDestructor(&ClassNameres))
        
        methodNameres: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&methodNameres, "load", false)
        defer(GDW.Destructors.stringNameDestructor(&methodNameres))
        load: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassNameres, &methodNameres, 3358495409)
        
        path: GDE.gdstring
        hint: GDE.gdstring
        GDW.StringConstruct.stringNewLatin(&path, "res://icon.svg")
        defer(GDW.Destructors.stringDestruction(&path))
        defer(GDW.Destructors.stringDestruction(&hint))
        GDW.StringConstruct.stringNewLatin(&hint, "Texture")
        cache_mode:GDE.Int=0
        args_res:= [?]rawptr {&path, &hint, &cache_mode}
        r_resource:rawptr
        GDW.gdAPI.objectMethodBindPtrCall(load, GDW.getMainLoop(), raw_data(args_res[:]), &r_resource)

        
        
        ClassNamespr:GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&ClassNamespr, "Sprite2D", false)
        defer(GDW.Destructors.stringNameDestructor(&ClassNamespr))
        
        methodNamespr: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&methodNamespr, "set_texture", false)
        defer(GDW.Destructors.stringNameDestructor(&methodNamespr))
        set_texture: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassNamespr, &methodNamespr, 4051416890)
        

        args_spr:= [?]rawptr {&r_resource}
        r_nil:rawptr
        GDW.gdAPI.objectMethodBindPtrCall(set_texture, mySprite, raw_data(args_spr[:]), &r_ret)

        ClassName:GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&ClassName, "Node", false)
        defer(GDW.Destructors.stringNameDestructor(&ClassName))
        
        methodName: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&methodName, "add_child", false)
        defer(GDW.Destructors.stringNameDestructor(&methodName))
        addChild: GDE.MethodBindPtr = GDW.gdAPI.classDBGetMethodBind(&ClassName, &methodName, 3863233950)
        force_readable_name: GDE.Bool = false
        internal: GDE.Int = 0
        args:= [?]rawptr {&mySprite, &force_readable_name, &internal}
        r_ret2:rawptr
        GDW.gdAPI.objectMethodBindPtrCall(addChild, cast(GDE.ObjectPtr)r_ret, raw_data(args[:]), r_ret2)

        GDW.getMainLoop()

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