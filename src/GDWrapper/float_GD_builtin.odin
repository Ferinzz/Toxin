package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


float_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POWER_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SUBTRACT_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_DIVIDE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POWER_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Color: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedFloat64Array: GDE.PtrOperatorEvaluator,
}
init_float_Methods :: proc(float_method_store: ^float_Methods_list) {
  float_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 0)
  float_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 1)
  float_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 2)
  float_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 3)
  float_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 4)
  float_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_AND_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_OR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_XOR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_NOT_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_LESS_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .FLOAT, .INT)
  float_method_store.VARIANT_OP_LESS_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_GREATER_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .FLOAT, .INT)
  float_method_store.VARIANT_OP_GREATER_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_ADD_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .FLOAT, .INT)
  float_method_store.VARIANT_OP_SUBTRACT_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .FLOAT, .INT)
  float_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .INT)
  float_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .FLOAT, .INT)
  float_method_store.VARIANT_OP_POWER_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .FLOAT, .INT)
  float_method_store.VARIANT_OP_AND_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .INT)
  float_method_store.VARIANT_OP_OR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .INT)
  float_method_store.VARIANT_OP_XOR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .INT)
  float_method_store.VARIANT_OP_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_NOT_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_LESS_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_LESS_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_GREATER_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_GREATER_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_ADD_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_SUBTRACT_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_POWER_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_AND_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_OR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_XOR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_MULTIPLY_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR2)
  float_method_store.VARIANT_OP_MULTIPLY_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR2I)
  float_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR3)
  float_method_store.VARIANT_OP_MULTIPLY_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR3I)
  float_method_store.VARIANT_OP_MULTIPLY_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR4)
  float_method_store.VARIANT_OP_MULTIPLY_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR4I)
  float_method_store.VARIANT_OP_MULTIPLY_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .QUATERNION)
  float_method_store.VARIANT_OP_MULTIPLY_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .COLOR)
  float_method_store.VARIANT_OP_AND_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_OR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_XOR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .DICTIONARY)
  float_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .ARRAY)
  float_method_store.VARIANT_OP_IN_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_BYTE_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_INT32_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_INT64_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_FLOAT32_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_FLOAT64_ARRAY)
}
