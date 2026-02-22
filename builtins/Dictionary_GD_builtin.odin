package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Dictionary_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  size:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  clear:  GDE.PtrBuiltInMethod,
  assign:  GDE.PtrBuiltInMethod,
  sort:  GDE.PtrBuiltInMethod,
  merge:  GDE.PtrBuiltInMethod,
  merged:  GDE.PtrBuiltInMethod,
  has:  GDE.PtrBuiltInMethod,
  has_all:  GDE.PtrBuiltInMethod,
  find_key:  GDE.PtrBuiltInMethod,
  erase:  GDE.PtrBuiltInMethod,
  hash:  GDE.PtrBuiltInMethod,
  keys:  GDE.PtrBuiltInMethod,
  values:  GDE.PtrBuiltInMethod,
  duplicate:  GDE.PtrBuiltInMethod,
  duplicate_deep:  GDE.PtrBuiltInMethod,
  get:  GDE.PtrBuiltInMethod,
  get_or_add:  GDE.PtrBuiltInMethod,
  set:  GDE.PtrBuiltInMethod,
  is_typed:  GDE.PtrBuiltInMethod,
  is_typed_key:  GDE.PtrBuiltInMethod,
  is_typed_value:  GDE.PtrBuiltInMethod,
  is_same_typed:  GDE.PtrBuiltInMethod,
  is_same_typed_key:  GDE.PtrBuiltInMethod,
  is_same_typed_value:  GDE.PtrBuiltInMethod,
  get_typed_key_builtin:  GDE.PtrBuiltInMethod,
  get_typed_value_builtin:  GDE.PtrBuiltInMethod,
  get_typed_key_class_name:  GDE.PtrBuiltInMethod,
  get_typed_value_class_name:  GDE.PtrBuiltInMethod,
  get_typed_key_script:  GDE.PtrBuiltInMethod,
  get_typed_value_script:  GDE.PtrBuiltInMethod,
  make_read_only:  GDE.PtrBuiltInMethod,
  is_read_only:  GDE.PtrBuiltInMethod,
  recursive_equal:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Dictionary_Methods :: proc(Dictionary_method_store: ^Dictionary_Methods_list) {
  Dictionary_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 0)
  Dictionary_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 1)
  Dictionary_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 2)
  Dictionary_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.DICTIONARY)
  Dictionary_method_store.size = GDW.Get_Builtin_Method(.DICTIONARY, "size", 3173160232)
  Dictionary_method_store.is_empty = GDW.Get_Builtin_Method(.DICTIONARY, "is_empty", 3918633141)
  Dictionary_method_store.clear = GDW.Get_Builtin_Method(.DICTIONARY, "clear", 3218959716)
  Dictionary_method_store.assign = GDW.Get_Builtin_Method(.DICTIONARY, "assign", 3642266950)
  Dictionary_method_store.sort = GDW.Get_Builtin_Method(.DICTIONARY, "sort", 3218959716)
  Dictionary_method_store.merge = GDW.Get_Builtin_Method(.DICTIONARY, "merge", 2079548978)
  Dictionary_method_store.merged = GDW.Get_Builtin_Method(.DICTIONARY, "merged", 2271165639)
  Dictionary_method_store.has = GDW.Get_Builtin_Method(.DICTIONARY, "has", 3680194679)
  Dictionary_method_store.has_all = GDW.Get_Builtin_Method(.DICTIONARY, "has_all", 2988181878)
  Dictionary_method_store.find_key = GDW.Get_Builtin_Method(.DICTIONARY, "find_key", 1988825835)
  Dictionary_method_store.erase = GDW.Get_Builtin_Method(.DICTIONARY, "erase", 1776646889)
  Dictionary_method_store.hash = GDW.Get_Builtin_Method(.DICTIONARY, "hash", 3173160232)
  Dictionary_method_store.keys = GDW.Get_Builtin_Method(.DICTIONARY, "keys", 4144163970)
  Dictionary_method_store.values = GDW.Get_Builtin_Method(.DICTIONARY, "values", 4144163970)
  Dictionary_method_store.duplicate = GDW.Get_Builtin_Method(.DICTIONARY, "duplicate", 830099069)
  Dictionary_method_store.duplicate_deep = GDW.Get_Builtin_Method(.DICTIONARY, "duplicate_deep", 2160600714)
  Dictionary_method_store.get = GDW.Get_Builtin_Method(.DICTIONARY, "get", 2205440559)
  Dictionary_method_store.get_or_add = GDW.Get_Builtin_Method(.DICTIONARY, "get_or_add", 1052551076)
  Dictionary_method_store.set = GDW.Get_Builtin_Method(.DICTIONARY, "set", 2175348267)
  Dictionary_method_store.is_typed = GDW.Get_Builtin_Method(.DICTIONARY, "is_typed", 3918633141)
  Dictionary_method_store.is_typed_key = GDW.Get_Builtin_Method(.DICTIONARY, "is_typed_key", 3918633141)
  Dictionary_method_store.is_typed_value = GDW.Get_Builtin_Method(.DICTIONARY, "is_typed_value", 3918633141)
  Dictionary_method_store.is_same_typed = GDW.Get_Builtin_Method(.DICTIONARY, "is_same_typed", 3471775634)
  Dictionary_method_store.is_same_typed_key = GDW.Get_Builtin_Method(.DICTIONARY, "is_same_typed_key", 3471775634)
  Dictionary_method_store.is_same_typed_value = GDW.Get_Builtin_Method(.DICTIONARY, "is_same_typed_value", 3471775634)
  Dictionary_method_store.get_typed_key_builtin = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_key_builtin", 3173160232)
  Dictionary_method_store.get_typed_value_builtin = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_value_builtin", 3173160232)
  Dictionary_method_store.get_typed_key_class_name = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_key_class_name", 1825232092)
  Dictionary_method_store.get_typed_value_class_name = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_value_class_name", 1825232092)
  Dictionary_method_store.get_typed_key_script = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_key_script", 1460142086)
  Dictionary_method_store.get_typed_value_script = GDW.Get_Builtin_Method(.DICTIONARY, "get_typed_value_script", 1460142086)
  Dictionary_method_store.make_read_only = GDW.Get_Builtin_Method(.DICTIONARY, "make_read_only", 3218959716)
  Dictionary_method_store.is_read_only = GDW.Get_Builtin_Method(.DICTIONARY, "is_read_only", 3918633141)
  Dictionary_method_store.recursive_equal = GDW.Get_Builtin_Method(.DICTIONARY, "recursive_equal", 1404404751)
  Dictionary_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .DICTIONARY, .NIL)
  Dictionary_method_store.VARIANT_OP_EQUAL_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_NOT_EQUAL_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .DICTIONARY, .ARRAY)
}
