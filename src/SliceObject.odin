package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"
import "core:slice"

//Find and Replace SliceObject with the name that you will be giving to the GDE class.
//Find and Replace RefCounted with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. SliceObject_SN
SliceObject :: struct {
    selfPtr: GDE.ObjectPtr, //always keep. Self-reference to this object's memory in Godot.
    OdinSlice: Slice,
    Error: sliceErrors,
}

//nil is ok
sliceErrors :: enum {
    OUT_OF_BOUNDS,
    ARRAY_IS_NIL,
    SLICE_IS_NIL,
}

Slice :: union {
    []i64,
    []f64,
    []u8,
}

SliceObject_byteSize :: proc "c" (self: ^SliceObject) -> GDE.Int {
    context = runtime.default_context()
    #partial switch type in self.OdinSlice {
    case []i64:
        return slice.size(self.OdinSlice.([]i64))
    case []f64:
        return slice.size(self.OdinSlice.([]f64))
    case []u8:
        return slice.size(self.OdinSlice.([]u8))
    }
    return 0
}

SliceObject_all_of :: proc "c" (self: ^SliceObject, value: GDE.Variant) -> GDE.Bool {
    context = runtime.default_context()
    value:= value
    ret: GDE.Int
    GDW.variant_to(&value, &ret)
    return b8(slice.all_of(self.OdinSlice.([]i64), i64(ret)))
}

SliceObject_index_of :: proc "c" (self: ^SliceObject, index: GDE.Int) -> GDE.Variant {
    context = runtime.default_context()
    #partial switch type in self.OdinSlice {
    case []i64:
        val: GDE.Variant = GDW.tovariant(&(self.OdinSlice.([]i64))[index], i64)
        return val
    case []f64:
        val: GDE.Variant = GDW.tovariant(&(self.OdinSlice.([]f64))[index], f64)
        return val
    case []u8:
        val: GDE.Variant = GDW.tovariant(&(self.OdinSlice.([]u8))[index], u8)
        return val
    }
    ret: GDE.Int = -1
    return GDW.tovariant(&ret, GDE.Int)
}

SliceObject_SN : GDE.StringName
SliceObject_CString: cstring = "SliceObject"
SliceObject_GDClass_String: cstring = "RefCounted"

//Technically can have a single massive function to init everything, but having one in each is easier?
//Make sure to add this to the init of the extension otherwise you won't be able to access this class.
//p_userdata and initLevel are optional.
//p_userdata: I'm assuming this is best used to pass the context around. If context is set in the calling class this should be implicitly passed to this one.
//initLevel: should probably be handled by the calling proc, but also safety check is nice.
//See where registerSprite is called in the loadTextureToSceneTree main.odin
SliceObjectInit :: proc "c" (p_userdata: rawptr, initLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(&SliceObject_SN, SliceObject_CString, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, SliceObject_GDClass_String, false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
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
        create_instance_func = SliceObjectCreate,
        free_instance_func = SliceObjectDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  SliceObjectgetVirtualWithData,
        call_virtual_with_data_func = SliceObjectcallVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &SliceObject_SN, &parent_class_name, &class_info)
    
    SliceObjectBindMethod()
}

//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
SliceObjectBindMethod :: proc "c" (){

    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    //GDW.bindMethod(&SliceObject_SN, "Some_method_name", somePublicFunction, GDE.ClassMethodFlags.NORMAL, "arg1")
    
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific.


//This runs when the class is created before it gets added to a tree.
//init your class struct, heap allocated variables, any class children.
SliceObjectCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, SliceObject_GDClass_String, false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: ^SliceObject = cast(^SliceObject)GDW.gdAPI.mem_alloc(size_of(SliceObject))
    self.selfPtr = object
    
    GDW.gdAPI.object_set_instance(object, &SliceObject_SN, cast(^GDE.Object)self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

//Delete all the heap allocated aspects of the class along with the class struct as well as any
//additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
SliceObjectDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    
    GDW.gdAPI.mem_free(cast(^SliceObject)p_instance)

}

//If you ever rename a virtual function (method callback) you will need to update it in three places.
//Here, SliceObjectcallVirtualFunctionWithData, the function itself.
//Look at Godot docs to know what is supported by a certain class. If it inherits from another, it will also inherit its methods.
//ie something that inherits canvas item will have draw.
SliceObjectgetVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)SliceObject_ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)SliceObject_process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)SliceObject_physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)SliceObject_draw
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)SliceObject_Input
    }
    return nil
}


//Thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//Unfortunately the more methods you registered in SliceObjectgetVirtualWithData the more times this thing is called.
SliceObjectcallVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)SliceObject_physics {
        GDW.virtualProcCall(SliceObject_physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)SliceObject_process {
        GDW.virtualProcCall(SliceObject_process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)SliceObject_draw {
        GDW.virtualProcCall(SliceObject_draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)SliceObject_Input {
        GDW.virtualProcCall(SliceObject_Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)SliceObject_ready {
        GDW.virtualProcCall(SliceObject_ready, p_instance, p_args, r_ret)
    }
}

SliceObject_ready :: proc "c" (self: ^SliceObject) {
    context = runtime.default_context()//These are good to set in a singleton at some point.
    //These are statically stored and thus only need to be called once when the game engine is fully initialize.
    GDW.getInputSingleton()
    //GDW.getPhysServer2dObj()
    //GDW.getRenderServer2dObj()

}

SliceObject_physics :: proc "c" (self: ^SliceObject, delta: f64) {
    context = runtime.default_context()
    
    SliceObject: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    GDW.isMouseButtonPressed(&SliceObject, &isPressed)
    fmt.println(isPressed)
}

SliceObject_process :: proc "c" (self: ^SliceObject, delta: f64) {
    context = runtime.default_context()

}

SliceObject_draw :: proc "c" (self: ^SliceObject) {

}


SliceObject_Input :: proc "c" (self: ^SliceObject, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

SliceObject_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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
