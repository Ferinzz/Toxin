package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector4i_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
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
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
}
@(rodata)
Vector4i_ZERO :GDW.Vector4i= {0, 0, 0, 0}
@(rodata)
Vector4i_ONE :GDW.Vector4i= {1, 1, 1, 1}
@(rodata)
Vector4i_MIN :GDW.Vector4i= {-2147483648, -2147483648, -2147483648, -2147483648}
@(rodata)
Vector4i_MAX :GDW.Vector4i= {2147483647, 2147483647, 2147483647, 2147483647}
init_Vector4i_Methods :: proc(Vector4i_method_store: ^Vector4i_Methods_list) {
  Vector4i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 0)
  Vector4i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 1)
  Vector4i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 2)
  Vector4i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 3)
  Vector4i_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR4I, "min_axis_index", 3173160232)
  Vector4i_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR4I, "max_axis_index", 3173160232)
  Vector4i_method_store.length = GDW.Get_Builtin_Method(.VECTOR4I, "length", 466405837)
  Vector4i_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR4I, "length_squared", 3173160232)
  Vector4i_method_store.sign = GDW.Get_Builtin_Method(.VECTOR4I, "sign", 4134919947)
  Vector4i_method_store.abs = GDW.Get_Builtin_Method(.VECTOR4I, "abs", 4134919947)
  Vector4i_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR4I, "clamp", 3046490913)
  Vector4i_method_store.clampi = GDW.Get_Builtin_Method(.VECTOR4I, "clampi", 2994578256)
  Vector4i_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR4I, "snapped", 1181693102)
  Vector4i_method_store.snappedi = GDW.Get_Builtin_Method(.VECTOR4I, "snappedi", 1476494415)
  Vector4i_method_store.min = GDW.Get_Builtin_Method(.VECTOR4I, "min", 1181693102)
  Vector4i_method_store.mini = GDW.Get_Builtin_Method(.VECTOR4I, "mini", 1476494415)
  Vector4i_method_store.max = GDW.Get_Builtin_Method(.VECTOR4I, "max", 1181693102)
  Vector4i_method_store.maxi = GDW.Get_Builtin_Method(.VECTOR4I, "maxi", 1476494415)
  Vector4i_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR4I, "distance_to", 3446086573)
  Vector4i_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR4I, "distance_squared_to", 346708794)
}
