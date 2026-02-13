package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


PackedInt32Array_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  get:  GDE.PtrBuiltInMethod,
  set:  GDE.PtrBuiltInMethod,
  size:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  push_back:  GDE.PtrBuiltInMethod,
  append:  GDE.PtrBuiltInMethod,
  append_array:  GDE.PtrBuiltInMethod,
  remove_at:  GDE.PtrBuiltInMethod,
  insert:  GDE.PtrBuiltInMethod,
  fill:  GDE.PtrBuiltInMethod,
  resize:  GDE.PtrBuiltInMethod,
  clear:  GDE.PtrBuiltInMethod,
  has:  GDE.PtrBuiltInMethod,
  reverse:  GDE.PtrBuiltInMethod,
  slice:  GDE.PtrBuiltInMethod,
  to_byte_array:  GDE.PtrBuiltInMethod,
  sort:  GDE.PtrBuiltInMethod,
  bsearch:  GDE.PtrBuiltInMethod,
  duplicate:  GDE.PtrBuiltInMethod,
  find:  GDE.PtrBuiltInMethod,
  rfind:  GDE.PtrBuiltInMethod,
  count:  GDE.PtrBuiltInMethod,
  erase:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedInt32Array: GDE.PtrOperatorEvaluator,
}
init_PackedInt32Array_Methods :: proc(PackedInt32Array_method_store: ^PackedInt32Array_Methods_list) {
  PackedInt32Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT32_ARRAY, 0)
  PackedInt32Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT32_ARRAY, 1)
  PackedInt32Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT32_ARRAY, 2)
  PackedInt32Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT32_ARRAY)
  PackedInt32Array_method_store.get = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "get", 4103005248)
  PackedInt32Array_method_store.set = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "set", 3638975848)
  PackedInt32Array_method_store.size = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "size", 3173160232)
  PackedInt32Array_method_store.is_empty = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "is_empty", 3918633141)
  PackedInt32Array_method_store.push_back = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "push_back", 694024632)
  PackedInt32Array_method_store.append = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "append", 694024632)
  PackedInt32Array_method_store.append_array = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "append_array", 1087733270)
  PackedInt32Array_method_store.remove_at = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "remove_at", 2823966027)
  PackedInt32Array_method_store.insert = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "insert", 1487112728)
  PackedInt32Array_method_store.fill = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "fill", 2823966027)
  PackedInt32Array_method_store.resize = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "resize", 848867239)
  PackedInt32Array_method_store.clear = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "clear", 3218959716)
  PackedInt32Array_method_store.has = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "has", 931488181)
  PackedInt32Array_method_store.reverse = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "reverse", 3218959716)
  PackedInt32Array_method_store.slice = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "slice", 1216021098)
  PackedInt32Array_method_store.to_byte_array = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "to_byte_array", 247621236)
  PackedInt32Array_method_store.sort = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "sort", 3218959716)
  PackedInt32Array_method_store.bsearch = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "bsearch", 954237325)
  PackedInt32Array_method_store.duplicate = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "duplicate", 3158844420)
  PackedInt32Array_method_store.find = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "find", 2984303840)
  PackedInt32Array_method_store.rfind = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "rfind", 2984303840)
  PackedInt32Array_method_store.count = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "count", 4103005248)
  PackedInt32Array_method_store.erase = GDW.Get_Builtin_Method(.PACKED_INT32_ARRAY, "erase", 694024632)
  PackedInt32Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_INT32_ARRAY, .NIL)
  PackedInt32Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT32_ARRAY, .DICTIONARY)
  PackedInt32Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT32_ARRAY, .ARRAY)
  PackedInt32Array_method_store.VARIANT_OP_EQUAL_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_INT32_ARRAY, .PACKED_INT32_ARRAY)
  PackedInt32Array_method_store.VARIANT_OP_NOT_EQUAL_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_INT32_ARRAY, .PACKED_INT32_ARRAY)
  PackedInt32Array_method_store.VARIANT_OP_ADD_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_INT32_ARRAY, .PACKED_INT32_ARRAY)
}
