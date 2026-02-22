package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


PackedVector3Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedVector3Array,  #by_ptr p_args: struct{ from: ^PackedVector3Array, }),
    Create2: proc "c" (p_base: ^PackedVector3Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedVector3Array),
    IndxSetter : proc "c" (p_base: ^PackedVector3Array, p_index: Int, p_value: ^Vector3),
    IndxGetter : proc "c" (p_base: ^PackedVector3Array, p_index: Int, r_value: ^Vector3),
    get:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ index: ^Int, value: ^Vector3, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ array: ^PackedVector3Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ at_index: ^Int, value: ^Vector3, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedVector3Array, p_argument_count: i64 = 2),
    to_byte_array:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sort:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedVector3Array, p_args: rawptr = nil, r_return: ^PackedVector3Array, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedVector3Array, #by_ptr p_args: struct{ value: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedVector3Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform3D: proc "c" (p_left: ^PackedVector3Array, p_right: ^Transform3D, r_result: ^PackedVector3Array),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedVector3Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedVector3Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedVector3Array: proc "c" (p_left: ^PackedVector3Array, p_right: ^PackedVector3Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedVector3Array: proc "c" (p_left: ^PackedVector3Array, p_right: ^PackedVector3Array, r_result: ^Bool),
    VARIANT_OP_ADD_PackedVector3Array: proc "c" (p_left: ^PackedVector3Array, p_right: ^PackedVector3Array, r_result: ^PackedVector3Array),
}
init_PackedVector3Array_Methods :: proc(PackedVector3Array_method_store: ^PackedVector3Array_Methods_list) {
  PackedVector3Array_method_store.Create0 = cast(type_of(PackedVector3Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 0)
  PackedVector3Array_method_store.Create1 = cast(type_of(PackedVector3Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 1)
  PackedVector3Array_method_store.Create2 = cast(type_of(PackedVector3Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 2)
  PackedVector3Array_method_store.Destroy = cast(type_of(PackedVector3Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.IndxGetter = cast(type_of(PackedVector3Array_method_store.PackedVector3ArrayIndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.IndxSetter = cast(type_of(PackedVector3Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.get = cast(type_of(PackedVector3Array_method_store.get))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "get", 1394941017)
  PackedVector3Array_method_store.set = cast(type_of(PackedVector3Array_method_store.set))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "set", 3975343409)
  PackedVector3Array_method_store.size = cast(type_of(PackedVector3Array_method_store.size))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "size", 3173160232)
  PackedVector3Array_method_store.is_empty = cast(type_of(PackedVector3Array_method_store.is_empty))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "is_empty", 3918633141)
  PackedVector3Array_method_store.push_back = cast(type_of(PackedVector3Array_method_store.push_back))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "push_back", 3295363524)
  PackedVector3Array_method_store.append = cast(type_of(PackedVector3Array_method_store.append))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "append", 3295363524)
  PackedVector3Array_method_store.append_array = cast(type_of(PackedVector3Array_method_store.append_array))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "append_array", 203538016)
  PackedVector3Array_method_store.remove_at = cast(type_of(PackedVector3Array_method_store.remove_at))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "remove_at", 2823966027)
  PackedVector3Array_method_store.insert = cast(type_of(PackedVector3Array_method_store.insert))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "insert", 3892262309)
  PackedVector3Array_method_store.fill = cast(type_of(PackedVector3Array_method_store.fill))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "fill", 3726392409)
  PackedVector3Array_method_store.resize = cast(type_of(PackedVector3Array_method_store.resize))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "resize", 848867239)
  PackedVector3Array_method_store.clear = cast(type_of(PackedVector3Array_method_store.clear))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "clear", 3218959716)
  PackedVector3Array_method_store.has = cast(type_of(PackedVector3Array_method_store.has))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "has", 1749054343)
  PackedVector3Array_method_store.reverse = cast(type_of(PackedVector3Array_method_store.reverse))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "reverse", 3218959716)
  PackedVector3Array_method_store.slice = cast(type_of(PackedVector3Array_method_store.slice))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "slice", 2086131305)
  PackedVector3Array_method_store.to_byte_array = cast(type_of(PackedVector3Array_method_store.to_byte_array))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "to_byte_array", 247621236)
  PackedVector3Array_method_store.sort = cast(type_of(PackedVector3Array_method_store.sort))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "sort", 3218959716)
  PackedVector3Array_method_store.bsearch = cast(type_of(PackedVector3Array_method_store.bsearch))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "bsearch", 1259277637)
  PackedVector3Array_method_store.duplicate = cast(type_of(PackedVector3Array_method_store.duplicate))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "duplicate", 4171207452)
  PackedVector3Array_method_store.find = cast(type_of(PackedVector3Array_method_store.find))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "find", 3718155780)
  PackedVector3Array_method_store.rfind = cast(type_of(PackedVector3Array_method_store.rfind))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "rfind", 3718155780)
  PackedVector3Array_method_store.count = cast(type_of(PackedVector3Array_method_store.count))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "count", 194580386)
  PackedVector3Array_method_store.erase = cast(type_of(PackedVector3Array_method_store.erase))Get_Builtin_Method(.PACKED_VECTOR3_ARRAY, "erase", 3295363524)
  PackedVector3Array_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_VECTOR3_ARRAY, .NIL)
  PackedVector3Array_method_store.VARIANT_OP_MULTIPLY_Transform3D = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_MULTIPLY_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PACKED_VECTOR3_ARRAY, .TRANSFORM3D)
  PackedVector3Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR3_ARRAY, .DICTIONARY)
  PackedVector3Array_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_VECTOR3_ARRAY, .ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_EQUAL_PackedVector3Array = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_EQUAL_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector3Array = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_NOT_EQUAL_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
  PackedVector3Array_method_store.VARIANT_OP_ADD_PackedVector3Array = cast(type_of(PackedVector3Array_method_store.VARIANT_OP_ADD_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_VECTOR3_ARRAY, .PACKED_VECTOR3_ARRAY)
}
