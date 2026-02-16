package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


bool_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_bool_Methods :: proc(bool_method_store: ^bool_Methods_list) {
  bool_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 0)
  bool_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 1)
  bool_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 2)
  bool_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 3)
  bool_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .BOOL, .NIL)
  bool_method_store.VARIANT_OP_EQUAL_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_NOT_EQUAL_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_LESS_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_GREATER_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_AND_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_OR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_XOR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .BOOL, .BOOL)
  bool_method_store.VARIANT_OP_AND_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .BOOL, .INT)
  bool_method_store.VARIANT_OP_OR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .BOOL, .INT)
  bool_method_store.VARIANT_OP_XOR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .BOOL, .INT)
  bool_method_store.VARIANT_OP_AND_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .BOOL, .FLOAT)
  bool_method_store.VARIANT_OP_OR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .BOOL, .FLOAT)
  bool_method_store.VARIANT_OP_XOR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .BOOL, .FLOAT)
  bool_method_store.VARIANT_OP_AND_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .BOOL, .OBJECT)
  bool_method_store.VARIANT_OP_OR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .BOOL, .OBJECT)
  bool_method_store.VARIANT_OP_XOR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .BOOL, .OBJECT)
  bool_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BOOL, .DICTIONARY)
  bool_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BOOL, .ARRAY)
}
