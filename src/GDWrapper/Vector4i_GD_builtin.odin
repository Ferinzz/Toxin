package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


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
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
@(rodata)
Vector4i_ZERO :Vector4i= {0, 0, 0, 0}
@(rodata)
Vector4i_ONE :Vector4i= {1, 1, 1, 1}
@(rodata)
Vector4i_MIN :Vector4i= {-2147483648, -2147483648, -2147483648, -2147483648}
@(rodata)
Vector4i_MAX :Vector4i= {2147483647, 2147483647, 2147483647, 2147483647}
init_Vector4i_Methods :: proc(Vector4i_method_store: ^Vector4i_Methods_list) {
  Vector4i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 0)
  Vector4i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 1)
  Vector4i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 2)
  Vector4i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 3)
  Vector4i_method_store.min_axis_index = Get_Builtin_Method(.VECTOR4I, "min_axis_index", 3173160232)
  Vector4i_method_store.max_axis_index = Get_Builtin_Method(.VECTOR4I, "max_axis_index", 3173160232)
  Vector4i_method_store.length = Get_Builtin_Method(.VECTOR4I, "length", 466405837)
  Vector4i_method_store.length_squared = Get_Builtin_Method(.VECTOR4I, "length_squared", 3173160232)
  Vector4i_method_store.sign = Get_Builtin_Method(.VECTOR4I, "sign", 4134919947)
  Vector4i_method_store.abs = Get_Builtin_Method(.VECTOR4I, "abs", 4134919947)
  Vector4i_method_store.clamp = Get_Builtin_Method(.VECTOR4I, "clamp", 3046490913)
  Vector4i_method_store.clampi = Get_Builtin_Method(.VECTOR4I, "clampi", 2994578256)
  Vector4i_method_store.snapped = Get_Builtin_Method(.VECTOR4I, "snapped", 1181693102)
  Vector4i_method_store.snappedi = Get_Builtin_Method(.VECTOR4I, "snappedi", 1476494415)
  Vector4i_method_store.min = Get_Builtin_Method(.VECTOR4I, "min", 1181693102)
  Vector4i_method_store.mini = Get_Builtin_Method(.VECTOR4I, "mini", 1476494415)
  Vector4i_method_store.max = Get_Builtin_Method(.VECTOR4I, "max", 1181693102)
  Vector4i_method_store.maxi = Get_Builtin_Method(.VECTOR4I, "maxi", 1476494415)
  Vector4i_method_store.distance_to = Get_Builtin_Method(.VECTOR4I, "distance_to", 3446086573)
  Vector4i_method_store.distance_squared_to = Get_Builtin_Method(.VECTOR4I, "distance_squared_to", 346708794)
  Vector4i_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .FLOAT)
  Vector4i_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .FLOAT)
  Vector4i_method_store.VARIANT_OP_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_NOT_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_LESS_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_LESS_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_GREATER_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_GREATER_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_ADD_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_SUBTRACT_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_DIVIDE_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_MODULE_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4I, .DICTIONARY)
  Vector4i_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4I, .ARRAY)
}
