package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector2i_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  aspect:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  min_axis_index:  GDE.PtrBuiltInMethod,
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
Vector2i_ZERO :GDW.Vector2i= {0, 0}
@(rodata)
Vector2i_ONE :GDW.Vector2i= {1, 1}
@(rodata)
Vector2i_MIN :GDW.Vector2i= {-2147483648, -2147483648}
@(rodata)
Vector2i_MAX :GDW.Vector2i= {2147483647, 2147483647}
@(rodata)
Vector2i_LEFT :GDW.Vector2i= {-1, 0}
@(rodata)
Vector2i_RIGHT :GDW.Vector2i= {1, 0}
@(rodata)
Vector2i_UP :GDW.Vector2i= {0, -1}
@(rodata)
Vector2i_DOWN :GDW.Vector2i= {0, 1}
init_Vector2i_Methods :: proc(Vector2i_method_store: ^Vector2i_Methods_list) {
  Vector2i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 0)
  Vector2i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 1)
  Vector2i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 2)
  Vector2i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 3)
  Vector2i_method_store.aspect = GDW.Get_Builtin_Method(.VECTOR2I, "aspect", 466405837)
  Vector2i_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR2I, "max_axis_index", 3173160232)
  Vector2i_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR2I, "min_axis_index", 3173160232)
  Vector2i_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR2I, "distance_to", 707501214)
  Vector2i_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR2I, "distance_squared_to", 1130029528)
  Vector2i_method_store.length = GDW.Get_Builtin_Method(.VECTOR2I, "length", 466405837)
  Vector2i_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR2I, "length_squared", 3173160232)
  Vector2i_method_store.sign = GDW.Get_Builtin_Method(.VECTOR2I, "sign", 3444277866)
  Vector2i_method_store.abs = GDW.Get_Builtin_Method(.VECTOR2I, "abs", 3444277866)
  Vector2i_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR2I, "clamp", 186568249)
  Vector2i_method_store.clampi = GDW.Get_Builtin_Method(.VECTOR2I, "clampi", 3686769569)
  Vector2i_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR2I, "snapped", 1735278196)
  Vector2i_method_store.snappedi = GDW.Get_Builtin_Method(.VECTOR2I, "snappedi", 2161988953)
  Vector2i_method_store.min = GDW.Get_Builtin_Method(.VECTOR2I, "min", 1735278196)
  Vector2i_method_store.mini = GDW.Get_Builtin_Method(.VECTOR2I, "mini", 2161988953)
  Vector2i_method_store.max = GDW.Get_Builtin_Method(.VECTOR2I, "max", 1735278196)
  Vector2i_method_store.maxi = GDW.Get_Builtin_Method(.VECTOR2I, "maxi", 2161988953)
}
