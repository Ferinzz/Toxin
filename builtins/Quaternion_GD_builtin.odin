package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Quaternion_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  Create5: GDE.PtrConstructor,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  inverse:  GDE.PtrBuiltInMethod,
  log:  GDE.PtrBuiltInMethod,
  exp:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  slerpni:  GDE.PtrBuiltInMethod,
  spherical_cubic_interpolate:  GDE.PtrBuiltInMethod,
  spherical_cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  get_euler:  GDE.PtrBuiltInMethod,
  from_euler:  GDE.PtrBuiltInMethod,
  get_axis:  GDE.PtrBuiltInMethod,
  get_angle:  GDE.PtrBuiltInMethod,
}
init_Quaternion_Methods :: proc(Quaternion_method_store: ^Quaternion_Methods_list) {
  Quaternion_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 0)
  Quaternion_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 1)
  Quaternion_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 2)
  Quaternion_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 3)
  Quaternion_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 4)
  Quaternion_method_store.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.QUATERNION, 5)
  Quaternion_method_store.length = GDW.Get_Builtin_Method(.QUATERNION, "length", 466405837)
  Quaternion_method_store.length_squared = GDW.Get_Builtin_Method(.QUATERNION, "length_squared", 466405837)
  Quaternion_method_store.normalized = GDW.Get_Builtin_Method(.QUATERNION, "normalized", 4274879941)
  Quaternion_method_store.is_normalized = GDW.Get_Builtin_Method(.QUATERNION, "is_normalized", 3918633141)
  Quaternion_method_store.is_equal_approx = GDW.Get_Builtin_Method(.QUATERNION, "is_equal_approx", 1682156903)
  Quaternion_method_store.is_finite = GDW.Get_Builtin_Method(.QUATERNION, "is_finite", 3918633141)
  Quaternion_method_store.inverse = GDW.Get_Builtin_Method(.QUATERNION, "inverse", 4274879941)
  Quaternion_method_store.log = GDW.Get_Builtin_Method(.QUATERNION, "log", 4274879941)
  Quaternion_method_store.exp = GDW.Get_Builtin_Method(.QUATERNION, "exp", 4274879941)
  Quaternion_method_store.angle_to = GDW.Get_Builtin_Method(.QUATERNION, "angle_to", 3244682419)
  Quaternion_method_store.dot = GDW.Get_Builtin_Method(.QUATERNION, "dot", 3244682419)
  Quaternion_method_store.slerp = GDW.Get_Builtin_Method(.QUATERNION, "slerp", 1773590316)
  Quaternion_method_store.slerpni = GDW.Get_Builtin_Method(.QUATERNION, "slerpni", 1773590316)
  Quaternion_method_store.spherical_cubic_interpolate = GDW.Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate", 2150967576)
  Quaternion_method_store.spherical_cubic_interpolate_in_time = GDW.Get_Builtin_Method(.QUATERNION, "spherical_cubic_interpolate_in_time", 1436023539)
  Quaternion_method_store.get_euler = GDW.Get_Builtin_Method(.QUATERNION, "get_euler", 1394941017)
  Quaternion_method_store.from_euler = GDW.Get_Builtin_Method(.QUATERNION, "from_euler", 4053467903)
  Quaternion_method_store.get_axis = GDW.Get_Builtin_Method(.QUATERNION, "get_axis", 1776574132)
  Quaternion_method_store.get_angle = GDW.Get_Builtin_Method(.QUATERNION, "get_angle", 466405837)
}
