package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Vector3_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  signed_angle_to:  GDE.PtrBuiltInMethod,
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
  inverse:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  bezier_interpolate:  GDE.PtrBuiltInMethod,
  bezier_derivative:  GDE.PtrBuiltInMethod,
  move_toward:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  cross:  GDE.PtrBuiltInMethod,
  outer:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  project:  GDE.PtrBuiltInMethod,
  slide:  GDE.PtrBuiltInMethod,
  bounce:  GDE.PtrBuiltInMethod,
  reflect:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  octahedron_encode:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
  octahedron_decode:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedVector3Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector3_ZERO :Vector3= {0, 0, 0}
@(rodata)
Vector3_ONE :Vector3= {1, 1, 1}
@(rodata)
Vector3_LEFT :Vector3= {-1, 0, 0}
@(rodata)
Vector3_RIGHT :Vector3= {1, 0, 0}
@(rodata)
Vector3_UP :Vector3= {0, 1, 0}
@(rodata)
Vector3_DOWN :Vector3= {0, -1, 0}
@(rodata)
Vector3_FORWARD :Vector3= {0, 0, -1}
@(rodata)
Vector3_BACK :Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_LEFT :Vector3= {1, 0, 0}
@(rodata)
Vector3_MODEL_RIGHT :Vector3= {-1, 0, 0}
@(rodata)
Vector3_MODEL_TOP :Vector3= {0, 1, 0}
@(rodata)
Vector3_MODEL_BOTTOM :Vector3= {0, -1, 0}
@(rodata)
Vector3_MODEL_FRONT :Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_REAR :Vector3= {0, 0, -1}
init_Vector3_Methods :: proc(Vector3_method_store: ^Vector3_Methods_list) {
  Vector3_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 0)
  Vector3_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 1)
  Vector3_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 2)
  Vector3_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 3)
  Vector3_method_store.min_axis_index = Get_Builtin_Method(.VECTOR3, "min_axis_index", 3173160232)
  Vector3_method_store.max_axis_index = Get_Builtin_Method(.VECTOR3, "max_axis_index", 3173160232)
  Vector3_method_store.angle_to = Get_Builtin_Method(.VECTOR3, "angle_to", 1047977935)
  Vector3_method_store.signed_angle_to = Get_Builtin_Method(.VECTOR3, "signed_angle_to", 2781412522)
  Vector3_method_store.direction_to = Get_Builtin_Method(.VECTOR3, "direction_to", 2923479887)
  Vector3_method_store.distance_to = Get_Builtin_Method(.VECTOR3, "distance_to", 1047977935)
  Vector3_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR3, "distance_squared_to", 1047977935)
  Vector3_method_store.length = Get_Builtin_Method(.VECTOR3, "length", 466405837)
  Vector3_method_store.length_squared = Get_Builtin_Method(.VECTOR3, "length_squared", 466405837)
  Vector3_method_store.limit_length = Get_Builtin_Method(.VECTOR3, "limit_length", 514930144)
  Vector3_method_store.normalized = Get_Builtin_Method(.VECTOR3, "normalized", 1776574132)
  Vector3_method_store.is_normalized = Get_Builtin_Method(.VECTOR3, "is_normalized", 3918633141)
  Vector3_method_store.is_equal_approx = Get_Builtin_Method(.VECTOR3, "is_equal_approx", 1749054343)
  Vector3_method_store.is_zero_approx = Get_Builtin_Method(.VECTOR3, "is_zero_approx", 3918633141)
  Vector3_method_store.is_finite = Get_Builtin_Method(.VECTOR3, "is_finite", 3918633141)
  Vector3_method_store.inverse = Get_Builtin_Method(.VECTOR3, "inverse", 1776574132)
  Vector3_method_store.clamp = Get_Builtin_Method(.VECTOR3, "clamp", 4145107892)
  Vector3_method_store.clampf = Get_Builtin_Method(.VECTOR3, "clampf", 2329594628)
  Vector3_method_store.snapped = Get_Builtin_Method(.VECTOR3, "snapped", 2923479887)
  Vector3_method_store.snappedf = Get_Builtin_Method(.VECTOR3, "snappedf", 514930144)
  Vector3_method_store.rotated = Get_Builtin_Method(.VECTOR3, "rotated", 1682608829)
  Vector3_method_store.lerp = Get_Builtin_Method(.VECTOR3, "lerp", 1682608829)
  Vector3_method_store.slerp = Get_Builtin_Method(.VECTOR3, "slerp", 1682608829)
  Vector3_method_store.cubic_interpolate = Get_Builtin_Method(.VECTOR3, "cubic_interpolate", 2597922253)
  Vector3_method_store.cubic_interpolate_in_time = Get_Builtin_Method(.VECTOR3, "cubic_interpolate_in_time", 3256682901)
  Vector3_method_store.bezier_interpolate = Get_Builtin_Method(.VECTOR3, "bezier_interpolate", 2597922253)
  Vector3_method_store.bezier_derivative = Get_Builtin_Method(.VECTOR3, "bezier_derivative", 2597922253)
  Vector3_method_store.move_toward = Get_Builtin_Method(.VECTOR3, "move_toward", 1682608829)
  Vector3_method_store.dot = Get_Builtin_Method(.VECTOR3, "dot", 1047977935)
  Vector3_method_store.cross = Get_Builtin_Method(.VECTOR3, "cross", 2923479887)
  Vector3_method_store.outer = Get_Builtin_Method(.VECTOR3, "outer", 3934786792)
  Vector3_method_store.abs = Get_Builtin_Method(.VECTOR3, "abs", 1776574132)
  Vector3_method_store.floor = Get_Builtin_Method(.VECTOR3, "floor", 1776574132)
  Vector3_method_store.ceil = Get_Builtin_Method(.VECTOR3, "ceil", 1776574132)
  Vector3_method_store.round = Get_Builtin_Method(.VECTOR3, "round", 1776574132)
  Vector3_method_store.posmod = Get_Builtin_Method(.VECTOR3, "posmod", 514930144)
  Vector3_method_store.posmodv = Get_Builtin_Method(.VECTOR3, "posmodv", 2923479887)
  Vector3_method_store.project = Get_Builtin_Method(.VECTOR3, "project", 2923479887)
  Vector3_method_store.slide = Get_Builtin_Method(.VECTOR3, "slide", 2923479887)
  Vector3_method_store.bounce = Get_Builtin_Method(.VECTOR3, "bounce", 2923479887)
  Vector3_method_store.reflect = Get_Builtin_Method(.VECTOR3, "reflect", 2923479887)
  Vector3_method_store.sign = Get_Builtin_Method(.VECTOR3, "sign", 1776574132)
  Vector3_method_store.octahedron_encode = Get_Builtin_Method(.VECTOR3, "octahedron_encode", 2428350749)
  Vector3_method_store.min = Get_Builtin_Method(.VECTOR3, "min", 2923479887)
  Vector3_method_store.minf = Get_Builtin_Method(.VECTOR3, "minf", 514930144)
  Vector3_method_store.max = Get_Builtin_Method(.VECTOR3, "max", 2923479887)
  Vector3_method_store.maxf = Get_Builtin_Method(.VECTOR3, "maxf", 514930144)
  Vector3_method_store.octahedron_decode = Get_Builtin_Method(.VECTOR3, "octahedron_decode", 3991820552)
  Vector3_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR3, .NIL)
  Vector3_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .INT)
  Vector3_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .INT)
  Vector3_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .FLOAT)
  Vector3_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .FLOAT)
  Vector3_method_store.VARIANT_OP_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_NOT_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_LESS_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_LESS_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_GREATER_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_GREATER_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_ADD_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_SUBTRACT_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_DIVIDE_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3, .VECTOR3)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .QUATERNION)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .BASIS)
  Vector3_method_store.VARIANT_OP_MULTIPLY_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3, .TRANSFORM3D)
  Vector3_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .DICTIONARY)
  Vector3_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .ARRAY)
  Vector3_method_store.VARIANT_OP_IN_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3, .PACKED_VECTOR3_ARRAY)
}
