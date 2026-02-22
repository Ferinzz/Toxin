package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


PackedStringArray_Methods_list :: struct {
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
  VARIANT_OP_EQUAL_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedStringArray: GDE.PtrOperatorEvaluator,
}
init_PackedStringArray_Methods :: proc(PackedStringArray_method_store: ^PackedStringArray_Methods_list) {
  PackedStringArray_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 0)
  PackedStringArray_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 1)
  PackedStringArray_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 2)
  PackedStringArray_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_STRING_ARRAY)
  PackedStringArray_method_store.get = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "get", 2162347432)
  PackedStringArray_method_store.set = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "set", 725585539)
  PackedStringArray_method_store.size = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "size", 3173160232)
  PackedStringArray_method_store.is_empty = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "is_empty", 3918633141)
  PackedStringArray_method_store.push_back = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "push_back", 816187996)
  PackedStringArray_method_store.append = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "append", 816187996)
  PackedStringArray_method_store.append_array = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "append_array", 1120103966)
  PackedStringArray_method_store.remove_at = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "remove_at", 2823966027)
  PackedStringArray_method_store.insert = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "insert", 2432393153)
  PackedStringArray_method_store.fill = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "fill", 3174917410)
  PackedStringArray_method_store.resize = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "resize", 848867239)
  PackedStringArray_method_store.clear = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "clear", 3218959716)
  PackedStringArray_method_store.has = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "has", 2566493496)
  PackedStringArray_method_store.reverse = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "reverse", 3218959716)
  PackedStringArray_method_store.slice = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "slice", 2094601407)
  PackedStringArray_method_store.to_byte_array = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "to_byte_array", 247621236)
  PackedStringArray_method_store.sort = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "sort", 3218959716)
  PackedStringArray_method_store.bsearch = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "bsearch", 1171495151)
  PackedStringArray_method_store.duplicate = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "duplicate", 747180633)
  PackedStringArray_method_store.find = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "find", 1760645412)
  PackedStringArray_method_store.rfind = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "rfind", 1760645412)
  PackedStringArray_method_store.count = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "count", 2920860731)
  PackedStringArray_method_store.erase = GDW.Get_Builtin_Method(.PACKED_STRING_ARRAY, "erase", 816187996)
  PackedStringArray_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_STRING_ARRAY, .NIL)
  PackedStringArray_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_STRING_ARRAY, .DICTIONARY)
  PackedStringArray_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_STRING_ARRAY, .ARRAY)
  PackedStringArray_method_store.VARIANT_OP_EQUAL_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
  PackedStringArray_method_store.VARIANT_OP_NOT_EQUAL_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
  PackedStringArray_method_store.VARIANT_OP_ADD_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
}
