package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


PackedInt64Array_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedInt64Array: GDE.PtrOperatorEvaluator,
}
init_PackedInt64Array_Methods :: proc(PackedInt64Array_method_store: ^PackedInt64Array_Methods_list) {
  PackedInt64Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 0)
  PackedInt64Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 1)
  PackedInt64Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 2)
  PackedInt64Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.get = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "get", 4103005248)
  PackedInt64Array_method_store.set = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "set", 3638975848)
  PackedInt64Array_method_store.size = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "size", 3173160232)
  PackedInt64Array_method_store.is_empty = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "is_empty", 3918633141)
  PackedInt64Array_method_store.push_back = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "push_back", 694024632)
  PackedInt64Array_method_store.append = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "append", 694024632)
  PackedInt64Array_method_store.append_array = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "append_array", 2090311302)
  PackedInt64Array_method_store.remove_at = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "remove_at", 2823966027)
  PackedInt64Array_method_store.insert = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "insert", 1487112728)
  PackedInt64Array_method_store.fill = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "fill", 2823966027)
  PackedInt64Array_method_store.resize = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "resize", 848867239)
  PackedInt64Array_method_store.clear = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "clear", 3218959716)
  PackedInt64Array_method_store.has = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "has", 931488181)
  PackedInt64Array_method_store.reverse = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "reverse", 3218959716)
  PackedInt64Array_method_store.slice = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "slice", 1726550804)
  PackedInt64Array_method_store.to_byte_array = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "to_byte_array", 247621236)
  PackedInt64Array_method_store.sort = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "sort", 3218959716)
  PackedInt64Array_method_store.bsearch = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "bsearch", 954237325)
  PackedInt64Array_method_store.duplicate = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "duplicate", 1961294120)
  PackedInt64Array_method_store.find = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "find", 2984303840)
  PackedInt64Array_method_store.rfind = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "rfind", 2984303840)
  PackedInt64Array_method_store.count = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "count", 4103005248)
  PackedInt64Array_method_store.erase = GDW.Get_Builtin_Method(.PACKED_INT64_ARRAY, "erase", 694024632)
  PackedInt64Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_INT64_ARRAY, .NIL)
  PackedInt64Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT64_ARRAY, .DICTIONARY)
  PackedInt64Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT64_ARRAY, .ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_EQUAL_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_ADD_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
}
