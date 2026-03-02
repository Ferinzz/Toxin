package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Projection_IDENTITY : Projection= {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
@(rodata)
Projection_ZERO : Projection= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

Projection_Planes :: enum i64 {
  PLANE_NEAR = 0,
  PLANE_FAR = 1,
  PLANE_LEFT = 2,
  PLANE_TOP = 3,
  PLANE_RIGHT = 4,
  PLANE_BOTTOM = 5,
}
Projection_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Projection, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Projection,  #by_ptr p_args: struct{ from: ^Projection, }),
    Create2: proc "c" (p_base: ^Projection,  #by_ptr p_args: struct{ from: ^Transform3D, }),
    Create3: proc "c" (p_base: ^Projection,  #by_ptr p_args: struct{ x_axis: ^Vector4, y_axis: ^Vector4, z_axis: ^Vector4, w_axis: ^Vector4, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Projection,
    IndxSetter : proc "c" (p_base: ^Projection, p_index: Int, p_value: ^Vector4),
    IndxGetter : proc "c" (p_base: ^Projection, p_index: Int, r_value: ^Vector4),
    create_depth_correction:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ flip_y: ^Bool, }, r_return: ^Projection, p_argument_count: i64 = 1),
    create_light_atlas_rect:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ rect: ^Rect2, }, r_return: ^Projection, p_argument_count: i64 = 1),
    create_perspective:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ fovy: ^float, aspect: ^float, z_near: ^float, z_far: ^float, flip_fov: ^Bool, }, r_return: ^Projection, p_argument_count: i64 = 5),
    create_perspective_hmd:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ fovy: ^float, aspect: ^float, z_near: ^float, z_far: ^float, flip_fov: ^Bool, eye: ^Int, intraocular_dist: ^float, convergence_dist: ^float, }, r_return: ^Projection, p_argument_count: i64 = 8),
    create_for_hmd:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ eye: ^Int, aspect: ^float, intraocular_dist: ^float, display_width: ^float, display_to_lens: ^float, oversample: ^float, z_near: ^float, z_far: ^float, }, r_return: ^Projection, p_argument_count: i64 = 8),
    create_orthogonal:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ left: ^float, right: ^float, bottom: ^float, top: ^float, z_near: ^float, z_far: ^float, }, r_return: ^Projection, p_argument_count: i64 = 6),
    create_orthogonal_aspect:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ size: ^float, aspect: ^float, z_near: ^float, z_far: ^float, flip_fov: ^Bool, }, r_return: ^Projection, p_argument_count: i64 = 5),
    create_frustum:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ left: ^float, right: ^float, bottom: ^float, top: ^float, z_near: ^float, z_far: ^float, }, r_return: ^Projection, p_argument_count: i64 = 6),
    create_frustum_aspect:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ size: ^float, aspect: ^float, offset: ^Vector2, z_near: ^float, z_far: ^float, flip_fov: ^Bool, }, r_return: ^Projection, p_argument_count: i64 = 6),
    create_fit_aabb:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ aabb: ^AABB, }, r_return: ^Projection, p_argument_count: i64 = 1),
    determinant:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    perspective_znear_adjusted:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ new_znear: ^float, }, r_return: ^Projection, p_argument_count: i64 = 1),
    get_projection_plane:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ plane: ^Int, }, r_return: ^Plane, p_argument_count: i64 = 1),
    flipped_y:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^Projection, p_argument_count: i64 = 0),
    jitter_offseted:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ offset: ^Vector2, }, r_return: ^Projection, p_argument_count: i64 = 1),
    get_fovy:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ fovx: ^float, aspect: ^float, }, r_return: ^float, p_argument_count: i64 = 2),
    get_z_far:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_z_near:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_aspect:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    get_fov:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    is_orthogonal:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_viewport_half_extents:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    get_far_plane_half_extents:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    inverse:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^Projection, p_argument_count: i64 = 0),
    get_pixels_per_meter:  proc "c" (p_base: ^Projection, #by_ptr p_args: struct{ for_pixel_width: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    get_lod_multiplier:  proc "c" (p_base: ^Projection, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Projection, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Vector4: proc "c" (p_left: ^Projection, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_EQUAL_Projection: proc "c" (p_left: ^Projection, p_right: ^Projection, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Projection: proc "c" (p_left: ^Projection, p_right: ^Projection, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Projection: proc "c" (p_left: ^Projection, p_right: ^Projection, r_result: ^Projection),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Projection, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Projection, p_right: ^Array, r_result: ^Bool),
}
init_Projection_Methods :: proc(Projection_method_store: ^Projection_Methods_list) {
  Projection_method_store.Create0 = cast(type_of(Projection_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 0)
  Projection_method_store.Create1 = cast(type_of(Projection_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 1)
  Projection_method_store.Create2 = cast(type_of(Projection_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 2)
  Projection_method_store.Create3 = cast(type_of(Projection_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 3)
    Projection_method_store.get_ptr = cast(type_of(Projection_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PROJECTION)
  Projection_method_store.IndxGetter = cast(type_of(Projection_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.PROJECTION)
  Projection_method_store.IndxSetter = cast(type_of(Projection_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.PROJECTION)
  Projection_method_store.create_depth_correction = cast(type_of(Projection_method_store.create_depth_correction))Get_Builtin_Method(.PROJECTION, "create_depth_correction", 1228516048)
  Projection_method_store.create_light_atlas_rect = cast(type_of(Projection_method_store.create_light_atlas_rect))Get_Builtin_Method(.PROJECTION, "create_light_atlas_rect", 2654950662)
  Projection_method_store.create_perspective = cast(type_of(Projection_method_store.create_perspective))Get_Builtin_Method(.PROJECTION, "create_perspective", 390915442)
  Projection_method_store.create_perspective_hmd = cast(type_of(Projection_method_store.create_perspective_hmd))Get_Builtin_Method(.PROJECTION, "create_perspective_hmd", 2857674800)
  Projection_method_store.create_for_hmd = cast(type_of(Projection_method_store.create_for_hmd))Get_Builtin_Method(.PROJECTION, "create_for_hmd", 4184144994)
  Projection_method_store.create_orthogonal = cast(type_of(Projection_method_store.create_orthogonal))Get_Builtin_Method(.PROJECTION, "create_orthogonal", 3707929169)
  Projection_method_store.create_orthogonal_aspect = cast(type_of(Projection_method_store.create_orthogonal_aspect))Get_Builtin_Method(.PROJECTION, "create_orthogonal_aspect", 390915442)
  Projection_method_store.create_frustum = cast(type_of(Projection_method_store.create_frustum))Get_Builtin_Method(.PROJECTION, "create_frustum", 3707929169)
  Projection_method_store.create_frustum_aspect = cast(type_of(Projection_method_store.create_frustum_aspect))Get_Builtin_Method(.PROJECTION, "create_frustum_aspect", 1535076251)
  Projection_method_store.create_fit_aabb = cast(type_of(Projection_method_store.create_fit_aabb))Get_Builtin_Method(.PROJECTION, "create_fit_aabb", 2264694907)
  Projection_method_store.determinant = cast(type_of(Projection_method_store.determinant))Get_Builtin_Method(.PROJECTION, "determinant", 466405837)
  Projection_method_store.perspective_znear_adjusted = cast(type_of(Projection_method_store.perspective_znear_adjusted))Get_Builtin_Method(.PROJECTION, "perspective_znear_adjusted", 3584785443)
  Projection_method_store.get_projection_plane = cast(type_of(Projection_method_store.get_projection_plane))Get_Builtin_Method(.PROJECTION, "get_projection_plane", 1551184160)
  Projection_method_store.flipped_y = cast(type_of(Projection_method_store.flipped_y))Get_Builtin_Method(.PROJECTION, "flipped_y", 4212530932)
  Projection_method_store.jitter_offseted = cast(type_of(Projection_method_store.jitter_offseted))Get_Builtin_Method(.PROJECTION, "jitter_offseted", 2448438599)
  Projection_method_store.get_fovy = cast(type_of(Projection_method_store.get_fovy))Get_Builtin_Method(.PROJECTION, "get_fovy", 3514207532)
  Projection_method_store.get_z_far = cast(type_of(Projection_method_store.get_z_far))Get_Builtin_Method(.PROJECTION, "get_z_far", 466405837)
  Projection_method_store.get_z_near = cast(type_of(Projection_method_store.get_z_near))Get_Builtin_Method(.PROJECTION, "get_z_near", 466405837)
  Projection_method_store.get_aspect = cast(type_of(Projection_method_store.get_aspect))Get_Builtin_Method(.PROJECTION, "get_aspect", 466405837)
  Projection_method_store.get_fov = cast(type_of(Projection_method_store.get_fov))Get_Builtin_Method(.PROJECTION, "get_fov", 466405837)
  Projection_method_store.is_orthogonal = cast(type_of(Projection_method_store.is_orthogonal))Get_Builtin_Method(.PROJECTION, "is_orthogonal", 3918633141)
  Projection_method_store.get_viewport_half_extents = cast(type_of(Projection_method_store.get_viewport_half_extents))Get_Builtin_Method(.PROJECTION, "get_viewport_half_extents", 2428350749)
  Projection_method_store.get_far_plane_half_extents = cast(type_of(Projection_method_store.get_far_plane_half_extents))Get_Builtin_Method(.PROJECTION, "get_far_plane_half_extents", 2428350749)
  Projection_method_store.inverse = cast(type_of(Projection_method_store.inverse))Get_Builtin_Method(.PROJECTION, "inverse", 4212530932)
  Projection_method_store.get_pixels_per_meter = cast(type_of(Projection_method_store.get_pixels_per_meter))Get_Builtin_Method(.PROJECTION, "get_pixels_per_meter", 4103005248)
  Projection_method_store.get_lod_multiplier = cast(type_of(Projection_method_store.get_lod_multiplier))Get_Builtin_Method(.PROJECTION, "get_lod_multiplier", 466405837)
  Projection_method_store.VARIANT_OP_NOT_ = cast(type_of(Projection_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PROJECTION, .NIL)
  Projection_method_store.VARIANT_OP_MULTIPLY_Vector4 = cast(type_of(Projection_method_store.VARIANT_OP_MULTIPLY_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PROJECTION, .VECTOR4)
  Projection_method_store.VARIANT_OP_EQUAL_Projection = cast(type_of(Projection_method_store.VARIANT_OP_EQUAL_Projection))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PROJECTION, .PROJECTION)
  Projection_method_store.VARIANT_OP_NOT_EQUAL_Projection = cast(type_of(Projection_method_store.VARIANT_OP_NOT_EQUAL_Projection))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PROJECTION, .PROJECTION)
  Projection_method_store.VARIANT_OP_MULTIPLY_Projection = cast(type_of(Projection_method_store.VARIANT_OP_MULTIPLY_Projection))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .PROJECTION, .PROJECTION)
  Projection_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Projection_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PROJECTION, .DICTIONARY)
  Projection_method_store.VARIANT_OP_IN_Array = cast(type_of(Projection_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PROJECTION, .ARRAY)
}
