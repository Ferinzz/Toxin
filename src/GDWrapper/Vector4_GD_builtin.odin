package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


@(rodata)
Vector4_ZERO : Vector4= {0, 0, 0, 0}
@(rodata)
Vector4_ONE : Vector4= {1, 1, 1, 1}
@(rodata)
Vector4_INF : Vector4= {math.INF_F32, math.INF_F32, math.INF_F32, math.INF_F32}

Vector4_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
  AXIS_Z = 2,
  AXIS_W = 3,
}
Vector4_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector4, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector4,  #by_ptr p_args: struct{ from: ^Vector4, }),
    Create2: proc "c" (p_base: ^Vector4,  #by_ptr p_args: struct{ from: ^Vector4i, }),
    Create3: proc "c" (p_base: ^Vector4,  #by_ptr p_args: struct{ x: ^float, y: ^float, z: ^float, w: ^float, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Vector4,
    IndxSetter : proc "c" (p_base: ^Vector4, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^Vector4, p_index: Int, r_value: ^float),
    min_axis_index:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    max_axis_index:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    length:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    abs:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    sign:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    floor:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    ceil:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    round:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    lerp:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ to: ^Vector4, weight: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 2),
    cubic_interpolate:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ b: ^Vector4, pre_a: ^Vector4, post_b: ^Vector4, weight: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 4),
    cubic_interpolate_in_time:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ b: ^Vector4, pre_a: ^Vector4, post_b: ^Vector4, weight: ^float, b_t: ^float, pre_a_t: ^float, post_b_t: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 7),
    posmod:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ mod: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    posmodv:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ modv: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    snapped:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ step: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    snappedf:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ step: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    clamp:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ min: ^Vector4, max: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 2),
    clampf:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ min: ^float, max: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 2),
    normalized:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    is_normalized:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    direction_to:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ to: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    distance_to:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ to: ^Vector4, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ to: ^Vector4, }, r_return: ^float, p_argument_count: i64 = 1),
    dot:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ with: ^Vector4, }, r_return: ^float, p_argument_count: i64 = 1),
    inverse:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Vector4, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ to: ^Vector4, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_zero_approx:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_finite:  proc "c" (p_base: ^Vector4, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    min:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ with: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    minf:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ with: ^Vector4, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    maxf:  proc "c" (p_base: ^Vector4, #by_ptr p_args: struct{ with: ^float, }, r_return: ^Vector4, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector4, p_right: rawptr = nil,  r_result: ^Vector4),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector4, p_right: rawptr = nil,  r_result: ^Vector4),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector4, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector4, p_right: ^Int, r_result: ^Vector4),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector4, p_right: ^Int, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector4, p_right: ^float, r_result: ^Vector4),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector4, p_right: ^float, r_result: ^Vector4),
    VARIANT_OP_EQUAL_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_LESS_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Bool),
    VARIANT_OP_ADD_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_SUBTRACT_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_DIVIDE_Vector4: proc "c" (p_left: ^Vector4, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_Projection: proc "c" (p_left: ^Vector4, p_right: ^Projection, r_result: ^Vector4),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector4, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector4, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedVector4Array: proc "c" (p_left: ^Vector4, p_right: ^PackedVector4Array, r_result: ^Bool),
}
init_Vector4_Methods :: proc(Vector4_method_store: ^Vector4_Methods_list) {
  Vector4_method_store.Create0 = cast(type_of(Vector4_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 0)
  Vector4_method_store.Create1 = cast(type_of(Vector4_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 1)
  Vector4_method_store.Create2 = cast(type_of(Vector4_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 2)
  Vector4_method_store.Create3 = cast(type_of(Vector4_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 3)
    Vector4_method_store.get_ptr = cast(type_of(Vector4_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.VECTOR4)
  Vector4_method_store.IndxGetter = cast(type_of(Vector4_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.VECTOR4)
  Vector4_method_store.IndxSetter = cast(type_of(Vector4_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.VECTOR4)
  Vector4_method_store.min_axis_index = cast(type_of(Vector4_method_store.min_axis_index))Get_Builtin_Method(.VECTOR4, "min_axis_index", 3173160232)
  Vector4_method_store.max_axis_index = cast(type_of(Vector4_method_store.max_axis_index))Get_Builtin_Method(.VECTOR4, "max_axis_index", 3173160232)
  Vector4_method_store.length = cast(type_of(Vector4_method_store.length))Get_Builtin_Method(.VECTOR4, "length", 466405837)
  Vector4_method_store.length_squared = cast(type_of(Vector4_method_store.length_squared))Get_Builtin_Method(.VECTOR4, "length_squared", 466405837)
  Vector4_method_store.abs = cast(type_of(Vector4_method_store.abs))Get_Builtin_Method(.VECTOR4, "abs", 80860099)
  Vector4_method_store.sign = cast(type_of(Vector4_method_store.sign))Get_Builtin_Method(.VECTOR4, "sign", 80860099)
  Vector4_method_store.floor = cast(type_of(Vector4_method_store.floor))Get_Builtin_Method(.VECTOR4, "floor", 80860099)
  Vector4_method_store.ceil = cast(type_of(Vector4_method_store.ceil))Get_Builtin_Method(.VECTOR4, "ceil", 80860099)
  Vector4_method_store.round = cast(type_of(Vector4_method_store.round))Get_Builtin_Method(.VECTOR4, "round", 80860099)
  Vector4_method_store.lerp = cast(type_of(Vector4_method_store.lerp))Get_Builtin_Method(.VECTOR4, "lerp", 2329757942)
  Vector4_method_store.cubic_interpolate = cast(type_of(Vector4_method_store.cubic_interpolate))Get_Builtin_Method(.VECTOR4, "cubic_interpolate", 726768410)
  Vector4_method_store.cubic_interpolate_in_time = cast(type_of(Vector4_method_store.cubic_interpolate_in_time))Get_Builtin_Method(.VECTOR4, "cubic_interpolate_in_time", 681631873)
  Vector4_method_store.posmod = cast(type_of(Vector4_method_store.posmod))Get_Builtin_Method(.VECTOR4, "posmod", 3129671720)
  Vector4_method_store.posmodv = cast(type_of(Vector4_method_store.posmodv))Get_Builtin_Method(.VECTOR4, "posmodv", 2031281584)
  Vector4_method_store.snapped = cast(type_of(Vector4_method_store.snapped))Get_Builtin_Method(.VECTOR4, "snapped", 2031281584)
  Vector4_method_store.snappedf = cast(type_of(Vector4_method_store.snappedf))Get_Builtin_Method(.VECTOR4, "snappedf", 3129671720)
  Vector4_method_store.clamp = cast(type_of(Vector4_method_store.clamp))Get_Builtin_Method(.VECTOR4, "clamp", 823915692)
  Vector4_method_store.clampf = cast(type_of(Vector4_method_store.clampf))Get_Builtin_Method(.VECTOR4, "clampf", 4072091586)
  Vector4_method_store.normalized = cast(type_of(Vector4_method_store.normalized))Get_Builtin_Method(.VECTOR4, "normalized", 80860099)
  Vector4_method_store.is_normalized = cast(type_of(Vector4_method_store.is_normalized))Get_Builtin_Method(.VECTOR4, "is_normalized", 3918633141)
  Vector4_method_store.direction_to = cast(type_of(Vector4_method_store.direction_to))Get_Builtin_Method(.VECTOR4, "direction_to", 2031281584)
  Vector4_method_store.distance_to = cast(type_of(Vector4_method_store.distance_to))Get_Builtin_Method(.VECTOR4, "distance_to", 3770801042)
  Vector4_method_store.distance_squared_to = cast(type_of(Vector4_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR4, "distance_squared_to", 3770801042)
  Vector4_method_store.dot = cast(type_of(Vector4_method_store.dot))Get_Builtin_Method(.VECTOR4, "dot", 3770801042)
  Vector4_method_store.inverse = cast(type_of(Vector4_method_store.inverse))Get_Builtin_Method(.VECTOR4, "inverse", 80860099)
  Vector4_method_store.is_equal_approx = cast(type_of(Vector4_method_store.is_equal_approx))Get_Builtin_Method(.VECTOR4, "is_equal_approx", 88913544)
  Vector4_method_store.is_zero_approx = cast(type_of(Vector4_method_store.is_zero_approx))Get_Builtin_Method(.VECTOR4, "is_zero_approx", 3918633141)
  Vector4_method_store.is_finite = cast(type_of(Vector4_method_store.is_finite))Get_Builtin_Method(.VECTOR4, "is_finite", 3918633141)
  Vector4_method_store.min = cast(type_of(Vector4_method_store.min))Get_Builtin_Method(.VECTOR4, "min", 2031281584)
  Vector4_method_store.minf = cast(type_of(Vector4_method_store.minf))Get_Builtin_Method(.VECTOR4, "minf", 3129671720)
  Vector4_method_store.max = cast(type_of(Vector4_method_store.max))Get_Builtin_Method(.VECTOR4, "max", 2031281584)
  Vector4_method_store.maxf = cast(type_of(Vector4_method_store.maxf))Get_Builtin_Method(.VECTOR4, "maxf", 3129671720)
  Vector4_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector4_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector4_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector4_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector4_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .INT)
  Vector4_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector4_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .INT)
  Vector4_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector4_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .FLOAT)
  Vector4_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector4_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .FLOAT)
  Vector4_method_store.VARIANT_OP_EQUAL_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_EQUAL_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_NOT_EQUAL_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_NOT_EQUAL_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_LESS_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_LESS_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_LESS_EQUAL_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_LESS_EQUAL_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_GREATER_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_GREATER_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_GREATER_EQUAL_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_GREATER_EQUAL_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_ADD_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_ADD_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_SUBTRACT_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_SUBTRACT_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_MULTIPLY_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_MULTIPLY_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_DIVIDE_Vector4 = cast(type_of(Vector4_method_store.VARIANT_OP_DIVIDE_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_MULTIPLY_Projection = cast(type_of(Vector4_method_store.VARIANT_OP_MULTIPLY_Projection))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .PROJECTION)
  Vector4_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector4_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .DICTIONARY)
  Vector4_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector4_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .ARRAY)
  Vector4_method_store.VARIANT_OP_IN_PackedVector4Array = cast(type_of(Vector4_method_store.VARIANT_OP_IN_PackedVector4Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .PACKED_VECTOR4_ARRAY)
}
