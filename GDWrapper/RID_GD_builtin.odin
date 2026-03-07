package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


RID_Methods_list :: struct {
    Create0: proc "c" (p_base: ^RID, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^RID,  #by_ptr p_args: struct{ from: ^RID, }),
    get_ptr: proc "c" (base: ^Variant) -> ^RID,
    is_valid:  proc "c" (p_base: ^RID, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_id:  proc "c" (p_base: ^RID, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^RID, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_LESS_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_GREATER_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_RID: proc "c" (p_left: ^RID, p_right: ^RID, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^RID, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^RID, p_right: ^Array, r_result: ^Bool),
}
init_RID_Methods :: proc(RID_method_store: ^RID_Methods_list) {
  RID_method_store.Create0 = cast(type_of(RID_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.RID, 0)
  RID_method_store.Create1 = cast(type_of(RID_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.RID, 1)
    RID_method_store.get_ptr = cast(type_of(RID_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.RID)
  RID_method_store.is_valid = cast(type_of(RID_method_store.is_valid))Get_Builtin_Method(.RID, "is_valid", 3918633141)
  RID_method_store.get_id = cast(type_of(RID_method_store.get_id))Get_Builtin_Method(.RID, "get_id", 3173160232)
  RID_method_store.VARIANT_OP_NOT_ = cast(type_of(RID_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .RID, .NIL)
  RID_method_store.VARIANT_OP_EQUAL_RID = cast(type_of(RID_method_store.VARIANT_OP_EQUAL_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_NOT_EQUAL_RID = cast(type_of(RID_method_store.VARIANT_OP_NOT_EQUAL_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_LESS_RID = cast(type_of(RID_method_store.VARIANT_OP_LESS_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .RID, .RID)
  RID_method_store.VARIANT_OP_LESS_EQUAL_RID = cast(type_of(RID_method_store.VARIANT_OP_LESS_EQUAL_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_GREATER_RID = cast(type_of(RID_method_store.VARIANT_OP_GREATER_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .RID, .RID)
  RID_method_store.VARIANT_OP_GREATER_EQUAL_RID = cast(type_of(RID_method_store.VARIANT_OP_GREATER_EQUAL_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(RID_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RID, .DICTIONARY)
  RID_method_store.VARIANT_OP_IN_Array = cast(type_of(RID_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RID, .ARRAY)
}
