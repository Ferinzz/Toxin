package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


AABB_Methods_list :: struct {
    Create0: proc "c" (p_base: ^AABB, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^AABB,  #by_ptr p_args: struct{ from: ^AABB, }),
    Create2: proc "c" (p_base: ^AABB,  #by_ptr p_args: struct{ position: ^Vector3, size: ^Vector3, }),
    get_ptr: proc "c" (base: ^Variant) -> ^AABB,
    abs:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^AABB, p_argument_count: i64 = 0),
    get_center:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    get_volume:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    has_volume:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    has_surface:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    has_point:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ point: ^Vector3, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_equal_approx:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ aabb: ^AABB, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    intersects:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ with: ^AABB, }, r_return: ^Bool, p_argument_count: i64 = 1),
    encloses:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ with: ^AABB, }, r_return: ^Bool, p_argument_count: i64 = 1),
    intersects_plane:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ plane: ^Plane, }, r_return: ^Bool, p_argument_count: i64 = 1),
    intersection:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ with: ^AABB, }, r_return: ^AABB, p_argument_count: i64 = 1),
    merge:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ with: ^AABB, }, r_return: ^AABB, p_argument_count: i64 = 1),
    expand:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ to_point: ^Vector3, }, r_return: ^AABB, p_argument_count: i64 = 1),
    grow:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ by: ^float, }, r_return: ^AABB, p_argument_count: i64 = 1),
    get_support:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ direction: ^Vector3, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    get_longest_axis:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    get_longest_axis_index:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_longest_axis_size:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_shortest_axis:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Vector3, p_argument_count: i64 = 0),
    get_shortest_axis_index:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_shortest_axis_size:  proc "c" (p_base: ^AABB, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_endpoint:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ idx: ^Int, }, r_return: ^Vector3, p_argument_count: i64 = 1),
    intersects_segment:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ from: ^Vector3, to: ^Vector3, }, r_return: ^Variant, p_argument_count: i64 = 2),
    intersects_ray:  proc "c" (p_base: ^AABB, #by_ptr p_args: struct{ from: ^Vector3, dir: ^Vector3, }, r_return: ^Variant, p_argument_count: i64 = 2),
    VARIANT_OP_NOT_: proc "c" (p_left: ^AABB, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_AABB: proc "c" (p_left: ^AABB, p_right: ^AABB, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_AABB: proc "c" (p_left: ^AABB, p_right: ^AABB, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform3D: proc "c" (p_left: ^AABB, p_right: ^Transform3D, r_result: ^AABB),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^AABB, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^AABB, p_right: ^Array, r_result: ^Bool),
}
init_AABB_Methods :: proc(AABB_method_store: ^AABB_Methods_list) {
  AABB_method_store.Create0 = cast(type_of(AABB_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 0)
  AABB_method_store.Create1 = cast(type_of(AABB_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 1)
  AABB_method_store.Create2 = cast(type_of(AABB_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 2)
    AABB_method_store.get_ptr = cast(type_of(AABB_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.AABB)
  AABB_method_store.abs = cast(type_of(AABB_method_store.abs))Get_Builtin_Method(.AABB, "abs", 1576868580)
  AABB_method_store.get_center = cast(type_of(AABB_method_store.get_center))Get_Builtin_Method(.AABB, "get_center", 1776574132)
  AABB_method_store.get_volume = cast(type_of(AABB_method_store.get_volume))Get_Builtin_Method(.AABB, "get_volume", 466405837)
  AABB_method_store.has_volume = cast(type_of(AABB_method_store.has_volume))Get_Builtin_Method(.AABB, "has_volume", 3918633141)
  AABB_method_store.has_surface = cast(type_of(AABB_method_store.has_surface))Get_Builtin_Method(.AABB, "has_surface", 3918633141)
  AABB_method_store.has_point = cast(type_of(AABB_method_store.has_point))Get_Builtin_Method(.AABB, "has_point", 1749054343)
  AABB_method_store.is_equal_approx = cast(type_of(AABB_method_store.is_equal_approx))Get_Builtin_Method(.AABB, "is_equal_approx", 299946684)
  AABB_method_store.is_finite = cast(type_of(AABB_method_store.is_finite))Get_Builtin_Method(.AABB, "is_finite", 3918633141)
  AABB_method_store.intersects = cast(type_of(AABB_method_store.intersects))Get_Builtin_Method(.AABB, "intersects", 299946684)
  AABB_method_store.encloses = cast(type_of(AABB_method_store.encloses))Get_Builtin_Method(.AABB, "encloses", 299946684)
  AABB_method_store.intersects_plane = cast(type_of(AABB_method_store.intersects_plane))Get_Builtin_Method(.AABB, "intersects_plane", 1150170233)
  AABB_method_store.intersection = cast(type_of(AABB_method_store.intersection))Get_Builtin_Method(.AABB, "intersection", 1271470306)
  AABB_method_store.merge = cast(type_of(AABB_method_store.merge))Get_Builtin_Method(.AABB, "merge", 1271470306)
  AABB_method_store.expand = cast(type_of(AABB_method_store.expand))Get_Builtin_Method(.AABB, "expand", 2851643018)
  AABB_method_store.grow = cast(type_of(AABB_method_store.grow))Get_Builtin_Method(.AABB, "grow", 239217291)
  AABB_method_store.get_support = cast(type_of(AABB_method_store.get_support))Get_Builtin_Method(.AABB, "get_support", 2923479887)
  AABB_method_store.get_longest_axis = cast(type_of(AABB_method_store.get_longest_axis))Get_Builtin_Method(.AABB, "get_longest_axis", 1776574132)
  AABB_method_store.get_longest_axis_index = cast(type_of(AABB_method_store.get_longest_axis_index))Get_Builtin_Method(.AABB, "get_longest_axis_index", 3173160232)
  AABB_method_store.get_longest_axis_size = cast(type_of(AABB_method_store.get_longest_axis_size))Get_Builtin_Method(.AABB, "get_longest_axis_size", 466405837)
  AABB_method_store.get_shortest_axis = cast(type_of(AABB_method_store.get_shortest_axis))Get_Builtin_Method(.AABB, "get_shortest_axis", 1776574132)
  AABB_method_store.get_shortest_axis_index = cast(type_of(AABB_method_store.get_shortest_axis_index))Get_Builtin_Method(.AABB, "get_shortest_axis_index", 3173160232)
  AABB_method_store.get_shortest_axis_size = cast(type_of(AABB_method_store.get_shortest_axis_size))Get_Builtin_Method(.AABB, "get_shortest_axis_size", 466405837)
  AABB_method_store.get_endpoint = cast(type_of(AABB_method_store.get_endpoint))Get_Builtin_Method(.AABB, "get_endpoint", 1394941017)
  AABB_method_store.intersects_segment = cast(type_of(AABB_method_store.intersects_segment))Get_Builtin_Method(.AABB, "intersects_segment", 2048133369)
  AABB_method_store.intersects_ray = cast(type_of(AABB_method_store.intersects_ray))Get_Builtin_Method(.AABB, "intersects_ray", 2048133369)
  AABB_method_store.VARIANT_OP_NOT_ = cast(type_of(AABB_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .AABB, .NIL)
  AABB_method_store.VARIANT_OP_EQUAL_AABB = cast(type_of(AABB_method_store.VARIANT_OP_EQUAL_AABB))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .AABB, .AABB)
  AABB_method_store.VARIANT_OP_NOT_EQUAL_AABB = cast(type_of(AABB_method_store.VARIANT_OP_NOT_EQUAL_AABB))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .AABB, .AABB)
  AABB_method_store.VARIANT_OP_MULTIPLY_Transform3D = cast(type_of(AABB_method_store.VARIANT_OP_MULTIPLY_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .AABB, .TRANSFORM3D)
  AABB_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(AABB_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .AABB, .DICTIONARY)
  AABB_method_store.VARIANT_OP_IN_Array = cast(type_of(AABB_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .AABB, .ARRAY)
}
