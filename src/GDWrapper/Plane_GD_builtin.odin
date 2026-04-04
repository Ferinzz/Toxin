package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


@(rodata)
@(export)
Plane_PLANE_YZ : Plane= {1, 0, 0, 0}
@(rodata)
@(export)
Plane_PLANE_XZ : Plane= {0, 1, 0, 0}
@(rodata)
@(export)
Plane_PLANE_XY : Plane= {0, 0, 1, 0}
Plane_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Plane, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ from: ^Plane, }),
    Create2: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ normal: ^Vector3, }),
    Create3: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ normal: ^Vector3, d: ^float, }),
    Create4: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ normal: ^Vector3, point: ^Vector3, }),
    Create5: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ point1: ^Vector3, point2: ^Vector3, point3: ^Vector3, }),
    Create6: proc "c" (p_base: ^Plane,  #by_ptr p_args: struct{ a: ^float, b: ^float, c: ^float, d: ^float, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Plane,
    normalized:  proc "c" (p_base: ^Plane, p_args: rawptr = nil, r_return: ^Plane, p_argument_count: i64 = 0),
    get_center:  proc "c" (p_base: ^Plane, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ to_plane: ^Plane, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Plane, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_point_over:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ point: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    distance_to:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ point: ^Vector3, }, r_return: ^float, p_argument_count: i64 = 1),
    has_point:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ point: ^Vector3, tolerance: ^float, }, r_return: ^Bool, p_argument_count: i64 = 2),
    project:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ point: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    intersect_3:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ b: ^Plane, c: ^Plane, }, r_return: ^Variant, p_argument_count: i64 = 2),
    intersects_ray:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ from: ^Vector3, dir: ^Vector3, }, r_return: ^Variant, p_argument_count: i64 = 2),
    intersects_segment:  proc "c" (p_base: ^Plane, #by_ptr p_args: struct{ from: ^Vector3, to: ^Vector3, }, r_return: ^Variant, p_argument_count: i64 = 2),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Plane, p_right: rawptr = nil,  r_result: ^Plane),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Plane, p_right: rawptr = nil,  r_result: ^Plane),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Plane, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Plane: proc "c" (p_left: ^Plane, p_right: ^Plane, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Plane: proc "c" (p_left: ^Plane, p_right: ^Plane, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform3D: proc "c" (p_left: ^Plane, p_right: ^Transform3D, r_result: ^Plane),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Plane, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Plane, p_right: ^Array, r_result: ^Bool),
}
init_Plane_Methods :: proc "c" (Plane_method_store: ^Plane_Methods_list) {
  Plane_method_store.Create0 = cast(type_of(Plane_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 0)
  Plane_method_store.Create1 = cast(type_of(Plane_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 1)
  Plane_method_store.Create2 = cast(type_of(Plane_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 2)
  Plane_method_store.Create3 = cast(type_of(Plane_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 3)
  Plane_method_store.Create4 = cast(type_of(Plane_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 4)
  Plane_method_store.Create5 = cast(type_of(Plane_method_store.Create5))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 5)
  Plane_method_store.Create6 = cast(type_of(Plane_method_store.Create6))gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 6)
    Plane_method_store.get_ptr = cast(type_of(Plane_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PLANE)
  Plane_method_store.normalized = cast(type_of(Plane_method_store.normalized))Get_Builtin_Method(.PLANE, "normalized", 1051796340)
  Plane_method_store.get_center = cast(type_of(Plane_method_store.get_center))Get_Builtin_Method(.PLANE, "get_center", 1776574132)
  Plane_method_store.is_equal_approx = cast(type_of(Plane_method_store.is_equal_approx))Get_Builtin_Method(.PLANE, "is_equal_approx", 1150170233)
  Plane_method_store.is_finite = cast(type_of(Plane_method_store.is_finite))Get_Builtin_Method(.PLANE, "is_finite", 3918633141)
  Plane_method_store.is_point_over = cast(type_of(Plane_method_store.is_point_over))Get_Builtin_Method(.PLANE, "is_point_over", 1749054343)
  Plane_method_store.distance_to = cast(type_of(Plane_method_store.distance_to))Get_Builtin_Method(.PLANE, "distance_to", 1047977935)
  Plane_method_store.has_point = cast(type_of(Plane_method_store.has_point))Get_Builtin_Method(.PLANE, "has_point", 1258189072)
  Plane_method_store.project = cast(type_of(Plane_method_store.project))Get_Builtin_Method(.PLANE, "project", 2923479887)
  Plane_method_store.intersect_3 = cast(type_of(Plane_method_store.intersect_3))Get_Builtin_Method(.PLANE, "intersect_3", 2012052692)
  Plane_method_store.intersects_ray = cast(type_of(Plane_method_store.intersects_ray))Get_Builtin_Method(.PLANE, "intersects_ray", 2048133369)
  Plane_method_store.intersects_segment = cast(type_of(Plane_method_store.intersects_segment))Get_Builtin_Method(.PLANE, "intersects_segment", 2048133369)
  Plane_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Plane_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .PLANE, .NIL)
  Plane_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Plane_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .PLANE, .NIL)
  Plane_method_store.VARIANT_OP_NOT_ = cast(type_of(Plane_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PLANE, .NIL)
  Plane_method_store.VARIANT_OP_EQUAL_Plane = cast(type_of(Plane_method_store.VARIANT_OP_EQUAL_Plane))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PLANE, .PLANE)
  Plane_method_store.VARIANT_OP_NOT_EQUAL_Plane = cast(type_of(Plane_method_store.VARIANT_OP_NOT_EQUAL_Plane))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PLANE, .PLANE)
  Plane_method_store.VARIANT_OP_MULTIPLY_Transform3D = cast(type_of(Plane_method_store.VARIANT_OP_MULTIPLY_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PLANE, .TRANSFORM3D)
  Plane_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Plane_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PLANE, .DICTIONARY)
  Plane_method_store.VARIANT_OP_IN_Array = cast(type_of(Plane_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PLANE, .ARRAY)
}
