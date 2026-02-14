package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector4_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  direction_to:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  inverse:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_zero_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
}
@(rodata)
Vector4_ZERO :GDW.Vector4= {0, 0, 0, 0}
@(rodata)
Vector4_ONE :GDW.Vector4= {1, 1, 1, 1}
@(rodata)
Vector4_INF :GDW.Vector4= {inf, inf, inf, inf}
init_Vector4_Methods :: proc(Vector4_method_store: ^Vector4_Methods_list) {
  Vector4_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 0)
  Vector4_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 1)
  Vector4_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 2)
  Vector4_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4, 3)
  Vector4_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR4, "min_axis_index", 3173160232)
  Vector4_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR4, "max_axis_index", 3173160232)
  Vector4_method_store.length = GDW.Get_Builtin_Method(.VECTOR4, "length", 466405837)
  Vector4_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR4, "length_squared", 466405837)
  Vector4_method_store.abs = GDW.Get_Builtin_Method(.VECTOR4, "abs", 80860099)
  Vector4_method_store.sign = GDW.Get_Builtin_Method(.VECTOR4, "sign", 80860099)
  Vector4_method_store.floor = GDW.Get_Builtin_Method(.VECTOR4, "floor", 80860099)
  Vector4_method_store.ceil = GDW.Get_Builtin_Method(.VECTOR4, "ceil", 80860099)
  Vector4_method_store.round = GDW.Get_Builtin_Method(.VECTOR4, "round", 80860099)
  Vector4_method_store.lerp = GDW.Get_Builtin_Method(.VECTOR4, "lerp", 2329757942)
  Vector4_method_store.cubic_interpolate = GDW.Get_Builtin_Method(.VECTOR4, "cubic_interpolate", 726768410)
  Vector4_method_store.cubic_interpolate_in_time = GDW.Get_Builtin_Method(.VECTOR4, "cubic_interpolate_in_time", 681631873)
  Vector4_method_store.posmod = GDW.Get_Builtin_Method(.VECTOR4, "posmod", 3129671720)
  Vector4_method_store.posmodv = GDW.Get_Builtin_Method(.VECTOR4, "posmodv", 2031281584)
  Vector4_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR4, "snapped", 2031281584)
  Vector4_method_store.snappedf = GDW.Get_Builtin_Method(.VECTOR4, "snappedf", 3129671720)
  Vector4_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR4, "clamp", 823915692)
  Vector4_method_store.clampf = GDW.Get_Builtin_Method(.VECTOR4, "clampf", 4072091586)
  Vector4_method_store.normalized = GDW.Get_Builtin_Method(.VECTOR4, "normalized", 80860099)
  Vector4_method_store.is_normalized = GDW.Get_Builtin_Method(.VECTOR4, "is_normalized", 3918633141)
  Vector4_method_store.direction_to = GDW.Get_Builtin_Method(.VECTOR4, "direction_to", 2031281584)
  Vector4_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR4, "distance_to", 3770801042)
  Vector4_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR4, "distance_squared_to", 3770801042)
  Vector4_method_store.dot = GDW.Get_Builtin_Method(.VECTOR4, "dot", 3770801042)
  Vector4_method_store.inverse = GDW.Get_Builtin_Method(.VECTOR4, "inverse", 80860099)
  Vector4_method_store.is_equal_approx = GDW.Get_Builtin_Method(.VECTOR4, "is_equal_approx", 88913544)
  Vector4_method_store.is_zero_approx = GDW.Get_Builtin_Method(.VECTOR4, "is_zero_approx", 3918633141)
  Vector4_method_store.is_finite = GDW.Get_Builtin_Method(.VECTOR4, "is_finite", 3918633141)
  Vector4_method_store.min = GDW.Get_Builtin_Method(.VECTOR4, "min", 2031281584)
  Vector4_method_store.minf = GDW.Get_Builtin_Method(.VECTOR4, "minf", 3129671720)
  Vector4_method_store.max = GDW.Get_Builtin_Method(.VECTOR4, "max", 2031281584)
  Vector4_method_store.maxf = GDW.Get_Builtin_Method(.VECTOR4, "maxf", 3129671720)
}
