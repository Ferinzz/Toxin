package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedInt64Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedInt64Array,  #by_ptr p_args: struct{ from: ^PackedInt64Array, }),
    Create2: proc "c" (p_base: ^PackedInt64Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedInt64Array),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedInt64Array,
    IndxSetter : proc "c" (p_base: ^PackedInt64Array, p_index: Int, p_value: ^Int),
    IndxGetter : proc "c" (p_base: ^PackedInt64Array, p_index: Int, r_value: ^Int),
    get:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ index: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ array: ^PackedInt64Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedInt64Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedInt64Array, p_args: rawptr = nil, r_return: ^PackedInt64Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedInt64Array, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedInt64Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedInt64Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedInt64Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedInt64Array: proc "c" (p_left: ^PackedInt64Array, p_right: ^PackedInt64Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedInt64Array: proc "c" (p_left: ^PackedInt64Array, p_right: ^PackedInt64Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedInt64Array: proc "c" (p_left: ^PackedInt64Array, p_right: ^PackedInt64Array, r_result: ^PackedInt64Array),
}
init_PackedInt64Array_Methods :: proc "c" (PackedInt64Array_method_store: ^PackedInt64Array_Methods_list) {
  PackedInt64Array_method_store.Create0 = cast(type_of(PackedInt64Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 0)
  PackedInt64Array_method_store.Create1 = cast(type_of(PackedInt64Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 1)
  PackedInt64Array_method_store.Create2 = cast(type_of(PackedInt64Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 2)
  PackedInt64Array_method_store.Destroy = cast(type_of(PackedInt64Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT64_ARRAY)
    PackedInt64Array_method_store.get_ptr = cast(type_of(PackedInt64Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.IndxGetter = cast(type_of(PackedInt64Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.IndxSetter = cast(type_of(PackedInt64Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.get = cast(type_of(PackedInt64Array_method_store.get))Get_Builtin_Method(.PACKED_INT64_ARRAY, "get", 4103005248)
  PackedInt64Array_method_store.set = cast(type_of(PackedInt64Array_method_store.set))Get_Builtin_Method(.PACKED_INT64_ARRAY, "set", 3638975848)
  PackedInt64Array_method_store.size = cast(type_of(PackedInt64Array_method_store.size))Get_Builtin_Method(.PACKED_INT64_ARRAY, "size", 3173160232)
  PackedInt64Array_method_store.is_empty = cast(type_of(PackedInt64Array_method_store.is_empty))Get_Builtin_Method(.PACKED_INT64_ARRAY, "is_empty", 3918633141)
  PackedInt64Array_method_store.push_back = cast(type_of(PackedInt64Array_method_store.push_back))Get_Builtin_Method(.PACKED_INT64_ARRAY, "push_back", 694024632)
  PackedInt64Array_method_store.append = cast(type_of(PackedInt64Array_method_store.append))Get_Builtin_Method(.PACKED_INT64_ARRAY, "append", 694024632)
  PackedInt64Array_method_store.append_array = cast(type_of(PackedInt64Array_method_store.append_array))Get_Builtin_Method(.PACKED_INT64_ARRAY, "append_array", 2090311302)
  PackedInt64Array_method_store.remove_at = cast(type_of(PackedInt64Array_method_store.remove_at))Get_Builtin_Method(.PACKED_INT64_ARRAY, "remove_at", 2823966027)
  PackedInt64Array_method_store.insert = cast(type_of(PackedInt64Array_method_store.insert))Get_Builtin_Method(.PACKED_INT64_ARRAY, "insert", 1487112728)
  PackedInt64Array_method_store.fill = cast(type_of(PackedInt64Array_method_store.fill))Get_Builtin_Method(.PACKED_INT64_ARRAY, "fill", 2823966027)
  PackedInt64Array_method_store.resize = cast(type_of(PackedInt64Array_method_store.resize))Get_Builtin_Method(.PACKED_INT64_ARRAY, "resize", 848867239)
  PackedInt64Array_method_store.clear = cast(type_of(PackedInt64Array_method_store.clear))Get_Builtin_Method(.PACKED_INT64_ARRAY, "clear", 3218959716)
  PackedInt64Array_method_store.has = cast(type_of(PackedInt64Array_method_store.has))Get_Builtin_Method(.PACKED_INT64_ARRAY, "has", 931488181)
  PackedInt64Array_method_store.reverse = cast(type_of(PackedInt64Array_method_store.reverse))Get_Builtin_Method(.PACKED_INT64_ARRAY, "reverse", 3218959716)
  PackedInt64Array_method_store.slice = cast(type_of(PackedInt64Array_method_store.slice))Get_Builtin_Method(.PACKED_INT64_ARRAY, "slice", 1726550804)
  PackedInt64Array_method_store.to_byte_array = cast(type_of(PackedInt64Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_INT64_ARRAY, "to_byte_array", 247621236)
  PackedInt64Array_method_store.sort = cast(type_of(PackedInt64Array_method_store.sort))Get_Builtin_Method(.PACKED_INT64_ARRAY, "sort", 3218959716)
  PackedInt64Array_method_store.bsearch = cast(type_of(PackedInt64Array_method_store.bsearch))Get_Builtin_Method(.PACKED_INT64_ARRAY, "bsearch", 954237325)
  PackedInt64Array_method_store.duplicate = cast(type_of(PackedInt64Array_method_store.duplicate))Get_Builtin_Method(.PACKED_INT64_ARRAY, "duplicate", 1961294120)
  PackedInt64Array_method_store.find = cast(type_of(PackedInt64Array_method_store.find))Get_Builtin_Method(.PACKED_INT64_ARRAY, "find", 2984303840)
  PackedInt64Array_method_store.rfind = cast(type_of(PackedInt64Array_method_store.rfind))Get_Builtin_Method(.PACKED_INT64_ARRAY, "rfind", 2984303840)
  PackedInt64Array_method_store.count = cast(type_of(PackedInt64Array_method_store.count))Get_Builtin_Method(.PACKED_INT64_ARRAY, "count", 4103005248)
  PackedInt64Array_method_store.erase = cast(type_of(PackedInt64Array_method_store.erase))Get_Builtin_Method(.PACKED_INT64_ARRAY, "erase", 694024632)
  PackedInt64Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_INT64_ARRAY, .NIL)
  PackedInt64Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT64_ARRAY, .DICTIONARY)
  PackedInt64Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_INT64_ARRAY, .ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_EQUAL_PackedInt64Array = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_EQUAL_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedInt64Array = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
  PackedInt64Array_method_store.VARIANT_OP_ADD_PackedInt64Array = cast(type_of(PackedInt64Array_method_store.VARIANT_OP_ADD_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_INT64_ARRAY, .PACKED_INT64_ARRAY)
}
