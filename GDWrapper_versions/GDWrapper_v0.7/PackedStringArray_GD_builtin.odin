package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedStringArray_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedStringArray,  #by_ptr p_args: struct{ from: ^PackedStringArray, }),
    Create2: proc "c" (p_base: ^PackedStringArray,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedStringArray),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedStringArray,
    IndxSetter : proc "c" (p_base: ^PackedStringArray, p_index: Int, p_value: ^gdstring),
    IndxGetter : proc "c" (p_base: ^PackedStringArray, p_index: Int, r_value: ^gdstring),
    get:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ index: ^Int, value: ^gdstring, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ array: ^PackedStringArray, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ at_index: ^Int, value: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedStringArray, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedStringArray, p_args: rawptr = nil, r_return: ^PackedStringArray, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedStringArray, #by_ptr p_args: struct{ value: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedStringArray, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedStringArray, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedStringArray, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedStringArray: proc "c" (p_left: ^PackedStringArray, p_right: ^PackedStringArray, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedStringArray: proc "c" (p_left: ^PackedStringArray, p_right: ^PackedStringArray, r_result: ^Bool),
    VARIANT_OP_ADD_PackedStringArray: proc "c" (p_left: ^PackedStringArray, p_right: ^PackedStringArray, r_result: ^PackedStringArray),
}
init_PackedStringArray_Methods :: proc(PackedStringArray_method_store: ^PackedStringArray_Methods_list) {
  PackedStringArray_method_store.Create0 = cast(type_of(PackedStringArray_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 0)
  PackedStringArray_method_store.Create1 = cast(type_of(PackedStringArray_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 1)
  PackedStringArray_method_store.Create2 = cast(type_of(PackedStringArray_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 2)
  PackedStringArray_method_store.Destroy = cast(type_of(PackedStringArray_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_STRING_ARRAY)
    PackedStringArray_method_store.get_ptr = cast(type_of(PackedStringArray_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_STRING_ARRAY)
  PackedStringArray_method_store.IndxGetter = cast(type_of(PackedStringArray_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_STRING_ARRAY)
  PackedStringArray_method_store.IndxSetter = cast(type_of(PackedStringArray_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_STRING_ARRAY)
  PackedStringArray_method_store.get = cast(type_of(PackedStringArray_method_store.get))Get_Builtin_Method(.PACKED_STRING_ARRAY, "get", 2162347432)
  PackedStringArray_method_store.set = cast(type_of(PackedStringArray_method_store.set))Get_Builtin_Method(.PACKED_STRING_ARRAY, "set", 725585539)
  PackedStringArray_method_store.size = cast(type_of(PackedStringArray_method_store.size))Get_Builtin_Method(.PACKED_STRING_ARRAY, "size", 3173160232)
  PackedStringArray_method_store.is_empty = cast(type_of(PackedStringArray_method_store.is_empty))Get_Builtin_Method(.PACKED_STRING_ARRAY, "is_empty", 3918633141)
  PackedStringArray_method_store.push_back = cast(type_of(PackedStringArray_method_store.push_back))Get_Builtin_Method(.PACKED_STRING_ARRAY, "push_back", 816187996)
  PackedStringArray_method_store.append = cast(type_of(PackedStringArray_method_store.append))Get_Builtin_Method(.PACKED_STRING_ARRAY, "append", 816187996)
  PackedStringArray_method_store.append_array = cast(type_of(PackedStringArray_method_store.append_array))Get_Builtin_Method(.PACKED_STRING_ARRAY, "append_array", 1120103966)
  PackedStringArray_method_store.remove_at = cast(type_of(PackedStringArray_method_store.remove_at))Get_Builtin_Method(.PACKED_STRING_ARRAY, "remove_at", 2823966027)
  PackedStringArray_method_store.insert = cast(type_of(PackedStringArray_method_store.insert))Get_Builtin_Method(.PACKED_STRING_ARRAY, "insert", 2432393153)
  PackedStringArray_method_store.fill = cast(type_of(PackedStringArray_method_store.fill))Get_Builtin_Method(.PACKED_STRING_ARRAY, "fill", 3174917410)
  PackedStringArray_method_store.resize = cast(type_of(PackedStringArray_method_store.resize))Get_Builtin_Method(.PACKED_STRING_ARRAY, "resize", 848867239)
  PackedStringArray_method_store.clear = cast(type_of(PackedStringArray_method_store.clear))Get_Builtin_Method(.PACKED_STRING_ARRAY, "clear", 3218959716)
  PackedStringArray_method_store.has = cast(type_of(PackedStringArray_method_store.has))Get_Builtin_Method(.PACKED_STRING_ARRAY, "has", 2566493496)
  PackedStringArray_method_store.reverse = cast(type_of(PackedStringArray_method_store.reverse))Get_Builtin_Method(.PACKED_STRING_ARRAY, "reverse", 3218959716)
  PackedStringArray_method_store.slice = cast(type_of(PackedStringArray_method_store.slice))Get_Builtin_Method(.PACKED_STRING_ARRAY, "slice", 2094601407)
  PackedStringArray_method_store.to_byte_array = cast(type_of(PackedStringArray_method_store.to_byte_array))Get_Builtin_Method(.PACKED_STRING_ARRAY, "to_byte_array", 247621236)
  PackedStringArray_method_store.sort = cast(type_of(PackedStringArray_method_store.sort))Get_Builtin_Method(.PACKED_STRING_ARRAY, "sort", 3218959716)
  PackedStringArray_method_store.bsearch = cast(type_of(PackedStringArray_method_store.bsearch))Get_Builtin_Method(.PACKED_STRING_ARRAY, "bsearch", 1171495151)
  PackedStringArray_method_store.duplicate = cast(type_of(PackedStringArray_method_store.duplicate))Get_Builtin_Method(.PACKED_STRING_ARRAY, "duplicate", 747180633)
  PackedStringArray_method_store.find = cast(type_of(PackedStringArray_method_store.find))Get_Builtin_Method(.PACKED_STRING_ARRAY, "find", 1760645412)
  PackedStringArray_method_store.rfind = cast(type_of(PackedStringArray_method_store.rfind))Get_Builtin_Method(.PACKED_STRING_ARRAY, "rfind", 1760645412)
  PackedStringArray_method_store.count = cast(type_of(PackedStringArray_method_store.count))Get_Builtin_Method(.PACKED_STRING_ARRAY, "count", 2920860731)
  PackedStringArray_method_store.erase = cast(type_of(PackedStringArray_method_store.erase))Get_Builtin_Method(.PACKED_STRING_ARRAY, "erase", 816187996)
  PackedStringArray_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedStringArray_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_STRING_ARRAY, .NIL)
  PackedStringArray_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedStringArray_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_STRING_ARRAY, .DICTIONARY)
  PackedStringArray_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedStringArray_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_STRING_ARRAY, .ARRAY)
  PackedStringArray_method_store.VARIANT_OP_EQUAL_PackedStringArray = cast(type_of(PackedStringArray_method_store.VARIANT_OP_EQUAL_PackedStringArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
  PackedStringArray_method_store.VARIANT_OP_NOT_EQUAL_PackedStringArray = cast(type_of(PackedStringArray_method_store.VARIANT_OP_NOT_EQUAL_PackedStringArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
  PackedStringArray_method_store.VARIANT_OP_ADD_PackedStringArray = cast(type_of(PackedStringArray_method_store.VARIANT_OP_ADD_PackedStringArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_STRING_ARRAY, .PACKED_STRING_ARRAY)
}
