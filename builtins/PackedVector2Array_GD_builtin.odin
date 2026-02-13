package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


PackedVector2Array_Methods_list :: struct {
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
  VARIANT_OP_MULTIPLY_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedVector2Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector2Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedVector2Array: GDE.PtrOperatorEvaluator,
}
init_PackedVector2Array_Methods :: proc(PackedVector2Array_method_store: ^PackedVector2Array_Methods_list) {
  PackedVector2Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 0)
  PackedVector2Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 1)
  PackedVector2Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 2)
  PackedVector2Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.get = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "get", 2609058838)
  PackedVector2Array_method_store.set = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "set", 635767250)
  PackedVector2Array_method_store.size = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "size", 3173160232)
  PackedVector2Array_method_store.is_empty = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "is_empty", 3918633141)
  PackedVector2Array_method_store.push_back = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "push_back", 4188891560)
  PackedVector2Array_method_store.append = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "append", 4188891560)
  PackedVector2Array_method_store.append_array = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "append_array", 3887534835)
  PackedVector2Array_method_store.remove_at = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "remove_at", 2823966027)
  PackedVector2Array_method_store.insert = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "insert", 2225629369)
  PackedVector2Array_method_store.fill = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "fill", 3790411178)
  PackedVector2Array_method_store.resize = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "resize", 848867239)
  PackedVector2Array_method_store.clear = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "clear", 3218959716)
  PackedVector2Array_method_store.has = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "has", 3190634762)
  PackedVector2Array_method_store.reverse = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "reverse", 3218959716)
  PackedVector2Array_method_store.slice = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "slice", 3864005350)
  PackedVector2Array_method_store.to_byte_array = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "to_byte_array", 247621236)
  PackedVector2Array_method_store.sort = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "sort", 3218959716)
  PackedVector2Array_method_store.bsearch = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "bsearch", 3341588170)
  PackedVector2Array_method_store.duplicate = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "duplicate", 1660374357)
  PackedVector2Array_method_store.find = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "find", 1469606149)
  PackedVector2Array_method_store.rfind = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "rfind", 1469606149)
  PackedVector2Array_method_store.count = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "count", 2798848307)
  PackedVector2Array_method_store.erase = GDW.Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "erase", 4188891560)
  PackedVector2Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR2_ARRAY, .NIL)
  PackedVector2Array_method_store.VARIANT_OP_MULTIPLY_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PACKED_VECTOR2_ARRAY, .TRANSFORM2D)
  PackedVector2Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR2_ARRAY, .DICTIONARY)
  PackedVector2Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR2_ARRAY, .ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_EQUAL_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_ADD_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
}
