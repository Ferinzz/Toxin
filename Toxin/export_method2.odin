
package Toxin

import "base:runtime"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import sics "base:intrinsics"
import "core:fmt"
import "base:builtin"
import "core:slice"
import "core:strings"
import "core:strconv"
import "core:reflect"


@(private)
Get_Proc_Names :: #force_inline proc(function: $T) -> []string {
    info:= type_info_of(T)
    return info.variant.(runtime.Type_Info_Procedure).params.variant.(runtime.Type_Info_Parameters).names
}
@(private)
get_arg_deets :: #force_inline proc(args: []arg_deets, function: $P, $offset: int) {
    argcount:: sics.type_proc_parameter_count(P) - offset
    when argcount > 0 {
        args[0].variant_type = variant_index(sics.type_elem_type(sics.type_proc_parameter_type(P, offset)))
        
        when argcount > 1 do args[1].variant_type = variant_index(sics.type_elem_type(sics.type_proc_parameter_type(P, 1+ offset)))
        when argcount > 2 do args[2].variant_type = variant_index(sics.type_elem_type(sics.type_proc_parameter_type(P, 2+ offset)))
        when argcount > 3 do args[3].variant_type = variant_index(sics.type_elem_type(sics.type_proc_parameter_type(P, 3+ offset)))
        when argcount > 4 do args[4].variant_type = variant_index(sics.type_elem_type(sics.type_proc_parameter_type(P, 4+ offset)))
        for name, i in (Get_Proc_Names(function))[offset:] {
            args[i].name = name
        }
    }
}
//Arguments with default values must be at the end of the function’s argument list.
//You just have to pass arguments in order. If you have more than one, and you want to pass something for the last, you have to pass something for all the ones before. There are no named arguments when calling a function. 

_bind_default :: proc(function: $P, class: ^StringName, call_info:= #caller_expression(function)) where (sics.type_is_proc(P) && sics.type_proc_parameter_count(P) <= 6) {
    argcount:: sics.type_proc_parameter_count(P) - 1

    ptrcall:: sics.procedure_of(godotPtrCallback(function, nil, {}, nil))
    call:: sics.procedure_of(godotVariantCallback(function, nil, {}, 0, nil, nil))
    args: [5]arg_deets
    get_arg_deets(args[:argcount], function, 1)

    ret: GDE.VariantType
    when sics.type_proc_return_count(P) > 0 {
        ret = variant_index(sics.type_proc_return_type(P, 0))
    }

    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(call_info), Int(len(call_info)))

    bind_method(class, &methodStringName, rawptr(function), call, ptrcall, ret, args[:argcount])
    Destroy(&methodStringName)
}
_bind_static :: proc(function: $P, class: ^StringName, call_info:= #caller_expression(function)) where (sics.type_is_proc(P) && sics.type_proc_parameter_count(P) <= 6) {
    argcount:: sics.type_proc_parameter_count(P)

    ptrcall:: sics.procedure_of(godotPtrCallback_s(function, nil, {}, nil))
    call:: sics.procedure_of(godotVariantCallback_s(function, nil, {}, 0, nil, nil))
    args: [5]arg_deets
    get_arg_deets(args[:argcount], function, 0)

    ret: GDE.VariantType
    when sics.type_proc_return_count(P) > 0 {
        ret = variant_index(sics.type_proc_return_type(P, 0))
    }

    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(call_info), Int(len(call_info)))

    bind_method(class, &methodStringName, rawptr(function), call, ptrcall, ret, args[:argcount], {.STATIC})
    Destroy(&methodStringName)
}

method_info :: struct($P: typeid) {
    function: P,
    default: []^Variant,
}
_make_method_info :: proc(function: $P, args: []^Variant) -> ^method_info(P) {
    info:= new(method_info(P))
    info.function = function
    info.default = make([]^Variant, len(args))
    for arg, i in args {
        info.default[i]=arg
    }
    return info
}
_delete_method_info :: proc(bind_info: ^$T/method_info($P)) {
    delete(bind_info.default)
    delete(bind_info)
}
@(require_results)
_bind_with_defaults :: proc(function: $P, class: ^StringName, defaults: ..^Variant, call_info:= #caller_expression(function)) -> (^method_info(P)) where (sics.type_is_proc(P) && sics.type_proc_parameter_count(P) <= 6) {
    argcount:: sics.type_proc_parameter_count(P) - 1
    assert(argcount>=len(defaults), "default args should be less than amount of arguments")

    bind_info:= _make_method_info(function, defaults[:])
    ptrcall:: sics.procedure_of(godotPtrCallback_dv(method_info(P){function, {}}, nil, {}, nil))
    call:: sics.procedure_of(godotVariantCallback_dv(method_info(P){function, {}}, nil, {}, 0, nil, nil))
    args: [5]arg_deets
    get_arg_deets(args[:argcount], function, 1)

    ret: GDE.VariantType
    when sics.type_proc_return_count(P) > 0 {
        ret = variant_index(sics.type_proc_return_type(P, 0))
    }

    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(call_info), Int(len(call_info)))

    bind_method(class, &methodStringName, rawptr(bind_info), call, ptrcall, ret, args[:argcount], {.STATIC}, defaults)
    Destroy(&methodStringName)
    return bind_info
}

godotPtrCallback_dv :: proc "c"  (method_userdata: $P, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
    godotPtrCallback(method_userdata.function, p_instance, p_args, r_ret)
}
godotVariantCallback_dv :: proc "c" (userdata: $T/method_info($P), p_instance: GDE.ClassInstancePtr,
    p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    argCount::sics.type_proc_parameter_count(P) - 1
    args:[argCount]^Variant
    for arg, i in p_args[:p_argument_count] {
        args[i] = arg
    }
    if p_argument_count<argCount {
        start:=len(userdata.default)-int(argCount - p_argument_count)
        for arg, i in userdata.default[start:] {
            args[i+int(p_argument_count)] = arg
        }
    }
    call::sics.procedure_of(godotVariantCallback(userdata.function, nil, {}, 0, nil,nil))
    call(userdata.function, p_instance, raw_data(args[:]), argCount, r_return, r_error)
}
@(require_results)
_bind_static_with_defaults :: proc(function: $P, class: ^StringName, defaults: ..^Variant, call_info:= #caller_expression(function)) -> (^method_info(P)) where (sics.type_is_proc(P) && sics.type_proc_parameter_count(P) <= 6) {
    argcount:: sics.type_proc_parameter_count(P)
    assert(argcount>=len(defaults), "default args should be less than amount of arguments")

    bind_info:= _make_method_info(function, defaults[:])
    ptrcall:: sics.procedure_of(godotPtrCallback_sdv(method_info(P){function, {}}, nil, {}, nil))
    call:: sics.procedure_of(godotVariantCallback_sdv(method_info(P){function, {}}, nil, {}, 0, nil, nil))
    args: [5]arg_deets
    get_arg_deets(args[:argcount], function, 0)

    ret: GDE.VariantType
    when sics.type_proc_return_count(P) > 0 {
        ret = variant_index(sics.type_proc_return_type(P, 0))
    }

    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(call_info), Int(len(call_info)))

    bind_method(class, &methodStringName, rawptr(bind_info), call, ptrcall, ret, args[:argcount], {.STATIC}, defaults)
    Destroy(&methodStringName)
    return bind_info
}

godotPtrCallback_sdv :: proc "c"  (method_userdata: $P, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
    godotPtrCallback_s(method_userdata.function, p_instance, p_args, r_ret)
}
godotVariantCallback_sdv :: proc "c" (userdata: $T/method_info($P), p_instance: GDE.ClassInstancePtr,
    p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    argCount::sics.type_proc_parameter_count(P)
    args:[argCount]^Variant
    for arg, i in p_args[:p_argument_count] {
        args[i] = arg
    }
    if p_argument_count<argCount {
        start:=len(userdata.default)-int(argCount - p_argument_count)
        for arg, i in userdata.default[start:] {
            args[i+int(p_argument_count)] = arg
        }
    }
    call::sics.procedure_of(godotVariantCallback_s(userdata.function, nil, {}, 0, nil,nil))
    call(userdata.function, p_instance, raw_data(args[:]), argCount, r_return, r_error)
}


//called by the binding methods. You should not need to call this directly yourself.
bind_method :: #force_no_inline proc(class, funcname: ^StringName, user_data: rawptr, vCallFunc:GDE.ClassMethodCall, ptrCallFunc: GDE.ClassMethodPtrCall, ret: GDE.VariantType, args: []arg_deets, methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, default_args: []^Variant={}) {
    maxargs::5
    argsInfo: [maxargs]GDE.PropertyInfo
    for arg, i in args {
        argsInfo[i] = make_property(arg.variant_type, arg.name)
    }
    args_metadata:[maxargs]GDE.ClassMethodArgumentMetadata={}

    //only necessary to have a specific string when the export type is not default.
    returnInfo: GDE.PropertyInfo = make_property(ret, "")

    methodInfo : GDE.ClassMethodInfo = {
        name = funcname,
        method_userdata = user_data,

        call_func = vCallFunc,
        ptrcall_func = ptrCallFunc,
        method_flags = (methodType),
        argument_count = u32(len(args)),
        arguments_info = raw_data(argsInfo[:]),
        arguments_metadata = raw_data(args_metadata[:]),
        has_return_value = ret != .NIL,
        return_value_info = &returnInfo,
        return_value_metadata = GDE.ClassMethodArgumentMetadata.NONE,
        default_argument_count = u32(len(default_args)),
        default_arguments = raw_data(default_args[:]),
    }

    gdAPI.ClassDB.RegisterExtensionClassMethod(Library, class, &methodInfo)

    destructProperty(&returnInfo)
    for i in 0..<len(args) {
        destructProperty(&argsInfo[i])
    }
}

godotPtrCallback :: proc "c" (method_userdata: $P, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
    context = runtime.default_context()
    func := cast(P)method_userdata
    arg0:: sics.type_proc_parameter_type(P, 0)
    when sics.type_proc_parameter_count(P)==2{
    s_ptrs:struct{
    arg1:(sics.type_proc_parameter_type(P, 1))}
    s_ptrs.arg1=cast(sics.type_proc_parameter_type(P, 1))p_args[0]
    }
    when sics.type_proc_parameter_count(P)==3{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 1))p_args[0],
    cast(sics.type_proc_parameter_type(P, 2))p_args[1])
    }
    when sics.type_proc_parameter_count(P)==4{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 1))p_args[0],
    cast(sics.type_proc_parameter_type(P, 2))p_args[1],
    cast(sics.type_proc_parameter_type(P, 3))p_args[2])
    }
    when sics.type_proc_parameter_count(P)==5{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 1))p_args[0],
    cast(sics.type_proc_parameter_type(P, 2))p_args[1],
    cast(sics.type_proc_parameter_type(P, 3))p_args[2],
    cast(sics.type_proc_parameter_type(P, 4))p_args[3])
    }
    when sics.type_proc_parameter_count(P)==6{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 1))p_args[0],
    cast(sics.type_proc_parameter_type(P, 2))p_args[1],
    cast(sics.type_proc_parameter_type(P, 3))p_args[2],
    cast(sics.type_proc_parameter_type(P, 4))p_args[3],
    cast(sics.type_proc_parameter_type(P, 5))p_args[4])
    }
    when sics.type_proc_parameter_count(P) > 1 {
        when sics.type_proc_return_count(P) > 0 {
        //Dictionary and Array need to be destroyed specifically before returning to them.
        //Others are fine so far, but better safe than sorry.
        when sics.type_proc_return_type(P, 0) == Dictionary || sics.type_proc_return_type(P, 0) == Array ||
             sics.type_proc_return_type(P, 0) == gdstring || sics.type_proc_return_type(P, 0) == StringName ||
             sics.type_proc_return_type(P, 0) == Callable || sics.type_proc_return_type(P, 0) == PackedByteArray ||
             sics.type_proc_return_type(P, 0) == PackedInt32Array || sics.type_proc_return_type(P, 0) == PackedInt64Array ||
             sics.type_proc_return_type(P, 0) == PackedFloat32Array || sics.type_proc_return_type(P, 0) == PackedFloat64Array ||
             sics.type_proc_return_type(P, 0) == PackedStringArray || sics.type_proc_return_type(P, 0) == PackedVector2Array ||
             sics.type_proc_return_type(P, 0) == PackedVector3Array || sics.type_proc_return_type(P, 0) == PackedColorArray ||
             sics.type_proc_return_type(P, 0) == NodePath || sics.type_proc_return_type(P, 0) == Signal ||
             sics.type_proc_return_type(P, 0) == PackedVector4Array {
                ret:= (cast(P)method_userdata)(cast(arg0)p_instance, expand_values(s_ptrs))
            Ref_Count(&ret, (cast(^(sics.type_proc_return_type(P, 0)))r_ret))
        } else {
            (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = (cast(P)method_userdata)(cast(arg0)p_instance, expand_values(s_ptrs))
        }
    } else {
        (cast(P)method_userdata)(cast(arg0)p_instance, expand_values(s_ptrs))
    }
    } else {
    when sics.type_proc_return_count(P) > 0 {
        when sics.type_proc_return_type(P, 0) == Dictionary || sics.type_proc_return_type(P, 0) == Array ||
             sics.type_proc_return_type(P, 0) == gdstring || sics.type_proc_return_type(P, 0) == StringName ||
             sics.type_proc_return_type(P, 0) == Callable || sics.type_proc_return_type(P, 0) == PackedByteArray ||
             sics.type_proc_return_type(P, 0) == PackedInt32Array || sics.type_proc_return_type(P, 0) == PackedInt64Array ||
             sics.type_proc_return_type(P, 0) == PackedFloat32Array || sics.type_proc_return_type(P, 0) == PackedFloat64Array ||
             sics.type_proc_return_type(P, 0) == PackedStringArray || sics.type_proc_return_type(P, 0) == PackedVector2Array ||
             sics.type_proc_return_type(P, 0) == PackedVector3Array || sics.type_proc_return_type(P, 0) == PackedColorArray ||
             sics.type_proc_return_type(P, 0) == NodePath || sics.type_proc_return_type(P, 0) == Signal ||
             sics.type_proc_return_type(P, 0) == PackedVector4Array {
                ret:= (cast(P)method_userdata)(cast(arg0)p_instance)
            Ref_Count(&ret, (cast(^(sics.type_proc_return_type(P, 0)))r_ret))
        } else {
            (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(arg0)p_instance)
        }
    } else {
        func(cast(arg0)p_instance)
    }}
}

godotVariantCallback :: proc "c" (method_userdata: $P, p_instance: GDE.ClassInstancePtr,
    p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    arg_count:: sics.type_proc_parameter_count(P) - 1
    arg0:: sics.type_proc_parameter_type(P, 0)
    when sics.type_proc_parameter_count(P)==2{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 1),
        }
    }
    when sics.type_proc_parameter_count(P)==3{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 1),
            arg2: sics.type_proc_parameter_type(P, 2),
        }
    }
    when sics.type_proc_parameter_count(P)==4{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 1),
            arg2: sics.type_proc_parameter_type(P, 2),
            arg3: sics.type_proc_parameter_type(P, 3),
        }
    }
    when sics.type_proc_parameter_count(P)==5{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 1),
            arg2: sics.type_proc_parameter_type(P, 2),
            arg3: sics.type_proc_parameter_type(P, 3),
            arg4: sics.type_proc_parameter_type(P, 4),
        }
    }
    when sics.type_proc_parameter_count(P)==6{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 1),
            arg2: sics.type_proc_parameter_type(P, 2),
            arg3: sics.type_proc_parameter_type(P, 3),
            arg4: sics.type_proc_parameter_type(P, 4),
            arg5: sics.type_proc_parameter_type(P, 5),
        }
    }
    when sics.type_proc_parameter_count(P) > 1 {
    when sics.type_proc_return_count(P) > 0 {
        to_variant(r_return, (cast(P)method_userdata)(cast(arg0)p_instance, expand_values(variant_multi_return(p_args[:p_argument_count], s_ptrs))))
    } else {
        variant_multi_return(p_args, &s_ptrs)
        (cast(P)method_userdata)(cast(arg0)p_instance, expand_values(s_ptrs))
    }
    } else {
    when sics.type_proc_return_count(P) > 0{
        to_variant(r_return, (cast(P)method_userdata)(cast(arg0)p_instance))
    } else {
        (cast(P)method_userdata)(cast(arg0)p_instance)
    }}
    when sics.type_proc_parameter_count(P) > 1 {
        multi_destructor(&s_ptrs)
    }
}
godotPtrCallback_s :: proc "c" (method_userdata: $P, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
    context = runtime.default_context()
    func := cast(P)method_userdata
    when sics.type_proc_parameter_count(P)==1{
    s_ptrs:struct{arg1:sics.type_proc_parameter_type(P, 0)}
    s_ptrs.arg1=(cast(sics.type_proc_parameter_type(P, 0))p_args[0])
    }
    when sics.type_proc_parameter_count(P)==2{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 0))p_args[0],
    cast(sics.type_proc_parameter_type(P, 1))p_args[1])
    }
    when sics.type_proc_parameter_count(P)==3{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 0))p_args[0],
    cast(sics.type_proc_parameter_type(P, 1))p_args[1],
    cast(sics.type_proc_parameter_type(P, 2))p_args[2])
    }
    when sics.type_proc_parameter_count(P)==4{
    s_ptrs: =compress_values(
    cast(sics.type_proc_parameter_type(P, 0))p_args[0],
    cast(sics.type_proc_parameter_type(P, 1))p_args[1],
    cast(sics.type_proc_parameter_type(P, 2))p_args[2],
    cast(sics.type_proc_parameter_type(P, 3))p_args[3])
    }
    when sics.type_proc_parameter_count(P)==5{
    s_ptrs:=compress_values(
    cast(sics.type_proc_parameter_type(P, 0))p_args[0],
    cast(sics.type_proc_parameter_type(P, 1))p_args[1],
    cast(sics.type_proc_parameter_type(P, 2))p_args[2],
    cast(sics.type_proc_parameter_type(P, 3))p_args[3],
    cast(sics.type_proc_parameter_type(P, 4))p_args[4])
    }
    when sics.type_proc_parameter_count(P) > 0 {
        when sics.type_proc_return_count(P) > 0 {
        //Dictionary and Array need to be destroyed specifically before returning to them.
        //Others are fine so far, but better safe than sorry.
        when sics.type_proc_return_type(P, 0) == Dictionary || sics.type_proc_return_type(P, 0) == Array ||
             sics.type_proc_return_type(P, 0) == gdstring || sics.type_proc_return_type(P, 0) == StringName ||
             sics.type_proc_return_type(P, 0) == Callable || sics.type_proc_return_type(P, 0) == PackedByteArray ||
             sics.type_proc_return_type(P, 0) == PackedInt32Array || sics.type_proc_return_type(P, 0) == PackedInt64Array ||
             sics.type_proc_return_type(P, 0) == PackedFloat32Array || sics.type_proc_return_type(P, 0) == PackedFloat64Array ||
             sics.type_proc_return_type(P, 0) == PackedStringArray || sics.type_proc_return_type(P, 0) == PackedVector2Array ||
             sics.type_proc_return_type(P, 0) == PackedVector3Array || sics.type_proc_return_type(P, 0) == PackedColorArray ||
             sics.type_proc_return_type(P, 0) == NodePath || sics.type_proc_return_type(P, 0) == Signal ||
             sics.type_proc_return_type(P, 0) == PackedVector4Array {
            ret:= (cast(P)method_userdata)(expand_values(s_ptrs))
            Ref_Count(&ret, (cast(^(sics.type_proc_return_type(P, 0)))r_ret))
        } else {
            (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = (cast(P)method_userdata)(expand_values(s_ptrs))
        }
    } else {
        (cast(P)method_userdata)(expand_values(s_ptrs))
    }
    } else {
        when sics.type_proc_return_count(P) > 0 {when sics.type_proc_return_type(P, 0) == Dictionary || sics.type_proc_return_type(P, 0) == Array ||
             sics.type_proc_return_type(P, 0) == gdstring || sics.type_proc_return_type(P, 0) == StringName ||
             sics.type_proc_return_type(P, 0) == Callable || sics.type_proc_return_type(P, 0) == PackedByteArray ||
             sics.type_proc_return_type(P, 0) == PackedInt32Array || sics.type_proc_return_type(P, 0) == PackedInt64Array ||
             sics.type_proc_return_type(P, 0) == PackedFloat32Array || sics.type_proc_return_type(P, 0) == PackedFloat64Array ||
             sics.type_proc_return_type(P, 0) == PackedStringArray || sics.type_proc_return_type(P, 0) == PackedVector2Array ||
             sics.type_proc_return_type(P, 0) == PackedVector3Array || sics.type_proc_return_type(P, 0) == PackedColorArray ||
             sics.type_proc_return_type(P, 0) == NodePath || sics.type_proc_return_type(P, 0) == Signal ||
             sics.type_proc_return_type(P, 0) == PackedVector4Array {
            ret:= (cast(P)method_userdata)()
            Ref_Count(&ret, (cast(^(sics.type_proc_return_type(P, 0)))r_ret))
        } else {
            (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func()
        }
    } else {
        func()
    }}
}

godotVariantCallback_s :: proc "c" (method_userdata: $P, p_instance: GDE.ClassInstancePtr,
    p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    arg_count:: sics.type_proc_parameter_count(P)
    when sics.type_proc_parameter_count(P)==1{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 0),
        }
    }
    when sics.type_proc_parameter_count(P)==2{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 0),
            arg2: sics.type_proc_parameter_type(P, 1),
        }
    }
    when sics.type_proc_parameter_count(P)==3{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 0),
            arg2: sics.type_proc_parameter_type(P, 1),
            arg3: sics.type_proc_parameter_type(P, 2),
        }
    }
    when sics.type_proc_parameter_count(P)==4{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 0),
            arg2: sics.type_proc_parameter_type(P, 1),
            arg3: sics.type_proc_parameter_type(P, 2),
            arg4: sics.type_proc_parameter_type(P, 3),
        }
    }
    when sics.type_proc_parameter_count(P)==5{
    s_ptrs: struct {
            arg1: sics.type_proc_parameter_type(P, 0),
            arg2: sics.type_proc_parameter_type(P, 1),
            arg3: sics.type_proc_parameter_type(P, 2),
            arg4: sics.type_proc_parameter_type(P, 3),
            arg5: sics.type_proc_parameter_type(P, 4),
        }
    }
    when sics.type_proc_parameter_count(P) > 0 {
    when sics.type_proc_return_count(P) > 0 {
        to_variant(r_return, (cast(P)method_userdata)(expand_values(variant_multi_return(p_args, s_ptrs))))
    } else {
        variant_multi_return(p_args, &s_ptrs)
        (cast(P)method_userdata)(expand_values(s_ptrs))
    }
    } else {
    when sics.type_proc_return_count(P) > 0{
        to_variant(r_return, (cast(P)method_userdata)())
    } else {
        (cast(P)method_userdata)()
    }}
    when sics.type_proc_parameter_count(P) > 0 {
        multi_destructor(&s_ptrs)
    }
}

@(private)
variant_multi_return :: proc(vars: GDE.ConstVariantPtrargs, ptrs: ^$T){
    for field, i in reflect.struct_fields_zipped(typeid_of(T)) {
        field_value:= reflect.struct_field_value(ptrs^, field)
        switch field_value.id {
        case ^Int:
            ((^^Int)((field_value).data))^=cast(^Int)(variant_get_ptr(vars[i]))
	    case ^Bool:
            ((^^Bool)((field_value).data))^=cast(^Bool)(variant_get_ptr(vars[i]))
	    case ^float:
            ((^^float)((field_value).data))^=cast(^float)(variant_get_ptr(vars[i]))
	    case ^gdstring:
            ((^^gdstring)((field_value).data))^=cast(^gdstring)(variant_get_ptr(vars[i]))
	    case ^Vector2:
            ((^^Vector2)((field_value).data))^=cast(^Vector2)(variant_get_ptr(vars[i]))
	    case ^Vector2i:
            ((^^Vector2i)((field_value).data))^=cast(^Vector2i)(variant_get_ptr(vars[i]))
	    case ^Rect2:
            ((^^Rect2)((field_value).data))^=cast(^Rect2)(variant_get_ptr(vars[i]))
	    case ^Rect2i:
            ((^^Rect2i)((field_value).data))^=cast(^Rect2i)(variant_get_ptr(vars[i]))
	    case ^Vector3:
            ((^^Vector3)((field_value).data))^=cast(^Vector3)(variant_get_ptr(vars[i]))
	    case ^Vector3i:
            ((^^Vector3i)((field_value).data))^=cast(^Vector3i)(variant_get_ptr(vars[i]))
	    case ^Transform2D:
            ((^^Transform2D)((field_value).data))^=cast(^Transform2D)(variant_get_ptr(vars[i]))
	    case ^Vector4:
            ((^^Vector4)((field_value).data))^=cast(^Vector4)(variant_get_ptr(vars[i]))
	    case ^Vector4i:
            ((^^Vector4i)((field_value).data))^=cast(^Vector4i)(variant_get_ptr(vars[i]))
	    case ^Plane:
            ((^^Plane)((field_value).data))^=cast(^Plane)(variant_get_ptr(vars[i]))
	    case ^Quaternion:
            ((^^Quaternion)((field_value).data))^=cast(^Quaternion)(variant_get_ptr(vars[i]))
	    case ^AABB:
            ((^^AABB)((field_value).data))^=cast(^AABB)(variant_get_ptr(vars[i]))
	    case ^Basis:
            ((^^Basis)((field_value).data))^=cast(^Basis)(variant_get_ptr(vars[i]))
	    case ^Transform3D:
            ((^^Transform3D)((field_value).data))^=cast(^Transform3D)(variant_get_ptr(vars[i]))
	    case ^Projection:
            ((^^Projection)((field_value).data))^=cast(^Projection)(variant_get_ptr(vars[i]))
	    case ^Color:
            ((^^Color)((field_value).data))^=cast(^Color)(variant_get_ptr(vars[i]))
	    case ^StringName:
            ((^^StringName)((field_value).data))^=cast(^StringName)(variant_get_ptr(vars[i]))
	    case ^NodePath:
            ((^^NodePath)((field_value).data))^=cast(^NodePath)(variant_get_ptr(vars[i]))
	    case ^RID:
            ((^^RID)((field_value).data))^=cast(^RID)(variant_get_ptr(vars[i]))
	    case ^Object:
            ((^^Object)((field_value).data))^=cast(^Object)(variant_get_ptr(vars[i]))
	    case ^Callable:
            ((^^Callable)((field_value).data))^=cast(^Callable)(variant_get_ptr(vars[i]))
	    case ^Signal:
            ((^^Signal)((field_value).data))^=cast(^Signal)(variant_get_ptr(vars[i]))
	    case ^Dictionary:
            when builtin.ODIN_DEBUG {
                check_array_type(.DICTIONARY, vars[i].VType)}
                ((^^Dictionary)((field_value).data))^ = new(Dictionary)
                GDW.new_type_from_methods(((^^Dictionary)((field_value).data))^, vars[i])
	    case ^Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.ARRAY, vars[i].VType)}
                ((^^Array)((field_value).data))^ = new(Array)
                GDW.new_type_from_methods(((^^Array)((field_value).data))^, vars[i])
	    case ^PackedByteArray:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_BYTE_ARRAY, vars[i].VType)}
                ((^^PackedByteArray)((field_value).data))^ = new(PackedByteArray)
                GDW.new_type_from_methods(((^^PackedByteArray)((field_value).data))^, vars[i])
	    case ^PackedInt32Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_INT32_ARRAY, vars[i].VType)}
                ((^^PackedInt32Array)((field_value).data))^ = new(PackedInt32Array)
                GDW.new_type_from_methods(((^^PackedInt32Array)((field_value).data))^, vars[i])
	    case ^PackedInt64Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_INT64_ARRAY, vars[i].VType)}
                ((^^PackedInt64Array)((field_value).data))^ = new(PackedInt64Array)
                GDW.new_type_from_methods(((^^PackedInt64Array)((field_value).data))^, vars[i])
	    case ^PackedFloat32Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_FLOAT32_ARRAY, vars[i].VType)}
                ((^^PackedFloat32Array)((field_value).data))^ = new(PackedFloat32Array)
                GDW.new_type_from_methods(((^^PackedFloat32Array)((field_value).data))^, vars[i])
	    case ^PackedFloat64Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_FLOAT64_ARRAY, vars[i].VType)}
                ((^^PackedFloat64Array)((field_value).data))^ = new(PackedFloat64Array)
                GDW.new_type_from_methods(((^^PackedFloat64Array)((field_value).data))^, vars[i])
	    case ^PackedStringArray:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_STRING_ARRAY, vars[i].VType)}
                ((^^PackedStringArray)((field_value).data))^ = new(PackedStringArray)
                GDW.new_type_from_methods(((^^PackedStringArray)((field_value).data))^, vars[i])
	    case ^PackedVector2Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_VECTOR2_ARRAY, vars[i].VType)}
                ((^^PackedVector2Array)((field_value).data))^ = new(PackedVector2Array)
                GDW.new_type_from_methods(((^^PackedVector2Array)((field_value).data))^, vars[i])
	    case ^PackedVector3Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_VECTOR3_ARRAY, vars[i].VType)}
                ((^^PackedVector3Array)((field_value).data))^ = new(PackedVector3Array)
                GDW.new_type_from_methods(((^^PackedVector3Array)((field_value).data))^, vars[i])
        case ^PackedColorArray:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_COLOR_ARRAY, vars[i].VType)}
                ((^^PackedColorArray)((field_value).data))^ = new(PackedColorArray)
                GDW.new_type_from_methods(((^^PackedColorArray)((field_value).data))^, vars[i])
	    case ^PackedVector4Array:
            when builtin.ODIN_DEBUG {
                check_array_type(.PACKED_VECTOR4_ARRAY, vars[i].VType)}
                ((^^PackedVector4Array)((field_value).data))^ = new(PackedVector4Array)
                GDW.new_type_from_methods(((^^PackedVector4Array)((field_value).data))^, vars[i])
        case:
            panic("Should be impossible to reach this. Type of method parameter is not supported.")
    }
    }
}

@(private)
multi_destructor :: proc(ptrs: ^$T) {
    for field, i in reflect.struct_fields_zipped(typeid_of(T)) {
        field_value:= reflect.struct_field_value(ptrs^, field)
        switch field_value.id {
        case ^Int:
	    case ^Bool:
	    case ^float:
	    case ^gdstring:
	    case ^Vector2:
	    case ^Vector2i:
	    case ^Rect2:
	    case ^Rect2i:
	    case ^Vector3:
	    case ^Vector3i:
	    case ^Transform2D:
	    case ^Vector4:
	    case ^Vector4i:
	    case ^Plane:
	    case ^Quaternion:
	    case ^AABB:
	    case ^Basis:
	    case ^Transform3D:
	    case ^Projection:
	    case ^Color:
	    case ^StringName:
	    case ^NodePath:
	    case ^RID:
	    case ^Object:
	    case ^Callable:
	    case ^Signal:
	    case ^Dictionary:
            Destroy((cast(^^Dictionary)field_value.data)^)
            free((cast(^^Dictionary)field_value.data)^)
	    case ^Array:
            Destroy((cast(^^Array)field_value.data)^)
            free((cast(^^Array)field_value.data)^)
	    case ^PackedByteArray:
            Destroy((cast(^^PackedByteArray)field_value.data)^)
            free((cast(^^PackedByteArray)field_value.data)^)
	    case ^PackedInt32Array:
            Destroy((cast(^^PackedInt32Array)field_value.data)^)
            free((cast(^^PackedInt32Array)field_value.data)^)
	    case ^PackedInt64Array:
            Destroy((cast(^^PackedInt64Array)field_value.data)^)
            free((cast(^^PackedInt64Array)field_value.data)^)
	    case ^PackedFloat32Array:
            Destroy((cast(^^PackedFloat32Array)field_value.data)^)
            free((cast(^^PackedFloat32Array)field_value.data)^)
	    case ^PackedFloat64Array:
            Destroy((cast(^^PackedFloat64Array)field_value.data)^)
            free((cast(^^PackedFloat64Array)field_value.data)^)
	    case ^PackedStringArray:
            Destroy((cast(^^PackedStringArray)field_value.data)^)
            free((cast(^^PackedStringArray)field_value.data)^)
	    case ^PackedVector2Array:
            Destroy((cast(^^PackedVector2Array)field_value.data)^)
            free((cast(^^PackedVector2Array)field_value.data)^)
	    case ^PackedVector3Array:
            Destroy((cast(^^PackedVector3Array)field_value.data)^)
            free((cast(^^PackedVector3Array)field_value.data)^)
        case ^PackedColorArray:
            Destroy((cast(^^PackedColorArray)field_value.data)^)
            free((cast(^^PackedColorArray)field_value.data)^)
	    case ^PackedVector4Array:
            Destroy((cast(^^PackedVector4Array)field_value.data)^)
            free((cast(^^PackedVector4Array)field_value.data)^)
        case:
            panic("Should be impossible to reach this. Type of method parameter is not supported.")
    }
    }
}

check_array_type :: proc(desired, actual: GDE.VariantType){
    if desired != actual {
        message:= fmt.caprintf("incorrect type passed as Packed%sArray, this will cause extra allocations", desired)
        field:= fmt.caprint("")
        gdAPI.Logging.PrintErrorWithMessage("mistyped", message, field, "", -1, true)
        delete(message)
        delete(field)
    }
}