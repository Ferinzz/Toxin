package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Vector3_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  min_axis_index:  GDE.PtrBuiltInMethod,
  max_axis_index:  GDE.PtrBuiltInMethod,
  angle_to:  GDE.PtrBuiltInMethod,
  signed_angle_to:  GDE.PtrBuiltInMethod,
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
  inverse:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  clampf:  GDE.PtrBuiltInMethod,
  snapped:  GDE.PtrBuiltInMethod,
  snappedf:  GDE.PtrBuiltInMethod,
  rotated:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  slerp:  GDE.PtrBuiltInMethod,
  cubic_interpolate:  GDE.PtrBuiltInMethod,
  cubic_interpolate_in_time:  GDE.PtrBuiltInMethod,
  bezier_interpolate:  GDE.PtrBuiltInMethod,
  bezier_derivative:  GDE.PtrBuiltInMethod,
  move_toward:  GDE.PtrBuiltInMethod,
  dot:  GDE.PtrBuiltInMethod,
  cross:  GDE.PtrBuiltInMethod,
  outer:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  floor:  GDE.PtrBuiltInMethod,
  ceil:  GDE.PtrBuiltInMethod,
  round:  GDE.PtrBuiltInMethod,
  posmod:  GDE.PtrBuiltInMethod,
  posmodv:  GDE.PtrBuiltInMethod,
  project:  GDE.PtrBuiltInMethod,
  slide:  GDE.PtrBuiltInMethod,
  bounce:  GDE.PtrBuiltInMethod,
  reflect:  GDE.PtrBuiltInMethod,
  sign:  GDE.PtrBuiltInMethod,
  octahedron_encode:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  minf:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  maxf:  GDE.PtrBuiltInMethod,
  octahedron_decode:  GDE.PtrBuiltInMethod,
}
@(rodata)
Vector3_ZERO :GDW.Vector3= {0, 0, 0}
@(rodata)
Vector3_ONE :GDW.Vector3= {1, 1, 1}
@(rodata)
Vector3_INF :GDW.Vector3= {inf, inf, inf}
@(rodata)
Vector3_LEFT :GDW.Vector3= {-1, 0, 0}
@(rodata)
Vector3_RIGHT :GDW.Vector3= {1, 0, 0}
@(rodata)
Vector3_UP :GDW.Vector3= {0, 1, 0}
@(rodata)
Vector3_DOWN :GDW.Vector3= {0, -1, 0}
@(rodata)
Vector3_FORWARD :GDW.Vector3= {0, 0, -1}
@(rodata)
Vector3_BACK :GDW.Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_LEFT :GDW.Vector3= {1, 0, 0}
@(rodata)
Vector3_MODEL_RIGHT :GDW.Vector3= {-1, 0, 0}
@(rodata)
Vector3_MODEL_TOP :GDW.Vector3= {0, 1, 0}
@(rodata)
Vector3_MODEL_BOTTOM :GDW.Vector3= {0, -1, 0}
@(rodata)
Vector3_MODEL_FRONT :GDW.Vector3= {0, 0, 1}
@(rodata)
Vector3_MODEL_REAR :GDW.Vector3= {0, 0, -1}
init_Vector3_Methods :: proc(Vector3_method_store: ^Vector3_Methods_list) {
  Vector3_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 0)
  Vector3_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 1)
  Vector3_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 2)
  Vector3_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3, 3)
  Vector3_method_store.min_axis_index = GDW.Get_Builtin_Method(.VECTOR3, "min_axis_index", 3173160232)
  Vector3_method_store.max_axis_index = GDW.Get_Builtin_Method(.VECTOR3, "max_axis_index", 3173160232)
  Vector3_method_store.angle_to = GDW.Get_Builtin_Method(.VECTOR3, "angle_to", 1047977935)
  Vector3_method_store.signed_angle_to = GDW.Get_Builtin_Method(.VECTOR3, "signed_angle_to", 2781412522)
  Vector3_method_store.direction_to = GDW.Get_Builtin_Method(.VECTOR3, "direction_to", 2923479887)
  Vector3_method_store.distance_to = GDW.Get_Builtin_Method(.VECTOR3, "distance_to", 1047977935)
  Vector3_method_store.distance_squared_to = GDW.Get_Builtin_Method(.VECTOR3, "distance_squared_to", 1047977935)
  Vector3_method_store.length = GDW.Get_Builtin_Method(.VECTOR3, "length", 466405837)
  Vector3_method_store.length_squared = GDW.Get_Builtin_Method(.VECTOR3, "length_squared", 466405837)
  Vector3_method_store.limit_length = GDW.Get_Builtin_Method(.VECTOR3, "limit_length", 514930144)
  Vector3_method_store.normalized = GDW.Get_Builtin_Method(.VECTOR3, "normalized", 1776574132)
  Vector3_method_store.is_normalized = GDW.Get_Builtin_Method(.VECTOR3, "is_normalized", 3918633141)
  Vector3_method_store.is_equal_approx = GDW.Get_Builtin_Method(.VECTOR3, "is_equal_approx", 1749054343)
  Vector3_method_store.is_zero_approx = GDW.Get_Builtin_Method(.VECTOR3, "is_zero_approx", 3918633141)
  Vector3_method_store.is_finite = GDW.Get_Builtin_Method(.VECTOR3, "is_finite", 3918633141)
  Vector3_method_store.inverse = GDW.Get_Builtin_Method(.VECTOR3, "inverse", 1776574132)
  Vector3_method_store.clamp = GDW.Get_Builtin_Method(.VECTOR3, "clamp", 4145107892)
  Vector3_method_store.clampf = GDW.Get_Builtin_Method(.VECTOR3, "clampf", 2329594628)
  Vector3_method_store.snapped = GDW.Get_Builtin_Method(.VECTOR3, "snapped", 2923479887)
  Vector3_method_store.snappedf = GDW.Get_Builtin_Method(.VECTOR3, "snappedf", 514930144)
  Vector3_method_store.rotated = GDW.Get_Builtin_Method(.VECTOR3, "rotated", 1682608829)
  Vector3_method_store.lerp = GDW.Get_Builtin_Method(.VECTOR3, "lerp", 1682608829)
  Vector3_method_store.slerp = GDW.Get_Builtin_Method(.VECTOR3, "slerp", 1682608829)
  Vector3_method_store.cubic_interpolate = GDW.Get_Builtin_Method(.VECTOR3, "cubic_interpolate", 2597922253)
  Vector3_method_store.cubic_interpolate_in_time = GDW.Get_Builtin_Method(.VECTOR3, "cubic_interpolate_in_time", 3256682901)
  Vector3_method_store.bezier_interpolate = GDW.Get_Builtin_Method(.VECTOR3, "bezier_interpolate", 2597922253)
  Vector3_method_store.bezier_derivative = GDW.Get_Builtin_Method(.VECTOR3, "bezier_derivative", 2597922253)
  Vector3_method_store.move_toward = GDW.Get_Builtin_Method(.VECTOR3, "move_toward", 1682608829)
  Vector3_method_store.dot = GDW.Get_Builtin_Method(.VECTOR3, "dot", 1047977935)
  Vector3_method_store.cross = GDW.Get_Builtin_Method(.VECTOR3, "cross", 2923479887)
  Vector3_method_store.outer = GDW.Get_Builtin_Method(.VECTOR3, "outer", 3934786792)
  Vector3_method_store.abs = GDW.Get_Builtin_Method(.VECTOR3, "abs", 1776574132)
  Vector3_method_store.floor = GDW.Get_Builtin_Method(.VECTOR3, "floor", 1776574132)
  Vector3_method_store.ceil = GDW.Get_Builtin_Method(.VECTOR3, "ceil", 1776574132)
  Vector3_method_store.round = GDW.Get_Builtin_Method(.VECTOR3, "round", 1776574132)
  Vector3_method_store.posmod = GDW.Get_Builtin_Method(.VECTOR3, "posmod", 514930144)
  Vector3_method_store.posmodv = GDW.Get_Builtin_Method(.VECTOR3, "posmodv", 2923479887)
  Vector3_method_store.project = GDW.Get_Builtin_Method(.VECTOR3, "project", 2923479887)
  Vector3_method_store.slide = GDW.Get_Builtin_Method(.VECTOR3, "slide", 2923479887)
  Vector3_method_store.bounce = GDW.Get_Builtin_Method(.VECTOR3, "bounce", 2923479887)
  Vector3_method_store.reflect = GDW.Get_Builtin_Method(.VECTOR3, "reflect", 2923479887)
  Vector3_method_store.sign = GDW.Get_Builtin_Method(.VECTOR3, "sign", 1776574132)
  Vector3_method_store.octahedron_encode = GDW.Get_Builtin_Method(.VECTOR3, "octahedron_encode", 2428350749)
  Vector3_method_store.min = GDW.Get_Builtin_Method(.VECTOR3, "min", 2923479887)
  Vector3_method_store.minf = GDW.Get_Builtin_Method(.VECTOR3, "minf", 514930144)
  Vector3_method_store.max = GDW.Get_Builtin_Method(.VECTOR3, "max", 2923479887)
  Vector3_method_store.maxf = GDW.Get_Builtin_Method(.VECTOR3, "maxf", 514930144)
  Vector3_method_store.octahedron_decode = GDW.Get_Builtin_Method(.VECTOR3, "octahedron_decode", 3991820552)
}
