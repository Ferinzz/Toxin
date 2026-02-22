package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Transform2D_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  affine_inverse:  GDE.PtrBuiltInMethod,
  get_rotation:  GDE.PtrBuiltInMethod,
  get_origin:  GDE.PtrBuiltInMethod,
  get_scale:  GDE.PtrBuiltInMethod,
  get_skew:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  rotated_local:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  translated:  GDE.PtrBuiltInMethod,
  translated_local:  GDE.PtrBuiltInMethod,
  determinant:  GDE.PtrBuiltInMethod,
  basis_xform:  GDE.PtrBuiltInMethod,
  basis_xform_inv:  GDE.PtrBuiltInMethod,
  interpolate_with:  GDE.PtrBuiltInMethod,
  is_conformal:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
}
@(rodata)
Transform2D_IDENTITY :GDW.Transform2D= {1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_X :GDW.Transform2D= {-1, 0, 0, 1, 0, 0}
@(rodata)
Transform2D_FLIP_Y :GDW.Transform2D= {1, 0, 0, -1, 0, 0}
init_Transform2D_Methods :: proc(Transform2D_method_store: ^Transform2D_Methods_list) {
  Transform2D_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 0)
  Transform2D_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 1)
  Transform2D_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 2)
  Transform2D_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 3)
  Transform2D_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 4)
  Transform2D_method_store.inverse = GDW.Get_Builtin_Method(.TRANSFORM2D, "inverse", 1420440541)
  Transform2D_method_store.affine_inverse = GDW.Get_Builtin_Method(.TRANSFORM2D, "affine_inverse", 1420440541)
  Transform2D_method_store.get_rotation = GDW.Get_Builtin_Method(.TRANSFORM2D, "get_rotation", 466405837)
  Transform2D_method_store.get_origin = GDW.Get_Builtin_Method(.TRANSFORM2D, "get_origin", 2428350749)
  Transform2D_method_store.get_scale = GDW.Get_Builtin_Method(.TRANSFORM2D, "get_scale", 2428350749)
  Transform2D_method_store.get_skew = GDW.Get_Builtin_Method(.TRANSFORM2D, "get_skew", 466405837)
  Transform2D_method_store.orthonormalized = GDW.Get_Builtin_Method(.TRANSFORM2D, "orthonormalized", 1420440541)
  Transform2D_method_store.rotated = GDW.Get_Builtin_Method(.TRANSFORM2D, "rotated", 729597514)
  Transform2D_method_store.rotated_local = GDW.Get_Builtin_Method(.TRANSFORM2D, "rotated_local", 729597514)
  Transform2D_method_store.scaled = GDW.Get_Builtin_Method(.TRANSFORM2D, "scaled", 1446323263)
  Transform2D_method_store.scaled_local = GDW.Get_Builtin_Method(.TRANSFORM2D, "scaled_local", 1446323263)
  Transform2D_method_store.translated = GDW.Get_Builtin_Method(.TRANSFORM2D, "translated", 1446323263)
  Transform2D_method_store.translated_local = GDW.Get_Builtin_Method(.TRANSFORM2D, "translated_local", 1446323263)
  Transform2D_method_store.determinant = GDW.Get_Builtin_Method(.TRANSFORM2D, "determinant", 466405837)
  Transform2D_method_store.basis_xform = GDW.Get_Builtin_Method(.TRANSFORM2D, "basis_xform", 2026743667)
  Transform2D_method_store.basis_xform_inv = GDW.Get_Builtin_Method(.TRANSFORM2D, "basis_xform_inv", 2026743667)
  Transform2D_method_store.interpolate_with = GDW.Get_Builtin_Method(.TRANSFORM2D, "interpolate_with", 359399686)
  Transform2D_method_store.is_conformal = GDW.Get_Builtin_Method(.TRANSFORM2D, "is_conformal", 3918633141)
  Transform2D_method_store.is_equal_approx = GDW.Get_Builtin_Method(.TRANSFORM2D, "is_equal_approx", 3837431929)
  Transform2D_method_store.is_finite = GDW.Get_Builtin_Method(.TRANSFORM2D, "is_finite", 3918633141)
  Transform2D_method_store.looking_at = GDW.Get_Builtin_Method(.TRANSFORM2D, "looking_at", 1446323263)
}
