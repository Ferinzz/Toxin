package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import sics "base:intrinsics"
import "base:runtime"

/* Get a binding to a method from Godot's class DB.
* Pass in the class and method name as strings. The function will convert Odin strings to Godot's StringName.
* 
* className : a string with the name of the Godot class
* methodName : a string with the name of a method in the Godot class
* hash : the hash of the method. find it in the json. Careful of buildmode it's under.
*/
@(deprecated="Use classDBGetMethodBind3")
classDBGetMethodBind :: proc "c" (className, methodName: cstring, hash: i64, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {

    native_class_name: StringName;
    method_name: StringName;
    
    gdAPI.StringName_Utils.Latin1Chars(&native_class_name, className, false)
    gdAPI.StringName_Utils.Latin1Chars(&method_name, methodName, false)
    
    methodBind = gdAPI.ClassDB.GetMethodBind(&native_class_name, &method_name, hash)
    //assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)
    
    StringName_M_List.Destroy(&native_class_name)
    StringName_M_List.Destroy(&method_name)

    return methodBind
}

@(deprecated="Use classDBGetMethodBind3")
classDBGetMethodBind2 :: proc "c" (className: ^StringName, methodName: cstring, hash: i64, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {
    //assert(className != nil, "ClassName is nil. Did you accidentally free this early?")
    method_name: StringName;
    
    gdAPI.StringName_Utils.Latin1Chars(&method_name, methodName, false)
    
    methodBind = gdAPI.ClassDB.GetMethodBind(className, &method_name, hash)
    //assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)
    
    
    StringName_M_List.Destroy(&method_name)

    return methodBind
}

classDBGetMethodBind3 :: proc "c" (className: ClassName_Index, methodName: cstring, hash: i64, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {
    native_class_name: ^StringName;
    method_name: StringName;

    //native_class_name = GDClass_StringName_get(className)
    gdAPI.StringName_Utils.Latin1Chars(&method_name, methodName, false)

    methodBind = gdAPI.ClassDB.GetMethodBind(&method_name, &method_name, hash)
    //assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)

    StringName_M_List.Destroy(&method_name)

    return methodBind
}

//Do not use. Used for padding where necessary. Container for Godot's Vector class.
cowData :: struct {
    _ptr: rawptr,
    data: rawptr,
}

mb_container :: struct {
  mb: ^MethodBind,
  mbptrcall: rawptr,
}


//Godot creates a class which has several utility methods and the below properties.
//Of interest if you feel like being hacky would be the method value, which is a direct pointer to the method which you could call if you're brave enough.
//(Don't call them directly. The setup needed to do so feels very hacky and property fields are verrrry inconsistent.)
MethodBind :: struct #align(8) {
    //vtable: rawptr,
    vtable: Int,
    method_id: i32,
    hint_flags: i32,
    name: StringName,
    instance_class:  StringName,
    default_args_size: cowData,
    default_arg_count: i32,
    argument_count: i32,
    _static: Bool,
    _const: Bool,
    _returns: Bool,
    _returns_raw_obj_ptr: Bool,
    argument_types: ^GDE.VariantType,
    argument_Names: cowData, //Only in debug builds.
    method: rawptr, //The actual method we want to use!
}
