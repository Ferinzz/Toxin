package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


PackedVector2Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedVector2Array,  #by_ptr p_args: struct{ from: ^PackedVector2Array, }),
    Create2: proc "c" (p_base: ^PackedVector2Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedVector2Array),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedVector2Array,
    IndxSetter : proc "c" (p_base: ^PackedVector2Array, p_index: Int, p_value: ^Vector2),
    IndxGetter : proc "c" (p_base: ^PackedVector2Array, p_index: Int, r_value: ^Vector2),
    get:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ index: ^Int, value: ^Vector2, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ array: ^PackedVector2Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^Vector2, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedVector2Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedVector2Array, p_args: rawptr = nil, r_return: ^PackedVector2Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedVector2Array, #by_ptr p_args: struct{ value: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedVector2Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform2D: proc "c" (p_left: ^PackedVector2Array, p_right: ^Transform2D, r_result: ^PackedVector2Array),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedVector2Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedVector2Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedVector2Array: proc "c" (p_left: ^PackedVector2Array, p_right: ^PackedVector2Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedVector2Array: proc "c" (p_left: ^PackedVector2Array, p_right: ^PackedVector2Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedVector2Array: proc "c" (p_left: ^PackedVector2Array, p_right: ^PackedVector2Array, r_result: ^PackedVector2Array),
}
init_PackedVector2Array_Methods :: proc(PackedVector2Array_method_store: ^PackedVector2Array_Methods_list) {
  PackedVector2Array_method_store.Create0 = cast(type_of(PackedVector2Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 0)
  PackedVector2Array_method_store.Create1 = cast(type_of(PackedVector2Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 1)
  PackedVector2Array_method_store.Create2 = cast(type_of(PackedVector2Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 2)
  PackedVector2Array_method_store.Destroy = cast(type_of(PackedVector2Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR2_ARRAY)
    PackedVector2Array_method_store.get_ptr = cast(type_of(PackedVector2Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.IndxGetter = cast(type_of(PackedVector2Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.IndxSetter = cast(type_of(PackedVector2Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.get = cast(type_of(PackedVector2Array_method_store.get))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "get", 2609058838)
  PackedVector2Array_method_store.set = cast(type_of(PackedVector2Array_method_store.set))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "set", 635767250)
  PackedVector2Array_method_store.size = cast(type_of(PackedVector2Array_method_store.size))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "size", 3173160232)
  PackedVector2Array_method_store.is_empty = cast(type_of(PackedVector2Array_method_store.is_empty))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "is_empty", 3918633141)
  PackedVector2Array_method_store.push_back = cast(type_of(PackedVector2Array_method_store.push_back))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "push_back", 4188891560)
  PackedVector2Array_method_store.append = cast(type_of(PackedVector2Array_method_store.append))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "append", 4188891560)
  PackedVector2Array_method_store.append_array = cast(type_of(PackedVector2Array_method_store.append_array))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "append_array", 3887534835)
  PackedVector2Array_method_store.remove_at = cast(type_of(PackedVector2Array_method_store.remove_at))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "remove_at", 2823966027)
  PackedVector2Array_method_store.insert = cast(type_of(PackedVector2Array_method_store.insert))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "insert", 2225629369)
  PackedVector2Array_method_store.fill = cast(type_of(PackedVector2Array_method_store.fill))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "fill", 3790411178)
  PackedVector2Array_method_store.resize = cast(type_of(PackedVector2Array_method_store.resize))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "resize", 848867239)
  PackedVector2Array_method_store.clear = cast(type_of(PackedVector2Array_method_store.clear))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "clear", 3218959716)
  PackedVector2Array_method_store.has = cast(type_of(PackedVector2Array_method_store.has))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "has", 3190634762)
  PackedVector2Array_method_store.reverse = cast(type_of(PackedVector2Array_method_store.reverse))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "reverse", 3218959716)
  PackedVector2Array_method_store.slice = cast(type_of(PackedVector2Array_method_store.slice))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "slice", 3864005350)
  PackedVector2Array_method_store.to_byte_array = cast(type_of(PackedVector2Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "to_byte_array", 247621236)
  PackedVector2Array_method_store.sort = cast(type_of(PackedVector2Array_method_store.sort))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "sort", 3218959716)
  PackedVector2Array_method_store.bsearch = cast(type_of(PackedVector2Array_method_store.bsearch))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "bsearch", 3341588170)
  PackedVector2Array_method_store.duplicate = cast(type_of(PackedVector2Array_method_store.duplicate))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "duplicate", 1660374357)
  PackedVector2Array_method_store.find = cast(type_of(PackedVector2Array_method_store.find))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "find", 1469606149)
  PackedVector2Array_method_store.rfind = cast(type_of(PackedVector2Array_method_store.rfind))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "rfind", 1469606149)
  PackedVector2Array_method_store.count = cast(type_of(PackedVector2Array_method_store.count))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "count", 2798848307)
  PackedVector2Array_method_store.erase = cast(type_of(PackedVector2Array_method_store.erase))Get_Builtin_Method(.PACKED_VECTOR2_ARRAY, "erase", 4188891560)
  PackedVector2Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR2_ARRAY, .NIL)
  PackedVector2Array_method_store.VARIANT_OP_MULTIPLY_Transform2D = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_MULTIPLY_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PACKED_VECTOR2_ARRAY, .TRANSFORM2D)
  PackedVector2Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR2_ARRAY, .DICTIONARY)
  PackedVector2Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR2_ARRAY, .ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_EQUAL_PackedVector2Array = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_EQUAL_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector2Array = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
  PackedVector2Array_method_store.VARIANT_OP_ADD_PackedVector2Array = cast(type_of(PackedVector2Array_method_store.VARIANT_OP_ADD_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR2_ARRAY)
}
