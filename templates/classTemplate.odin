package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"


//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. THIS_CLASS_NAME__SN
THIS_CLASS_NAME_ :: struct {
    selfPtr: GDE.ObjectPtr, //always keep. Self-reference to this object's memory in Godot.
    keyBind: GDE.gdstring,
}

THIS_CLASS_NAME__SN : GDE.StringName

THIS_CLASS_NAME_Init :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(&THIS_CLASS_NAME__SN, "THIS_CLASS_NAME_", false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Godot_Class_Name", false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
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
        create_instance_func = THIS_CLASS_NAME_Create,
        free_instance_func = THIS_CLASS_NAME_Destroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  THIS_CLASS_NAME_getVirtualWithData,
        call_virtual_with_data_func = THIS_CLASS_NAME_callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &THIS_CLASS_NAME__SN, &parent_class_name, &class_info)
    
    THIS_CLASS_NAME_BindMethod()
}

//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_BindMethod :: proc "c" (){
    className:cstring= "THIS_CLASS_NAME_"
    GDW.bindMethod(className, "Some_method_name", somePublicFunction, GDE.ClassMethodFlags.NORMAL, "arg1")

}

somePublicFunction :: proc "c" (arg1: GDE.RID) {
    //do stuff
}


//This runs when the class is created before it gets added to a tree.
//init your class struct, heap allocated variables, any class children.
THIS_CLASS_NAME_Create :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&THIS_CLASS_NAME__SN)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: ^THIS_CLASS_NAME_ = cast(^THIS_CLASS_NAME_)GDW.gdAPI.mem_alloc(size_of(THIS_CLASS_NAME_))
    self.selfPtr = object
    
    GDW.gdAPI.object_set_instance(object, &THIS_CLASS_NAME__SN, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

//Only need this once in a project unless you will be overriding these defaults.
//I still don't know what these are for :/ Maybe some more C# specific things considering create free and reference are in the class struct.
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}

//Delete all the heap allocated aspects of the class along with the class struct as well as any
//additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
THIS_CLASS_NAME_Destroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    
    GDW.gdAPI.mem_free(cast(^THIS_CLASS_NAME_)p_instance)

}

//If you ever rename a virtual function (method callback) you will need to update it in three places.
//Here, THIS_CLASS_NAME_callVirtualFunctionWithData, the function itself.
//Look at Godot docs to know what is supported by a certain class. If it inherits from another, it will also inherit its methods.
//ie something that inherits canvas item will have draw.
THIS_CLASS_NAME_getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)THIS_CLASS_NAME__ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)THIS_CLASS_NAME__process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)THIS_CLASS_NAME__physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)THIS_CLASS_NAME__draw
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)THIS_CLASS_NAME__Input
    }
    return nil
}


//Thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//Unfortunately the more methods you registered in THIS_CLASS_NAME_getVirtualWithData the more times this thing is called.
THIS_CLASS_NAME_callVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME__physics {
        GDW.virtualProcCall(THIS_CLASS_NAME__physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME__process {
        GDW.virtualProcCall(THIS_CLASS_NAME__process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME__draw {
        GDW.virtualProcCall(THIS_CLASS_NAME__draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME__Input {
        GDW.virtualProcCall(THIS_CLASS_NAME__Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME__ready {
        GDW.virtualProcCall(THIS_CLASS_NAME__ready, p_instance, p_args, r_ret)
    }
}

THIS_CLASS_NAME__ready :: proc "c" (self: ^THIS_CLASS_NAME_) {
    context = runtime.default_context()//These are good to set in a singleton at some point.
    //These are statically stored and thus only need to be called once when the game engine is fully initialize.
    //GDW.getInputSingleton()
    //GDW.getPhysServer2dObj()
    //GDW.getRenderServer2dObj()

}

THIS_CLASS_NAME__physics :: proc "c" (self: ^THIS_CLASS_NAME_, delta: f64) {
    context = runtime.default_context()
    
    THIS_CLASS_NAME_: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    GDW.isMouseButtonPressed(&THIS_CLASS_NAME_, &isPressed)
    fmt.println(isPressed)
}

THIS_CLASS_NAME__process :: proc "c" (self: ^THIS_CLASS_NAME_, delta: f64) {
    context = runtime.default_context()
    GDW.queueRedraw(self.selfPtr)


}

THIS_CLASS_NAME__draw :: proc "c" (self: ^THIS_CLASS_NAME_) {

}


THIS_CLASS_NAME__Input :: proc "c" (self: ^THIS_CLASS_NAME_, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

THIS_CLASS_NAME__signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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
