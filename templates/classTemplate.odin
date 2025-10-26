package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    selfPtr: GDE.ObjectPtr, //always keep. Self-reference to this object's memory in Godot.
    someProperty: GDE.Int,
}

THIS_CLASS_NAME_SN : GDE.StringName
THIS_CLASS_NAME_CString: cstring = "THIS_CLASS_NAME"
THIS_CLASS_NAME_GDClass_Index: GDW.ClassName_Index = .Node2D
THIS_CLASS_NAME_GDClass_StringName: GDE.StringName

//Technically can have a single massive function to init everything, but having one in each is easier?
//Make sure to add this to the init of the extension otherwise you won't be able to access this class.
//p_userdata and initLevel are optional.
//p_userdata: I'm assuming this is best used to pass the context around. If context is set in the calling class this should be implicitly passed to this one.
//initLevel: Pass in the current init level from the entry's extentionInit proc.
//See where registerSprite is called in the loadTextureToSceneTree main.odin
THIS_CLASS_NAME_Register :: proc "c" ($classStruct: typeid, initLevel:GDE.InitializationLevel, p_userdata:rawptr=nil) {
    context = runtime.default_context()

    /*
    * Specify at what init level this should be loaded at.
    * If this check fails, then you did not put it in the correct init level in the extensionInit proc.
    * This template example assumes .INITIALIZATION_SCENE is the desired init timing for this class and as a result it is specified here.
    */
    assert(initLevel == .INITIALIZATION_SCENE, "Class init function called at a different level than was specified.")

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    //review definition of GDE.ClassCreationInfo4 for more details on each field.
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
        create_instance_func = THIS_CLASS_NAMECreate,
        free_instance_func = THIS_CLASS_NAMEDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  THIS_CLASS_NAMEgetVirtualWithData,
        call_virtual_with_data_func = THIS_CLASS_NAMEcallVirtualFunctionWithData,
        class_userdata = nil, 
    }

    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(&THIS_CLASS_NAME_SN, THIS_CLASS_NAME_CString, false)

    
    THIS_CLASS_NAME_GDClass_StringName = GDW.ClassName_StringName_get(THIS_CLASS_NAME_GDClass_Index)


    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &THIS_CLASS_NAME_SN, THIS_CLASS_NAME_GDClass_StringName, &class_info)
    
    THIS_CLASS_NAMEBindMethod()
}

//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAMEBindMethod :: proc "c" (){

    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    GDW.bindMethod(&THIS_CLASS_NAME_SN, "Some_method_name", somePublicFunction, GDE.ClassMethodFlags.NORMAL, "arg1")
    
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    GDW.Export(THIS_CLASS_NAME, "someProperty")
}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
somePublicFunction :: proc "c" (classStruct: ^THIS_CLASS_NAME, arg1: GDE.Int) {
    //do stuff
}


//This runs once when the class is created before it gets added to a tree.
//construct parent class, malloc your class struct, set defaults, heap allocate variables, construct any class children.
//This is different from Godot's ready, which is called sometime after this.
THIS_CLASS_NAMECreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(THIS_CLASS_NAME_GDClass_StringName)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: ^THIS_CLASS_NAME = cast(^THIS_CLASS_NAME)GDW.gdAPI.mem_alloc(size_of(THIS_CLASS_NAME))
    self.selfPtr = object
    
    GDW.gdAPI.object_set_instance(object, &THIS_CLASS_NAME_SN, cast(^GDE.Object)self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

//Delete all the heap allocated aspects of the class along with the class struct as well as any
//additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
//Removing from scene tree does not necessarily destroy a class.
THIS_CLASS_NAMEDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    
    GDW.gdAPI.mem_free(cast(^THIS_CLASS_NAME)p_instance)
}

//Tells Godot what function pointer to use when calling your function.
//Runs once at class registration.
//Remove those you are not using.
//If you ever rename a virtual function (method callback) you will need to update it in three places.
//Here, THIS_CLASS_NAMEcallVirtualFunctionWithData, the function itself.
//Look at Godot docs to know what is supported by a certain class. If it inherits from another, it will also inherit its methods.
//ie something that inherits canvas item will have draw.
//Can replace the StringName compare (which is slower) with a compare to the p_hash. This would require checking the extension_api.json for the correct hash.
THIS_CLASS_NAMEgetVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    //This is safe because there's only one _ready method in all of the classes.
    if p_hash == 3218959716 {
        return cast(rawptr)THIS_CLASS_NAME_ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)THIS_CLASS_NAME_process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)THIS_CLASS_NAME_physics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)THIS_CLASS_NAME_draw
    }
    //Only one _input method exists in Godot classes, so this is safe for now.
    if p_hash == 3754044979 {
        return cast(rawptr)THIS_CLASS_NAME_Input
    }
    return nil
}

//Will be called any time Godot needs to call your version of a virtual function.
//We had to create special helpers for our functions during the Export(bind) step because Godot only give use an array of arg pointers.
//As a result we can't call our function directly. (unless you want to deal with some any type conversion yourself).
//It's good to keep this in a particular order. The least likely or one-time event should be last.
//The more methods you registered in THIS_CLASS_NAMEgetVirtualWithData the more times this thing is called.
THIS_CLASS_NAMEcallVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME_physics {
        GDW.virtualProcCall(THIS_CLASS_NAME_physics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME_process {
        GDW.virtualProcCall(THIS_CLASS_NAME_process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME_draw {
        GDW.virtualProcCall(THIS_CLASS_NAME_draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME_Input {
        GDW.virtualProcCall(THIS_CLASS_NAME_Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)THIS_CLASS_NAME_ready {
        GDW.virtualProcCall(THIS_CLASS_NAME_ready, p_instance, p_args, r_ret)
    }
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\


/*
* The complicated part of virutal methods is dealt with by Toxin.
* Once registered and configured in the above two procs you don't need any extra steps.
* Write the functions as normal Odin functions and allow Toxin to handle the rawptr casts.
* Continue to be mindful of what data is in Godot vs your extension.
*/

THIS_CLASS_NAME_ready :: proc "c" (self: ^THIS_CLASS_NAME) {
    context = runtime.default_context()
    
    //These are good to set in a singleton at some point.
    //These are statically stored and thus only need to be called once when the game engine is fully initialize.
    GDW.getPhysServer2dObj()
    GDW.getRenderServer2dObj()

}

THIS_CLASS_NAME_physics :: proc "c" (self: ^THIS_CLASS_NAME, delta: f64) {
    context = runtime.default_context()
    
    THIS_CLASS_NAME: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    GDW.isMouseButtonPressed(&THIS_CLASS_NAME, &isPressed)
    fmt.println(isPressed)
}

THIS_CLASS_NAME_process :: proc "c" (self: ^THIS_CLASS_NAME, delta: f64) {
    context = runtime.default_context()

}

THIS_CLASS_NAME_draw :: proc "c" (self: ^THIS_CLASS_NAME) {

}


THIS_CLASS_NAME_Input :: proc "c" (self: ^THIS_CLASS_NAME, event: GDE.ObjectPtr) {
    context = runtime.default_context()


}

THIS_CLASS_NAME_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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