package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


AABB_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  abs:  GDE.PtrBuiltInMethod,
  get_center:  GDE.PtrBuiltInMethod,
  get_volume:  GDE.PtrBuiltInMethod,
  has_volume:  GDE.PtrBuiltInMethod,
  has_surface:  GDE.PtrBuiltInMethod,
  has_point:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  intersects:  GDE.PtrBuiltInMethod,
  encloses:  GDE.PtrBuiltInMethod,
  intersects_plane:  GDE.PtrBuiltInMethod,
  intersection:  GDE.PtrBuiltInMethod,
  merge:  GDE.PtrBuiltInMethod,
  expand:  GDE.PtrBuiltInMethod,
  grow:  GDE.PtrBuiltInMethod,
  get_support:  GDE.PtrBuiltInMethod,
  get_longest_axis:  GDE.PtrBuiltInMethod,
  get_longest_axis_index:  GDE.PtrBuiltInMethod,
  get_longest_axis_size:  GDE.PtrBuiltInMethod,
  get_shortest_axis:  GDE.PtrBuiltInMethod,
  get_shortest_axis_index:  GDE.PtrBuiltInMethod,
  get_shortest_axis_size:  GDE.PtrBuiltInMethod,
  get_endpoint:  GDE.PtrBuiltInMethod,
  intersects_segment:  GDE.PtrBuiltInMethod,
  intersects_ray:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_AABB_Methods :: proc(AABB_method_store: ^AABB_Methods_list) {
  AABB_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 0)
  AABB_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 1)
  AABB_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 2)
  AABB_method_store.abs = Get_Builtin_Method(.AABB, "abs", 1576868580)
  AABB_method_store.get_center = Get_Builtin_Method(.AABB, "get_center", 1776574132)
  AABB_method_store.get_volume = Get_Builtin_Method(.AABB, "get_volume", 466405837)
  AABB_method_store.has_volume = Get_Builtin_Method(.AABB, "has_volume", 3918633141)
  AABB_method_store.has_surface = Get_Builtin_Method(.AABB, "has_surface", 3918633141)
  AABB_method_store.has_point = Get_Builtin_Method(.AABB, "has_point", 1749054343)
  AABB_method_store.is_equal_approx = Get_Builtin_Method(.AABB, "is_equal_approx", 299946684)
  AABB_method_store.is_finite = Get_Builtin_Method(.AABB, "is_finite", 3918633141)
  AABB_method_store.intersects = Get_Builtin_Method(.AABB, "intersects", 299946684)
  AABB_method_store.encloses = Get_Builtin_Method(.AABB, "encloses", 299946684)
  AABB_method_store.intersects_plane = Get_Builtin_Method(.AABB, "intersects_plane", 1150170233)
  AABB_method_store.intersection = Get_Builtin_Method(.AABB, "intersection", 1271470306)
  AABB_method_store.merge = Get_Builtin_Method(.AABB, "merge", 1271470306)
  AABB_method_store.expand = Get_Builtin_Method(.AABB, "expand", 2851643018)
  AABB_method_store.grow = Get_Builtin_Method(.AABB, "grow", 239217291)
  AABB_method_store.get_support = Get_Builtin_Method(.AABB, "get_support", 2923479887)
  AABB_method_store.get_longest_axis = Get_Builtin_Method(.AABB, "get_longest_axis", 1776574132)
  AABB_method_store.get_longest_axis_index = Get_Builtin_Method(.AABB, "get_longest_axis_index", 3173160232)
  AABB_method_store.get_longest_axis_size = Get_Builtin_Method(.AABB, "get_longest_axis_size", 466405837)
  AABB_method_store.get_shortest_axis = Get_Builtin_Method(.AABB, "get_shortest_axis", 1776574132)
  AABB_method_store.get_shortest_axis_index = Get_Builtin_Method(.AABB, "get_shortest_axis_index", 3173160232)
  AABB_method_store.get_shortest_axis_size = Get_Builtin_Method(.AABB, "get_shortest_axis_size", 466405837)
  AABB_method_store.get_endpoint = Get_Builtin_Method(.AABB, "get_endpoint", 1394941017)
  AABB_method_store.intersects_segment = Get_Builtin_Method(.AABB, "intersects_segment", 2048133369)
  AABB_method_store.intersects_ray = Get_Builtin_Method(.AABB, "intersects_ray", 2048133369)
  AABB_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .AABB, .NIL)
  AABB_method_store.VARIANT_OP_EQUAL_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .AABB, .AABB)
  AABB_method_store.VARIANT_OP_NOT_EQUAL_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .AABB, .AABB)
  AABB_method_store.VARIANT_OP_MULTIPLY_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .AABB, .TRANSFORM3D)
  AABB_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .AABB, .DICTIONARY)
  AABB_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .AABB, .ARRAY)
}
