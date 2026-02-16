package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


PackedVector4Array_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedVector4Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector4Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedVector4Array: GDE.PtrOperatorEvaluator,
}
init_PackedVector4Array_Methods :: proc(PackedVector4Array_method_store: ^PackedVector4Array_Methods_list) {
  PackedVector4Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 0)
  PackedVector4Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 1)
  PackedVector4Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 2)
  PackedVector4Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.get = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "get", 1227817084)
  PackedVector4Array_method_store.set = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "set", 1350366223)
  PackedVector4Array_method_store.size = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "size", 3173160232)
  PackedVector4Array_method_store.is_empty = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "is_empty", 3918633141)
  PackedVector4Array_method_store.push_back = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "push_back", 3289167688)
  PackedVector4Array_method_store.append = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "append", 3289167688)
  PackedVector4Array_method_store.append_array = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "append_array", 537428395)
  PackedVector4Array_method_store.remove_at = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "remove_at", 2823966027)
  PackedVector4Array_method_store.insert = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "insert", 11085009)
  PackedVector4Array_method_store.fill = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "fill", 3761353134)
  PackedVector4Array_method_store.resize = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "resize", 848867239)
  PackedVector4Array_method_store.clear = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "clear", 3218959716)
  PackedVector4Array_method_store.has = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "has", 88913544)
  PackedVector4Array_method_store.reverse = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "reverse", 3218959716)
  PackedVector4Array_method_store.slice = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "slice", 2942803855)
  PackedVector4Array_method_store.to_byte_array = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "to_byte_array", 247621236)
  PackedVector4Array_method_store.sort = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "sort", 3218959716)
  PackedVector4Array_method_store.bsearch = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "bsearch", 1822067054)
  PackedVector4Array_method_store.duplicate = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "duplicate", 146203628)
  PackedVector4Array_method_store.find = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "find", 3091171314)
  PackedVector4Array_method_store.rfind = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "rfind", 3091171314)
  PackedVector4Array_method_store.count = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "count", 3956594488)
  PackedVector4Array_method_store.erase = Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "erase", 3289167688)
  PackedVector4Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR4_ARRAY, .NIL)
  PackedVector4Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR4_ARRAY, .DICTIONARY)
  PackedVector4Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR4_ARRAY, .ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_EQUAL_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_ADD_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
}
