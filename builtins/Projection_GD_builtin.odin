package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Projection_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  create_depth_correction:  GDE.PtrBuiltInMethod,
  create_light_atlas_rect:  GDE.PtrBuiltInMethod,
  create_perspective:  GDE.PtrBuiltInMethod,
  create_perspective_hmd:  GDE.PtrBuiltInMethod,
  create_for_hmd:  GDE.PtrBuiltInMethod,
  create_orthogonal:  GDE.PtrBuiltInMethod,
  create_orthogonal_aspect:  GDE.PtrBuiltInMethod,
  create_frustum:  GDE.PtrBuiltInMethod,
  create_frustum_aspect:  GDE.PtrBuiltInMethod,
  create_fit_aabb:  GDE.PtrBuiltInMethod,
  determinant:  GDE.PtrBuiltInMethod,
  perspective_znear_adjusted:  GDE.PtrBuiltInMethod,
  get_projection_plane:  GDE.PtrBuiltInMethod,
  flipped_y:  GDE.PtrBuiltInMethod,
  jitter_offseted:  GDE.PtrBuiltInMethod,
  get_fovy:  GDE.PtrBuiltInMethod,
  get_z_far:  GDE.PtrBuiltInMethod,
  get_z_near:  GDE.PtrBuiltInMethod,
  get_aspect:  GDE.PtrBuiltInMethod,
  get_fov:  GDE.PtrBuiltInMethod,
  is_orthogonal:  GDE.PtrBuiltInMethod,
  get_viewport_half_extents:  GDE.PtrBuiltInMethod,
  get_far_plane_half_extents:  GDE.PtrBuiltInMethod,
  inverse:  GDE.PtrBuiltInMethod,
  get_pixels_per_meter:  GDE.PtrBuiltInMethod,
  get_lod_multiplier:  GDE.PtrBuiltInMethod,
}
@(rodata)
Projection_IDENTITY :GDW.Projection= {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
@(rodata)
Projection_ZERO :GDW.Projection= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
init_Projection_Methods :: proc(Projection_method_store: ^Projection_Methods_list) {
  Projection_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 0)
  Projection_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 1)
  Projection_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 2)
  Projection_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 3)
  Projection_method_store.create_depth_correction = GDW.Get_Builtin_Method(.PROJECTION, "create_depth_correction", 1228516048)
  Projection_method_store.create_light_atlas_rect = GDW.Get_Builtin_Method(.PROJECTION, "create_light_atlas_rect", 2654950662)
  Projection_method_store.create_perspective = GDW.Get_Builtin_Method(.PROJECTION, "create_perspective", 390915442)
  Projection_method_store.create_perspective_hmd = GDW.Get_Builtin_Method(.PROJECTION, "create_perspective_hmd", 2857674800)
  Projection_method_store.create_for_hmd = GDW.Get_Builtin_Method(.PROJECTION, "create_for_hmd", 4184144994)
  Projection_method_store.create_orthogonal = GDW.Get_Builtin_Method(.PROJECTION, "create_orthogonal", 3707929169)
  Projection_method_store.create_orthogonal_aspect = GDW.Get_Builtin_Method(.PROJECTION, "create_orthogonal_aspect", 390915442)
  Projection_method_store.create_frustum = GDW.Get_Builtin_Method(.PROJECTION, "create_frustum", 3707929169)
  Projection_method_store.create_frustum_aspect = GDW.Get_Builtin_Method(.PROJECTION, "create_frustum_aspect", 1535076251)
  Projection_method_store.create_fit_aabb = GDW.Get_Builtin_Method(.PROJECTION, "create_fit_aabb", 2264694907)
  Projection_method_store.determinant = GDW.Get_Builtin_Method(.PROJECTION, "determinant", 466405837)
  Projection_method_store.perspective_znear_adjusted = GDW.Get_Builtin_Method(.PROJECTION, "perspective_znear_adjusted", 3584785443)
  Projection_method_store.get_projection_plane = GDW.Get_Builtin_Method(.PROJECTION, "get_projection_plane", 1551184160)
  Projection_method_store.flipped_y = GDW.Get_Builtin_Method(.PROJECTION, "flipped_y", 4212530932)
  Projection_method_store.jitter_offseted = GDW.Get_Builtin_Method(.PROJECTION, "jitter_offseted", 2448438599)
  Projection_method_store.get_fovy = GDW.Get_Builtin_Method(.PROJECTION, "get_fovy", 3514207532)
  Projection_method_store.get_z_far = GDW.Get_Builtin_Method(.PROJECTION, "get_z_far", 466405837)
  Projection_method_store.get_z_near = GDW.Get_Builtin_Method(.PROJECTION, "get_z_near", 466405837)
  Projection_method_store.get_aspect = GDW.Get_Builtin_Method(.PROJECTION, "get_aspect", 466405837)
  Projection_method_store.get_fov = GDW.Get_Builtin_Method(.PROJECTION, "get_fov", 466405837)
  Projection_method_store.is_orthogonal = GDW.Get_Builtin_Method(.PROJECTION, "is_orthogonal", 3918633141)
  Projection_method_store.get_viewport_half_extents = GDW.Get_Builtin_Method(.PROJECTION, "get_viewport_half_extents", 2428350749)
  Projection_method_store.get_far_plane_half_extents = GDW.Get_Builtin_Method(.PROJECTION, "get_far_plane_half_extents", 2428350749)
  Projection_method_store.inverse = GDW.Get_Builtin_Method(.PROJECTION, "inverse", 4212530932)
  Projection_method_store.get_pixels_per_meter = GDW.Get_Builtin_Method(.PROJECTION, "get_pixels_per_meter", 4103005248)
  Projection_method_store.get_lod_multiplier = GDW.Get_Builtin_Method(.PROJECTION, "get_lod_multiplier", 466405837)
}
