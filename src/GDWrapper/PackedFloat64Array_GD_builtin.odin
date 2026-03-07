package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedFloat64Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedFloat64Array,  #by_ptr p_args: struct{ from: ^PackedFloat64Array, }),
    Create2: proc "c" (p_base: ^PackedFloat64Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedFloat64Array),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedFloat64Array,
    IndxSetter : proc "c" (p_base: ^PackedFloat64Array, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^PackedFloat64Array, p_index: Int, r_value: ^float),
    get:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^float, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ index: ^Int, value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ array: ^PackedFloat64Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^float, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedFloat64Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedFloat64Array, p_args: rawptr = nil, r_return: ^PackedFloat64Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedFloat64Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedFloat64Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedFloat64Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedFloat64Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedFloat64Array: proc "c" (p_left: ^PackedFloat64Array, p_right: ^PackedFloat64Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedFloat64Array: proc "c" (p_left: ^PackedFloat64Array, p_right: ^PackedFloat64Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedFloat64Array: proc "c" (p_left: ^PackedFloat64Array, p_right: ^PackedFloat64Array, r_result: ^PackedFloat64Array),
}
init_PackedFloat64Array_Methods :: proc(PackedFloat64Array_method_store: ^PackedFloat64Array_Methods_list) {
  PackedFloat64Array_method_store.Create0 = cast(type_of(PackedFloat64Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 0)
  PackedFloat64Array_method_store.Create1 = cast(type_of(PackedFloat64Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 1)
  PackedFloat64Array_method_store.Create2 = cast(type_of(PackedFloat64Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 2)
  PackedFloat64Array_method_store.Destroy = cast(type_of(PackedFloat64Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT64_ARRAY)
    PackedFloat64Array_method_store.get_ptr = cast(type_of(PackedFloat64Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.IndxGetter = cast(type_of(PackedFloat64Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.IndxSetter = cast(type_of(PackedFloat64Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.get = cast(type_of(PackedFloat64Array_method_store.get))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "get", 1401583798)
  PackedFloat64Array_method_store.set = cast(type_of(PackedFloat64Array_method_store.set))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "set", 1113000516)
  PackedFloat64Array_method_store.size = cast(type_of(PackedFloat64Array_method_store.size))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "size", 3173160232)
  PackedFloat64Array_method_store.is_empty = cast(type_of(PackedFloat64Array_method_store.is_empty))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "is_empty", 3918633141)
  PackedFloat64Array_method_store.push_back = cast(type_of(PackedFloat64Array_method_store.push_back))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "push_back", 4094791666)
  PackedFloat64Array_method_store.append = cast(type_of(PackedFloat64Array_method_store.append))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "append", 4094791666)
  PackedFloat64Array_method_store.append_array = cast(type_of(PackedFloat64Array_method_store.append_array))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "append_array", 792078629)
  PackedFloat64Array_method_store.remove_at = cast(type_of(PackedFloat64Array_method_store.remove_at))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "remove_at", 2823966027)
  PackedFloat64Array_method_store.insert = cast(type_of(PackedFloat64Array_method_store.insert))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "insert", 1379903876)
  PackedFloat64Array_method_store.fill = cast(type_of(PackedFloat64Array_method_store.fill))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "fill", 833936903)
  PackedFloat64Array_method_store.resize = cast(type_of(PackedFloat64Array_method_store.resize))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "resize", 848867239)
  PackedFloat64Array_method_store.clear = cast(type_of(PackedFloat64Array_method_store.clear))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "clear", 3218959716)
  PackedFloat64Array_method_store.has = cast(type_of(PackedFloat64Array_method_store.has))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "has", 1296369134)
  PackedFloat64Array_method_store.reverse = cast(type_of(PackedFloat64Array_method_store.reverse))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "reverse", 3218959716)
  PackedFloat64Array_method_store.slice = cast(type_of(PackedFloat64Array_method_store.slice))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "slice", 2192974324)
  PackedFloat64Array_method_store.to_byte_array = cast(type_of(PackedFloat64Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "to_byte_array", 247621236)
  PackedFloat64Array_method_store.sort = cast(type_of(PackedFloat64Array_method_store.sort))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "sort", 3218959716)
  PackedFloat64Array_method_store.bsearch = cast(type_of(PackedFloat64Array_method_store.bsearch))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "bsearch", 1175118842)
  PackedFloat64Array_method_store.duplicate = cast(type_of(PackedFloat64Array_method_store.duplicate))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "duplicate", 1627308337)
  PackedFloat64Array_method_store.find = cast(type_of(PackedFloat64Array_method_store.find))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "find", 1343150241)
  PackedFloat64Array_method_store.rfind = cast(type_of(PackedFloat64Array_method_store.rfind))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "rfind", 1343150241)
  PackedFloat64Array_method_store.count = cast(type_of(PackedFloat64Array_method_store.count))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "count", 2859915090)
  PackedFloat64Array_method_store.erase = cast(type_of(PackedFloat64Array_method_store.erase))Get_Builtin_Method(.PACKED_FLOAT64_ARRAY, "erase", 4094791666)
  PackedFloat64Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_FLOAT64_ARRAY, .NIL)
  PackedFloat64Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT64_ARRAY, .DICTIONARY)
  PackedFloat64Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT64_ARRAY, .ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_EQUAL_PackedFloat64Array = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_EQUAL_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat64Array = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
  PackedFloat64Array_method_store.VARIANT_OP_ADD_PackedFloat64Array = cast(type_of(PackedFloat64Array_method_store.VARIANT_OP_ADD_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_FLOAT64_ARRAY, .PACKED_FLOAT64_ARRAY)
}
