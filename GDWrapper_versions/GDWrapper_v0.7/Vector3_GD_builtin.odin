package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


@(rodata)
Vector3_ZERO : Vector3= {0, 0, 0}
@(rodata)
Vector3_ONE : Vector3= {1, 1, 1}
@(rodata)
Vector3_INF : Vector3= {math.INF_F32, math.INF_F32, math.INF_F32}
@(rodata)
Vector3_LEFT : Vector3= {-1, 0, 0}
@(rodata)
Vector3_RIGHT : Vector3= {1, 0, 0}
@(rodata)
Vector3_UP : Vector3= {0, 1, 0}
@(rodata)
Vector3_DOWN : Vector3= {0, -1, 0}
@(rodata)
Vector3_FORWARD : Vector3= {0, 0, -1}
@(rodata)
Vector3_BACK : Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_LEFT : Vector3= {1, 0, 0}
@(rodata)
Vector3_MODEL_RIGHT : Vector3= {-1, 0, 0}
@(rodata)
Vector3_MODEL_TOP : Vector3= {0, 1, 0}
@(rodata)
Vector3_MODEL_BOTTOM : Vector3= {0, -1, 0}
@(rodata)
Vector3_MODEL_FRONT : Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_REAR : Vector3= {0, 0, -1}

Vector3_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
  AXIS_Z = 2,
}
Vector3_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector3, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector3,  #by_ptr p_args: struct{ from: ^Vector3, }),
    Create2: proc "c" (p_base: ^Vector3,  #by_ptr p_args: struct{ from: ^Vector3i, }),
    Create3: proc "c" (p_base: ^Vector3,  #by_ptr p_args: struct{ x: ^float, y: ^float, z: ^float, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Vector3,
    IndxSetter : proc "c" (p_base: ^Vector3, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^Vector3, p_index: Int, r_value: ^float),
    min_axis_index:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    max_axis_index:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    angle_to:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    signed_angle_to:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, axis: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 2),
    direction_to:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    distance_to:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    length:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    limit_length:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ length: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    normalized:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    is_normalized:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_zero_approx:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_finite:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    inverse:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    clamp:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ min: ^Vector3, max: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    clampf:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ min: ^float, max: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    snapped:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ step: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    snappedf:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ step: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    rotated:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    lerp:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, weight: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    slerp:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, weight: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    cubic_interpolate:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ b: ^Vector3, pre_a: ^Vector3, post_b: ^Vector3, weight: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 4),
    cubic_interpolate_in_time:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ b: ^Vector3, pre_a: ^Vector3, post_b: ^Vector3, weight: ^float, b_t: ^float, pre_a_t: ^float, post_b_t: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 7),
    bezier_interpolate:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ control_1: ^Vector3, control_2: ^Vector3, end: ^Vector3, t: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 4),
    bezier_derivative:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ control_1: ^Vector3, control_2: ^Vector3, end: ^Vector3, t: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 4),
    move_toward:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ to: ^Vector3, delta: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 2),
    dot:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    cross:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    outer:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^Basis, p_argument_count: i64 = 1),
    abs:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    floor:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    ceil:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    round:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    posmod:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ mod: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    posmodv:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ modv: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    project:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ b: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    slide:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ n: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    bounce:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ n: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    reflect:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ n: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    sign:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    octahedron_encode:  proc "c" (p_base: ^Vector3, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    min:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    minf:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    maxf:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    octahedron_decode:  proc "c" (p_base: ^Vector3, #by_ptr p_args: struct{ uv: ^Vector2, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector3, p_right: rawptr = nil,  r_result: ^Vector3),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector3, p_right: rawptr = nil,  r_result: ^Vector3),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector3, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector3, p_right: ^Int, r_result: ^Vector3),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector3, p_right: ^Int, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector3, p_right: ^float, r_result: ^Vector3),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector3, p_right: ^float, r_result: ^Vector3),
    VARIANT_OP_EQUAL_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_LESS_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Bool),
    VARIANT_OP_ADD_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_SUBTRACT_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_DIVIDE_Vector3: proc "c" (p_left: ^Vector3, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Quaternion: proc "c" (p_left: ^Vector3, p_right: ^Quaternion, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Basis: proc "c" (p_left: ^Vector3, p_right: ^Basis, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Transform3D: proc "c" (p_left: ^Vector3, p_right: ^Transform3D, r_result: ^Vector3),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector3, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector3, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedVector3Array: proc "c" (p_left: ^Vector3, p_right: ^PackedVector3Array, r_result: ^Bool),
}
init_Vector3_Methods :: proc(Vector3_method_store: ^Vector3_Methods_list) {
  Vector3_method_store.Create0 = cast(type_of(Vector3_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 0)
  Vector3_method_store.Create1 = cast(type_of(Vector3_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 1)
  Vector3_method_store.Create2 = cast(type_of(Vector3_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 2)
  Vector3_method_store.Create3 = cast(type_of(Vector3_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 3)
    Vector3_method_store.get_ptr = cast(type_of(Vector3_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.VECTOR3)
  Vector3_method_store.IndxGetter = cast(type_of(Vector3_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.VECTOR3)
  Vector3_method_store.IndxSetter = cast(type_of(Vector3_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.VECTOR3)
  Vector3_method_store.min_axis_index = cast(type_of(Vector3_method_store.min_axis_index))Get_Builtin_Method(.VECTOR3, "min_axis_index", 3173160232)
  Vector3_method_store.max_axis_index = cast(type_of(Vector3_method_store.max_axis_index))Get_Builtin_Method(.VECTOR3, "max_axis_index", 3173160232)
  Vector3_method_store.angle_to = cast(type_of(Vector3_method_store.angle_to))Get_Builtin_Method(.VECTOR3, "angle_to", 1047977935)
  Vector3_method_store.signed_angle_to = cast(type_of(Vector3_method_store.signed_angle_to))Get_Builtin_Method(.VECTOR3, "signed_angle_to", 2781412522)
  Vector3_method_store.direction_to = cast(type_of(Vector3_method_store.direction_to))Get_Builtin_Method(.VECTOR3, "direction_to", 2923479887)
  Vector3_method_store.distance_to = cast(type_of(Vector3_method_store.distance_to))Get_Builtin_Method(.VECTOR3, "distance_to", 1047977935)
  Vector3_method_store.distance_squared_to = cast(type_of(Vector3_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR3, "distance_squared_to", 1047977935)
  Vector3_method_store.length = cast(type_of(Vector3_method_store.length))Get_Builtin_Method(.VECTOR3, "length", 466405837)
  Vector3_method_store.length_squared = cast(type_of(Vector3_method_store.length_squared))Get_Builtin_Method(.VECTOR3, "length_squared", 466405837)
  Vector3_method_store.limit_length = cast(type_of(Vector3_method_store.limit_length))Get_Builtin_Method(.VECTOR3, "limit_length", 514930144)
  Vector3_method_store.normalized = cast(type_of(Vector3_method_store.normalized))Get_Builtin_Method(.VECTOR3, "normalized", 1776574132)
  Vector3_method_store.is_normalized = cast(type_of(Vector3_method_store.is_normalized))Get_Builtin_Method(.VECTOR3, "is_normalized", 3918633141)
  Vector3_method_store.is_equal_approx = cast(type_of(Vector3_method_store.is_equal_approx))Get_Builtin_Method(.VECTOR3, "is_equal_approx", 1749054343)
  Vector3_method_store.is_zero_approx = cast(type_of(Vector3_method_store.is_zero_approx))Get_Builtin_Method(.VECTOR3, "is_zero_approx", 3918633141)
  Vector3_method_store.is_finite = cast(type_of(Vector3_method_store.is_finite))Get_Builtin_Method(.VECTOR3, "is_finite", 3918633141)
  Vector3_method_store.inverse = cast(type_of(Vector3_method_store.inverse))Get_Builtin_Method(.VECTOR3, "inverse", 1776574132)
  Vector3_method_store.clamp = cast(type_of(Vector3_method_store.clamp))Get_Builtin_Method(.VECTOR3, "clamp", 4145107892)
  Vector3_method_store.clampf = cast(type_of(Vector3_method_store.clampf))Get_Builtin_Method(.VECTOR3, "clampf", 2329594628)
  Vector3_method_store.snapped = cast(type_of(Vector3_method_store.snapped))Get_Builtin_Method(.VECTOR3, "snapped", 2923479887)
  Vector3_method_store.snappedf = cast(type_of(Vector3_method_store.snappedf))Get_Builtin_Method(.VECTOR3, "snappedf", 514930144)
  Vector3_method_store.rotated = cast(type_of(Vector3_method_store.rotated))Get_Builtin_Method(.VECTOR3, "rotated", 1682608829)
  Vector3_method_store.lerp = cast(type_of(Vector3_method_store.lerp))Get_Builtin_Method(.VECTOR3, "lerp", 1682608829)
  Vector3_method_store.slerp = cast(type_of(Vector3_method_store.slerp))Get_Builtin_Method(.VECTOR3, "slerp", 1682608829)
  Vector3_method_store.cubic_interpolate = cast(type_of(Vector3_method_store.cubic_interpolate))Get_Builtin_Method(.VECTOR3, "cubic_interpolate", 2597922253)
  Vector3_method_store.cubic_interpolate_in_time = cast(type_of(Vector3_method_store.cubic_interpolate_in_time))Get_Builtin_Method(.VECTOR3, "cubic_interpolate_in_time", 3256682901)
  Vector3_method_store.bezier_interpolate = cast(type_of(Vector3_method_store.bezier_interpolate))Get_Builtin_Method(.VECTOR3, "bezier_interpolate", 2597922253)
  Vector3_method_store.bezier_derivative = cast(type_of(Vector3_method_store.bezier_derivative))Get_Builtin_Method(.VECTOR3, "bezier_derivative", 2597922253)
  Vector3_method_store.move_toward = cast(type_of(Vector3_method_store.move_toward))Get_Builtin_Method(.VECTOR3, "move_toward", 1682608829)
  Vector3_method_store.dot = cast(type_of(Vector3_method_store.dot))Get_Builtin_Method(.VECTOR3, "dot", 1047977935)
  Vector3_method_store.cross = cast(type_of(Vector3_method_store.cross))Get_Builtin_Method(.VECTOR3, "cross", 2923479887)
  Vector3_method_store.outer = cast(type_of(Vector3_method_store.outer))Get_Builtin_Method(.VECTOR3, "outer", 3934786792)
  Vector3_method_store.abs = cast(type_of(Vector3_method_store.abs))Get_Builtin_Method(.VECTOR3, "abs", 1776574132)
  Vector3_method_store.floor = cast(type_of(Vector3_method_store.floor))Get_Builtin_Method(.VECTOR3, "floor", 1776574132)
  Vector3_method_store.ceil = cast(type_of(Vector3_method_store.ceil))Get_Builtin_Method(.VECTOR3, "ceil", 1776574132)
  Vector3_method_store.round = cast(type_of(Vector3_method_store.round))Get_Builtin_Method(.VECTOR3, "round", 1776574132)
  Vector3_method_store.posmod = cast(type_of(Vector3_method_store.posmod))Get_Builtin_Method(.VECTOR3, "posmod", 514930144)
  Vector3_method_store.posmodv = cast(type_of(Vector3_method_store.posmodv))Get_Builtin_Method(.VECTOR3, "posmodv", 2923479887)
  Vector3_method_store.project = cast(type_of(Vector3_method_store.project))Get_Builtin_Method(.VECTOR3, "project", 2923479887)
  Vector3_method_store.slide = cast(type_of(Vector3_method_store.slide))Get_Builtin_Method(.VECTOR3, "slide", 2923479887)
  Vector3_method_store.bounce = cast(type_of(Vector3_method_store.bounce))Get_Builtin_Method(.VECTOR3, "bounce", 2923479887)
  Vector3_method_store.reflect = cast(type_of(Vector3_method_store.reflect))Get_Builtin_Method(.VECTOR3, "reflect", 2923479887)
  Vector3_method_store.sign = cast(type_of(Vector3_method_store.sign))Get_Builtin_Method(.VECTOR3, "sign", 1776574132)
  Vector3_method_store.octahedron_encode = cast(type_of(Vector3_method_store.octahedron_encode))Get_Builtin_Method(.VECTOR3, "octahedron_encode", 2428350749)
  Vector3_method_store.min = cast(type_of(Vector3_method_store.min))Get_Builtin_Method(.VECTOR3, "min", 2923479887)
  Vector3_method_store.minf = cast(type_of(Vector3_method_store.minf))Get_Builtin_Method(.VECTOR3, "minf", 514930144)
  Vector3_method_store.max = cast(type_of(Vector3_method_store.max))Get_Builtin_Method(.VECTOR3, "max", 2923479887)
  Vector3_method_store.maxf = cast(type_of(Vector3_method_store.maxf))Get_Builtin_Method(.VECTOR3, "maxf", 514930144)
  Vector3_method_store.octahedron_decode = cast(type_of(Vector3_method_store.octahedron_decode))Get_Builtin_Method(.VECTOR3, "octahedron_decode", 3991820552)
  Vector3_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector3_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector3_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector3_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .INT)
  Vector3_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector3_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .INT)
  Vector3_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .FLOAT)
  Vector3_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector3_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .FLOAT)
  Vector3_method_store.VARIANT_OP_EQUAL_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_EQUAL_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_NOT_EQUAL_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_NOT_EQUAL_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_LESS_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_LESS_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_LESS_EQUAL_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_LESS_EQUAL_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_GREATER_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_GREATER_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_GREATER_EQUAL_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_GREATER_EQUAL_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_ADD_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_ADD_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_SUBTRACT_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_SUBTRACT_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_DIVIDE_Vector3 = cast(type_of(Vector3_method_store.VARIANT_OP_DIVIDE_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Quaternion = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .QUATERNION)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Basis = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_Basis))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .BASIS)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Transform3D = cast(type_of(Vector3_method_store.VARIANT_OP_MULTIPLY_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .TRANSFORM3D)
  Vector3_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector3_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .DICTIONARY)
  Vector3_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector3_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .ARRAY)
  Vector3_method_store.VARIANT_OP_IN_PackedVector3Array = cast(type_of(Vector3_method_store.VARIANT_OP_IN_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .PACKED_VECTOR3_ARRAY)
}
