package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedVector4Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedVector4Array,  #by_ptr p_args: struct{ from: ^PackedVector4Array, }),
    Create2: proc "c" (p_base: ^PackedVector4Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedVector4Array),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedVector4Array,
    IndxSetter : proc "c" (p_base: ^PackedVector4Array, p_index: Int, p_value: ^Vector4),
    IndxGetter : proc "c" (p_base: ^PackedVector4Array, p_index: Int, r_value: ^Vector4),
    get:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ index: ^Int, value: ^Vector4, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ array: ^PackedVector4Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^Vector4, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedVector4Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedVector4Array, p_args: rawptr = nil, r_return: ^PackedVector4Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedVector4Array, #by_ptr p_args: struct{ value: ^Vector4, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedVector4Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedVector4Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedVector4Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedVector4Array: proc "c" (p_left: ^PackedVector4Array, p_right: ^PackedVector4Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedVector4Array: proc "c" (p_left: ^PackedVector4Array, p_right: ^PackedVector4Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedVector4Array: proc "c" (p_left: ^PackedVector4Array, p_right: ^PackedVector4Array, r_result: ^PackedVector4Array),
}
init_PackedVector4Array_Methods :: proc(PackedVector4Array_method_store: ^PackedVector4Array_Methods_list) {
  PackedVector4Array_method_store.Create0 = cast(type_of(PackedVector4Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 0)
  PackedVector4Array_method_store.Create1 = cast(type_of(PackedVector4Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 1)
  PackedVector4Array_method_store.Create2 = cast(type_of(PackedVector4Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 2)
  PackedVector4Array_method_store.Destroy = cast(type_of(PackedVector4Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR4_ARRAY)
    PackedVector4Array_method_store.get_ptr = cast(type_of(PackedVector4Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.IndxGetter = cast(type_of(PackedVector4Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.IndxSetter = cast(type_of(PackedVector4Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.get = cast(type_of(PackedVector4Array_method_store.get))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "get", 1227817084)
  PackedVector4Array_method_store.set = cast(type_of(PackedVector4Array_method_store.set))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "set", 1350366223)
  PackedVector4Array_method_store.size = cast(type_of(PackedVector4Array_method_store.size))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "size", 3173160232)
  PackedVector4Array_method_store.is_empty = cast(type_of(PackedVector4Array_method_store.is_empty))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "is_empty", 3918633141)
  PackedVector4Array_method_store.push_back = cast(type_of(PackedVector4Array_method_store.push_back))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "push_back", 3289167688)
  PackedVector4Array_method_store.append = cast(type_of(PackedVector4Array_method_store.append))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "append", 3289167688)
  PackedVector4Array_method_store.append_array = cast(type_of(PackedVector4Array_method_store.append_array))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "append_array", 537428395)
  PackedVector4Array_method_store.remove_at = cast(type_of(PackedVector4Array_method_store.remove_at))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "remove_at", 2823966027)
  PackedVector4Array_method_store.insert = cast(type_of(PackedVector4Array_method_store.insert))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "insert", 11085009)
  PackedVector4Array_method_store.fill = cast(type_of(PackedVector4Array_method_store.fill))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "fill", 3761353134)
  PackedVector4Array_method_store.resize = cast(type_of(PackedVector4Array_method_store.resize))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "resize", 848867239)
  PackedVector4Array_method_store.clear = cast(type_of(PackedVector4Array_method_store.clear))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "clear", 3218959716)
  PackedVector4Array_method_store.has = cast(type_of(PackedVector4Array_method_store.has))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "has", 88913544)
  PackedVector4Array_method_store.reverse = cast(type_of(PackedVector4Array_method_store.reverse))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "reverse", 3218959716)
  PackedVector4Array_method_store.slice = cast(type_of(PackedVector4Array_method_store.slice))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "slice", 2942803855)
  PackedVector4Array_method_store.to_byte_array = cast(type_of(PackedVector4Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "to_byte_array", 247621236)
  PackedVector4Array_method_store.sort = cast(type_of(PackedVector4Array_method_store.sort))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "sort", 3218959716)
  PackedVector4Array_method_store.bsearch = cast(type_of(PackedVector4Array_method_store.bsearch))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "bsearch", 1822067054)
  PackedVector4Array_method_store.duplicate = cast(type_of(PackedVector4Array_method_store.duplicate))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "duplicate", 146203628)
  PackedVector4Array_method_store.find = cast(type_of(PackedVector4Array_method_store.find))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "find", 3091171314)
  PackedVector4Array_method_store.rfind = cast(type_of(PackedVector4Array_method_store.rfind))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "rfind", 3091171314)
  PackedVector4Array_method_store.count = cast(type_of(PackedVector4Array_method_store.count))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "count", 3956594488)
  PackedVector4Array_method_store.erase = cast(type_of(PackedVector4Array_method_store.erase))Get_Builtin_Method(.PACKED_VECTOR4_ARRAY, "erase", 3289167688)
  PackedVector4Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR4_ARRAY, .NIL)
  PackedVector4Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR4_ARRAY, .DICTIONARY)
  PackedVector4Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR4_ARRAY, .ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_EQUAL_PackedVector4Array = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_EQUAL_PackedVector4Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector4Array = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector4Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
  PackedVector4Array_method_store.VARIANT_OP_ADD_PackedVector4Array = cast(type_of(PackedVector4Array_method_store.VARIANT_OP_ADD_PackedVector4Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR4_ARRAY, .PACKED_VECTOR4_ARRAY)
}
