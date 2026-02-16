package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


RID_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  is_valid:  GDE.PtrBuiltInMethod,
  get_id:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_RID_Methods :: proc(RID_method_store: ^RID_Methods_list) {
  RID_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.RID, 0)
  RID_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.RID, 1)
  RID_method_store.is_valid = Get_Builtin_Method(.RID, "is_valid", 3918633141)
  RID_method_store.get_id = Get_Builtin_Method(.RID, "get_id", 3173160232)
  RID_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .RID, .NIL)
  RID_method_store.VARIANT_OP_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_NOT_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_LESS_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .RID, .RID)
  RID_method_store.VARIANT_OP_LESS_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_GREATER_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .RID, .RID)
  RID_method_store.VARIANT_OP_GREATER_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .RID, .RID)
  RID_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RID, .DICTIONARY)
  RID_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RID, .ARRAY)
}
