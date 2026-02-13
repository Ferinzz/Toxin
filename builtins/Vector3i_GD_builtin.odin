package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector3i_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampi:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedi:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  mini:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxi:  GDE.PtrBuiltInMethod,
}
@(rodata)
Vector3i_ZERO :GDW.Vector3i= {0, 0, 0}
init_Vector3i_Methods :: proc(Vector3i_method_store: ^Vector3i_Methods_list) {
  Vector3i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 0)
  Vector3i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 1)
  Vector3i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 2)
  Vector3i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 3)
  Vector3i_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR3I, "min_axis_index", 3173160232)
  Vector3i_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR3I, "max_axis_index", 3173160232)
  Vector3i_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR3I, "distance_to", 1975170430)
  Vector3i_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR3I, "distance_squared_to", 2947717320)
  Vector3i_method_store.length = GDW.Get_Builtin_Method(.VECTOR3I, "length", 466405837)
  Vector3i_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR3I, "length_squared", 3173160232)
  Vector3i_method_store.sign = GDW.Get_Builtin_Method(.VECTOR3I, "sign", 3729604559)
  Vector3i_method_store.abs = GDW.Get_Builtin_Method(.VECTOR3I, "abs", 3729604559)
  Vector3i_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR3I, "clamp", 1086892323)
  Vector3i_method_store.clampi = GDW.Get_Builtin_Method(.VECTOR3I, "clampi", 1077216921)
  Vector3i_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR3I, "snapped", 1989319750)
  Vector3i_method_store.snappedi = GDW.Get_Builtin_Method(.VECTOR3I, "snappedi", 2377625641)
  Vector3i_method_store.min = GDW.Get_Builtin_Method(.VECTOR3I, "min", 1989319750)
  Vector3i_method_store.mini = GDW.Get_Builtin_Method(.VECTOR3I, "mini", 2377625641)
  Vector3i_method_store.max = GDW.Get_Builtin_Method(.VECTOR3I, "max", 1989319750)
  Vector3i_method_store.maxi = GDW.Get_Builtin_Method(.VECTOR3I, "maxi", 2377625641)
}
