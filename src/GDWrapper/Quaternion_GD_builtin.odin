package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Quaternion_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Quaternion, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Quaternion,  #by_ptr p_args: struct{ from: ^Quaternion, }),
    Create2: proc "c" (p_base: ^Quaternion,  #by_ptr p_args: struct{ from: ^Basis, }),
    Create3: proc "c" (p_base: ^Quaternion,  #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }),
    Create4: proc "c" (p_base: ^Quaternion,  #by_ptr p_args: struct{ arc_from: ^Vector3, arc_to: ^Vector3, }),
    Create5: proc "c" (p_base: ^Quaternion,  #by_ptr p_args: struct{ x: ^float, y: ^float, z: ^float, w: ^float, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Quaternion,
    IndxSetter : proc "c" (p_base: ^Quaternion, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^Quaternion, p_index: Int, r_value: ^float),
    length:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    normalized:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Quaternion, p_argument_count: i64 = 0),
    is_normalized:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ to: ^Quaternion, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    inverse:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Quaternion, p_argument_count: i64 = 0),
    log:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Quaternion, p_argument_count: i64 = 0),
    exp:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Quaternion, p_argument_count: i64 = 0),
    angle_to:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ to: ^Quaternion, }, r_return: ^float, p_argument_count: i64 = 1),
    dot:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ with: ^Quaternion, }, r_return: ^float, p_argument_count: i64 = 1),
    slerp:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ to: ^Quaternion, weight: ^float, }, r_return: ^Quaternion, p_argument_count: i64 = 2),
    slerpni:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ to: ^Quaternion, weight: ^float, }, r_return: ^Quaternion, p_argument_count: i64 = 2),
    spherical_cubic_interpolate:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ b: ^Quaternion, pre_a: ^Quaternion, post_b: ^Quaternion, weight: ^float, }, r_return: ^Quaternion, p_argument_count: i64 = 4),
    spherical_cubic_interpolate_in_time:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ b: ^Quaternion, pre_a: ^Quaternion, post_b: ^Quaternion, weight: ^float, b_t: ^float, pre_a_t: ^float, post_b_t: ^float, }, r_return: ^Quaternion, p_argument_count: i64 = 7),
    get_euler:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ order: ^Int, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    from_euler:  proc "c" (p_base: ^Quaternion, #by_ptr p_args: struct{ euler: ^Vector3, }, r_return: ^Quaternion, p_argument_count: i64 = 1),
    get_axis:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    get_angle:  proc "c" (p_base: ^Quaternion, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Quaternion, p_right: rawptr = nil,  r_result: ^Quaternion),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Quaternion, p_right: rawptr = nil,  r_result: ^Quaternion),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Quaternion, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Quaternion, p_right: ^Int, r_result: ^Quaternion),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Quaternion, p_right: ^Int, r_result: ^Quaternion),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Quaternion, p_right: ^float, r_result: ^Quaternion),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Quaternion, p_right: ^float, r_result: ^Quaternion),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^Quaternion, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_EQUAL_Quaternion: proc "c" (p_left: ^Quaternion, p_right: ^Quaternion, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Quaternion: proc "c" (p_left: ^Quaternion, p_right: ^Quaternion, r_result: ^Bool),
    VARIANT_OP_ADD_Quaternion: proc "c" (p_left: ^Quaternion, p_right: ^Quaternion, r_result: ^Quaternion),
    VARIANT_OP_SUBTRACT_Quaternion: proc "c" (p_left: ^Quaternion, p_right: ^Quaternion, r_result: ^Quaternion),
    VARIANT_OP_MULTIPLY_Quaternion: proc "c" (p_left: ^Quaternion, p_right: ^Quaternion, r_result: ^Quaternion),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Quaternion, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Quaternion, p_right: ^Array, r_result: ^Bool),
}
init_Quaternion_Methods :: proc "c" (Quaternion_method_store: ^Quaternion_Methods_list) {
  Quaternion_method_store.Create0 = cast(type_of(Quaternion_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 0)
  Quaternion_method_store.Create1 = cast(type_of(Quaternion_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 1)
  Quaternion_method_store.Create2 = cast(type_of(Quaternion_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 2)
  Quaternion_method_store.Create3 = cast(type_of(Quaternion_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 3)
  Quaternion_method_store.Create4 = cast(type_of(Quaternion_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 4)
  Quaternion_method_store.Create5 = cast(type_of(Quaternion_method_store.Create5))gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 5)
    Quaternion_method_store.get_ptr = cast(type_of(Quaternion_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.QUATERNION)
  Quaternion_method_store.IndxGetter = cast(type_of(Quaternion_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.QUATERNION)
  Quaternion_method_store.IndxSetter = cast(type_of(Quaternion_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.QUATERNION)
  Quaternion_method_store.length = cast(type_of(Quaternion_method_store.length))Get_Builtin_Method(.QUATERNION, "length", 466405837)
  Quaternion_method_store.length_squared = cast(type_of(Quaternion_method_store.length_squared))Get_Builtin_Method(.QUATERNION, "length_squared", 466405837)
  Quaternion_method_store.normalized = cast(type_of(Quaternion_method_store.normalized))Get_Builtin_Method(.QUATERNION, "normalized", 4274879941)
  Quaternion_method_store.is_normalized = cast(type_of(Quaternion_method_store.is_normalized))Get_Builtin_Method(.QUATERNION, "is_normalized", 3918633141)
  Quaternion_method_store.is_equal_approx = cast(type_of(Quaternion_method_store.is_equal_approx))Get_Builtin_Method(.QUATERNION, "is_equal_approx", 1682156903)
  Quaternion_method_store.is_finite = cast(type_of(Quaternion_method_store.is_finite))Get_Builtin_Method(.QUATERNION, "is_finite", 3918633141)
  Quaternion_method_store.inverse = cast(type_of(Quaternion_method_store.inverse))Get_Builtin_Method(.QUATERNION, "inverse", 4274879941)
  Quaternion_method_store.log = cast(type_of(Quaternion_method_store.log))Get_Builtin_Method(.QUATERNION, "log", 4274879941)
  Quaternion_method_store.exp = cast(type_of(Quaternion_method_store.exp))Get_Builtin_Method(.QUATERNION, "exp", 4274879941)
  Quaternion_method_store.angle_to = cast(type_of(Quaternion_method_store.angle_to))Get_Builtin_Method(.QUATERNION, "angle_to", 3244682419)
  Quaternion_method_store.dot = cast(type_of(Quaternion_method_store.dot))Get_Builtin_Method(.QUATERNION, "dot", 3244682419)
  Quaternion_method_store.slerp = cast(type_of(Quaternion_method_store.slerp))Get_Builtin_Method(.QUATERNION, "slerp", 1773590316)
  Quaternion_method_store.slerpni = cast(type_of(Quaternion_method_store.slerpni))Get_Builtin_Method(.QUATERNION, "slerpni", 1773590316)
  Quaternion_method_store.spherical_cubic_interpolate = cast(type_of(Quaternion_method_store.spherical_cubic_interpolate))Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate", 2150967576)
  Quaternion_method_store.spherical_cubic_interpolate_in_time = cast(type_of(Quaternion_method_store.spherical_cubic_interpolate_in_time))Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate_in_time", 1436023539)
  Quaternion_method_store.get_euler = cast(type_of(Quaternion_method_store.get_euler))Get_Builtin_Method(.QUATERNION, "get_euler", 1394941017)
  Quaternion_method_store.from_euler = cast(type_of(Quaternion_method_store.from_euler))Get_Builtin_Method(.QUATERNION, "from_euler", 4053467903)
  Quaternion_method_store.get_axis = cast(type_of(Quaternion_method_store.get_axis))Get_Builtin_Method(.QUATERNION, "get_axis", 1776574132)
  Quaternion_method_store.get_angle = cast(type_of(Quaternion_method_store.get_angle))Get_Builtin_Method(.QUATERNION, "get_angle", 466405837)
  Quaternion_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Quaternion_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Quaternion_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_NOT_ = cast(type_of(Quaternion_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Quaternion_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .INT)
  Quaternion_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Quaternion_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .QUATERNION, .INT)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Quaternion_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .FLOAT)
  Quaternion_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Quaternion_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .QUATERNION, .FLOAT)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(Quaternion_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .VECTOR3)
  Quaternion_method_store.VARIANT_OP_EQUAL_Quaternion = cast(type_of(Quaternion_method_store.VARIANT_OP_EQUAL_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_NOT_EQUAL_Quaternion = cast(type_of(Quaternion_method_store.VARIANT_OP_NOT_EQUAL_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_ADD_Quaternion = cast(type_of(Quaternion_method_store.VARIANT_OP_ADD_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_SUBTRACT_Quaternion = cast(type_of(Quaternion_method_store.VARIANT_OP_SUBTRACT_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_Quaternion = cast(type_of(Quaternion_method_store.VARIANT_OP_MULTIPLY_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Quaternion_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .QUATERNION, .DICTIONARY)
  Quaternion_method_store.VARIANT_OP_IN_Array = cast(type_of(Quaternion_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .QUATERNION, .ARRAY)
}
