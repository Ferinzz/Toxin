package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


NodePath_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  is_absolute:  GDE.PtrBuiltInMethod,
  get_name_count:  GDE.PtrBuiltInMethod,
  get_name:  GDE.PtrBuiltInMethod,
  get_subname_count:  GDE.PtrBuiltInMethod,
  hash:  GDE.PtrBuiltInMethod,
  get_subname:  GDE.PtrBuiltInMethod,
  get_concatenated_names:  GDE.PtrBuiltInMethod,
  get_concatenated_subnames:  GDE.PtrBuiltInMethod,
  slice:  GDE.PtrBuiltInMethod,
  get_as_property_path:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_NodePath: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_NodePath: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_NodePath_Methods :: proc(NodePath_method_store: ^NodePath_Methods_list) {
  NodePath_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 0)
  NodePath_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 1)
  NodePath_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 2)
  NodePath_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.NODE_PATH)
  NodePath_method_store.is_absolute = Get_Builtin_Method(.NODE_PATH, "is_absolute", 3918633141)
  NodePath_method_store.get_name_count = Get_Builtin_Method(.NODE_PATH, "get_name_count", 3173160232)
  NodePath_method_store.get_name = Get_Builtin_Method(.NODE_PATH, "get_name", 2948586938)
  NodePath_method_store.get_subname_count = Get_Builtin_Method(.NODE_PATH, "get_subname_count", 3173160232)
  NodePath_method_store.hash = Get_Builtin_Method(.NODE_PATH, "hash", 3173160232)
  NodePath_method_store.get_subname = Get_Builtin_Method(.NODE_PATH, "get_subname", 2948586938)
  NodePath_method_store.get_concatenated_names = Get_Builtin_Method(.NODE_PATH, "get_concatenated_names", 1825232092)
  NodePath_method_store.get_concatenated_subnames = Get_Builtin_Method(.NODE_PATH, "get_concatenated_subnames", 1825232092)
  NodePath_method_store.slice = Get_Builtin_Method(.NODE_PATH, "slice", 421628484)
  NodePath_method_store.get_as_property_path = Get_Builtin_Method(.NODE_PATH, "get_as_property_path", 1598598043)
  NodePath_method_store.is_empty = Get_Builtin_Method(.NODE_PATH, "is_empty", 3918633141)
  NodePath_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .NODE_PATH, .NIL)
  NodePath_method_store.VARIANT_OP_EQUAL_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NODE_PATH, .NODE_PATH)
  NodePath_method_store.VARIANT_OP_NOT_EQUAL_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NODE_PATH, .NODE_PATH)
  NodePath_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NODE_PATH, .DICTIONARY)
  NodePath_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NODE_PATH, .ARRAY)
}
