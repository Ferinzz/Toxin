package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "core:fmt"
import sics "base:intrinsics"
import "base:runtime"
import str "core:strings"
import s "core:slice"

mySprite :: struct {
    selfPtr: GDE.ObjectPtr
}

registerSprite:: proc "c" () {
    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "mySprite", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Sprite2D", false)
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
        create_instance_func = SpriteCreate,
        free_instance_func = SpriteDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithDataSprite,
        call_virtual_with_data_func = callVirtualFunctionWithDataSprite,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //GDW.makePublic(mySprite, "timePassed")
    treeBindMethod()
}

extensionDeinitSprite :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}


treeBindMethodSprite :: proc "c" () {

}

SpriteCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Sprite2D", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    
    fmt.println("My own Sprite", object)

    //Create extension object.
    //Maybe can replace mem_alloc with new(). This should be safe as we make the free in the destroy callback.
    self: ^mySprite = cast(^mySprite)GDW.gdAPI.mem_alloc(size_of(mySprite))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "mySprite", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    /*
    //Connect to mainLoop's phys tick signal.
    //Can do at create or _ready.
    mainLoop := GDW.getMainLoop()
    rec_signal: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)mainPhysTickSprite,
	    token= GDW.Library,
	    
	    call_func= signalCalbackSprite,
    }

    signalName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&signalName, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&signalName))

    //connectErr:= GDW.connectToSignal(&rec_signal, &signalName, mainLoop)
    //fmt.println("was there a connection error: ", connectErr)*/

    return object

}


SpriteDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^mySprite = cast(^mySprite)p_instance
    class_destructorSprite(self)
    GDW.gdAPI.mem_free(self)

}

class_destructorSprite :: proc "c" (self: ^mySprite) {

}


getVirtualWithDataSprite :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)initializeSprite
    }
    return nil
}


callVirtualFunctionWithDataSprite :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)initializeSprite {
        GDW.virtualProcCall(initializeSprite, p_instance, p_args, r_ret)
    }
}


initializeSprite :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()

    
    //Connect to mainLoop's phys tick signal.
    //Can do at create or _ready.
    mainLoop := GDW.getMainLoop()
    rec_signal: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)mainPhysTickSprite,
	    token= GDW.Library,
	    
	    call_func= signalCalbackSprite,
    }

    signalName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&signalName, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&signalName))

    connectErr:= GDW.connectToSignal(&rec_signal, &signalName, mainLoop)
    fmt.println("was there a connection error: ", connectErr)

}


mainPhysTickSprite :: proc "c" () {
    context = runtime.default_context()

    fmt.println("My Sprite tick.")
}

signalCalbackSprite :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    if callable_userdata == cast(rawptr)mainPhysTickSprite {
        mainPhysTickSprite()
        r_error.error=.CALL_OK
        return
    }

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}