package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Quaternion_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  Create5: GDE.PtrConstructor,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  inverse:  GDE.PtrBuiltInMethod,
  log:  GDE.PtrBuiltInMethod,
  exp:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  slerpni:  GDE.PtrBuiltInMethod,
  spherical_cubic_interpolate:  GDE.PtrBuiltInMethod,
  spherical_cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  get_euler:  GDE.PtrBuiltInMethod,
  from_euler:  GDE.PtrBuiltInMethod,
  get_axis:  GDE.PtrBuiltInMethod,
  get_angle:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Quaternion_Methods :: proc(Quaternion_method_store: ^Quaternion_Methods_list) {
  Quaternion_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 0)
  Quaternion_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 1)
  Quaternion_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 2)
  Quaternion_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 3)
  Quaternion_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 4)
  Quaternion_method_store.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 5)
  Quaternion_method_store.length = Get_Builtin_Method(.QUATERNION, "length", 466405837)
  Quaternion_method_store.length_squared = Get_Builtin_Method(.QUATERNION, "length_squared", 466405837)
  Quaternion_method_store.normalized = Get_Builtin_Method(.QUATERNION, "normalized", 4274879941)
  Quaternion_method_store.is_normalized = Get_Builtin_Method(.QUATERNION, "is_normalized", 3918633141)
  Quaternion_method_store.is_equal_approx = Get_Builtin_Method(.QUATERNION, "is_equal_approx", 1682156903)
  Quaternion_method_store.is_finite = Get_Builtin_Method(.QUATERNION, "is_finite", 3918633141)
  Quaternion_method_store.inverse = Get_Builtin_Method(.QUATERNION, "inverse", 4274879941)
  Quaternion_method_store.log = Get_Builtin_Method(.QUATERNION, "log", 4274879941)
  Quaternion_method_store.exp = Get_Builtin_Method(.QUATERNION, "exp", 4274879941)
  Quaternion_method_store.angle_to = Get_Builtin_Method(.QUATERNION, "angle_to", 3244682419)
  Quaternion_method_store.dot = Get_Builtin_Method(.QUATERNION, "dot", 3244682419)
  Quaternion_method_store.slerp = Get_Builtin_Method(.QUATERNION, "slerp", 1773590316)
  Quaternion_method_store.slerpni = Get_Builtin_Method(.QUATERNION, "slerpni", 1773590316)
  Quaternion_method_store.spherical_cubic_interpolate = Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate", 2150967576)
  Quaternion_method_store.spherical_cubic_interpolate_in_time = Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate_in_time", 1436023539)
  Quaternion_method_store.get_euler = Get_Builtin_Method(.QUATERNION, "get_euler", 1394941017)
  Quaternion_method_store.from_euler = Get_Builtin_Method(.QUATERNION, "from_euler", 4053467903)
  Quaternion_method_store.get_axis = Get_Builtin_Method(.QUATERNION, "get_axis", 1776574132)
  Quaternion_method_store.get_angle = Get_Builtin_Method(.QUATERNION, "get_angle", 466405837)
  Quaternion_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .QUATERNION, .NIL)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .INT)
  Quaternion_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .QUATERNION, .INT)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .FLOAT)
  Quaternion_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .QUATERNION, .FLOAT)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .VECTOR3)
  Quaternion_method_store.VARIANT_OP_EQUAL_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_NOT_EQUAL_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_ADD_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_SUBTRACT_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_MULTIPLY_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .QUATERNION, .QUATERNION)
  Quaternion_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .QUATERNION, .DICTIONARY)
  Quaternion_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .QUATERNION, .ARRAY)
}
