package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Plane_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  Create5: GDE.PtrConstructor,
  Create6: GDE.PtrConstructor,
  normalized:  GDE.PtrBuiltInMethod,
  get_center:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  is_point_over:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  has_point:  GDE.PtrBuiltInMethod,
  project:  GDE.PtrBuiltInMethod,
  intersect_3:  GDE.PtrBuiltInMethod,
  intersects_ray:  GDE.PtrBuiltInMethod,
  intersects_segment:  GDE.PtrBuiltInMethod,
}
@(rodata)
Plane_PLANE_YZ :GDW.Plane= {1, 0, 0, 0}
@(rodata)
Plane_PLANE_XZ :GDW.Plane= {0, 1, 0, 0}
@(rodata)
Plane_PLANE_XY :GDW.Plane= {0, 0, 1, 0}
init_Plane_Methods :: proc(Plane_method_store: ^Plane_Methods_list) {
  Plane_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 0)
  Plane_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 1)
  Plane_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 2)
  Plane_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 3)
  Plane_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 4)
  Plane_method_store.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 5)
  Plane_method_store.Create6 = gdAPI.Variant_Utils.GetPtrConstructor(.PLANE, 6)
  Plane_method_store.normalized = GDW.Get_Builtin_Method(.PLANE, "normalized", 1051796340)
  Plane_method_store.get_center = GDW.Get_Builtin_Method(.PLANE, "get_center", 1776574132)
  Plane_method_store.is_equal_approx = GDW.Get_Builtin_Method(.PLANE, "is_equal_approx", 1150170233)
  Plane_method_store.is_finite = GDW.Get_Builtin_Method(.PLANE, "is_finite", 3918633141)
  Plane_method_store.is_point_over = GDW.Get_Builtin_Method(.PLANE, "is_point_over", 1749054343)
  Plane_method_store.distance_to = GDW.Get_Builtin_Method(.PLANE, "distance_to", 1047977935)
  Plane_method_store.has_point = GDW.Get_Builtin_Method(.PLANE, "has_point", 1258189072)
  Plane_method_store.project = GDW.Get_Builtin_Method(.PLANE, "project", 2923479887)
  Plane_method_store.intersect_3 = GDW.Get_Builtin_Method(.PLANE, "intersect_3", 2012052692)
  Plane_method_store.intersects_ray = GDW.Get_Builtin_Method(.PLANE, "intersects_ray", 2048133369)
  Plane_method_store.intersects_segment = GDW.Get_Builtin_Method(.PLANE, "intersects_segment", 2048133369)
}
