package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


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
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector3i_ZERO :Vector3i= {0, 0, 0}
@(rodata)
Vector3i_ONE :Vector3i= {1, 1, 1}
@(rodata)
Vector3i_MIN :Vector3i= {-2147483648, -2147483648, -2147483648}
@(rodata)
Vector3i_MAX :Vector3i= {2147483647, 2147483647, 2147483647}
@(rodata)
Vector3i_LEFT :Vector3i= {-1, 0, 0}
@(rodata)
Vector3i_RIGHT :Vector3i= {1, 0, 0}
@(rodata)
Vector3i_UP :Vector3i= {0, 1, 0}
@(rodata)
Vector3i_DOWN :Vector3i= {0, -1, 0}
@(rodata)
Vector3i_FORWARD :Vector3i= {0, 0, -1}
@(rodata)
Vector3i_BACK :Vector3i= {0, 0, 1}
init_Vector3i_Methods :: proc(Vector3i_method_store: ^Vector3i_Methods_list) {
  Vector3i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 0)
  Vector3i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 1)
  Vector3i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 2)
  Vector3i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 3)
  Vector3i_method_store.min_axis_index = Get_Builtin_Method(.VECTOR3I, "min_axis_index", 3173160232)
  Vector3i_method_store.max_axis_index = Get_Builtin_Method(.VECTOR3I, "max_axis_index", 3173160232)
  Vector3i_method_store.distance_to = Get_Builtin_Method(.VECTOR3I, "distance_to", 1975170430)
  Vector3i_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR3I, "distance_squared_to", 2947717320)
  Vector3i_method_store.length = Get_Builtin_Method(.VECTOR3I, "length", 466405837)
  Vector3i_method_store.length_squared = Get_Builtin_Method(.VECTOR3I, "length_squared", 3173160232)
  Vector3i_method_store.sign = Get_Builtin_Method(.VECTOR3I, "sign", 3729604559)
  Vector3i_method_store.abs = Get_Builtin_Method(.VECTOR3I, "abs", 3729604559)
  Vector3i_method_store.clamp = Get_Builtin_Method(.VECTOR3I, "clamp", 1086892323)
  Vector3i_method_store.clampi = Get_Builtin_Method(.VECTOR3I, "clampi", 1077216921)
  Vector3i_method_store.snapped = Get_Builtin_Method(.VECTOR3I, "snapped", 1989319750)
  Vector3i_method_store.snappedi = Get_Builtin_Method(.VECTOR3I, "snappedi", 2377625641)
  Vector3i_method_store.min = Get_Builtin_Method(.VECTOR3I, "min", 1989319750)
  Vector3i_method_store.mini = Get_Builtin_Method(.VECTOR3I, "mini", 2377625641)
  Vector3i_method_store.max = Get_Builtin_Method(.VECTOR3I, "max", 1989319750)
  Vector3i_method_store.maxi = Get_Builtin_Method(.VECTOR3I, "maxi", 2377625641)
  Vector3i_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .FLOAT)
  Vector3i_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .FLOAT)
  Vector3i_method_store.VARIANT_OP_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_NOT_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_LESS_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_LESS_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_GREATER_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_GREATER_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_ADD_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_SUBTRACT_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_DIVIDE_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_MODULE_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3I, .DICTIONARY)
  Vector3i_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3I, .ARRAY)
}
