package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


int_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  VARIANT_OP_NEGATE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POSITIVE_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_BIT_NEGATE_: GDE.PtrOperatorEvaluator,
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
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_POWER_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SHIFT_LEFT_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_SHIFT_RIGHT_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_BIT_AND_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_BIT_OR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_BIT_XOR_int: GDE.PtrOperatorEvaluator,
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
init_int_Methods :: proc(int_method_store: ^int_Methods_list) {
  int_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.INT, 0)
  int_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.INT, 1)
  int_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.INT, 2)
  int_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.INT, 3)
  int_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.INT, 4)
  int_method_store.VARIANT_OP_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .INT, .NIL)
  int_method_store.VARIANT_OP_POSITIVE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .INT, .NIL)
  int_method_store.VARIANT_OP_BIT_NEGATE_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_NEGATE, .INT, .NIL)
  int_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .INT, .NIL)
  int_method_store.VARIANT_OP_AND_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .BOOL)
  int_method_store.VARIANT_OP_OR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .BOOL)
  int_method_store.VARIANT_OP_XOR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .BOOL)
  int_method_store.VARIANT_OP_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .INT, .INT)
  int_method_store.VARIANT_OP_NOT_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .INT, .INT)
  int_method_store.VARIANT_OP_LESS_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .INT, .INT)
  int_method_store.VARIANT_OP_LESS_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .INT, .INT)
  int_method_store.VARIANT_OP_GREATER_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .INT, .INT)
  int_method_store.VARIANT_OP_GREATER_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .INT, .INT)
  int_method_store.VARIANT_OP_ADD_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .INT, .INT)
  int_method_store.VARIANT_OP_SUBTRACT_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .INT, .INT)
  int_method_store.VARIANT_OP_MULTIPLY_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .INT)
  int_method_store.VARIANT_OP_DIVIDE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .INT, .INT)
  int_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .INT, .INT)
  int_method_store.VARIANT_OP_POWER_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .INT, .INT)
  int_method_store.VARIANT_OP_SHIFT_LEFT_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SHIFT_LEFT, .INT, .INT)
  int_method_store.VARIANT_OP_SHIFT_RIGHT_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SHIFT_RIGHT, .INT, .INT)
  int_method_store.VARIANT_OP_BIT_AND_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_AND, .INT, .INT)
  int_method_store.VARIANT_OP_BIT_OR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_OR, .INT, .INT)
  int_method_store.VARIANT_OP_BIT_XOR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_XOR, .INT, .INT)
  int_method_store.VARIANT_OP_AND_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .INT)
  int_method_store.VARIANT_OP_OR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .INT)
  int_method_store.VARIANT_OP_XOR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .INT)
  int_method_store.VARIANT_OP_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .INT, .FLOAT)
  int_method_store.VARIANT_OP_NOT_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .INT, .FLOAT)
  int_method_store.VARIANT_OP_LESS_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .INT, .FLOAT)
  int_method_store.VARIANT_OP_LESS_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .INT, .FLOAT)
  int_method_store.VARIANT_OP_GREATER_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .INT, .FLOAT)
  int_method_store.VARIANT_OP_GREATER_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .INT, .FLOAT)
  int_method_store.VARIANT_OP_ADD_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .INT, .FLOAT)
  int_method_store.VARIANT_OP_SUBTRACT_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .INT, .FLOAT)
  int_method_store.VARIANT_OP_MULTIPLY_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .FLOAT)
  int_method_store.VARIANT_OP_DIVIDE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .INT, .FLOAT)
  int_method_store.VARIANT_OP_POWER_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .INT, .FLOAT)
  int_method_store.VARIANT_OP_AND_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .FLOAT)
  int_method_store.VARIANT_OP_OR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .FLOAT)
  int_method_store.VARIANT_OP_XOR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .FLOAT)
  int_method_store.VARIANT_OP_MULTIPLY_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR2)
  int_method_store.VARIANT_OP_MULTIPLY_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR2I)
  int_method_store.VARIANT_OP_MULTIPLY_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR3)
  int_method_store.VARIANT_OP_MULTIPLY_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR3I)
  int_method_store.VARIANT_OP_MULTIPLY_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR4)
  int_method_store.VARIANT_OP_MULTIPLY_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR4I)
  int_method_store.VARIANT_OP_MULTIPLY_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .QUATERNION)
  int_method_store.VARIANT_OP_MULTIPLY_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .COLOR)
  int_method_store.VARIANT_OP_AND_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .OBJECT)
  int_method_store.VARIANT_OP_OR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .OBJECT)
  int_method_store.VARIANT_OP_XOR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .OBJECT)
  int_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .DICTIONARY)
  int_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .ARRAY)
  int_method_store.VARIANT_OP_IN_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_BYTE_ARRAY)
  int_method_store.VARIANT_OP_IN_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_INT32_ARRAY)
  int_method_store.VARIANT_OP_IN_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_INT64_ARRAY)
  int_method_store.VARIANT_OP_IN_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_FLOAT32_ARRAY)
  int_method_store.VARIANT_OP_IN_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_FLOAT64_ARRAY)
}
