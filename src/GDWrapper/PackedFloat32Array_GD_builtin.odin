package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


PackedFloat32Array_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedFloat32Array: GDE.PtrOperatorEvaluator,
}
init_PackedFloat32Array_Methods :: proc(PackedFloat32Array_method_store: ^PackedFloat32Array_Methods_list) {
  PackedFloat32Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 0)
  PackedFloat32Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 1)
  PackedFloat32Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 2)
  PackedFloat32Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.get = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "get", 1401583798)
  PackedFloat32Array_method_store.set = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "set", 1113000516)
  PackedFloat32Array_method_store.size = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "size", 3173160232)
  PackedFloat32Array_method_store.is_empty = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "is_empty", 3918633141)
  PackedFloat32Array_method_store.push_back = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "push_back", 4094791666)
  PackedFloat32Array_method_store.append = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "append", 4094791666)
  PackedFloat32Array_method_store.append_array = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "append_array", 2981316639)
  PackedFloat32Array_method_store.remove_at = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "remove_at", 2823966027)
  PackedFloat32Array_method_store.insert = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "insert", 1379903876)
  PackedFloat32Array_method_store.fill = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "fill", 833936903)
  PackedFloat32Array_method_store.resize = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "resize", 848867239)
  PackedFloat32Array_method_store.clear = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "clear", 3218959716)
  PackedFloat32Array_method_store.has = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "has", 1296369134)
  PackedFloat32Array_method_store.reverse = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "reverse", 3218959716)
  PackedFloat32Array_method_store.slice = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "slice", 1418229160)
  PackedFloat32Array_method_store.to_byte_array = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "to_byte_array", 247621236)
  PackedFloat32Array_method_store.sort = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "sort", 3218959716)
  PackedFloat32Array_method_store.bsearch = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "bsearch", 1175118842)
  PackedFloat32Array_method_store.duplicate = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "duplicate", 3575107827)
  PackedFloat32Array_method_store.find = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "find", 1343150241)
  PackedFloat32Array_method_store.rfind = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "rfind", 1343150241)
  PackedFloat32Array_method_store.count = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "count", 2859915090)
  PackedFloat32Array_method_store.erase = Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "erase", 4094791666)
  PackedFloat32Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_FLOAT32_ARRAY, .NIL)
  PackedFloat32Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT32_ARRAY, .DICTIONARY)
  PackedFloat32Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT32_ARRAY, .ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_EQUAL_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_ADD_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
}
