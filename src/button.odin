package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import sics "base:intrinsics"
import "core:fmt"


//Godot will be passing us a pointer to this struct during callbacks.
remapButton :: struct {
    selfPtr: GDE.ObjectPtr, //always keep. Self-reference to this object's memory in Godot.
    keyBind: GDE.gdstring,
}

remapButton_SN : GDE.StringName

remapButtonInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {

    context = runtime.default_context()
    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    
    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "remapButton", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Button", false)
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
        create_instance_func = remapButtonCreate,
        free_instance_func = remapButtonDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)

    //We'll need this stringname every time the class is created. Might as well save some time and store it in the StringName index.
    GDW.StringConstruct.stringNameNewLatin(&remapButton_SN, "remapButton", false)
    
    remapButtonBindMethod()
}


remapButtonBindMethod :: proc "c" (){

}



remapButtonCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Button", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    //Create extension object.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: ^remapButton = cast(^remapButton)GDW.gdAPI.mem_alloc(size_of(remapButton))
    self.selfPtr = object
    
    GDW.gdAPI.object_set_instance(object, &remapButton_SN, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

/*
//I still don't know what these are for :/ Maybe some more C# specific things considering create free and reference are in the class struct.
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}*/

remapButtonDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {

}


remapButtongetVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)remapButton_ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)remapButton_process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)remapButton_physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)remapButton_draw
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)button_Input
    }
    return nil
}


//thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//unfortunately the more events a class has the more times this thing is called.
remapButtoncallVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)remapButton_physics {
        GDW.virtualProcCall(remapButton_physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)remapButton_process {
        GDW.virtualProcCall(remapButton_process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)remapButton_draw {
        GDW.virtualProcCall(remapButton_draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)button_Input {
        GDW.virtualProcCall(button_Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)remapButton_ready {
        GDW.virtualProcCall(remapButton_ready, p_instance, p_args, r_ret)
    }
}

remapButton_ready :: proc "c" (self: ^remapButton) {
    context = runtime.default_context()
    
    
}

remapButton_physics :: proc "c" (self: ^remapButton, delta: f64) {
    context = runtime.default_context()
    
    remapButton: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    GDW.isMouseButtonPressed(&remapButton, &isPressed)
    fmt.println(isPressed)
}

remapButton_process :: proc "c" (self: ^remapButton, delta: f64) {
    context = runtime.default_context()
    GDW.queueRedraw(self.selfPtr)


}

remapButton_draw :: proc "c" (self: ^remapButton) {

}


button_Input :: proc "c" (self: ^remapButton, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

remapButton_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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
