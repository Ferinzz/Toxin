package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Vector2_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  angle:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  angle_to_point:  GDE.PtrBuiltInMethod,
  direction_to:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  limit_length:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_zero_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  project:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  bezier_interpolate:  GDE.PtrBuiltInMethod,
  bezier_derivative:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  min_axis_index:  GDE.PtrBuiltInMethod,
  move_toward:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  orthogonal:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  aspect:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  slide:  GDE.PtrBuiltInMethod,
  bounce:  GDE.PtrBuiltInMethod,
  reflect:  GDE.PtrBuiltInMethod,
  cross:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
  from_angle:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedVector2Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector2_ZERO :Vector2= {0, 0}
@(rodata)
Vector2_ONE :Vector2= {1, 1}
@(rodata)
Vector2_LEFT :Vector2= {-1, 0}
@(rodata)
Vector2_RIGHT :Vector2= {1, 0}
@(rodata)
Vector2_UP :Vector2= {0, -1}
@(rodata)
Vector2_DOWN :Vector2= {0, 1}
init_Vector2_Methods :: proc(Vector2_method_store: ^Vector2_Methods_list) {
  Vector2_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 0)
  Vector2_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 1)
  Vector2_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 2)
  Vector2_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 3)
  Vector2_method_store.angle = Get_Builtin_Method(.VECTOR2, "angle", 466405837)
  Vector2_method_store.angle_to = Get_Builtin_Method(.VECTOR2, "angle_to", 3819070308)
  Vector2_method_store.angle_to_point = Get_Builtin_Method(.VECTOR2, "angle_to_point", 3819070308)
  Vector2_method_store.direction_to = Get_Builtin_Method(.VECTOR2, "direction_to", 2026743667)
  Vector2_method_store.distance_to = Get_Builtin_Method(.VECTOR2, "distance_to", 3819070308)
  Vector2_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR2, "distance_squared_to", 3819070308)
  Vector2_method_store.length = Get_Builtin_Method(.VECTOR2, "length", 466405837)
  Vector2_method_store.length_squared = Get_Builtin_Method(.VECTOR2, "length_squared", 466405837)
  Vector2_method_store.limit_length = Get_Builtin_Method(.VECTOR2, "limit_length", 2544004089)
  Vector2_method_store.normalized = Get_Builtin_Method(.VECTOR2, "normalized", 2428350749)
  Vector2_method_store.is_normalized = Get_Builtin_Method(.VECTOR2, "is_normalized", 3918633141)
  Vector2_method_store.is_equal_approx = Get_Builtin_Method(.VECTOR2, "is_equal_approx", 3190634762)
  Vector2_method_store.is_zero_approx = Get_Builtin_Method(.VECTOR2, "is_zero_approx", 3918633141)
  Vector2_method_store.is_finite = Get_Builtin_Method(.VECTOR2, "is_finite", 3918633141)
  Vector2_method_store.posmod = Get_Builtin_Method(.VECTOR2, "posmod", 2544004089)
  Vector2_method_store.posmodv = Get_Builtin_Method(.VECTOR2, "posmodv", 2026743667)
  Vector2_method_store.project = Get_Builtin_Method(.VECTOR2, "project", 2026743667)
  Vector2_method_store.lerp = Get_Builtin_Method(.VECTOR2, "lerp", 4250033116)
  Vector2_method_store.slerp = Get_Builtin_Method(.VECTOR2, "slerp", 4250033116)
  Vector2_method_store.cubic_interpolate = Get_Builtin_Method(.VECTOR2, "cubic_interpolate", 193522989)
  Vector2_method_store.cubic_interpolate_in_time = Get_Builtin_Method(.VECTOR2, "cubic_interpolate_in_time", 1957055074)
  Vector2_method_store.bezier_interpolate = Get_Builtin_Method(.VECTOR2, "bezier_interpolate", 193522989)
  Vector2_method_store.bezier_derivative = Get_Builtin_Method(.VECTOR2, "bezier_derivative", 193522989)
  Vector2_method_store.max_axis_index = Get_Builtin_Method(.VECTOR2, "max_axis_index", 3173160232)
  Vector2_method_store.min_axis_index = Get_Builtin_Method(.VECTOR2, "min_axis_index", 3173160232)
  Vector2_method_store.move_toward = Get_Builtin_Method(.VECTOR2, "move_toward", 4250033116)
  Vector2_method_store.rotated = Get_Builtin_Method(.VECTOR2, "rotated", 2544004089)
  Vector2_method_store.orthogonal = Get_Builtin_Method(.VECTOR2, "orthogonal", 2428350749)
  Vector2_method_store.floor = Get_Builtin_Method(.VECTOR2, "floor", 2428350749)
  Vector2_method_store.ceil = Get_Builtin_Method(.VECTOR2, "ceil", 2428350749)
  Vector2_method_store.round = Get_Builtin_Method(.VECTOR2, "round", 2428350749)
  Vector2_method_store.aspect = Get_Builtin_Method(.VECTOR2, "aspect", 466405837)
  Vector2_method_store.dot = Get_Builtin_Method(.VECTOR2, "dot", 3819070308)
  Vector2_method_store.slide = Get_Builtin_Method(.VECTOR2, "slide", 2026743667)
  Vector2_method_store.bounce = Get_Builtin_Method(.VECTOR2, "bounce", 2026743667)
  Vector2_method_store.reflect = Get_Builtin_Method(.VECTOR2, "reflect", 2026743667)
  Vector2_method_store.cross = Get_Builtin_Method(.VECTOR2, "cross", 3819070308)
  Vector2_method_store.abs = Get_Builtin_Method(.VECTOR2, "abs", 2428350749)
  Vector2_method_store.sign = Get_Builtin_Method(.VECTOR2, "sign", 2428350749)
  Vector2_method_store.clamp = Get_Builtin_Method(.VECTOR2, "clamp", 318031021)
  Vector2_method_store.clampf = Get_Builtin_Method(.VECTOR2, "clampf", 3464402636)
  Vector2_method_store.snapped = Get_Builtin_Method(.VECTOR2, "snapped", 2026743667)
  Vector2_method_store.snappedf = Get_Builtin_Method(.VECTOR2, "snappedf", 2544004089)
  Vector2_method_store.min = Get_Builtin_Method(.VECTOR2, "min", 2026743667)
  Vector2_method_store.minf = Get_Builtin_Method(.VECTOR2, "minf", 2544004089)
  Vector2_method_store.max = Get_Builtin_Method(.VECTOR2, "max", 2026743667)
  Vector2_method_store.maxf = Get_Builtin_Method(.VECTOR2, "maxf", 2544004089)
  Vector2_method_store.from_angle = Get_Builtin_Method(.VECTOR2, "from_angle", 889263119)
  Vector2_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR2, .NIL)
  Vector2_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .INT)
  Vector2_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .INT)
  Vector2_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .FLOAT)
  Vector2_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .FLOAT)
  Vector2_method_store.VARIANT_OP_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_NOT_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_LESS_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_LESS_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_GREATER_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_GREATER_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_ADD_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_SUBTRACT_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_MULTIPLY_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_DIVIDE_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2, .VECTOR2)
  Vector2_method_store.VARIANT_OP_MULTIPLY_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2, .TRANSFORM2D)
  Vector2_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .DICTIONARY)
  Vector2_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .ARRAY)
  Vector2_method_store.VARIANT_OP_IN_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2, .PACKED_VECTOR2_ARRAY)
}
