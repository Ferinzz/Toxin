package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import sics "base:intrinsics"
import "core:fmt"

game :: struct {
    selfPtr: GDE.ObjectPtr
}

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

    GDW.StringConstruct.stringNameNewLatin(&class_name, "game", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Node2D", false)
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
        create_instance_func = gameCreate,
        free_instance_func = gameDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    
    //GDW.makePublic(treeHook, "timePassed")
    gameBindMethod()
}


gameBindMethod :: proc "c" (){

}

extensionDeinit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}


gameCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Node2D", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    
    //fmt.println("My own tree", object)

    //Create extension object.
    //Can replace mem_alloc with new(). Just need to create the struct and pass a pointer.
    self: ^game = cast(^game)GDW.gdAPI.mem_alloc(size_of(game))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "game", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
    
}

//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}

gameDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {

}


getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)draw
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)inputPlayer
    }
    return nil
}


//thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//unfortunately the more events a class has the more times this thing is called.
callVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)physics {
        GDW.virtualProcCall(physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)process {
        GDW.virtualProcCall(process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)draw {
        GDW.virtualProcCall(draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)inputPlayer {
        GDW.virtualProcCall(inputPlayer, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)ready {
        GDW.virtualProcCall(ready, p_instance, p_args, r_ret)
    }
}

ready :: proc "c" (self: ^game) {
    context = runtime.default_context()
    GDW.getInputSingleton()
    GDW.getPhysServer2dObj()
    GDW.getRenderServer2dObj()
}
physics :: proc "c" (self: ^game, delta: f64) {
    context = runtime.default_context()
    
    GDW.getInputSingleton()
    button: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    GDW.isMouseButtonPressed(&button, &isPressed)
    fmt.println(isPressed)    
}

process :: proc "c" (self: ^game, delta: f64) {
    context = runtime.default_context()
    GDW.queueRedraw(self.selfPtr)


}

draw :: proc "c" (self: ^game) {

}


inputPlayer :: proc "c" (self: ^game, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

signalCalback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    /*
    if callable_userdata == cast(rawptr)mainPhysTick {
        mainPhysTick()
        r_error.error=.CALL_OK
        return
    }*/

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}
