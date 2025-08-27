package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"

//Find and Replace OdinArrayObj with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot. (2 instances)

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. OdinArrayObj_SN
OdinArrayObj :: struct {
    selfPtr: GDE.ObjectPtr, //always keep. Self-reference to this object's memory in Godot.
    someProperty: GDE.Int,
    selfArray: arrays,
}


arrays :: union {
    [dynamic]i64,
    [dynamic]f64,
}


OdinArrayObj_SN : GDE.StringName
OdinArrayObj_CString: cstring = "OdinArrayObj"
OdinArrayObj_GDClass_String: cstring = "RefCounted"

//Technically can have a single massive function to init everything, but having one in each is easier?
//Make sure to add this to the init of the extension otherwise you won't be able to access this class.
//p_userdata and initLevel are optional.
//p_userdata: I'm assuming this is best used to pass the context around. If context is set in the calling class this should be implicitly passed to this one.
//initLevel: should probably be handled by the calling proc, but also safety check is nice.
//See where registerSprite is called in the loadTextureToSceneTree main.odin
OdinArrayObjInit :: proc "c" (p_userdata: rawptr, initLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(&OdinArrayObj_SN, OdinArrayObj_CString, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, OdinArrayObj_GDClass_String, false) //Godot_Class_Name, Godot_Class_Name2D, Sprite2D etc. MUST match what is used in class create.
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
        reference_func = OdinArrayObj_reference,
        unreference_func = OdinArray_ClassUnreference,
        create_instance_func = OdinArrayObjCreate,
        free_instance_func = OdinArrayObjDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  OdinArrayObjgetVirtualWithData,
        call_virtual_with_data_func = OdinArrayObjcallVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &OdinArrayObj_SN, &parent_class_name, &class_info)
    
    OdinArrayObjBindMethod()
}

OdinArray_ClassUnreference :: proc "c" (p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    
    stringname: GDE.StringName
    getRefCount_SN: GDE.StringName
    getRefCount: GDE.MethodBindPtr
    GDW.StringConstruct.stringNameNewLatin(&stringname, OdinArrayObj_GDClass_String, false)
    GDW.StringConstruct.stringNameNewLatin(&getRefCount_SN, "get_reference_count", false)
    getRefCount = GDW.gdAPI.classDBGetMethodBind(&stringname, &getRefCount_SN, 3905245786)
    ret: GDE.Int
    GDW.gdAPI.objectMethodBindPtrCall(getRefCount, (cast(^OdinArrayObj)p_instance).selfPtr, nil, &ret)
    fmt.println("ferCount", ret)
    if ret == 0 {
        fmt.println((cast(^OdinArrayObj)p_instance).selfArray.([dynamic]i64))
        delete((cast(^OdinArrayObj)p_instance).selfArray.([dynamic]i64))
    }
}

OdinArrayObj_reference :: proc "c" (p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()

    variable:=0
    variable+=1

    stringname: GDE.StringName
    getRefCount_SN: GDE.StringName
    getRefCount: GDE.MethodBindPtr
    GDW.StringConstruct.stringNameNewLatin(&stringname, OdinArrayObj_GDClass_String, false)
    GDW.StringConstruct.stringNameNewLatin(&getRefCount_SN, "get_reference_count", false)
    getRefCount = GDW.gdAPI.classDBGetMethodBind(&stringname, &getRefCount_SN, 3905245786)
    ret: GDE.Int
    GDW.gdAPI.objectMethodBindPtrCall(getRefCount, (cast(^OdinArrayObj)p_instance).selfPtr, nil, &ret)
    fmt.println("ferCount", ret)

}

//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
OdinArrayObjBindMethod :: proc "c" (){

    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    GDW.bindMethod(&OdinArrayObj_SN, "Some_method_name", somePublicFunction2, GDE.ClassMethodFlags.NORMAL, "arg1")
    GDW.bindMethod(&OdinArrayObj_SN, "OdinArray_len",
    OdinArray_len, GDE.ClassMethodFlags.NORMAL)
    //GDW.bindMethod(&OdinArrayObj_SN, "OdinArray_giveSlice",
    //OdinArray_giveSlice, GDE.ClassMethodFlags.NORMAL, "rangeStart", "rangeEnd")
    GDW.bindMethod(&OdinArrayObj_SN, "OdinArray_create",
    OdinArray_create, GDE.ClassMethodFlags.NORMAL)
    GDW.bindMethod(&OdinArrayObj_SN, "OdinArray_append",
    OdinArray_append, GDE.ClassMethodFlags.NORMAL, "value")
    
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    GDW.makePublic(OdinArrayObj, "someProperty")
}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific.
somePublicFunction2 :: proc "c" (classStruct: ^OdinArrayObj, arg1: GDE.Int) {
    //do stuff
}

OdinArray_create :: proc "c" (self: ^OdinArrayObj) {
    context = runtime.default_context()

    self.selfArray = make([dynamic]i64)
}

OdinArray_append :: proc "c" (self: ^OdinArrayObj, value: GDE.Int) {
    context = runtime.default_context()

    append(&self.selfArray.([dynamic]i64), i64(value))
}

OdinArray_len :: proc "c" (self: ^OdinArrayObj) -> GDE.Int {
    context = runtime.default_context()
    switch type in self.selfArray {
        case [dynamic]i64 :
            return 1
        case [dynamic]f64 :
            return 2
    }
    return -1
}

OdinArray_getType :: proc "c" (myArray: arrays) -> typeid {
    #partial switch type in myArray {
        case [dynamic]i64:
            return typeid_of(type_of(myArray.([dynamic]i64)))
    }
    return nil
}

someOther :: proc "c" (myArray: ^arrays) {
    context = runtime.default_context()
    
    length:=(cast(^runtime.Raw_Dynamic_Array)myArray).len
}

OdinArray_giveSlice :: proc "c" (p_userdata: ^OdinArrayObj, rangeStart: GDE.Int, rangeEnd: GDE.Int) -> GDE.ObjectPtr {
    
    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "SliceObject", false)
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

//This runs when the class is created before it gets added to a tree.
//init your class struct, heap allocated variables, any class children.
OdinArrayObjCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, OdinArrayObj_GDClass_String, false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: ^OdinArrayObj = cast(^OdinArrayObj)GDW.gdAPI.mem_alloc(size_of(OdinArrayObj))
    self.selfPtr = object
    
    GDW.gdAPI.object_set_instance(object, &OdinArrayObj_SN, cast(^GDE.Object)self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

//Delete all the heap allocated aspects of the class along with the class struct as well as any
//additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
OdinArrayObjDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    
    GDW.gdAPI.mem_free(cast(^OdinArrayObj)p_instance)

}

//If you ever rename a virtual function (method callback) you will need to update it in three places.
//Here, OdinArrayObjcallVirtualFunctionWithData, the function itself.
//Look at Godot docs to know what is supported by a certain class. If it inherits from another, it will also inherit its methods.
//ie something that inherits canvas item will have draw.
OdinArrayObjgetVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)OdinArrayObj_ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)OdinArrayObj_process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)OdinArrayObj_physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)OdinArrayObj_draw
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)OdinArrayObj_Input
    }
    return nil
}


//Thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//Unfortunately the more methods you registered in OdinArrayObjgetVirtualWithData the more times this thing is called.
OdinArrayObjcallVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)OdinArrayObj_physics {
        GDW.virtualProcCall(OdinArrayObj_physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)OdinArrayObj_process {
        GDW.virtualProcCall(OdinArrayObj_process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)OdinArrayObj_draw {
        GDW.virtualProcCall(OdinArrayObj_draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)OdinArrayObj_Input {
        GDW.virtualProcCall(OdinArrayObj_Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)OdinArrayObj_ready {
        GDW.virtualProcCall(OdinArrayObj_ready, p_instance, p_args, r_ret)
    }
}

OdinArrayObj_ready :: proc "c" (self: ^OdinArrayObj) {
    context = runtime.default_context()//These are good to set in a singleton at some point.
    //These are statically stored and thus only need to be called once when the game engine is fully initialize.
    GDW.getInputSingleton()
    //GDW.getPhysServer2dObj()
    //GDW.getRenderServer2dObj()

}

OdinArrayObj_physics :: proc "c" (self: ^OdinArrayObj, delta: f64) {
    context = runtime.default_context()
    
}

OdinArrayObj_process :: proc "c" (self: ^OdinArrayObj, delta: f64) {
    context = runtime.default_context()
    //fmt.println(self.selfArray)
    
    stringname: GDE.StringName
    getRefCount_SN: GDE.StringName
    getRefCount: GDE.MethodBindPtr
    GDW.StringConstruct.stringNameNewLatin(&stringname, OdinArrayObj_GDClass_String, false)
    GDW.StringConstruct.stringNameNewLatin(&getRefCount_SN, "get_reference_count", false)
    getRefCount = GDW.gdAPI.classDBGetMethodBind(&stringname, &getRefCount_SN, 3905245786)
    ret: GDE.Int
    GDW.gdAPI.objectMethodBindPtrCall(getRefCount, self.selfPtr, nil, &ret)
    fmt.println("ferCount", ret)
}

OdinArrayObj_draw :: proc "c" (self: ^OdinArrayObj) {

}


OdinArrayObj_Input :: proc "c" (self: ^OdinArrayObj, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

OdinArrayObj_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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
