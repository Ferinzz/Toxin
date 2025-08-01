package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"
import "core:log"


/*
* Example to make the processes only run during the game instead of during the editor: 
* https://github.com/godotengine/godot/blob/662d0b188dc2bd6ca50ea0c3b3b9accb8255acfc/scene/2d/camera_2d.cpp#L67-L78
* Discussion
* https://godotforums.org/d/36709-life-cycle-of-gdextension-nodes-in-the-editor/5
*/

/*
* Godot will need a getter and setter to be able to handle variables 'made public'
* This function will generate basic get and set functions for you. Register their callbacks, register them for use in the editor or GDScripts.
* Assumption: you are setting all the information in a struct. You will provide the name of the field as you've declared it.
* P: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
*/
makePublic :: proc "c" ($P: typeid, $fieldName: cstring,
                        methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
                        loc:= #caller_location)
                        where sics.type_has_field(P, fieldName) //No point trying if the field doesn't exist. Typo safety.
    {
    context = runtime.default_context()
    //get the index from the GDTypes array, this is equivalent to the VariantType enum placement.
    index, ok := slice.linear_search(GDE.GDTypes[:], sics.type_field_type(P, fieldName))
    if ok == false {
        panic("The type sent to makePublic was not found in GDW.GDTypes. Please check the list of valid Godot types.", loc)
    }
    
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^P, godotValue: sics.type_field_type(P, fieldName)) {
        (cast(^sics.type_field_type(P, fieldName))(cast(uintptr)p_classData+offset_of_by_string(P, fieldName)))^ = godotValue
    }
    
    get :: proc "c" (p_classData: ^P) -> sics.type_field_type(P, fieldName) {
        context = runtime.default_context()
        
        return (cast(^sics.type_field_type(P, fieldName))(cast(uintptr)p_classData+offset_of_by_string(P, fieldName)))^
    }

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    className := fmt.caprint(type_info_of(P))
    defer delete(className)

    //These functions create the callbacks Godot will used to call set and get.
    bindMethod(className, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(className, "get_"+fieldName, get, methodType, loc = loc)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    bindProperty(className, fieldName, GDE.VariantType(index), "get_"+fieldName, "set_"+fieldName)
}

/*
* Will call bindNoReturn2 to create callback functions for Godot to call your function with.
* Once callbacks are created will supply all information in methodInfo so that your function can be bound to Godot.
* Once bound these should be available in GDScript.
* Godot only supports one return value per function.
*
* className: Name that holds the method.
* methodName: Name of the method you're binding; shown in the editor
* function: Pointer to the function you are binding to Godot
* argNames: Names of the arguments; shown in the Editor
*/
bindMethod :: proc "c" (className, methodName: cstring,
                        function: $T,
                        methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
                        argNames: ..cstring, loc:= #caller_location
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    context = runtime.default_context()

    methodStringName: GDE.StringName
    StringConstruct.stringNameNewLatin(&methodStringName, methodName, false)

    argcount:: sics.type_proc_parameter_count(T) - 1

    if argcount != len(argNames){
        panic("Number of args in function does not match number of argNames provided", loc)
    }
    

    ptrcallFunc, callFunc:= bindNoReturn2(function)
    when argcount > 0 {
        argsInfo: [argcount]GDE.PropertyInfo
        
        index:int
        index, _ = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 1))
        argsInfo[0] = make_property(GDE.VariantType(index), argNames[0])

        when argcount > 1 
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 2))
        argsInfo[1] = make_property(GDE.VariantType(index), argNames[1])}
        
        when argcount > 2 
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 3))
        argsInfo[2] = make_property(GDE.VariantType(index), argNames[2])}
        
        when argcount > 3
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 4))
        argsInfo[3] = make_property(GDE.VariantType(index), argNames[3])}
        
        when argcount > 4
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 5))
         argsInfo[4] = make_property(GDE.VariantType(index), argNames[4])}
        
        when argcount > 5
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 6))
        argsInfo[5] = make_property(GDE.VariantType(index), argNames[5])}
        
        when argcount > 6
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 7))
        argsInfo[6] = make_property(GDE.VariantType(index), argNames[6])}
    }
    else do argsInfo:= 0
    

    //I THINK that the metadata is a way to pass a type to Godot which isn't what it's specified as.
    when sics.type_proc_parameter_count(T) - 1 > 0 {
        
        args_metadata: [argcount]GDE.ClassMethodArgumentMetadata
        args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE

        when argcount > 1 do args_metadata[1] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 2 do args_metadata[2] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 3 do args_metadata[3] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 4 do args_metadata[4] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 5 do args_metadata[5] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 6 do args_metadata[6] = GDE.ClassMethodArgumentMetadata.NONE
    }
    else do args_metadata:= 0

    //Check if there's a return at compile-time. If there is, search the array for the corresponding type.
    //Else set 0.
    when sics.type_proc_return_count(T) > 0 {
    returnType, ok:= slice.linear_search(GDE.GDTypes[:], sics.type_proc_return_type(T, 0))
    if !ok {
        panic("Type is not a part of the GDE.GDTypes. Please verify the list in GDE.GDDEfs.", loc)
    }}
    else
    {returnType:= 0 }

    //string passed doesn't show up in Editor Documentation.? Leaving as something random for now.
    returnInfo: GDE.PropertyInfo = make_property(GDE.VariantType(returnType), "123")

    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = callFunc,
        ptrcall_func = ptrcallFunc,
        method_flags = u32(methodType),
    }

    
    when sics.type_proc_return_count(T) > 0 {
    
        methodInfo.has_return_value = returnType != 0
        methodInfo.return_value_info = &returnInfo
        methodInfo.return_value_metadata = GDE.ClassMethodArgumentMetadata.NONE
    }

    when sics.type_proc_parameter_count(T) - 1 > 0{
    
        methodInfo.argument_count = u32(argcount)
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]
    }

    classNameString: GDE.StringName
    StringConstruct.stringNameNewLatin(&classNameString, className, false)

    gdAPI.classdbRegisterExtensionClassMethod(Library, &classNameString, &methodInfo)
    
    //Destructor things.
    Destructors.stringNameDestructor(&methodStringName)
    Destructors.stringNameDestructor(&classNameString)
    destructProperty(&returnInfo)

}


/*
* bindProperty is used to make your variable public.
* Prior to calling this you should have registered the get and/or set functions with Godot.
* Provide their names as cstrings. Check the makePublic function for a general workflow.
* Use makePublic to auto-gen basic get/set functions for simple variables. (I haven't tested with arrays.)
*/
bindProperty :: proc "c" (className, name: cstring, type: GDE.VariantType, getter, setter: cstring) {
    //context = runtime.default_context()
    
    classNameString: GDE.StringName
    StringConstruct.stringNameNewLatin(&classNameString, className, false)
    info: GDE.PropertyInfo = make_property(type, name)

    getterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&getterName, getter, false)

    setterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&setterName, setter, false)
    
    //fmt.println("register property")
    gdAPI.classDBRegisterExtensionClassProperty(Library, &classNameString, &info, &setterName, &getterName)
    //fmt.println("register property complete")

    //Destructor stuff
    destructProperty(&info)
}



//This is messy. I dunno if this is better or worse than having 7 individual functions... Lots of casting. Eh.
//This is also using some really old functions for the variant conversion since they provide a return instead of needing an empty pointer.
bindNoReturn2 :: proc "c" (function: $P) -> (GDE.ClassMethodPtrCall, GDE.ClassMethodCall) {
    context = runtime.default_context()
    argcount:: sics.type_proc_parameter_count(P)
    argT0 :: sics.type_proc_parameter_type(P, 0)
    

    when argcount == 1 {
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance)
            } else {
                func(cast(argT0)p_instance)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small o args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance)
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance)
            }
        }
    return godotPtrCallback, godotVariantCallback

    } else {
        argT1 :: sics.type_proc_parameter_type(P, 1)
        when argcount == 2 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1))
                    variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT2 :: sics.type_proc_parameter_type(P, 2)
        when argcount == 3 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                            fromvariant(cast(GDE.VariantPtr)p_args[1], argT2))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT3 :: sics.type_proc_parameter_type(P, 3)
        when argcount == 4 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2), fromvariant(p_args[2], argT3))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT4 :: sics.type_proc_parameter_type(P, 4)
        when argcount == 5 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2), fromvariant(p_args[2], argT3),
                    fromvariant(p_args[3], argT4))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT5 :: sics.type_proc_parameter_type(P, 5)
        when argcount == 6 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
                
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2), fromvariant(p_args[2], argT3),
                    fromvariant(p_args[3], argT4), fromvariant(p_args[4], argT5))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT6 :: sics.type_proc_parameter_type(P, 6)
        when argcount == 7 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT6)p_args[5])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5),
                    fromvariant(cast(GDE.VariantPtr)p_args[5], argT6))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2), fromvariant(p_args[2], argT3),
                    fromvariant(p_args[3], argT4), fromvariant(p_args[4], argT5), fromvariant(p_args[5], argT6))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT7 :: sics.type_proc_parameter_type(P, 7)
        when argcount == 8 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6), typetoenum(argT7)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5),
                    fromvariant(cast(GDE.VariantPtr)p_args[5], argT6), fromvariant(cast(GDE.VariantPtr)p_args[6], argT7))
                variant_from(r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(p_args[0], argT1), fromvariant(p_args[1], argT2), fromvariant(p_args[2], argT3),
                    fromvariant(p_args[3], argT4), fromvariant(p_args[4], argT5), fromvariant(p_args[5], argT6), fromvariant(p_args[6], argT7))
            }
        }
    return godotPtrCallback, godotVariantCallback
    } else {
        panic("yikes")
    }
}}}}}}}}

