package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Basis_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  inverse:  GDE.PtrBuiltInMethod,
  transposed:  GDE.PtrBuiltInMethod,
  orthonormalized:  GDE.PtrBuiltInMethod,
  determinant:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  scaled:  GDE.PtrBuiltInMethod,
  scaled_local:  GDE.PtrBuiltInMethod,
  get_scale:  GDE.PtrBuiltInMethod,
  get_euler:  GDE.PtrBuiltInMethod,
  tdotx:  GDE.PtrBuiltInMethod,
  tdoty:  GDE.PtrBuiltInMethod,
  tdotz:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  is_conformal:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  get_rotation_quaternion:  GDE.PtrBuiltInMethod,
  looking_at:  GDE.PtrBuiltInMethod,
  from_scale:  GDE.PtrBuiltInMethod,
  from_euler:  GDE.PtrBuiltInMethod,
}
@(rodata)
Basis_IDENTITY :GDW.Basis= {1, 0, 0, 0, 1, 0, 0, 0, 1}
init_Basis_Methods :: proc(Basis_method_store: ^Basis_Methods_list) {
  Basis_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 0)
  Basis_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 1)
  Basis_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 2)
  Basis_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 3)
  Basis_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 4)
  Basis_method_store.inverse = GDW.Get_Builtin_Method(.BASIS, "inverse", 594669093)
  Basis_method_store.transposed = GDW.Get_Builtin_Method(.BASIS, "transposed", 594669093)
  Basis_method_store.orthonormalized = GDW.Get_Builtin_Method(.BASIS, "orthonormalized", 594669093)
  Basis_method_store.determinant = GDW.Get_Builtin_Method(.BASIS, "determinant", 466405837)
  Basis_method_store.rotated = GDW.Get_Builtin_Method(.BASIS, "rotated", 1998708965)
  Basis_method_store.scaled = GDW.Get_Builtin_Method(.BASIS, "scaled", 3934786792)
  Basis_method_store.scaled_local = GDW.Get_Builtin_Method(.BASIS, "scaled_local", 3934786792)
  Basis_method_store.get_scale = GDW.Get_Builtin_Method(.BASIS, "get_scale", 1776574132)
  Basis_method_store.get_euler = GDW.Get_Builtin_Method(.BASIS, "get_euler", 1394941017)
  Basis_method_store.tdotx = GDW.Get_Builtin_Method(.BASIS, "tdotx", 1047977935)
  Basis_method_store.tdoty = GDW.Get_Builtin_Method(.BASIS, "tdoty", 1047977935)
  Basis_method_store.tdotz = GDW.Get_Builtin_Method(.BASIS, "tdotz", 1047977935)
  Basis_method_store.slerp = GDW.Get_Builtin_Method(.BASIS, "slerp", 3118673011)
  Basis_method_store.is_conformal = GDW.Get_Builtin_Method(.BASIS, "is_conformal", 3918633141)
  Basis_method_store.is_equal_approx = GDW.Get_Builtin_Method(.BASIS, "is_equal_approx", 3165333982)
  Basis_method_store.is_finite = GDW.Get_Builtin_Method(.BASIS, "is_finite", 3918633141)
  Basis_method_store.get_rotation_quaternion = GDW.Get_Builtin_Method(.BASIS, "get_rotation_quaternion", 4274879941)
  Basis_method_store.looking_at = GDW.Get_Builtin_Method(.BASIS, "looking_at", 3728732505)
  Basis_method_store.from_scale = GDW.Get_Builtin_Method(.BASIS, "from_scale", 3703240166)
  Basis_method_store.from_euler = GDW.Get_Builtin_Method(.BASIS, "from_euler", 2802321791)
}
