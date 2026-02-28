
package Toxin

import "base:runtime"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"
import "core:strings"
import "core:strconv"
import "core:reflect"

Get_Proc_Names :: #force_inline proc(function: $T) -> []string {
    info:= type_info_of(T)
    return info.variant.(runtime.Type_Info_Procedure).params.variant.(runtime.Type_Info_Parameters).names
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
* This creates 2 functions.
*/
bindMethod :: #force_inline proc(className: ^StringName, methodName: string,
                        function: $T,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location,
                        call_info:= #caller_expression
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))
    fmt.println(call_info)
    fmt.println(Get_Proc_Names(function))
    argcount:: sics.type_proc_parameter_count(T) - 1

    argNames:= Get_Proc_Names(function)

    ptrcallFunc, callFunc:= bindNoReturn2(function, loc=loc)
    when argcount > 0 {
        argsInfo: [argcount]GDE.PropertyInfo
        
        index:GDE.VariantType
        index= variant_index(sics.type_elem_type(sics.type_proc_parameter_type(T, 1)))
        if sics.type_proc_parameter_type(T, 1) == ^PackedInt64Array do index = (GDE.VariantType.PACKED_INT64_ARRAY)
        argsInfo[0] = make_property((index), argNames[1])

        when argcount > 1 do argsInfo[1] = make_property(variant_index(sics.type_proc_parameter_type(T, 2)), argNames[2])
        when argcount > 2 do argsInfo[2] = make_property(variant_index(sics.type_proc_parameter_type(T, 3)), argNames[3])
        when argcount > 3 do argsInfo[3] = make_property(variant_index(sics.type_proc_parameter_type(T, 4)), argNames[4])
        when argcount > 4 do argsInfo[4] = make_property(variant_index(sics.type_proc_parameter_type(T, 5)), argNames[5])
        when argcount > 5 do argsInfo[5] = make_property(variant_index(sics.type_proc_parameter_type(T, 6)), argNames[6])
        when argcount > 6 do argsInfo[6] = make_property(variant_index(sics.type_proc_parameter_type(T, 7)), argNames[7])
    }
    else do argsInfo:= 0
    

    //TODO: test removing this or setting a fixed value.
    //These are only in existence when Godot is compiled in debug mode. Can ignore in release builds.
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

    //Check if there's a return. If there is, search for the corresponding type.
    //Else set 0.
    when sics.type_proc_return_count(T) > 0 {
        returnType:= variant_index(sics.type_proc_return_type(T, 0))
    }
    else {
        returnType:= 0
    }

    //only necessary to have a specific string when the export type is not default.
    returnInfo: GDE.PropertyInfo = make_property(GDE.VariantType(returnType), "")

    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = callFunc,
        ptrcall_func = ptrcallFunc,
        method_flags = (methodType),
    }

    when sics.type_proc_return_count(T) > 1 {
        #panic("Godot does not support multiple returns. Consider using an Array as return.")
    } else {
    when sics.type_proc_return_count(T) > 0 {
    
        methodInfo.has_return_value = returnType != 0
        methodInfo.return_value_info = &returnInfo
        methodInfo.return_value_metadata = GDE.ClassMethodArgumentMetadata.NONE
    }

    when sics.type_proc_parameter_count(T) - 1 > 0{
    
        methodInfo.argument_count = u32(argcount)
        methodInfo.arguments_info = raw_data(argsInfo[:])
        methodInfo.arguments_metadata = &args_metadata[0]
    }
    }

    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)

    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&returnInfo)
    for props in argsInfo {
        destructProperty(props)
    }

}

/*
* TODO: update to only pass the pointers to the getter/setter in order to simplify some of this.
** Return will still need specific types.
** Variant type validation would still need type validation.
*/
//This is messy. I dunno if this is better or worse than having 7 individual functions... Lots of casting. Eh.
//This is also using some really old functions for the variant conversion since they provide a return instead of needing an empty pointer.
bindNoReturn2 :: #force_inline proc(function: $P, loc:=#caller_location) -> (GDE.ClassMethodPtrCall, GDE.ClassMethodCall) {
    argcount:: sics.type_proc_parameter_count(P) - 1
    argT0 :: sics.type_proc_parameter_type(P, 0)
    

    when argcount == 0 {
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small o args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance)
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance)
            }
        }
    return godotPtrCallback, godotVariantCallback

    } else {
        argT1 :: sics.type_proc_parameter_type(P, 1)
        when argcount == 1 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, #by_ptr p_args: struct{a: ^argT1}, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
            } else {
                //func(cast(argT0)p_instance, (cast(^argT1)p_args.a)^)
                func(cast(argT0)p_instance, expand_values(p_args)^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount]GDE.VariantType {typetoenum(argT1)}
            variantTypeCheck(gdTypeList[:], p_args, r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(p_args[0], argT1))
                    copy_to_variant(r_return, &result)
            } else {
                fmt.println("copy returned: ", copy_from_variant_r(p_args[0], argT1))
                fmt.println("Variant's data: ", (p_args[0]).data)
                val: argT1
                val = copy_from_variant_r(p_args[0], argT1)
                func(cast(argT0)p_instance, val)
            }
        }
    return cast(GDE.ClassMethodPtrCall)godotPtrCallback, godotVariantCallback
    }else {
        argT2 :: sics.type_proc_parameter_type(P, 2)
        when argcount == 2 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, #by_ptr p_args: struct{a: argT1, b: argT2}, r_ret: GDE.TypePtr){
            context = runtime.default_context()

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, expand_values(p_args))
            } else {
                func(cast(argT0)p_instance, expand_values(p_args))
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }

            gdTypeList:= [argcount]GDE.VariantType {variant_index(argT1), variant_index(argT2)}
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(p_args[0], argT1),
                            copy_from_variant_r(p_args[1], argT2))
                copy_to_variant(r_return, &result)
            } else {
                a:=copy_from_variant_r(p_args[0], sics.type_elem_type(argT1))
                b:=copy_from_variant_r(p_args[1], sics.type_elem_type(argT2))
                func(cast(argT0)p_instance, &a, &b)
            }
        }
    return cast(GDE.ClassMethodPtrCall)godotPtrCallback, godotVariantCallback
    }else {
        argT3 :: sics.type_proc_parameter_type(P, 3)
        when argcount == 3 {
        
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }

            gdTypeList:= [argcount]GDE.VariantType {variant_index(argT1), variant_index(argT2), variant_index(argT3)}
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(cast(GDE.VariantPtr)p_args[0], argT1),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[1], argT2), copy_from_variant_r(cast(GDE.VariantPtr)p_args[2], argT3))
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, copy_from_variant_r(cast(^GDE.Variant)p_args[0], argT1), copy_from_variant_r(cast(^GDE.Variant)p_args[1], argT2), copy_from_variant_r(cast(^GDE.Variant)p_args[2], argT3))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT4 :: sics.type_proc_parameter_type(P, 4)
        when argcount == 4 {
        
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {

            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4)}
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(cast(GDE.VariantPtr)p_args[0], argT1),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[1], argT2), copy_from_variant_r(cast(GDE.VariantPtr)p_args[2], argT3),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[3], argT4))
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, copy_from_variant_r(cast(^GDE.Variant)p_args[0], argT1), copy_from_variant_r(cast(^GDE.Variant)p_args[1], argT2), copy_from_variant_r(cast(^GDE.Variant)p_args[2], argT3),
                    copy_from_variant_r(cast(^GDE.Variant)p_args[3], argT4))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT5 :: sics.type_proc_parameter_type(P, 5)
        when argcount == 5 {
        
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
                
            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5)}
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(cast(GDE.VariantPtr)p_args[0], argT1),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[1], argT2), copy_from_variant_r(cast(GDE.VariantPtr)p_args[2], argT3),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[3], argT4), copy_from_variant_r(cast(GDE.VariantPtr)p_args[4], argT5))
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, copy_from_variant_r(cast(^GDE.Variant)p_args[0], argT1), copy_from_variant_r(cast(^GDE.Variant)p_args[1], argT2), copy_from_variant_r(cast(^GDE.Variant)p_args[2], argT3),
                    copy_from_variant_r(cast(^GDE.Variant)p_args[3], argT4), copy_from_variant_r(cast(^GDE.Variant)p_args[4], argT5))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT6 :: sics.type_proc_parameter_type(P, 6)
        when argcount == 6 {
        
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {

            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(cast(GDE.VariantPtr)p_args[0], argT1),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[1], argT2), copy_from_variant_r(cast(GDE.VariantPtr)p_args[2], argT3),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[3], argT4), copy_from_variant_r(cast(GDE.VariantPtr)p_args[4], argT5),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[5], argT6))
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, copy_from_variant_r(cast(^GDE.Variant)p_args[0], argT1), copy_from_variant_r(cast(^GDE.Variant)p_args[1], argT2), copy_from_variant_r(cast(^GDE.Variant)p_args[2], argT3),
                    copy_from_variant_r(cast(^GDE.Variant)p_args[3], argT4), copy_from_variant_r(cast(^GDE.Variant)p_args[4], argT5), copy_from_variant_r(cast(^GDE.Variant)p_args[5], argT6))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT7 :: sics.type_proc_parameter_type(P, 7)
        when argcount == 7 {
        
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
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {

            context = runtime.default_context()
            if p_argument_count < argcount {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6), typetoenum(argT7)}
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, copy_from_variant_r(cast(GDE.VariantPtr)p_args[0], argT1),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[1], argT2), copy_from_variant_r(cast(GDE.VariantPtr)p_args[2], argT3),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[3], argT4), copy_from_variant_r(cast(GDE.VariantPtr)p_args[4], argT5),
                    copy_from_variant_r(cast(GDE.VariantPtr)p_args[5], argT6), copy_from_variant_r(cast(GDE.VariantPtr)p_args[6], argT7))
                copy_to_variant(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, copy_from_variant_r(cast(^GDE.Variant)p_args[0], argT1), copy_from_variant_r(cast(^GDE.Variant)p_args[1], argT2), copy_from_variant_r(cast(^GDE.Variant)p_args[2], argT3),
                    copy_from_variant_r(cast(^GDE.Variant)p_args[3], argT4), copy_from_variant_r(cast(^GDE.Variant)p_args[4], argT5), copy_from_variant_r(cast(^GDE.Variant)p_args[5], argT6), copy_from_variant_r(cast(^GDE.Variant)p_args[6], argT7))
            }
        }
    return godotPtrCallback, godotVariantCallback
    } else {
        panic("yikes")
    }
}}}}}}}}
