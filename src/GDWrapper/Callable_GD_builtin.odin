package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Callable_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Callable, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Callable,  #by_ptr p_args: struct{ from: ^Callable, }),
    Create2: proc "c" (p_base: ^Callable,  #by_ptr p_args: struct{ object: ^Object, method: ^StringName, }),
    Destroy: proc "c" (p_base: ^Callable),
    get_ptr: proc "c" (base: ^Variant) -> ^Callable,
    create:  proc "c" (p_base: ^Callable, #by_ptr p_args: struct{ variant: ^Variant, method: ^StringName, }, r_return: ^Callable, p_argument_count: i64 = 2),
    callv:  proc "c" (p_base: ^Callable, #by_ptr p_args: struct{ arguments: ^Array, }, r_return: ^Variant, p_argument_count: i64 = 1),
    is_null:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_custom:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_standard:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_object:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Object, p_argument_count: i64 = 0),
    get_object_id:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_method:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    get_argument_count:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_bound_arguments_count:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_bound_arguments:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Array, p_argument_count: i64 = 0),
    get_unbound_arguments_count:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    hash:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    bindv:  proc "c" (p_base: ^Callable, #by_ptr p_args: struct{ arguments: ^Array, }, r_return: ^Callable, p_argument_count: i64 = 1),
    unbind:  proc "c" (p_base: ^Callable, #by_ptr p_args: struct{ argcount: ^Int, }, r_return: ^Callable, p_argument_count: i64 = 1),
    call:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    call_deferred:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    rpc:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    rpc_id:  proc "c" (p_base: ^Callable, #by_ptr p_args: struct{ peer_id: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    bind:  proc "c" (p_base: ^Callable, p_args: rawptr = nil, r_return: ^Callable, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Callable, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Callable: proc "c" (p_left: ^Callable, p_right: ^Callable, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Callable: proc "c" (p_left: ^Callable, p_right: ^Callable, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Callable, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Callable, p_right: ^Array, r_result: ^Bool),
}
init_Callable_Methods :: proc "c" (Callable_method_store: ^Callable_Methods_list) {
  Callable_method_store.Create0 = cast(type_of(Callable_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 0)
  Callable_method_store.Create1 = cast(type_of(Callable_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 1)
  Callable_method_store.Create2 = cast(type_of(Callable_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 2)
  Callable_method_store.Destroy = cast(type_of(Callable_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.CALLABLE)
    Callable_method_store.get_ptr = cast(type_of(Callable_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.CALLABLE)
  Callable_method_store.create = cast(type_of(Callable_method_store.create))Get_Builtin_Method(.CALLABLE, "create", 1709381114)
  Callable_method_store.callv = cast(type_of(Callable_method_store.callv))Get_Builtin_Method(.CALLABLE, "callv", 413578926)
  Callable_method_store.is_null = cast(type_of(Callable_method_store.is_null))Get_Builtin_Method(.CALLABLE, "is_null", 3918633141)
  Callable_method_store.is_custom = cast(type_of(Callable_method_store.is_custom))Get_Builtin_Method(.CALLABLE, "is_custom", 3918633141)
  Callable_method_store.is_standard = cast(type_of(Callable_method_store.is_standard))Get_Builtin_Method(.CALLABLE, "is_standard", 3918633141)
  Callable_method_store.is_valid = cast(type_of(Callable_method_store.is_valid))Get_Builtin_Method(.CALLABLE, "is_valid", 3918633141)
  Callable_method_store.get_object = cast(type_of(Callable_method_store.get_object))Get_Builtin_Method(.CALLABLE, "get_object", 4008621732)
  Callable_method_store.get_object_id = cast(type_of(Callable_method_store.get_object_id))Get_Builtin_Method(.CALLABLE, "get_object_id", 3173160232)
  Callable_method_store.get_method = cast(type_of(Callable_method_store.get_method))Get_Builtin_Method(.CALLABLE, "get_method", 1825232092)
  Callable_method_store.get_argument_count = cast(type_of(Callable_method_store.get_argument_count))Get_Builtin_Method(.CALLABLE, "get_argument_count", 3173160232)
  Callable_method_store.get_bound_arguments_count = cast(type_of(Callable_method_store.get_bound_arguments_count))Get_Builtin_Method(.CALLABLE, "get_bound_arguments_count", 3173160232)
  Callable_method_store.get_bound_arguments = cast(type_of(Callable_method_store.get_bound_arguments))Get_Builtin_Method(.CALLABLE, "get_bound_arguments", 4144163970)
  Callable_method_store.get_unbound_arguments_count = cast(type_of(Callable_method_store.get_unbound_arguments_count))Get_Builtin_Method(.CALLABLE, "get_unbound_arguments_count", 3173160232)
  Callable_method_store.hash = cast(type_of(Callable_method_store.hash))Get_Builtin_Method(.CALLABLE, "hash", 3173160232)
  Callable_method_store.bindv = cast(type_of(Callable_method_store.bindv))Get_Builtin_Method(.CALLABLE, "bindv", 3564560322)
  Callable_method_store.unbind = cast(type_of(Callable_method_store.unbind))Get_Builtin_Method(.CALLABLE, "unbind", 755001590)
  Callable_method_store.call = cast(type_of(Callable_method_store.call))Get_Builtin_Method(.CALLABLE, "call", 3643564216)
  Callable_method_store.call_deferred = cast(type_of(Callable_method_store.call_deferred))Get_Builtin_Method(.CALLABLE, "call_deferred", 3286317445)
  Callable_method_store.rpc = cast(type_of(Callable_method_store.rpc))Get_Builtin_Method(.CALLABLE, "rpc", 3286317445)
  Callable_method_store.rpc_id = cast(type_of(Callable_method_store.rpc_id))Get_Builtin_Method(.CALLABLE, "rpc_id", 2270047679)
  Callable_method_store.bind = cast(type_of(Callable_method_store.bind))Get_Builtin_Method(.CALLABLE, "bind", 3224143119)
  Callable_method_store.VARIANT_OP_NOT_ = cast(type_of(Callable_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .CALLABLE, .NIL)
  Callable_method_store.VARIANT_OP_EQUAL_Callable = cast(type_of(Callable_method_store.VARIANT_OP_EQUAL_Callable))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .CALLABLE, .CALLABLE)
  Callable_method_store.VARIANT_OP_NOT_EQUAL_Callable = cast(type_of(Callable_method_store.VARIANT_OP_NOT_EQUAL_Callable))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .CALLABLE, .CALLABLE)
  Callable_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Callable_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .CALLABLE, .DICTIONARY)
  Callable_method_store.VARIANT_OP_IN_Array = cast(type_of(Callable_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .CALLABLE, .ARRAY)
}
