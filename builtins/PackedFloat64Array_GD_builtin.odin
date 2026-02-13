package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


PackedFloat64Array_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedFloat64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedFloat64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedFloat64Array: GDE.PtrOperatorEvaluator,
}
init_PackedFloat64Array_Methods :: proc(PackedFloat64Array_method_store: ^PackedFloat64Array_Methods_list) {
  PackedFloat64Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 0)
  PackedFloat64Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 1)
  PackedFloat64Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 2)
  PackedFloat64Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.get = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "get", 1401583798)
  PackedFloat64Array_method_store.set = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "set", 1113000516)
  PackedFloat64Array_method_store.size = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "size", 3173160232)
  PackedFloat64Array_method_store.is_empty = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "is_empty", 3918633141)
  PackedFloat64Array_method_store.push_back = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "push_back", 4094791666)
  PackedFloat64Array_method_store.append = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "append", 4094791666)
  PackedFloat64Array_method_store.append_array = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "append_array", 792078629)
  PackedFloat64Array_method_store.remove_at = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "remove_at", 2823966027)
  PackedFloat64Array_method_store.insert = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "insert", 1379903876)
  PackedFloat64Array_method_store.fill = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "fill", 833936903)
  PackedFloat64Array_method_store.resize = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "resize", 848867239)
  PackedFloat64Array_method_store.clear = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "clear", 3218959716)
  PackedFloat64Array_method_store.has = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "has", 1296369134)
  PackedFloat64Array_method_store.reverse = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "reverse", 3218959716)
  PackedFloat64Array_method_store.slice = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "slice", 2192974324)
  PackedFloat64Array_method_store.to_byte_array = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "to_byte_array", 247621236)
  PackedFloat64Array_method_store.sort = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "sort", 3218959716)
  PackedFloat64Array_method_store.bsearch = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "bsearch", 1175118842)
  PackedFloat64Array_method_store.duplicate = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "duplicate", 1627308337)
  PackedFloat64Array_method_store.find = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "find", 1343150241)
  PackedFloat64Array_method_store.rfind = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "rfind", 1343150241)
  PackedFloat64Array_method_store.count = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "count", 2859915090)
  PackedFloat64Array_method_store.erase = GDW.Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "erase", 4094791666)
  PackedFloat64Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_FLOAT64_ARRAY, .NIL)
  PackedFloat64Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT64_ARRAY, .DICTIONARY)
  PackedFloat64Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT64_ARRAY, .ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_EQUAL_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_ADD_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
}
