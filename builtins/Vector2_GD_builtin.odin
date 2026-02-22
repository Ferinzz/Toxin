package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector2_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  angle:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  angle_to_point:  GDE.PtrBuiltInMethod,
  direction_to:  GDE.PtrBuiltInMethod,
  distance_to:  GDE.PtrBuiltInMethod,
  distance_squared_to:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  length_squared:  GDE.PtrBuiltInMethod,
  limit_length:  GDE.PtrBuiltInMethod,
  normalized:  GDE.PtrBuiltInMethod,
  is_normalized:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_zero_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  project:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  bezier_interpolate:  GDE.PtrBuiltInMethod,
  bezier_derivative:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  min_axis_index:  GDE.PtrBuiltInMethod,
  move_toward:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  orthogonal:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  aspect:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  slide:  GDE.PtrBuiltInMethod,
  bounce:  GDE.PtrBuiltInMethod,
  reflect:  GDE.PtrBuiltInMethod,
  cross:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
  from_angle:  GDE.PtrBuiltInMethod,
}
@(rodata)
Vector2_ZERO :GDW.Vector2= {0, 0}
@(rodata)
Vector2_ONE :GDW.Vector2= {1, 1}
@(rodata)
Vector2_INF :GDW.Vector2= {inf, inf}
@(rodata)
Vector2_LEFT :GDW.Vector2= {-1, 0}
@(rodata)
Vector2_RIGHT :GDW.Vector2= {1, 0}
@(rodata)
Vector2_UP :GDW.Vector2= {0, -1}
@(rodata)
Vector2_DOWN :GDW.Vector2= {0, 1}
init_Vector2_Methods :: proc(Vector2_method_store: ^Vector2_Methods_list) {
  Vector2_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 0)
  Vector2_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 1)
  Vector2_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 2)
  Vector2_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2, 3)
  Vector2_method_store.angle = GDW.Get_Builtin_Method(.VECTOR2, "angle", 466405837)
  Vector2_method_store.angle_to = GDW.Get_Builtin_Method(.VECTOR2, "angle_to", 3819070308)
  Vector2_method_store.angle_to_point = GDW.Get_Builtin_Method(.VECTOR2, "angle_to_point", 3819070308)
  Vector2_method_store.direction_to = GDW.Get_Builtin_Method(.VECTOR2, "direction_to", 2026743667)
  Vector2_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR2, "distance_to", 3819070308)
  Vector2_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR2, "distance_squared_to", 3819070308)
  Vector2_method_store.length = GDW.Get_Builtin_Method(.VECTOR2, "length", 466405837)
  Vector2_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR2, "length_squared", 466405837)
  Vector2_method_store.limit_length = GDW.Get_Builtin_Method(.VECTOR2, "limit_length", 2544004089)
  Vector2_method_store.normalized = GDW.Get_Builtin_Method(.VECTOR2, "normalized", 2428350749)
  Vector2_method_store.is_normalized = GDW.Get_Builtin_Method(.VECTOR2, "is_normalized", 3918633141)
  Vector2_method_store.is_equal_approx = GDW.Get_Builtin_Method(.VECTOR2, "is_equal_approx", 3190634762)
  Vector2_method_store.is_zero_approx = GDW.Get_Builtin_Method(.VECTOR2, "is_zero_approx", 3918633141)
  Vector2_method_store.is_finite = GDW.Get_Builtin_Method(.VECTOR2, "is_finite", 3918633141)
  Vector2_method_store.posmod = GDW.Get_Builtin_Method(.VECTOR2, "posmod", 2544004089)
  Vector2_method_store.posmodv = GDW.Get_Builtin_Method(.VECTOR2, "posmodv", 2026743667)
  Vector2_method_store.project = GDW.Get_Builtin_Method(.VECTOR2, "project", 2026743667)
  Vector2_method_store.lerp = GDW.Get_Builtin_Method(.VECTOR2, "lerp", 4250033116)
  Vector2_method_store.slerp = GDW.Get_Builtin_Method(.VECTOR2, "slerp", 4250033116)
  Vector2_method_store.cubic_interpolate = GDW.Get_Builtin_Method(.VECTOR2, "cubic_interpolate", 193522989)
  Vector2_method_store.cubic_interpolate_in_time = GDW.Get_Builtin_Method(.VECTOR2, "cubic_interpolate_in_time", 1957055074)
  Vector2_method_store.bezier_interpolate = GDW.Get_Builtin_Method(.VECTOR2, "bezier_interpolate", 193522989)
  Vector2_method_store.bezier_derivative = GDW.Get_Builtin_Method(.VECTOR2, "bezier_derivative", 193522989)
  Vector2_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR2, "max_axis_index", 3173160232)
  Vector2_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR2, "min_axis_index", 3173160232)
  Vector2_method_store.move_toward = GDW.Get_Builtin_Method(.VECTOR2, "move_toward", 4250033116)
  Vector2_method_store.rotated = GDW.Get_Builtin_Method(.VECTOR2, "rotated", 2544004089)
  Vector2_method_store.orthogonal = GDW.Get_Builtin_Method(.VECTOR2, "orthogonal", 2428350749)
  Vector2_method_store.floor = GDW.Get_Builtin_Method(.VECTOR2, "floor", 2428350749)
  Vector2_method_store.ceil = GDW.Get_Builtin_Method(.VECTOR2, "ceil", 2428350749)
  Vector2_method_store.round = GDW.Get_Builtin_Method(.VECTOR2, "round", 2428350749)
  Vector2_method_store.aspect = GDW.Get_Builtin_Method(.VECTOR2, "aspect", 466405837)
  Vector2_method_store.dot = GDW.Get_Builtin_Method(.VECTOR2, "dot", 3819070308)
  Vector2_method_store.slide = GDW.Get_Builtin_Method(.VECTOR2, "slide", 2026743667)
  Vector2_method_store.bounce = GDW.Get_Builtin_Method(.VECTOR2, "bounce", 2026743667)
  Vector2_method_store.reflect = GDW.Get_Builtin_Method(.VECTOR2, "reflect", 2026743667)
  Vector2_method_store.cross = GDW.Get_Builtin_Method(.VECTOR2, "cross", 3819070308)
  Vector2_method_store.abs = GDW.Get_Builtin_Method(.VECTOR2, "abs", 2428350749)
  Vector2_method_store.sign = GDW.Get_Builtin_Method(.VECTOR2, "sign", 2428350749)
  Vector2_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR2, "clamp", 318031021)
  Vector2_method_store.clampf = GDW.Get_Builtin_Method(.VECTOR2, "clampf", 3464402636)
  Vector2_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR2, "snapped", 2026743667)
  Vector2_method_store.snappedf = GDW.Get_Builtin_Method(.VECTOR2, "snappedf", 2544004089)
  Vector2_method_store.min = GDW.Get_Builtin_Method(.VECTOR2, "min", 2026743667)
  Vector2_method_store.minf = GDW.Get_Builtin_Method(.VECTOR2, "minf", 2544004089)
  Vector2_method_store.max = GDW.Get_Builtin_Method(.VECTOR2, "max", 2026743667)
  Vector2_method_store.maxf = GDW.Get_Builtin_Method(.VECTOR2, "maxf", 2544004089)
  Vector2_method_store.from_angle = GDW.Get_Builtin_Method(.VECTOR2, "from_angle", 889263119)
}
