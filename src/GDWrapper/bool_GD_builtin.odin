package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


Bool_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Bool, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Bool,  #by_ptr p_args: struct{ from: ^Bool, }),
    Create2: proc "c" (p_base: ^Bool,  #by_ptr p_args: struct{ from: ^Int, }),
    Create3: proc "c" (p_base: ^Bool,  #by_ptr p_args: struct{ from: ^float, }),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Bool, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_LESS_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_GREATER_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_AND_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_OR_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_XOR_Bool: proc "c" (p_left: ^Bool, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_AND_Int: proc "c" (p_left: ^Bool, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_OR_Int: proc "c" (p_left: ^Bool, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_XOR_Int: proc "c" (p_left: ^Bool, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_AND_float: proc "c" (p_left: ^Bool, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_OR_float: proc "c" (p_left: ^Bool, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_XOR_float: proc "c" (p_left: ^Bool, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_AND_Object: proc "c" (p_left: ^Bool, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_OR_Object: proc "c" (p_left: ^Bool, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_XOR_Object: proc "c" (p_left: ^Bool, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Bool, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Bool, p_right: ^Array, r_result: ^Bool),
}
init_Bool_Methods :: proc(Bool_method_store: ^Bool_Methods_list) {
  Bool_method_store.Create0 = cast(type_of(Bool_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 0)
  Bool_method_store.Create1 = cast(type_of(Bool_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 1)
  Bool_method_store.Create2 = cast(type_of(Bool_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 2)
  Bool_method_store.Create3 = cast(type_of(Bool_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 3)
  Bool_method_store.VARIANT_OP_NOT_ = cast(type_of(Bool_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_EQUAL_Bool = cast(type_of(Bool_method_store.VARIANT_OP_EQUAL_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_NOT_EQUAL_Bool = cast(type_of(Bool_method_store.VARIANT_OP_NOT_EQUAL_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_LESS_Bool = cast(type_of(Bool_method_store.VARIANT_OP_LESS_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_GREATER_Bool = cast(type_of(Bool_method_store.VARIANT_OP_GREATER_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_AND_Bool = cast(type_of(Bool_method_store.VARIANT_OP_AND_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_OR_Bool = cast(type_of(Bool_method_store.VARIANT_OP_OR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_XOR_Bool = cast(type_of(Bool_method_store.VARIANT_OP_XOR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_AND_Int = cast(type_of(Bool_method_store.VARIANT_OP_AND_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_OR_Int = cast(type_of(Bool_method_store.VARIANT_OP_OR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_XOR_Int = cast(type_of(Bool_method_store.VARIANT_OP_XOR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .NIL)
  Bool_method_store.VARIANT_OP_AND_float = cast(type_of(Bool_method_store.VARIANT_OP_AND_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .FLOAT)
  Bool_method_store.VARIANT_OP_OR_float = cast(type_of(Bool_method_store.VARIANT_OP_OR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .FLOAT)
  Bool_method_store.VARIANT_OP_XOR_float = cast(type_of(Bool_method_store.VARIANT_OP_XOR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .FLOAT)
  Bool_method_store.VARIANT_OP_AND_Object = cast(type_of(Bool_method_store.VARIANT_OP_AND_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .OBJECT)
  Bool_method_store.VARIANT_OP_OR_Object = cast(type_of(Bool_method_store.VARIANT_OP_OR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .OBJECT)
  Bool_method_store.VARIANT_OP_XOR_Object = cast(type_of(Bool_method_store.VARIANT_OP_XOR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .OBJECT)
  Bool_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Bool_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NIL, .DICTIONARY)
  Bool_method_store.VARIANT_OP_IN_Array = cast(type_of(Bool_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NIL, .ARRAY)
}
