package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


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
}
init_AABB_Methods :: proc(AABB_method_store: ^AABB_Methods_list) {
  AABB_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 0)
  AABB_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 1)
  AABB_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 2)
  AABB_method_store.abs = GDW.Get_Builtin_Method(.AABB, "abs", 1576868580)
  AABB_method_store.get_center = GDW.Get_Builtin_Method(.AABB, "get_center", 1776574132)
  AABB_method_store.get_volume = GDW.Get_Builtin_Method(.AABB, "get_volume", 466405837)
  AABB_method_store.has_volume = GDW.Get_Builtin_Method(.AABB, "has_volume", 3918633141)
  AABB_method_store.has_surface = GDW.Get_Builtin_Method(.AABB, "has_surface", 3918633141)
  AABB_method_store.has_point = GDW.Get_Builtin_Method(.AABB, "has_point", 1749054343)
  AABB_method_store.is_equal_approx = GDW.Get_Builtin_Method(.AABB, "is_equal_approx", 299946684)
  AABB_method_store.is_finite = GDW.Get_Builtin_Method(.AABB, "is_finite", 3918633141)
  AABB_method_store.intersects = GDW.Get_Builtin_Method(.AABB, "intersects", 299946684)
  AABB_method_store.encloses = GDW.Get_Builtin_Method(.AABB, "encloses", 299946684)
  AABB_method_store.intersects_plane = GDW.Get_Builtin_Method(.AABB, "intersects_plane", 1150170233)
  AABB_method_store.intersection = GDW.Get_Builtin_Method(.AABB, "intersection", 1271470306)
  AABB_method_store.merge = GDW.Get_Builtin_Method(.AABB, "merge", 1271470306)
  AABB_method_store.expand = GDW.Get_Builtin_Method(.AABB, "expand", 2851643018)
  AABB_method_store.grow = GDW.Get_Builtin_Method(.AABB, "grow", 239217291)
  AABB_method_store.get_support = GDW.Get_Builtin_Method(.AABB, "get_support", 2923479887)
  AABB_method_store.get_longest_axis = GDW.Get_Builtin_Method(.AABB, "get_longest_axis", 1776574132)
  AABB_method_store.get_longest_axis_index = GDW.Get_Builtin_Method(.AABB, "get_longest_axis_index", 3173160232)
  AABB_method_store.get_longest_axis_size = GDW.Get_Builtin_Method(.AABB, "get_longest_axis_size", 466405837)
  AABB_method_store.get_shortest_axis = GDW.Get_Builtin_Method(.AABB, "get_shortest_axis", 1776574132)
  AABB_method_store.get_shortest_axis_index = GDW.Get_Builtin_Method(.AABB, "get_shortest_axis_index", 3173160232)
  AABB_method_store.get_shortest_axis_size = GDW.Get_Builtin_Method(.AABB, "get_shortest_axis_size", 466405837)
  AABB_method_store.get_endpoint = GDW.Get_Builtin_Method(.AABB, "get_endpoint", 1394941017)
  AABB_method_store.intersects_segment = GDW.Get_Builtin_Method(.AABB, "intersects_segment", 2048133369)
  AABB_method_store.intersects_ray = GDW.Get_Builtin_Method(.AABB, "intersects_ray", 2048133369)
}
