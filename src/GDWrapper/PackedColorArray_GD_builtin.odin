package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedColorArray_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedColorArray,  #by_ptr p_args: struct{ from: ^PackedColorArray, }),
    Create2: proc "c" (p_base: ^PackedColorArray,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedColorArray),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedColorArray,
    IndxSetter : proc "c" (p_base: ^PackedColorArray, p_index: Int, p_value: ^Color),
    IndxGetter : proc "c" (p_base: ^PackedColorArray, p_index: Int, r_value: ^Color),
    get:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Color, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ index: ^Int, value: ^Color, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ array: ^PackedColorArray, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ at_index: ^Int, value: ^Color, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedColorArray, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedColorArray, p_args: rawptr = nil, r_return: ^PackedColorArray, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedColorArray, #by_ptr p_args: struct{ value: ^Color, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedColorArray, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedColorArray, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedColorArray, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedColorArray: proc "c" (p_left: ^PackedColorArray, p_right: ^PackedColorArray, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedColorArray: proc "c" (p_left: ^PackedColorArray, p_right: ^PackedColorArray, r_result: ^Bool),
    VARIANT_OP_ADD_PackedColorArray: proc "c" (p_left: ^PackedColorArray, p_right: ^PackedColorArray, r_result: ^PackedColorArray),
}
init_PackedColorArray_Methods :: proc "c" (PackedColorArray_method_store: ^PackedColorArray_Methods_list) {
  PackedColorArray_method_store.Create0 = cast(type_of(PackedColorArray_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 0)
  PackedColorArray_method_store.Create1 = cast(type_of(PackedColorArray_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 1)
  PackedColorArray_method_store.Create2 = cast(type_of(PackedColorArray_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 2)
  PackedColorArray_method_store.Destroy = cast(type_of(PackedColorArray_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_COLOR_ARRAY)
    PackedColorArray_method_store.get_ptr = cast(type_of(PackedColorArray_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.IndxGetter = cast(type_of(PackedColorArray_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.IndxSetter = cast(type_of(PackedColorArray_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.get = cast(type_of(PackedColorArray_method_store.get))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "get", 2972831132)
  PackedColorArray_method_store.set = cast(type_of(PackedColorArray_method_store.set))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "set", 1444096570)
  PackedColorArray_method_store.size = cast(type_of(PackedColorArray_method_store.size))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "size", 3173160232)
  PackedColorArray_method_store.is_empty = cast(type_of(PackedColorArray_method_store.is_empty))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "is_empty", 3918633141)
  PackedColorArray_method_store.push_back = cast(type_of(PackedColorArray_method_store.push_back))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "push_back", 1007858200)
  PackedColorArray_method_store.append = cast(type_of(PackedColorArray_method_store.append))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "append", 1007858200)
  PackedColorArray_method_store.append_array = cast(type_of(PackedColorArray_method_store.append_array))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "append_array", 798822497)
  PackedColorArray_method_store.remove_at = cast(type_of(PackedColorArray_method_store.remove_at))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "remove_at", 2823966027)
  PackedColorArray_method_store.insert = cast(type_of(PackedColorArray_method_store.insert))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "insert", 785289703)
  PackedColorArray_method_store.fill = cast(type_of(PackedColorArray_method_store.fill))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "fill", 3730314301)
  PackedColorArray_method_store.resize = cast(type_of(PackedColorArray_method_store.resize))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "resize", 848867239)
  PackedColorArray_method_store.clear = cast(type_of(PackedColorArray_method_store.clear))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "clear", 3218959716)
  PackedColorArray_method_store.has = cast(type_of(PackedColorArray_method_store.has))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "has", 3167426256)
  PackedColorArray_method_store.reverse = cast(type_of(PackedColorArray_method_store.reverse))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "reverse", 3218959716)
  PackedColorArray_method_store.slice = cast(type_of(PackedColorArray_method_store.slice))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "slice", 2451797139)
  PackedColorArray_method_store.to_byte_array = cast(type_of(PackedColorArray_method_store.to_byte_array))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "to_byte_array", 247621236)
  PackedColorArray_method_store.sort = cast(type_of(PackedColorArray_method_store.sort))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "sort", 3218959716)
  PackedColorArray_method_store.bsearch = cast(type_of(PackedColorArray_method_store.bsearch))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "bsearch", 2639732838)
  PackedColorArray_method_store.duplicate = cast(type_of(PackedColorArray_method_store.duplicate))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "duplicate", 3072026941)
  PackedColorArray_method_store.find = cast(type_of(PackedColorArray_method_store.find))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "find", 3156095363)
  PackedColorArray_method_store.rfind = cast(type_of(PackedColorArray_method_store.rfind))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "rfind", 3156095363)
  PackedColorArray_method_store.count = cast(type_of(PackedColorArray_method_store.count))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "count", 1682108616)
  PackedColorArray_method_store.erase = cast(type_of(PackedColorArray_method_store.erase))Get_Builtin_Method(.PACKED_COLOR_ARRAY, "erase", 1007858200)
  PackedColorArray_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedColorArray_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_COLOR_ARRAY, .NIL)
  PackedColorArray_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedColorArray_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_COLOR_ARRAY, .DICTIONARY)
  PackedColorArray_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedColorArray_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_COLOR_ARRAY, .ARRAY)
  PackedColorArray_method_store.VARIANT_OP_EQUAL_PackedColorArray = cast(type_of(PackedColorArray_method_store.VARIANT_OP_EQUAL_PackedColorArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.VARIANT_OP_NOT_EQUAL_PackedColorArray = cast(type_of(PackedColorArray_method_store.VARIANT_OP_NOT_EQUAL_PackedColorArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
  PackedColorArray_method_store.VARIANT_OP_ADD_PackedColorArray = cast(type_of(PackedColorArray_method_store.VARIANT_OP_ADD_PackedColorArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_COLOR_ARRAY, .PACKED_COLOR_ARRAY)
}
