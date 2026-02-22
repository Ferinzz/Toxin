package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Basis_IDENTITY : Basis= {1, 0, 0, 0, 1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_X : Basis= {-1, 0, 0, 0, 1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_Y : Basis= {1, 0, 0, 0, -1, 0, 0, 0, 1}
@(rodata)
Basis_FLIP_Z : Basis= {1, 0, 0, 0, 1, 0, 0, 0, -1}
Basis_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Basis, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Basis,  #by_ptr p_args: struct{ from: ^Basis, }),
    Create2: proc "c" (p_base: ^Basis,  #by_ptr p_args: struct{ from: ^Quaternion, }),
    Create3: proc "c" (p_base: ^Basis,  #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }),
    Create4: proc "c" (p_base: ^Basis,  #by_ptr p_args: struct{ x_axis: ^Vector3, y_axis: ^Vector3, z_axis: ^Vector3, }),
    inverse:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Basis, p_argument_count: i64 = 0),
    transposed:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Basis, p_argument_count: i64 = 0),
    orthonormalized:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Basis, p_argument_count: i64 = 0),
    determinant:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    rotated:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ axis: ^Vector3, angle: ^float, }, r_return: ^Basis, p_argument_count: i64 = 2),
    scaled:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ scale: ^Vector3, }, r_return: ^Basis, p_argument_count: i64 = 1),
    scaled_local:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ scale: ^Vector3, }, r_return: ^Basis, p_argument_count: i64 = 1),
    get_scale:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    get_euler:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ order: ^Int, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    tdotx:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    tdoty:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    tdotz:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ with: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    slerp:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ to: ^Basis, weight: ^float, }, r_return: ^Basis, p_argument_count: i64 = 2),
    is_conformal:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ b: ^Basis, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_rotation_quaternion:  proc "c" (p_base: ^Basis, p_args: rawptr = nil, r_return: ^Quaternion, p_argument_count: i64 = 0),
    looking_at:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ target: ^Vector3, up: ^Vector3, use_model_front: ^Bool, }, r_return: ^Basis, p_argument_count: i64 = 3),
    from_scale:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ scale: ^Vector3, }, r_return: ^Basis, p_argument_count: i64 = 1),
    from_euler:  proc "c" (p_base: ^Basis, #by_ptr p_args: struct{ euler: ^Vector3, order: ^Int, }, r_return: ^Basis, p_argument_count: i64 = 2),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Basis, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Basis, p_right: ^Int, r_result: ^Basis),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Basis, p_right: ^Int, r_result: ^Basis),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Basis, p_right: ^float, r_result: ^Basis),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Basis, p_right: ^float, r_result: ^Basis),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^Basis, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_EQUAL_Basis: proc "c" (p_left: ^Basis, p_right: ^Basis, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Basis: proc "c" (p_left: ^Basis, p_right: ^Basis, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Basis: proc "c" (p_left: ^Basis, p_right: ^Basis, r_result: ^Basis),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Basis, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Basis, p_right: ^Array, r_result: ^Bool),
}
init_Basis_Methods :: proc(Basis_method_store: ^Basis_Methods_list) {
  Basis_method_store.Create0 = cast(type_of(Basis_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 0)
  Basis_method_store.Create1 = cast(type_of(Basis_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 1)
  Basis_method_store.Create2 = cast(type_of(Basis_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 2)
  Basis_method_store.Create3 = cast(type_of(Basis_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 3)
  Basis_method_store.Create4 = cast(type_of(Basis_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 4)
  Basis_method_store.inverse = cast(type_of(Basis_method_store.inverse))Get_Builtin_Method(.BASIS, "inverse", 594669093)
  Basis_method_store.transposed = cast(type_of(Basis_method_store.transposed))Get_Builtin_Method(.BASIS, "transposed", 594669093)
  Basis_method_store.orthonormalized = cast(type_of(Basis_method_store.orthonormalized))Get_Builtin_Method(.BASIS, "orthonormalized", 594669093)
  Basis_method_store.determinant = cast(type_of(Basis_method_store.determinant))Get_Builtin_Method(.BASIS, "determinant", 466405837)
  Basis_method_store.rotated = cast(type_of(Basis_method_store.rotated))Get_Builtin_Method(.BASIS, "rotated", 1998708965)
  Basis_method_store.scaled = cast(type_of(Basis_method_store.scaled))Get_Builtin_Method(.BASIS, "scaled", 3934786792)
  Basis_method_store.scaled_local = cast(type_of(Basis_method_store.scaled_local))Get_Builtin_Method(.BASIS, "scaled_local", 3934786792)
  Basis_method_store.get_scale = cast(type_of(Basis_method_store.get_scale))Get_Builtin_Method(.BASIS, "get_scale", 1776574132)
  Basis_method_store.get_euler = cast(type_of(Basis_method_store.get_euler))Get_Builtin_Method(.BASIS, "get_euler", 1394941017)
  Basis_method_store.tdotx = cast(type_of(Basis_method_store.tdotx))Get_Builtin_Method(.BASIS, "tdotx", 1047977935)
  Basis_method_store.tdoty = cast(type_of(Basis_method_store.tdoty))Get_Builtin_Method(.BASIS, "tdoty", 1047977935)
  Basis_method_store.tdotz = cast(type_of(Basis_method_store.tdotz))Get_Builtin_Method(.BASIS, "tdotz", 1047977935)
  Basis_method_store.slerp = cast(type_of(Basis_method_store.slerp))Get_Builtin_Method(.BASIS, "slerp", 3118673011)
  Basis_method_store.is_conformal = cast(type_of(Basis_method_store.is_conformal))Get_Builtin_Method(.BASIS, "is_conformal", 3918633141)
  Basis_method_store.is_equal_approx = cast(type_of(Basis_method_store.is_equal_approx))Get_Builtin_Method(.BASIS, "is_equal_approx", 3165333982)
  Basis_method_store.is_finite = cast(type_of(Basis_method_store.is_finite))Get_Builtin_Method(.BASIS, "is_finite", 3918633141)
  Basis_method_store.get_rotation_quaternion = cast(type_of(Basis_method_store.get_rotation_quaternion))Get_Builtin_Method(.BASIS, "get_rotation_quaternion", 4274879941)
  Basis_method_store.looking_at = cast(type_of(Basis_method_store.looking_at))Get_Builtin_Method(.BASIS, "looking_at", 3728732505)
  Basis_method_store.from_scale = cast(type_of(Basis_method_store.from_scale))Get_Builtin_Method(.BASIS, "from_scale", 3703240166)
  Basis_method_store.from_euler = cast(type_of(Basis_method_store.from_euler))Get_Builtin_Method(.BASIS, "from_euler", 2802321791)
  Basis_method_store.VARIANT_OP_NOT_ = cast(type_of(Basis_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .BASIS, .NIL)
  Basis_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Basis_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .INT)
  Basis_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Basis_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .BASIS, .INT)
  Basis_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Basis_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .FLOAT)
  Basis_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Basis_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .BASIS, .FLOAT)
  Basis_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(Basis_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .VECTOR3)
  Basis_method_store.VARIANT_OP_EQUAL_Basis = cast(type_of(Basis_method_store.VARIANT_OP_EQUAL_Basis))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_NOT_EQUAL_Basis = cast(type_of(Basis_method_store.VARIANT_OP_NOT_EQUAL_Basis))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_MULTIPLY_Basis = cast(type_of(Basis_method_store.VARIANT_OP_MULTIPLY_Basis))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .BASIS, .BASIS)
  Basis_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Basis_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BASIS, .DICTIONARY)
  Basis_method_store.VARIANT_OP_IN_Array = cast(type_of(Basis_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .BASIS, .ARRAY)
}
