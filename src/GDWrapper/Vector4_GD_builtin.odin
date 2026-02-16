package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Vector4_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  direction_to:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  inverse:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_zero_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Projection: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedVector4Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector4_ZERO :Vector4= {0, 0, 0, 0}
@(rodata)
Vector4_ONE :Vector4= {1, 1, 1, 1}
init_Vector4_Methods :: proc(Vector4_method_store: ^Vector4_Methods_list) {
  Vector4_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 0)
  Vector4_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 1)
  Vector4_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 2)
  Vector4_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 3)
  Vector4_method_store.min_axis_index = Get_Builtin_Method(.VECTOR4, "min_axis_index", 3173160232)
  Vector4_method_store.max_axis_index = Get_Builtin_Method(.VECTOR4, "max_axis_index", 3173160232)
  Vector4_method_store.length = Get_Builtin_Method(.VECTOR4, "length", 466405837)
  Vector4_method_store.length_squared = Get_Builtin_Method(.VECTOR4, "length_squared", 466405837)
  Vector4_method_store.abs = Get_Builtin_Method(.VECTOR4, "abs", 80860099)
  Vector4_method_store.sign = Get_Builtin_Method(.VECTOR4, "sign", 80860099)
  Vector4_method_store.floor = Get_Builtin_Method(.VECTOR4, "floor", 80860099)
  Vector4_method_store.ceil = Get_Builtin_Method(.VECTOR4, "ceil", 80860099)
  Vector4_method_store.round = Get_Builtin_Method(.VECTOR4, "round", 80860099)
  Vector4_method_store.lerp = Get_Builtin_Method(.VECTOR4, "lerp", 2329757942)
  Vector4_method_store.cubic_interpolate = Get_Builtin_Method(.VECTOR4, "cubic_interpolate", 726768410)
  Vector4_method_store.cubic_interpolate_in_time = Get_Builtin_Method(.VECTOR4, "cubic_interpolate_in_time", 681631873)
  Vector4_method_store.posmod = Get_Builtin_Method(.VECTOR4, "posmod", 3129671720)
  Vector4_method_store.posmodv = Get_Builtin_Method(.VECTOR4, "posmodv", 2031281584)
  Vector4_method_store.snapped = Get_Builtin_Method(.VECTOR4, "snapped", 2031281584)
  Vector4_method_store.snappedf = Get_Builtin_Method(.VECTOR4, "snappedf", 3129671720)
  Vector4_method_store.clamp = Get_Builtin_Method(.VECTOR4, "clamp", 823915692)
  Vector4_method_store.clampf = Get_Builtin_Method(.VECTOR4, "clampf", 4072091586)
  Vector4_method_store.normalized = Get_Builtin_Method(.VECTOR4, "normalized", 80860099)
  Vector4_method_store.is_normalized = Get_Builtin_Method(.VECTOR4, "is_normalized", 3918633141)
  Vector4_method_store.direction_to = Get_Builtin_Method(.VECTOR4, "direction_to", 2031281584)
  Vector4_method_store.distance_to = Get_Builtin_Method(.VECTOR4, "distance_to", 3770801042)
  Vector4_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR4, "distance_squared_to", 3770801042)
  Vector4_method_store.dot = Get_Builtin_Method(.VECTOR4, "dot", 3770801042)
  Vector4_method_store.inverse = Get_Builtin_Method(.VECTOR4, "inverse", 80860099)
  Vector4_method_store.is_equal_approx = Get_Builtin_Method(.VECTOR4, "is_equal_approx", 88913544)
  Vector4_method_store.is_zero_approx = Get_Builtin_Method(.VECTOR4, "is_zero_approx", 3918633141)
  Vector4_method_store.is_finite = Get_Builtin_Method(.VECTOR4, "is_finite", 3918633141)
  Vector4_method_store.min = Get_Builtin_Method(.VECTOR4, "min", 2031281584)
  Vector4_method_store.minf = Get_Builtin_Method(.VECTOR4, "minf", 3129671720)
  Vector4_method_store.max = Get_Builtin_Method(.VECTOR4, "max", 2031281584)
  Vector4_method_store.maxf = Get_Builtin_Method(.VECTOR4, "maxf", 3129671720)
  Vector4_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR4, .NIL)
  Vector4_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .INT)
  Vector4_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .INT)
  Vector4_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .FLOAT)
  Vector4_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .FLOAT)
  Vector4_method_store.VARIANT_OP_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_NOT_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_LESS_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_LESS_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_GREATER_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_GREATER_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_ADD_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_SUBTRACT_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_MULTIPLY_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_DIVIDE_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4, .VECTOR4)
  Vector4_method_store.VARIANT_OP_MULTIPLY_Projection = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4, .PROJECTION)
  Vector4_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .DICTIONARY)
  Vector4_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .ARRAY)
  Vector4_method_store.VARIANT_OP_IN_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4, .PACKED_VECTOR4_ARRAY)
}
