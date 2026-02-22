package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Vector2_ZERO : Vector2= {0, 0}
@(rodata)
Vector2_ONE : Vector2= {1, 1}
@(rodata)
Vector2_INF : Vector2= {math.INF_F32, math.INF_F32}
@(rodata)
Vector2_LEFT : Vector2= {-1, 0}
@(rodata)
Vector2_RIGHT : Vector2= {1, 0}
@(rodata)
Vector2_UP : Vector2= {0, -1}
@(rodata)
Vector2_DOWN : Vector2= {0, 1}

Vector2_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
}
Vector2_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector2, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector2,  #by_ptr p_args: struct{ from: ^Vector2, }),
    Create2: proc "c" (p_base: ^Vector2,  #by_ptr p_args: struct{ from: ^Vector2i, }),
    Create3: proc "c" (p_base: ^Vector2,  #by_ptr p_args: struct{ x: ^float, y: ^float, }),
    IndxSetter : proc "c" (p_base: ^Vector2, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^Vector2, p_index: Int, r_value: ^float),
    angle:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    angle_to:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    angle_to_point:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    direction_to:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    distance_to:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    length:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    limit_length:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ length: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    normalized:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    is_normalized:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_zero_approx:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_finite:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    posmod:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ mod: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    posmodv:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ modv: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    project:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ b: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    lerp:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, weight: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 2),
    slerp:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, weight: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 2),
    cubic_interpolate:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ b: ^Vector2, pre_a: ^Vector2, post_b: ^Vector2, weight: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 4),
    cubic_interpolate_in_time:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ b: ^Vector2, pre_a: ^Vector2, post_b: ^Vector2, weight: ^float, b_t: ^float, pre_a_t: ^float, post_b_t: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 7),
    bezier_interpolate:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ control_1: ^Vector2, control_2: ^Vector2, end: ^Vector2, t: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 4),
    bezier_derivative:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ control_1: ^Vector2, control_2: ^Vector2, end: ^Vector2, t: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 4),
    max_axis_index:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    min_axis_index:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    move_toward:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ to: ^Vector2, delta: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 2),
    rotated:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ angle: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    orthogonal:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    floor:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    ceil:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    round:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    aspect:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    dot:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    slide:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ n: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    bounce:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ n: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    reflect:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ line: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    cross:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^Vector2, }, r_return: ^float, p_argument_count: i64 = 1),
    abs:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    sign:  proc "c" (p_base: ^Vector2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    clamp:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ min: ^Vector2, max: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 2),
    clampf:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ min: ^float, max: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 2),
    snapped:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ step: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    snappedf:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ step: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    min:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    minf:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    maxf:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    from_angle:  proc "c" (p_base: ^Vector2, #by_ptr p_args: struct{ angle: ^float, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector2, p_right: rawptr = nil,  r_result: ^Vector2),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector2, p_right: rawptr = nil,  r_result: ^Vector2),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector2, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector2, p_right: ^Int, r_result: ^Vector2),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector2, p_right: ^Int, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector2, p_right: ^float, r_result: ^Vector2),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector2, p_right: ^float, r_result: ^Vector2),
    VARIANT_OP_EQUAL_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_LESS_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Bool),
    VARIANT_OP_ADD_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_SUBTRACT_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_DIVIDE_Vector2: proc "c" (p_left: ^Vector2, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Transform2D: proc "c" (p_left: ^Vector2, p_right: ^Transform2D, r_result: ^Vector2),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector2, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector2, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedVector2Array: proc "c" (p_left: ^Vector2, p_right: ^PackedVector2Array, r_result: ^Bool),
}
init_Vector2_Methods :: proc(Vector2_method_store: ^Vector2_Methods_list) {
  Vector2_method_store.Create0 = cast(type_of(Vector2_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 0)
  Vector2_method_store.Create1 = cast(type_of(Vector2_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 1)
  Vector2_method_store.Create2 = cast(type_of(Vector2_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 2)
  Vector2_method_store.Create3 = cast(type_of(Vector2_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 3)
  Vector2_method_store.IndxGetter = cast(type_of(Vector2_method_store.Vector2IndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.VECTOR2)
  Vector2_method_store.IndxSetter = cast(type_of(Vector2_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.VECTOR2)
  Vector2_method_store.angle = cast(type_of(Vector2_method_store.angle))Get_Builtin_Method(.VECTOR2, "angle", 466405837)
  Vector2_method_store.angle_to = cast(type_of(Vector2_method_store.angle_to))Get_Builtin_Method(.VECTOR2, "angle_to", 3819070308)
  Vector2_method_store.angle_to_point = cast(type_of(Vector2_method_store.angle_to_point))Get_Builtin_Method(.VECTOR2, "angle_to_point", 3819070308)
  Vector2_method_store.direction_to = cast(type_of(Vector2_method_store.direction_to))Get_Builtin_Method(.VECTOR2, "direction_to", 2026743667)
  Vector2_method_store.distance_to = cast(type_of(Vector2_method_store.distance_to))Get_Builtin_Method(.VECTOR2, "distance_to", 3819070308)
  Vector2_method_store.distance_squared_to = cast(type_of(Vector2_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR2, "distance_squared_to", 3819070308)
  Vector2_method_store.length = cast(type_of(Vector2_method_store.length))Get_Builtin_Method(.VECTOR2, "length", 466405837)
  Vector2_method_store.length_squared = cast(type_of(Vector2_method_store.length_squared))Get_Builtin_Method(.VECTOR2, "length_squared", 466405837)
  Vector2_method_store.limit_length = cast(type_of(Vector2_method_store.limit_length))Get_Builtin_Method(.VECTOR2, "limit_length", 2544004089)
  Vector2_method_store.normalized = cast(type_of(Vector2_method_store.normalized))Get_Builtin_Method(.VECTOR2, "normalized", 2428350749)
  Vector2_method_store.is_normalized = cast(type_of(Vector2_method_store.is_normalized))Get_Builtin_Method(.VECTOR2, "is_normalized", 3918633141)
  Vector2_method_store.is_equal_approx = cast(type_of(Vector2_method_store.is_equal_approx))Get_Builtin_Method(.VECTOR2, "is_equal_approx", 3190634762)
  Vector2_method_store.is_zero_approx = cast(type_of(Vector2_method_store.is_zero_approx))Get_Builtin_Method(.VECTOR2, "is_zero_approx", 3918633141)
  Vector2_method_store.is_finite = cast(type_of(Vector2_method_store.is_finite))Get_Builtin_Method(.VECTOR2, "is_finite", 3918633141)
  Vector2_method_store.posmod = cast(type_of(Vector2_method_store.posmod))Get_Builtin_Method(.VECTOR2, "posmod", 2544004089)
  Vector2_method_store.posmodv = cast(type_of(Vector2_method_store.posmodv))Get_Builtin_Method(.VECTOR2, "posmodv", 2026743667)
  Vector2_method_store.project = cast(type_of(Vector2_method_store.project))Get_Builtin_Method(.VECTOR2, "project", 2026743667)
  Vector2_method_store.lerp = cast(type_of(Vector2_method_store.lerp))Get_Builtin_Method(.VECTOR2, "lerp", 4250033116)
  Vector2_method_store.slerp = cast(type_of(Vector2_method_store.slerp))Get_Builtin_Method(.VECTOR2, "slerp", 4250033116)
  Vector2_method_store.cubic_interpolate = cast(type_of(Vector2_method_store.cubic_interpolate))Get_Builtin_Method(.VECTOR2, "cubic_interpolate", 193522989)
  Vector2_method_store.cubic_interpolate_in_time = cast(type_of(Vector2_method_store.cubic_interpolate_in_time))Get_Builtin_Method(.VECTOR2, "cubic_interpolate_in_time", 1957055074)
  Vector2_method_store.bezier_interpolate = cast(type_of(Vector2_method_store.bezier_interpolate))Get_Builtin_Method(.VECTOR2, "bezier_interpolate", 193522989)
  Vector2_method_store.bezier_derivative = cast(type_of(Vector2_method_store.bezier_derivative))Get_Builtin_Method(.VECTOR2, "bezier_derivative", 193522989)
  Vector2_method_store.max_axis_index = cast(type_of(Vector2_method_store.max_axis_index))Get_Builtin_Method(.VECTOR2, "max_axis_index", 3173160232)
  Vector2_method_store.min_axis_index = cast(type_of(Vector2_method_store.min_axis_index))Get_Builtin_Method(.VECTOR2, "min_axis_index", 3173160232)
  Vector2_method_store.move_toward = cast(type_of(Vector2_method_store.move_toward))Get_Builtin_Method(.VECTOR2, "move_toward", 4250033116)
  Vector2_method_store.rotated = cast(type_of(Vector2_method_store.rotated))Get_Builtin_Method(.VECTOR2, "rotated", 2544004089)
  Vector2_method_store.orthogonal = cast(type_of(Vector2_method_store.orthogonal))Get_Builtin_Method(.VECTOR2, "orthogonal", 2428350749)
  Vector2_method_store.floor = cast(type_of(Vector2_method_store.floor))Get_Builtin_Method(.VECTOR2, "floor", 2428350749)
  Vector2_method_store.ceil = cast(type_of(Vector2_method_store.ceil))Get_Builtin_Method(.VECTOR2, "ceil", 2428350749)
  Vector2_method_store.round = cast(type_of(Vector2_method_store.round))Get_Builtin_Method(.VECTOR2, "round", 2428350749)
  Vector2_method_store.aspect = cast(type_of(Vector2_method_store.aspect))Get_Builtin_Method(.VECTOR2, "aspect", 466405837)
  Vector2_method_store.dot = cast(type_of(Vector2_method_store.dot))Get_Builtin_Method(.VECTOR2, "dot", 3819070308)
  Vector2_method_store.slide = cast(type_of(Vector2_method_store.slide))Get_Builtin_Method(.VECTOR2, "slide", 2026743667)
  Vector2_method_store.bounce = cast(type_of(Vector2_method_store.bounce))Get_Builtin_Method(.VECTOR2, "bounce", 2026743667)
  Vector2_method_store.reflect = cast(type_of(Vector2_method_store.reflect))Get_Builtin_Method(.VECTOR2, "reflect", 2026743667)
  Vector2_method_store.cross = cast(type_of(Vector2_method_store.cross))Get_Builtin_Method(.VECTOR2, "cross", 3819070308)
  Vector2_method_store.abs = cast(type_of(Vector2_method_store.abs))Get_Builtin_Method(.VECTOR2, "abs", 2428350749)
  Vector2_method_store.sign = cast(type_of(Vector2_method_store.sign))Get_Builtin_Method(.VECTOR2, "sign", 2428350749)
  Vector2_method_store.clamp = cast(type_of(Vector2_method_store.clamp))Get_Builtin_Method(.VECTOR2, "clamp", 318031021)
  Vector2_method_store.clampf = cast(type_of(Vector2_method_store.clampf))Get_Builtin_Method(.VECTOR2, "clampf", 3464402636)
  Vector2_method_store.snapped = cast(type_of(Vector2_method_store.snapped))Get_Builtin_Method(.VECTOR2, "snapped", 2026743667)
  Vector2_method_store.snappedf = cast(type_of(Vector2_method_store.snappedf))Get_Builtin_Method(.VECTOR2, "snappedf", 2544004089)
  Vector2_method_store.min = cast(type_of(Vector2_method_store.min))Get_Builtin_Method(.VECTOR2, "min", 2026743667)
  Vector2_method_store.minf = cast(type_of(Vector2_method_store.minf))Get_Builtin_Method(.VECTOR2, "minf", 2544004089)
  Vector2_method_store.max = cast(type_of(Vector2_method_store.max))Get_Builtin_Method(.VECTOR2, "max", 2026743667)
  Vector2_method_store.maxf = cast(type_of(Vector2_method_store.maxf))Get_Builtin_Method(.VECTOR2, "maxf", 2544004089)
  Vector2_method_store.from_angle = cast(type_of(Vector2_method_store.from_angle))Get_Builtin_Method(.VECTOR2, "from_angle", 889263119)
  Vector2_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector2_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector2_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector2_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector2_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .INT)
  Vector2_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector2_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .INT)
  Vector2_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector2_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .FLOAT)
  Vector2_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector2_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .FLOAT)
  Vector2_method_store.VARIANT_OP_EQUAL_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_EQUAL_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_NOT_EQUAL_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_NOT_EQUAL_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_LESS_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_LESS_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_LESS_EQUAL_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_LESS_EQUAL_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_GREATER_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_GREATER_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_GREATER_EQUAL_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_GREATER_EQUAL_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_ADD_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_ADD_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_SUBTRACT_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_SUBTRACT_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_MULTIPLY_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_MULTIPLY_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_DIVIDE_Vector2 = cast(type_of(Vector2_method_store.VARIANT_OP_DIVIDE_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_MULTIPLY_Transform2D = cast(type_of(Vector2_method_store.VARIANT_OP_MULTIPLY_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .TRANSFORM2D)
  Vector2_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector2_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .DICTIONARY)
  Vector2_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector2_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .ARRAY)
  Vector2_method_store.VARIANT_OP_IN_PackedVector2Array = cast(type_of(Vector2_method_store.VARIANT_OP_IN_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .PACKED_VECTOR2_ARRAY)
}
