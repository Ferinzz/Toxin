package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Transform3D_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  affine_inverse:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  rotated_local:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  translated:  GDE.PtrBuiltInMethod,
  translated_local:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
  interpolate_with:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
}
@(rodata)
Transform3D_IDENTITY :GDW.Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_X :GDW.Transform3D= {-1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Y :GDW.Transform3D= {1, 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0}
@(rodata)
Transform3D_FLIP_Z :GDW.Transform3D= {1, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0}
init_Transform3D_Methods :: proc(Transform3D_method_store: ^Transform3D_Methods_list) {
  Transform3D_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 0)
  Transform3D_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 1)
  Transform3D_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 2)
  Transform3D_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 3)
  Transform3D_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 4)
  Transform3D_method_store.inverse = GDW.Get_Builtin_Method(.TRANSFORM3D, "inverse", 3816817146)
  Transform3D_method_store.affine_inverse = GDW.Get_Builtin_Method(.TRANSFORM3D, "affine_inverse", 3816817146)
  Transform3D_method_store.orthonormalized = GDW.Get_Builtin_Method(.TRANSFORM3D, "orthonormalized", 3816817146)
  Transform3D_method_store.rotated = GDW.Get_Builtin_Method(.TRANSFORM3D, "rotated", 1563203923)
  Transform3D_method_store.rotated_local = GDW.Get_Builtin_Method(.TRANSFORM3D, "rotated_local", 1563203923)
  Transform3D_method_store.scaled = GDW.Get_Builtin_Method(.TRANSFORM3D, "scaled", 1405596198)
  Transform3D_method_store.scaled_local = GDW.Get_Builtin_Method(.TRANSFORM3D, "scaled_local", 1405596198)
  Transform3D_method_store.translated = GDW.Get_Builtin_Method(.TRANSFORM3D, "translated", 1405596198)
  Transform3D_method_store.translated_local = GDW.Get_Builtin_Method(.TRANSFORM3D, "translated_local", 1405596198)
  Transform3D_method_store.looking_at = GDW.Get_Builtin_Method(.TRANSFORM3D, "looking_at", 90889270)
  Transform3D_method_store.interpolate_with = GDW.Get_Builtin_Method(.TRANSFORM3D, "interpolate_with", 1786453358)
  Transform3D_method_store.is_equal_approx = GDW.Get_Builtin_Method(.TRANSFORM3D, "is_equal_approx", 696001652)
  Transform3D_method_store.is_finite = GDW.Get_Builtin_Method(.TRANSFORM3D, "is_finite", 3918633141)
}
