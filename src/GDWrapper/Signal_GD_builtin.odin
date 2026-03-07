package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Signal_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Signal, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Signal,  #by_ptr p_args: struct{ from: ^Signal, }),
    Create2: proc "c" (p_base: ^Signal,  #by_ptr p_args: struct{ object: ^Object, signal: ^StringName, }),
    Destroy: proc "c" (p_base: ^Signal),
    get_ptr: proc "c" (base: ^Variant) -> ^Signal,
    is_null:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_object:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^Object, p_argument_count: i64 = 0),
    get_object_id:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_name:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    connect:  proc "c" (p_base: ^Signal, #by_ptr p_args: struct{ callable: ^Callable, flags: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    disconnect:  proc "c" (p_base: ^Signal, #by_ptr p_args: struct{ callable: ^Callable, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    is_connected:  proc "c" (p_base: ^Signal, #by_ptr p_args: struct{ callable: ^Callable, }, r_return: ^Bool, p_argument_count: i64 = 1),
    get_connections:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^Array, p_argument_count: i64 = 0),
    has_connections:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    emit:  proc "c" (p_base: ^Signal, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Signal, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Signal: proc "c" (p_left: ^Signal, p_right: ^Signal, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Signal: proc "c" (p_left: ^Signal, p_right: ^Signal, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Signal, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Signal, p_right: ^Array, r_result: ^Bool),
}
init_Signal_Methods :: proc(Signal_method_store: ^Signal_Methods_list) {
  Signal_method_store.Create0 = cast(type_of(Signal_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 0)
  Signal_method_store.Create1 = cast(type_of(Signal_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 1)
  Signal_method_store.Create2 = cast(type_of(Signal_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 2)
  Signal_method_store.Destroy = cast(type_of(Signal_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.SIGNAL)
    Signal_method_store.get_ptr = cast(type_of(Signal_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.SIGNAL)
  Signal_method_store.is_null = cast(type_of(Signal_method_store.is_null))Get_Builtin_Method(.SIGNAL, "is_null", 3918633141)
  Signal_method_store.get_object = cast(type_of(Signal_method_store.get_object))Get_Builtin_Method(.SIGNAL, "get_object", 4008621732)
  Signal_method_store.get_object_id = cast(type_of(Signal_method_store.get_object_id))Get_Builtin_Method(.SIGNAL, "get_object_id", 3173160232)
  Signal_method_store.get_name = cast(type_of(Signal_method_store.get_name))Get_Builtin_Method(.SIGNAL, "get_name", 1825232092)
  Signal_method_store.connect = cast(type_of(Signal_method_store.connect))Get_Builtin_Method(.SIGNAL, "connect", 979702392)
  Signal_method_store.disconnect = cast(type_of(Signal_method_store.disconnect))Get_Builtin_Method(.SIGNAL, "disconnect", 3470848906)
  Signal_method_store.is_connected = cast(type_of(Signal_method_store.is_connected))Get_Builtin_Method(.SIGNAL, "is_connected", 4129521963)
  Signal_method_store.get_connections = cast(type_of(Signal_method_store.get_connections))Get_Builtin_Method(.SIGNAL, "get_connections", 4144163970)
  Signal_method_store.has_connections = cast(type_of(Signal_method_store.has_connections))Get_Builtin_Method(.SIGNAL, "has_connections", 3918633141)
  Signal_method_store.emit = cast(type_of(Signal_method_store.emit))Get_Builtin_Method(.SIGNAL, "emit", 3286317445)
  Signal_method_store.VARIANT_OP_NOT_ = cast(type_of(Signal_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .SIGNAL, .NIL)
  Signal_method_store.VARIANT_OP_EQUAL_Signal = cast(type_of(Signal_method_store.VARIANT_OP_EQUAL_Signal))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .SIGNAL, .SIGNAL)
  Signal_method_store.VARIANT_OP_NOT_EQUAL_Signal = cast(type_of(Signal_method_store.VARIANT_OP_NOT_EQUAL_Signal))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .SIGNAL, .SIGNAL)
  Signal_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Signal_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .SIGNAL, .DICTIONARY)
  Signal_method_store.VARIANT_OP_IN_Array = cast(type_of(Signal_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .SIGNAL, .ARRAY)
}
