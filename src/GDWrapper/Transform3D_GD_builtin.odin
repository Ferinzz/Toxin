package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Transform3D_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  affine_inverse:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  rotated_local:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  translated:  GDE.PtrBuiltInMethod,
  translated_local:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
  interpolate_with:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Plane: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_PackedVector3Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Transform3D_IDENTITY :Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_X :Transform3D= {-1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Y :Transform3D= {1, 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Z :Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0}
init_Transform3D_Methods :: proc(Transform3D_method_store: ^Transform3D_Methods_list) {
  Transform3D_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 0)
  Transform3D_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 1)
  Transform3D_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 2)
  Transform3D_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 3)
  Transform3D_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 4)
  Transform3D_method_store.inverse = Get_Builtin_Method(.TRANSFORM3D, "inverse", 3816817146)
  Transform3D_method_store.affine_inverse = Get_Builtin_Method(.TRANSFORM3D, "affine_inverse", 3816817146)
  Transform3D_method_store.orthonormalized = Get_Builtin_Method(.TRANSFORM3D, "orthonormalized", 3816817146)
  Transform3D_method_store.rotated = Get_Builtin_Method(.TRANSFORM3D, "rotated", 1563203923)
  Transform3D_method_store.rotated_local = Get_Builtin_Method(.TRANSFORM3D, "rotated_local", 1563203923)
  Transform3D_method_store.scaled = Get_Builtin_Method(.TRANSFORM3D, "scaled", 1405596198)
  Transform3D_method_store.scaled_local = Get_Builtin_Method(.TRANSFORM3D, "scaled_local", 1405596198)
  Transform3D_method_store.translated = Get_Builtin_Method(.TRANSFORM3D, "translated", 1405596198)
  Transform3D_method_store.translated_local = Get_Builtin_Method(.TRANSFORM3D, "translated_local", 1405596198)
  Transform3D_method_store.looking_at = Get_Builtin_Method(.TRANSFORM3D, "looking_at", 90889270)
  Transform3D_method_store.interpolate_with = Get_Builtin_Method(.TRANSFORM3D, "interpolate_with", 1786453358)
  Transform3D_method_store.is_equal_approx = Get_Builtin_Method(.TRANSFORM3D, "is_equal_approx", 696001652)
  Transform3D_method_store.is_finite = Get_Builtin_Method(.TRANSFORM3D, "is_finite", 3918633141)
  Transform3D_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .TRANSFORM3D, .NIL)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .INT)
  Transform3D_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM3D, .INT)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .FLOAT)
  Transform3D_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM3D, .FLOAT)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .VECTOR3)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Plane = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .PLANE)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .AABB)
  Transform3D_method_store.VARIANT_OP_EQUAL_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_NOT_EQUAL_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM3D, .DICTIONARY)
  Transform3D_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM3D, .ARRAY)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .PACKED_VECTOR3_ARRAY)
}
