package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


PackedVector3Array_Methods_list :: struct {
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
  VARIANT_OP_MULTIPLY_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedVector3Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector3Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedVector3Array: GDE.PtrOperatorEvaluator,
}
init_PackedVector3Array_Methods :: proc(PackedVector3Array_method_store: ^PackedVector3Array_Methods_list) {
  PackedVector3Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 0)
  PackedVector3Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 1)
  PackedVector3Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 2)
  PackedVector3Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.get = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "get", 1394941017)
  PackedVector3Array_method_store.set = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "set", 3975343409)
  PackedVector3Array_method_store.size = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "size", 3173160232)
  PackedVector3Array_method_store.is_empty = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "is_empty", 3918633141)
  PackedVector3Array_method_store.push_back = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "push_back", 3295363524)
  PackedVector3Array_method_store.append = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "append", 3295363524)
  PackedVector3Array_method_store.append_array = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "append_array", 203538016)
  PackedVector3Array_method_store.remove_at = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "remove_at", 2823966027)
  PackedVector3Array_method_store.insert = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "insert", 3892262309)
  PackedVector3Array_method_store.fill = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "fill", 3726392409)
  PackedVector3Array_method_store.resize = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "resize", 848867239)
  PackedVector3Array_method_store.clear = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "clear", 3218959716)
  PackedVector3Array_method_store.has = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "has", 1749054343)
  PackedVector3Array_method_store.reverse = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "reverse", 3218959716)
  PackedVector3Array_method_store.slice = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "slice", 2086131305)
  PackedVector3Array_method_store.to_byte_array = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "to_byte_array", 247621236)
  PackedVector3Array_method_store.sort = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "sort", 3218959716)
  PackedVector3Array_method_store.bsearch = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "bsearch", 1259277637)
  PackedVector3Array_method_store.duplicate = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "duplicate", 4171207452)
  PackedVector3Array_method_store.find = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "find", 3718155780)
  PackedVector3Array_method_store.rfind = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "rfind", 3718155780)
  PackedVector3Array_method_store.count = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "count", 194580386)
  PackedVector3Array_method_store.erase = Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "erase", 3295363524)
  PackedVector3Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR3_ARRAY, .NIL)
  PackedVector3Array_method_store.VARIANT_OP_MULTIPLY_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PACKED_VECTOR3_ARRAY, .TRANSFORM3D)
  PackedVector3Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR3_ARRAY, .DICTIONARY)
  PackedVector3Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR3_ARRAY, .ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_EQUAL_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_ADD_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
}
