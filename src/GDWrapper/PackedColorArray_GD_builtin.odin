package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


PackedColorArray_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedColorArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedColorArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedColorArray: GDE.PtrOperatorEvaluator,
}
init_PackedColorArray_Methods :: proc(PackedColorArray_method_store: ^PackedColorArray_Methods_list) {
  PackedColorArray_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 0)
  PackedColorArray_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 1)
  PackedColorArray_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 2)
  PackedColorArray_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.get = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "get", 2972831132)
  PackedColorArray_method_store.set = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "set", 1444096570)
  PackedColorArray_method_store.size = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "size", 3173160232)
  PackedColorArray_method_store.is_empty = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "is_empty", 3918633141)
  PackedColorArray_method_store.push_back = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "push_back", 1007858200)
  PackedColorArray_method_store.append = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "append", 1007858200)
  PackedColorArray_method_store.append_array = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "append_array", 798822497)
  PackedColorArray_method_store.remove_at = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "remove_at", 2823966027)
  PackedColorArray_method_store.insert = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "insert", 785289703)
  PackedColorArray_method_store.fill = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "fill", 3730314301)
  PackedColorArray_method_store.resize = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "resize", 848867239)
  PackedColorArray_method_store.clear = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "clear", 3218959716)
  PackedColorArray_method_store.has = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "has", 3167426256)
  PackedColorArray_method_store.reverse = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "reverse", 3218959716)
  PackedColorArray_method_store.slice = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "slice", 2451797139)
  PackedColorArray_method_store.to_byte_array = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "to_byte_array", 247621236)
  PackedColorArray_method_store.sort = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "sort", 3218959716)
  PackedColorArray_method_store.bsearch = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "bsearch", 2639732838)
  PackedColorArray_method_store.duplicate = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "duplicate", 3072026941)
  PackedColorArray_method_store.find = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "find", 3156095363)
  PackedColorArray_method_store.rfind = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "rfind", 3156095363)
  PackedColorArray_method_store.count = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "count", 1682108616)
  PackedColorArray_method_store.erase = Get_Builtin_Method(.PACKED_COLOR_ARRAY, "erase", 1007858200)
  PackedColorArray_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_COLOR_ARRAY, .NIL)
  PackedColorArray_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_COLOR_ARRAY, .DICTIONARY)
  PackedColorArray_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_COLOR_ARRAY, .ARRAY)
  PackedColorArray_method_store.VARIANT_OP_EQUAL_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.VARIANT_OP_NOT_EQUAL_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.VARIANT_OP_ADD_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
}
