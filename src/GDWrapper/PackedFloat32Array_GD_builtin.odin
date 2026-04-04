package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedFloat32Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedFloat32Array,  #by_ptr p_args: struct{ from: ^PackedFloat32Array, }),
    Create2: proc "c" (p_base: ^PackedFloat32Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedFloat32Array),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedFloat32Array,
    IndxSetter : proc "c" (p_base: ^PackedFloat32Array, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^PackedFloat32Array, p_index: Int, r_value: ^float),
    get:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^float, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ index: ^Int, value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ array: ^PackedFloat32Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^float, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedFloat32Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedFloat32Array, p_args: rawptr = nil, r_return: ^PackedFloat32Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedFloat32Array, #by_ptr p_args: struct{ value: ^float, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedFloat32Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedFloat32Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedFloat32Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedFloat32Array: proc "c" (p_left: ^PackedFloat32Array, p_right: ^PackedFloat32Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedFloat32Array: proc "c" (p_left: ^PackedFloat32Array, p_right: ^PackedFloat32Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedFloat32Array: proc "c" (p_left: ^PackedFloat32Array, p_right: ^PackedFloat32Array, r_result: ^PackedFloat32Array),
}
init_PackedFloat32Array_Methods :: proc "c" (PackedFloat32Array_method_store: ^PackedFloat32Array_Methods_list) {
  PackedFloat32Array_method_store.Create0 = cast(type_of(PackedFloat32Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 0)
  PackedFloat32Array_method_store.Create1 = cast(type_of(PackedFloat32Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 1)
  PackedFloat32Array_method_store.Create2 = cast(type_of(PackedFloat32Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 2)
  PackedFloat32Array_method_store.Destroy = cast(type_of(PackedFloat32Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT32_ARRAY)
    PackedFloat32Array_method_store.get_ptr = cast(type_of(PackedFloat32Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.IndxGetter = cast(type_of(PackedFloat32Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.IndxSetter = cast(type_of(PackedFloat32Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.get = cast(type_of(PackedFloat32Array_method_store.get))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "get", 1401583798)
  PackedFloat32Array_method_store.set = cast(type_of(PackedFloat32Array_method_store.set))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "set", 1113000516)
  PackedFloat32Array_method_store.size = cast(type_of(PackedFloat32Array_method_store.size))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "size", 3173160232)
  PackedFloat32Array_method_store.is_empty = cast(type_of(PackedFloat32Array_method_store.is_empty))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "is_empty", 3918633141)
  PackedFloat32Array_method_store.push_back = cast(type_of(PackedFloat32Array_method_store.push_back))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "push_back", 4094791666)
  PackedFloat32Array_method_store.append = cast(type_of(PackedFloat32Array_method_store.append))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "append", 4094791666)
  PackedFloat32Array_method_store.append_array = cast(type_of(PackedFloat32Array_method_store.append_array))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "append_array", 2981316639)
  PackedFloat32Array_method_store.remove_at = cast(type_of(PackedFloat32Array_method_store.remove_at))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "remove_at", 2823966027)
  PackedFloat32Array_method_store.insert = cast(type_of(PackedFloat32Array_method_store.insert))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "insert", 1379903876)
  PackedFloat32Array_method_store.fill = cast(type_of(PackedFloat32Array_method_store.fill))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "fill", 833936903)
  PackedFloat32Array_method_store.resize = cast(type_of(PackedFloat32Array_method_store.resize))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "resize", 848867239)
  PackedFloat32Array_method_store.clear = cast(type_of(PackedFloat32Array_method_store.clear))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "clear", 3218959716)
  PackedFloat32Array_method_store.has = cast(type_of(PackedFloat32Array_method_store.has))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "has", 1296369134)
  PackedFloat32Array_method_store.reverse = cast(type_of(PackedFloat32Array_method_store.reverse))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "reverse", 3218959716)
  PackedFloat32Array_method_store.slice = cast(type_of(PackedFloat32Array_method_store.slice))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "slice", 1418229160)
  PackedFloat32Array_method_store.to_byte_array = cast(type_of(PackedFloat32Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "to_byte_array", 247621236)
  PackedFloat32Array_method_store.sort = cast(type_of(PackedFloat32Array_method_store.sort))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "sort", 3218959716)
  PackedFloat32Array_method_store.bsearch = cast(type_of(PackedFloat32Array_method_store.bsearch))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "bsearch", 1175118842)
  PackedFloat32Array_method_store.duplicate = cast(type_of(PackedFloat32Array_method_store.duplicate))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "duplicate", 3575107827)
  PackedFloat32Array_method_store.find = cast(type_of(PackedFloat32Array_method_store.find))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "find", 1343150241)
  PackedFloat32Array_method_store.rfind = cast(type_of(PackedFloat32Array_method_store.rfind))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "rfind", 1343150241)
  PackedFloat32Array_method_store.count = cast(type_of(PackedFloat32Array_method_store.count))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "count", 2859915090)
  PackedFloat32Array_method_store.erase = cast(type_of(PackedFloat32Array_method_store.erase))Get_Builtin_Method(.PACKED_FLOAT32_ARRAY, "erase", 4094791666)
  PackedFloat32Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_FLOAT32_ARRAY, .NIL)
  PackedFloat32Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT32_ARRAY, .DICTIONARY)
  PackedFloat32Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_FLOAT32_ARRAY, .ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_EQUAL_PackedFloat32Array = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_EQUAL_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat32Array = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
  PackedFloat32Array_method_store.VARIANT_OP_ADD_PackedFloat32Array = cast(type_of(PackedFloat32Array_method_store.VARIANT_OP_ADD_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT32_ARRAY)
}
