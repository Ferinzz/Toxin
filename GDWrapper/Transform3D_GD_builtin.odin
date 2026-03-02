package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Transform3D_IDENTITY : Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_X : Transform3D= {-1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Y : Transform3D= {1, 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Z : Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0}
Transform3D_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Transform3D, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Transform3D,  #by_ptr p_args: struct{ from: ^Transform3D, }),
    Create2: proc "c" (p_base: ^Transform3D,  #by_ptr p_args: struct{ basis: ^Basis, origin: ^Vector3, }),
    Create3: proc "c" (p_base: ^Transform3D,  #by_ptr p_args: struct{ x_axis: ^Vector3, y_axis: ^Vector3, z_axis: ^Vector3, origin: ^Vector3, }),
    Create4: proc "c" (p_base: ^Transform3D,  #by_ptr p_args: struct{ from: ^Projection, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Transform3D,
    inverse:  proc "c" (p_base: ^Transform3D, p_args: rawptr = nil, r_return: ^Transform3D, p_argument_count: i64 = 0),
    affine_inverse:  proc "c" (p_base: ^Transform3D, p_args: rawptr = nil, r_return: ^Transform3D, p_argument_count: i64 = 0),
    orthonormalized:  proc "c" (p_base: ^Transform3D, p_args: rawptr = nil, r_return: ^Transform3D, p_argument_count: i64 = 0),
    rotated:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }, r_return: ^Transform3D, p_argument_count: i64 = 2),
    rotated_local:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }, r_return: ^Transform3D, p_argument_count: i64 = 2),
    scaled:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ scale: ^Vector3, }, r_return: ^Transform3D, p_argument_count: i64 = 1),
    scaled_local:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ scale: ^Vector3, }, r_return: ^Transform3D, p_argument_count: i64 = 1),
    translated:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ offset: ^Vector3, }, r_return: ^Transform3D, p_argument_count: i64 = 1),
    translated_local:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ offset: ^Vector3, }, r_return: ^Transform3D, p_argument_count: i64 = 1),
    looking_at:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ target: ^Vector3, up: ^Vector3, use_model_front: ^Bool, }, r_return: ^Transform3D, p_argument_count: i64 = 3),
    interpolate_with:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ xform: ^Transform3D, weight: ^float, }, r_return: ^Transform3D, p_argument_count: i64 = 2),
    is_equal_approx:  proc "c" (p_base: ^Transform3D, #by_ptr p_args: struct{ xform: ^Transform3D, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Transform3D, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Transform3D, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Transform3D, p_right: ^Int, r_result: ^Transform3D),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Transform3D, p_right: ^Int, r_result: ^Transform3D),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Transform3D, p_right: ^float, r_result: ^Transform3D),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Transform3D, p_right: ^float, r_result: ^Transform3D),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^Transform3D, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Plane: proc "c" (p_left: ^Transform3D, p_right: ^Plane, r_result: ^Plane),
    VARIANT_OP_MULTIPLY_AABB: proc "c" (p_left: ^Transform3D, p_right: ^AABB, r_result: ^AABB),
    VARIANT_OP_EQUAL_Transform3D: proc "c" (p_left: ^Transform3D, p_right: ^Transform3D, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Transform3D: proc "c" (p_left: ^Transform3D, p_right: ^Transform3D, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform3D: proc "c" (p_left: ^Transform3D, p_right: ^Transform3D, r_result: ^Transform3D),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Transform3D, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Transform3D, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_PackedVector3Array: proc "c" (p_left: ^Transform3D, p_right: ^PackedVector3Array, r_result: ^PackedVector3Array),
}
init_Transform3D_Methods :: proc(Transform3D_method_store: ^Transform3D_Methods_list) {
  Transform3D_method_store.Create0 = cast(type_of(Transform3D_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 0)
  Transform3D_method_store.Create1 = cast(type_of(Transform3D_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 1)
  Transform3D_method_store.Create2 = cast(type_of(Transform3D_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 2)
  Transform3D_method_store.Create3 = cast(type_of(Transform3D_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 3)
  Transform3D_method_store.Create4 = cast(type_of(Transform3D_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 4)
    Transform3D_method_store.get_ptr = cast(type_of(Transform3D_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.TRANSFORM3D)
  Transform3D_method_store.inverse = cast(type_of(Transform3D_method_store.inverse))Get_Builtin_Method(.TRANSFORM3D, "inverse", 3816817146)
  Transform3D_method_store.affine_inverse = cast(type_of(Transform3D_method_store.affine_inverse))Get_Builtin_Method(.TRANSFORM3D, "affine_inverse", 3816817146)
  Transform3D_method_store.orthonormalized = cast(type_of(Transform3D_method_store.orthonormalized))Get_Builtin_Method(.TRANSFORM3D, "orthonormalized", 3816817146)
  Transform3D_method_store.rotated = cast(type_of(Transform3D_method_store.rotated))Get_Builtin_Method(.TRANSFORM3D, "rotated", 1563203923)
  Transform3D_method_store.rotated_local = cast(type_of(Transform3D_method_store.rotated_local))Get_Builtin_Method(.TRANSFORM3D, "rotated_local", 1563203923)
  Transform3D_method_store.scaled = cast(type_of(Transform3D_method_store.scaled))Get_Builtin_Method(.TRANSFORM3D, "scaled", 1405596198)
  Transform3D_method_store.scaled_local = cast(type_of(Transform3D_method_store.scaled_local))Get_Builtin_Method(.TRANSFORM3D, "scaled_local", 1405596198)
  Transform3D_method_store.translated = cast(type_of(Transform3D_method_store.translated))Get_Builtin_Method(.TRANSFORM3D, "translated", 1405596198)
  Transform3D_method_store.translated_local = cast(type_of(Transform3D_method_store.translated_local))Get_Builtin_Method(.TRANSFORM3D, "translated_local", 1405596198)
  Transform3D_method_store.looking_at = cast(type_of(Transform3D_method_store.looking_at))Get_Builtin_Method(.TRANSFORM3D, "looking_at", 90889270)
  Transform3D_method_store.interpolate_with = cast(type_of(Transform3D_method_store.interpolate_with))Get_Builtin_Method(.TRANSFORM3D, "interpolate_with", 1786453358)
  Transform3D_method_store.is_equal_approx = cast(type_of(Transform3D_method_store.is_equal_approx))Get_Builtin_Method(.TRANSFORM3D, "is_equal_approx", 696001652)
  Transform3D_method_store.is_finite = cast(type_of(Transform3D_method_store.is_finite))Get_Builtin_Method(.TRANSFORM3D, "is_finite", 3918633141)
  Transform3D_method_store.VARIANT_OP_NOT_ = cast(type_of(Transform3D_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .TRANSFORM3D, .NIL)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .INT)
  Transform3D_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Transform3D_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM3D, .INT)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .FLOAT)
  Transform3D_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Transform3D_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .TRANSFORM3D, .FLOAT)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .VECTOR3)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Plane = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_Plane))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .PLANE)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_AABB = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_AABB))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .AABB)
  Transform3D_method_store.VARIANT_OP_EQUAL_Transform3D = cast(type_of(Transform3D_method_store.VARIANT_OP_EQUAL_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_NOT_EQUAL_Transform3D = cast(type_of(Transform3D_method_store.VARIANT_OP_NOT_EQUAL_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_Transform3D = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .TRANSFORM3D)
  Transform3D_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Transform3D_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM3D, .DICTIONARY)
  Transform3D_method_store.VARIANT_OP_IN_Array = cast(type_of(Transform3D_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .TRANSFORM3D, .ARRAY)
  Transform3D_method_store.VARIANT_OP_MULTIPLY_PackedVector3Array = cast(type_of(Transform3D_method_store.VARIANT_OP_MULTIPLY_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .TRANSFORM3D, .PACKED_VECTOR3_ARRAY)
}
