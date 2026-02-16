package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


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
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector2i_ZERO :Vector2i= {0, 0}
@(rodata)
Vector2i_ONE :Vector2i= {1, 1}
@(rodata)
Vector2i_MIN :Vector2i= {-2147483648, -2147483648}
@(rodata)
Vector2i_MAX :Vector2i= {2147483647, 2147483647}
@(rodata)
Vector2i_LEFT :Vector2i= {-1, 0}
@(rodata)
Vector2i_RIGHT :Vector2i= {1, 0}
@(rodata)
Vector2i_UP :Vector2i= {0, -1}
@(rodata)
Vector2i_DOWN :Vector2i= {0, 1}
init_Vector2i_Methods :: proc(Vector2i_method_store: ^Vector2i_Methods_list) {
  Vector2i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 0)
  Vector2i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 1)
  Vector2i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 2)
  Vector2i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 3)
  Vector2i_method_store.aspect = Get_Builtin_Method(.VECTOR2I, "aspect", 466405837)
  Vector2i_method_store.max_axis_index = Get_Builtin_Method(.VECTOR2I, "max_axis_index", 3173160232)
  Vector2i_method_store.min_axis_index = Get_Builtin_Method(.VECTOR2I, "min_axis_index", 3173160232)
  Vector2i_method_store.distance_to = Get_Builtin_Method(.VECTOR2I, "distance_to", 707501214)
  Vector2i_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR2I, "distance_squared_to", 1130029528)
  Vector2i_method_store.length = Get_Builtin_Method(.VECTOR2I, "length", 466405837)
  Vector2i_method_store.length_squared = Get_Builtin_Method(.VECTOR2I, "length_squared", 3173160232)
  Vector2i_method_store.sign = Get_Builtin_Method(.VECTOR2I, "sign", 3444277866)
  Vector2i_method_store.abs = Get_Builtin_Method(.VECTOR2I, "abs", 3444277866)
  Vector2i_method_store.clamp = Get_Builtin_Method(.VECTOR2I, "clamp", 186568249)
  Vector2i_method_store.clampi = Get_Builtin_Method(.VECTOR2I, "clampi", 3686769569)
  Vector2i_method_store.snapped = Get_Builtin_Method(.VECTOR2I, "snapped", 1735278196)
  Vector2i_method_store.snappedi = Get_Builtin_Method(.VECTOR2I, "snappedi", 2161988953)
  Vector2i_method_store.min = Get_Builtin_Method(.VECTOR2I, "min", 1735278196)
  Vector2i_method_store.mini = Get_Builtin_Method(.VECTOR2I, "mini", 2161988953)
  Vector2i_method_store.max = Get_Builtin_Method(.VECTOR2I, "max", 1735278196)
  Vector2i_method_store.maxi = Get_Builtin_Method(.VECTOR2I, "maxi", 2161988953)
  Vector2i_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .FLOAT)
  Vector2i_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .FLOAT)
  Vector2i_method_store.VARIANT_OP_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_NOT_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_LESS_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_LESS_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_GREATER_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_GREATER_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_ADD_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_SUBTRACT_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_DIVIDE_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_MODULE_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2I, .DICTIONARY)
  Vector2i_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2I, .ARRAY)
}
