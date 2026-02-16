package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Transform2D_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  affine_inverse:  GDE.PtrBuiltInMethod,
  get_rotation:  GDE.PtrBuiltInMethod,
  get_origin:  GDE.PtrBuiltInMethod,
  get_scale:  GDE.PtrBuiltInMethod,
  get_skew:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  rotated_local:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  translated:  GDE.PtrBuiltInMethod,
  translated_local:  GDE.PtrBuiltInMethod,
  determinant:  GDE.PtrBuiltInMethod,
  basis_xform:  GDE.PtrBuiltInMethod,
  basis_xform_inv:  GDE.PtrBuiltInMethod,
  interpolate_with:  GDE.PtrBuiltInMethod,
  is_conformal:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_PackedVector2Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Transform2D_IDENTITY :Transform2D= {1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_X :Transform2D= {-1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_Y :Transform2D= {1, 0, 0, -1, 0, 0}
init_Transform2D_Methods :: proc(Transform2D_method_store: ^Transform2D_Methods_list) {
  Transform2D_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 0)
  Transform2D_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 1)
  Transform2D_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 2)
  Transform2D_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 3)
  Transform2D_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 4)
  Transform2D_method_store.inverse = Get_Builtin_Method(.TRANSFORM2D, "inverse", 1420440541)
  Transform2D_method_store.affine_inverse = Get_Builtin_Method(.TRANSFORM2D, "affine_inverse", 1420440541)
  Transform2D_method_store.get_rotation = Get_Builtin_Method(.TRANSFORM2D, "get_rotation", 466405837)
  Transform2D_method_store.get_origin = Get_Builtin_Method(.TRANSFORM2D, "get_origin", 2428350749)
  Transform2D_method_store.get_scale = Get_Builtin_Method(.TRANSFORM2D, "get_scale", 2428350749)
  Transform2D_method_store.get_skew = Get_Builtin_Method(.TRANSFORM2D, "get_skew", 466405837)
  Transform2D_method_store.orthonormalized = Get_Builtin_Method(.TRANSFORM2D, "orthonormalized", 1420440541)
  Transform2D_method_store.rotated = Get_Builtin_Method(.TRANSFORM2D, "rotated", 729597514)
  Transform2D_method_store.rotated_local = Get_Builtin_Method(.TRANSFORM2D, "rotated_local", 729597514)
  Transform2D_method_store.scaled = Get_Builtin_Method(.TRANSFORM2D, "scaled", 1446323263)
  Transform2D_method_store.scaled_local = Get_Builtin_Method(.TRANSFORM2D, "scaled_local", 1446323263)
  Transform2D_method_store.translated = Get_Builtin_Method(.TRANSFORM2D, "translated", 1446323263)
  Transform2D_method_store.translated_local = Get_Builtin_Method(.TRANSFORM2D, "translated_local", 1446323263)
  Transform2D_method_store.determinant = Get_Builtin_Method(.TRANSFORM2D, "determinant", 466405837)
  Transform2D_method_store.basis_xform = Get_Builtin_Method(.TRANSFORM2D, "basis_xform", 2026743667)
  Transform2D_method_store.basis_xform_inv = Get_Builtin_Method(.TRANSFORM2D, "basis_xform_inv", 2026743667)
  Transform2D_method_store.interpolate_with = Get_Builtin_Method(.TRANSFORM2D, "interpolate_with", 359399686)
  Transform2D_method_store.is_conformal = Get_Builtin_Method(.TRANSFORM2D, "is_conformal", 3918633141)
  Transform2D_method_store.is_equal_approx = Get_Builtin_Method(.TRANSFORM2D, "is_equal_approx", 3837431929)
  Transform2D_method_store.is_finite = Get_Builtin_Method(.TRANSFORM2D, "is_finite", 3918633141)
  Transform2D_method_store.looking_at = Get_Builtin_Method(.TRANSFORM2D, "looking_at", 1446323263)
  Transform2D_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .TRANSFORM2D, .NIL)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .INT)
  Transform2D_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM2D, .INT)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .FLOAT)
  Transform2D_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM2D, .FLOAT)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .VECTOR2)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .RECT2)
  Transform2D_method_store.VARIANT_OP_EQUAL_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_NOT_EQUAL_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM2D, .DICTIONARY)
  Transform2D_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM2D, .ARRAY)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .PACKED_VECTOR2_ARRAY)
}
