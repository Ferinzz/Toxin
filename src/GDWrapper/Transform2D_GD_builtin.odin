package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Transform2D_IDENTITY : Transform2D= {1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_X : Transform2D= {-1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_Y : Transform2D= {1, 0, 0, -1, 0, 0}
Transform2D_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Transform2D, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Transform2D,  #by_ptr p_args: struct{ from: ^Transform2D, }),
    Create2: proc "c" (p_base: ^Transform2D,  #by_ptr p_args: struct{ rotation: ^float, position: ^Vector2, }),
    Create3: proc "c" (p_base: ^Transform2D,  #by_ptr p_args: struct{ rotation: ^float, scale: ^Vector2, skew: ^float, position: ^Vector2, }),
    Create4: proc "c" (p_base: ^Transform2D,  #by_ptr p_args: struct{ x_axis: ^Vector2, y_axis: ^Vector2, origin: ^Vector2, }),
    inverse:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Transform2D, p_argument_count: i64 = 0),
    affine_inverse:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Transform2D, p_argument_count: i64 = 0),
    get_rotation:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_origin:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    get_scale:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    get_skew:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    orthonormalized:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Transform2D, p_argument_count: i64 = 0),
    rotated:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ angle: ^float, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    rotated_local:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ angle: ^float, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    scaled:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ scale: ^Vector2, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    scaled_local:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ scale: ^Vector2, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    translated:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ offset: ^Vector2, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    translated_local:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ offset: ^Vector2, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    determinant:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    basis_xform:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ v: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    basis_xform_inv:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ v: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    interpolate_with:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ xform: ^Transform2D, weight: ^float, }, r_return: ^Transform2D, p_argument_count: i64 = 2),
    is_conformal:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ xform: ^Transform2D, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Transform2D, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    looking_at:  proc "c" (p_base: ^Transform2D, #by_ptr p_args: struct{ target: ^Vector2, }, r_return: ^Transform2D, p_argument_count: i64 = 1),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Transform2D, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Transform2D, p_right: ^Int, r_result: ^Transform2D),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Transform2D, p_right: ^Int, r_result: ^Transform2D),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Transform2D, p_right: ^float, r_result: ^Transform2D),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Transform2D, p_right: ^float, r_result: ^Transform2D),
    VARIANT_OP_MULTIPLY_Vector2: proc "c" (p_left: ^Transform2D, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Rect2: proc "c" (p_left: ^Transform2D, p_right: ^Rect2, r_result: ^Rect2),
    VARIANT_OP_EQUAL_Transform2D: proc "c" (p_left: ^Transform2D, p_right: ^Transform2D, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Transform2D: proc "c" (p_left: ^Transform2D, p_right: ^Transform2D, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform2D: proc "c" (p_left: ^Transform2D, p_right: ^Transform2D, r_result: ^Transform2D),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Transform2D, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Transform2D, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_PackedVector2Array: proc "c" (p_left: ^Transform2D, p_right: ^PackedVector2Array, r_result: ^PackedVector2Array),
}
init_Transform2D_Methods :: proc(Transform2D_method_store: ^Transform2D_Methods_list) {
  Transform2D_method_store.Create0 = cast(type_of(Transform2D_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 0)
  Transform2D_method_store.Create1 = cast(type_of(Transform2D_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 1)
  Transform2D_method_store.Create2 = cast(type_of(Transform2D_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 2)
  Transform2D_method_store.Create3 = cast(type_of(Transform2D_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 3)
  Transform2D_method_store.Create4 = cast(type_of(Transform2D_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 4)
  Transform2D_method_store.inverse = cast(type_of(Transform2D_method_store.inverse))Get_Builtin_Method(.TRANSFORM2D, "inverse", 1420440541)
  Transform2D_method_store.affine_inverse = cast(type_of(Transform2D_method_store.affine_inverse))Get_Builtin_Method(.TRANSFORM2D, "affine_inverse", 1420440541)
  Transform2D_method_store.get_rotation = cast(type_of(Transform2D_method_store.get_rotation))Get_Builtin_Method(.TRANSFORM2D, "get_rotation", 466405837)
  Transform2D_method_store.get_origin = cast(type_of(Transform2D_method_store.get_origin))Get_Builtin_Method(.TRANSFORM2D, "get_origin", 2428350749)
  Transform2D_method_store.get_scale = cast(type_of(Transform2D_method_store.get_scale))Get_Builtin_Method(.TRANSFORM2D, "get_scale", 2428350749)
  Transform2D_method_store.get_skew = cast(type_of(Transform2D_method_store.get_skew))Get_Builtin_Method(.TRANSFORM2D, "get_skew", 466405837)
  Transform2D_method_store.orthonormalized = cast(type_of(Transform2D_method_store.orthonormalized))Get_Builtin_Method(.TRANSFORM2D, "orthonormalized", 1420440541)
  Transform2D_method_store.rotated = cast(type_of(Transform2D_method_store.rotated))Get_Builtin_Method(.TRANSFORM2D, "rotated", 729597514)
  Transform2D_method_store.rotated_local = cast(type_of(Transform2D_method_store.rotated_local))Get_Builtin_Method(.TRANSFORM2D, "rotated_local", 729597514)
  Transform2D_method_store.scaled = cast(type_of(Transform2D_method_store.scaled))Get_Builtin_Method(.TRANSFORM2D, "scaled", 1446323263)
  Transform2D_method_store.scaled_local = cast(type_of(Transform2D_method_store.scaled_local))Get_Builtin_Method(.TRANSFORM2D, "scaled_local", 1446323263)
  Transform2D_method_store.translated = cast(type_of(Transform2D_method_store.translated))Get_Builtin_Method(.TRANSFORM2D, "translated", 1446323263)
  Transform2D_method_store.translated_local = cast(type_of(Transform2D_method_store.translated_local))Get_Builtin_Method(.TRANSFORM2D, "translated_local", 1446323263)
  Transform2D_method_store.determinant = cast(type_of(Transform2D_method_store.determinant))Get_Builtin_Method(.TRANSFORM2D, "determinant", 466405837)
  Transform2D_method_store.basis_xform = cast(type_of(Transform2D_method_store.basis_xform))Get_Builtin_Method(.TRANSFORM2D, "basis_xform", 2026743667)
  Transform2D_method_store.basis_xform_inv = cast(type_of(Transform2D_method_store.basis_xform_inv))Get_Builtin_Method(.TRANSFORM2D, "basis_xform_inv", 2026743667)
  Transform2D_method_store.interpolate_with = cast(type_of(Transform2D_method_store.interpolate_with))Get_Builtin_Method(.TRANSFORM2D, "interpolate_with", 359399686)
  Transform2D_method_store.is_conformal = cast(type_of(Transform2D_method_store.is_conformal))Get_Builtin_Method(.TRANSFORM2D, "is_conformal", 3918633141)
  Transform2D_method_store.is_equal_approx = cast(type_of(Transform2D_method_store.is_equal_approx))Get_Builtin_Method(.TRANSFORM2D, "is_equal_approx", 3837431929)
  Transform2D_method_store.is_finite = cast(type_of(Transform2D_method_store.is_finite))Get_Builtin_Method(.TRANSFORM2D, "is_finite", 3918633141)
  Transform2D_method_store.looking_at = cast(type_of(Transform2D_method_store.looking_at))Get_Builtin_Method(.TRANSFORM2D, "looking_at", 1446323263)
  Transform2D_method_store.VARIANT_OP_NOT_ = cast(type_of(Transform2D_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .TRANSFORM2D, .NIL)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .NIL)
  Transform2D_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Transform2D_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM2D, .NIL)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .FLOAT)
  Transform2D_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Transform2D_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM2D, .FLOAT)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Vector2 = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .VECTOR2)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Rect2 = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_Rect2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .RECT2)
  Transform2D_method_store.VARIANT_OP_EQUAL_Transform2D = cast(type_of(Transform2D_method_store.VARIANT_OP_EQUAL_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_NOT_EQUAL_Transform2D = cast(type_of(Transform2D_method_store.VARIANT_OP_NOT_EQUAL_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_Transform2D = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .TRANSFORM2D)
  Transform2D_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Transform2D_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM2D, .DICTIONARY)
  Transform2D_method_store.VARIANT_OP_IN_Array = cast(type_of(Transform2D_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM2D, .ARRAY)
  Transform2D_method_store.VARIANT_OP_MULTIPLY_PackedVector2Array = cast(type_of(Transform2D_method_store.VARIANT_OP_MULTIPLY_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM2D, .PACKED_VECTOR2_ARRAY)
}
