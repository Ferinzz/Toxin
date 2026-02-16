package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Basis_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  transposed:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  determinant:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  get_scale:  GDE.PtrBuiltInMethod,
  get_euler:  GDE.PtrBuiltInMethod,
  tdotx:  GDE.PtrBuiltInMethod,
  tdoty:  GDE.PtrBuiltInMethod,
  tdotz:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  is_conformal:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  get_rotation_quaternion:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
  from_scale:  GDE.PtrBuiltInMethod,
  from_euler:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Basis_IDENTITY :Basis= {1, 0, 0, 0, 1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_X :Basis= {-1, 0, 0, 0, 1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_Y :Basis= {1, 0, 0, 0, -1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_Z :Basis= {1, 0, 0, 0, 1, 0, 0, 0, -1}
init_Basis_Methods :: proc(Basis_method_store: ^Basis_Methods_list) {
  Basis_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 0)
  Basis_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 1)
  Basis_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 2)
  Basis_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 3)
  Basis_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 4)
  Basis_method_store.inverse = Get_Builtin_Method(.BASIS, "inverse", 594669093)
  Basis_method_store.transposed = Get_Builtin_Method(.BASIS, "transposed", 594669093)
  Basis_method_store.orthonormalized = Get_Builtin_Method(.BASIS, "orthonormalized", 594669093)
  Basis_method_store.determinant = Get_Builtin_Method(.BASIS, "determinant", 466405837)
  Basis_method_store.rotated = Get_Builtin_Method(.BASIS, "rotated", 1998708965)
  Basis_method_store.scaled = Get_Builtin_Method(.BASIS, "scaled", 3934786792)
  Basis_method_store.scaled_local = Get_Builtin_Method(.BASIS, "scaled_local", 3934786792)
  Basis_method_store.get_scale = Get_Builtin_Method(.BASIS, "get_scale", 1776574132)
  Basis_method_store.get_euler = Get_Builtin_Method(.BASIS, "get_euler", 1394941017)
  Basis_method_store.tdotx = Get_Builtin_Method(.BASIS, "tdotx", 1047977935)
  Basis_method_store.tdoty = Get_Builtin_Method(.BASIS, "tdoty", 1047977935)
  Basis_method_store.tdotz = Get_Builtin_Method(.BASIS, "tdotz", 1047977935)
  Basis_method_store.slerp = Get_Builtin_Method(.BASIS, "slerp", 3118673011)
  Basis_method_store.is_conformal = Get_Builtin_Method(.BASIS, "is_conformal", 3918633141)
  Basis_method_store.is_equal_approx = Get_Builtin_Method(.BASIS, "is_equal_approx", 3165333982)
  Basis_method_store.is_finite = Get_Builtin_Method(.BASIS, "is_finite", 3918633141)
  Basis_method_store.get_rotation_quaternion = Get_Builtin_Method(.BASIS, "get_rotation_quaternion", 4274879941)
  Basis_method_store.looking_at = Get_Builtin_Method(.BASIS, "looking_at", 3728732505)
  Basis_method_store.from_scale = Get_Builtin_Method(.BASIS, "from_scale", 3703240166)
  Basis_method_store.from_euler = Get_Builtin_Method(.BASIS, "from_euler", 2802321791)
  Basis_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .BASIS, .NIL)
  Basis_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .INT)
  Basis_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .BASIS, .INT)
  Basis_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .FLOAT)
  Basis_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .BASIS, .FLOAT)
  Basis_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .VECTOR3)
  Basis_method_store.VARIANT_OP_EQUAL_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_NOT_EQUAL_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_MULTIPLY_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BASIS, .DICTIONARY)
  Basis_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BASIS, .ARRAY)
}
