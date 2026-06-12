package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Int_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Int, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Int,  #by_ptr p_args: struct{ from: ^Int, }),
    Create2: proc "c" (p_base: ^Int,  #by_ptr p_args: struct{ from: ^float, }),
    Create3: proc "c" (p_base: ^Int,  #by_ptr p_args: struct{ from: ^Bool, }),
    Create4: proc "c" (p_base: ^Int,  #by_ptr p_args: struct{ from: ^gdstring, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Int,
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Int, p_right: rawptr = nil,  r_result: ^Int),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Int, p_right: rawptr = nil,  r_result: ^Int),
    VARIANT_OP_BIT_NEGATE_: proc "c" (p_left: ^Int, p_right: rawptr = nil,  r_result: ^Int),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Int, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_AND_Bool: proc "c" (p_left: ^Int, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_OR_Bool: proc "c" (p_left: ^Int, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_XOR_Bool: proc "c" (p_left: ^Int, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_EQUAL_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_LESS_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_GREATER_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_ADD_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_SUBTRACT_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_MODULE_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_POWER_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_SHIFT_LEFT_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_SHIFT_RIGHT_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_BIT_AND_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_BIT_OR_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_BIT_XOR_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Int),
    VARIANT_OP_AND_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_OR_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_XOR_Int: proc "c" (p_left: ^Int, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_EQUAL_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_LESS_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_GREATER_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_ADD_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^float),
    VARIANT_OP_SUBTRACT_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^float),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^float),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^float),
    VARIANT_OP_POWER_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^float),
    VARIANT_OP_AND_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_OR_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_XOR_float: proc "c" (p_left: ^Int, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Vector2: proc "c" (p_left: ^Int, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Vector2i: proc "c" (p_left: ^Int, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^Int, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Vector3i: proc "c" (p_left: ^Int, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_MULTIPLY_Vector4: proc "c" (p_left: ^Int, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_Vector4i: proc "c" (p_left: ^Int, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_MULTIPLY_Quaternion: proc "c" (p_left: ^Int, p_right: ^Quaternion, r_result: ^Quaternion),
    VARIANT_OP_MULTIPLY_Color: proc "c" (p_left: ^Int, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_AND_Object: proc "c" (p_left: ^Int, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_OR_Object: proc "c" (p_left: ^Int, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_XOR_Object: proc "c" (p_left: ^Int, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Int, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Int, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedByteArray: proc "c" (p_left: ^Int, p_right: ^PackedByteArray, r_result: ^Bool),
    VARIANT_OP_IN_PackedInt32Array: proc "c" (p_left: ^Int, p_right: ^PackedInt32Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedInt64Array: proc "c" (p_left: ^Int, p_right: ^PackedInt64Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedFloat32Array: proc "c" (p_left: ^Int, p_right: ^PackedFloat32Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedFloat64Array: proc "c" (p_left: ^Int, p_right: ^PackedFloat64Array, r_result: ^Bool),
}
init_Int_Methods :: proc "c" (Int_method_store: ^Int_Methods_list) {
  Int_method_store.Create0 = cast(type_of(Int_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.INT, 0)
  Int_method_store.Create1 = cast(type_of(Int_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.INT, 1)
  Int_method_store.Create2 = cast(type_of(Int_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.INT, 2)
  Int_method_store.Create3 = cast(type_of(Int_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.INT, 3)
  Int_method_store.Create4 = cast(type_of(Int_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.INT, 4)
    Int_method_store.get_ptr = cast(type_of(Int_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.INT)
  Int_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Int_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .INT, .NIL)
  Int_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Int_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .INT, .NIL)
  Int_method_store.VARIANT_OP_BIT_NEGATE_ = cast(type_of(Int_method_store.VARIANT_OP_BIT_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_NEGATE, .INT, .NIL)
  Int_method_store.VARIANT_OP_NOT_ = cast(type_of(Int_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .INT, .NIL)
  Int_method_store.VARIANT_OP_AND_Bool = cast(type_of(Int_method_store.VARIANT_OP_AND_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .BOOL)
  Int_method_store.VARIANT_OP_OR_Bool = cast(type_of(Int_method_store.VARIANT_OP_OR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .BOOL)
  Int_method_store.VARIANT_OP_XOR_Bool = cast(type_of(Int_method_store.VARIANT_OP_XOR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .BOOL)
  Int_method_store.VARIANT_OP_EQUAL_Int = cast(type_of(Int_method_store.VARIANT_OP_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .INT, .INT)
  Int_method_store.VARIANT_OP_NOT_EQUAL_Int = cast(type_of(Int_method_store.VARIANT_OP_NOT_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .INT, .INT)
  Int_method_store.VARIANT_OP_LESS_Int = cast(type_of(Int_method_store.VARIANT_OP_LESS_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .INT, .INT)
  Int_method_store.VARIANT_OP_LESS_EQUAL_Int = cast(type_of(Int_method_store.VARIANT_OP_LESS_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .INT, .INT)
  Int_method_store.VARIANT_OP_GREATER_Int = cast(type_of(Int_method_store.VARIANT_OP_GREATER_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .INT, .INT)
  Int_method_store.VARIANT_OP_GREATER_EQUAL_Int = cast(type_of(Int_method_store.VARIANT_OP_GREATER_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .INT, .INT)
  Int_method_store.VARIANT_OP_ADD_Int = cast(type_of(Int_method_store.VARIANT_OP_ADD_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .INT, .INT)
  Int_method_store.VARIANT_OP_SUBTRACT_Int = cast(type_of(Int_method_store.VARIANT_OP_SUBTRACT_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .INT, .INT)
  Int_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .INT)
  Int_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Int_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .INT, .INT)
  Int_method_store.VARIANT_OP_MODULE_Int = cast(type_of(Int_method_store.VARIANT_OP_MODULE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .INT, .INT)
  Int_method_store.VARIANT_OP_POWER_Int = cast(type_of(Int_method_store.VARIANT_OP_POWER_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .INT, .INT)
  Int_method_store.VARIANT_OP_SHIFT_LEFT_Int = cast(type_of(Int_method_store.VARIANT_OP_SHIFT_LEFT_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SHIFT_LEFT, .INT, .INT)
  Int_method_store.VARIANT_OP_SHIFT_RIGHT_Int = cast(type_of(Int_method_store.VARIANT_OP_SHIFT_RIGHT_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SHIFT_RIGHT, .INT, .INT)
  Int_method_store.VARIANT_OP_BIT_AND_Int = cast(type_of(Int_method_store.VARIANT_OP_BIT_AND_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_AND, .INT, .INT)
  Int_method_store.VARIANT_OP_BIT_OR_Int = cast(type_of(Int_method_store.VARIANT_OP_BIT_OR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_OR, .INT, .INT)
  Int_method_store.VARIANT_OP_BIT_XOR_Int = cast(type_of(Int_method_store.VARIANT_OP_BIT_XOR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_BIT_XOR, .INT, .INT)
  Int_method_store.VARIANT_OP_AND_Int = cast(type_of(Int_method_store.VARIANT_OP_AND_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .INT)
  Int_method_store.VARIANT_OP_OR_Int = cast(type_of(Int_method_store.VARIANT_OP_OR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .INT)
  Int_method_store.VARIANT_OP_XOR_Int = cast(type_of(Int_method_store.VARIANT_OP_XOR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .INT)
  Int_method_store.VARIANT_OP_EQUAL_float = cast(type_of(Int_method_store.VARIANT_OP_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_NOT_EQUAL_float = cast(type_of(Int_method_store.VARIANT_OP_NOT_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_LESS_float = cast(type_of(Int_method_store.VARIANT_OP_LESS_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_LESS_EQUAL_float = cast(type_of(Int_method_store.VARIANT_OP_LESS_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_GREATER_float = cast(type_of(Int_method_store.VARIANT_OP_GREATER_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_GREATER_EQUAL_float = cast(type_of(Int_method_store.VARIANT_OP_GREATER_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_ADD_float = cast(type_of(Int_method_store.VARIANT_OP_ADD_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_SUBTRACT_float = cast(type_of(Int_method_store.VARIANT_OP_SUBTRACT_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Int_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_POWER_float = cast(type_of(Int_method_store.VARIANT_OP_POWER_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_AND_float = cast(type_of(Int_method_store.VARIANT_OP_AND_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_OR_float = cast(type_of(Int_method_store.VARIANT_OP_OR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_XOR_float = cast(type_of(Int_method_store.VARIANT_OP_XOR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .FLOAT)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector2 = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR2)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector2i = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR2I)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR3)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector3i = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR3I)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector4 = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR4)
  Int_method_store.VARIANT_OP_MULTIPLY_Vector4i = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .VECTOR4I)
  Int_method_store.VARIANT_OP_MULTIPLY_Quaternion = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .QUATERNION)
  Int_method_store.VARIANT_OP_MULTIPLY_Color = cast(type_of(Int_method_store.VARIANT_OP_MULTIPLY_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .INT, .COLOR)
  Int_method_store.VARIANT_OP_AND_Object = cast(type_of(Int_method_store.VARIANT_OP_AND_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .INT, .OBJECT)
  Int_method_store.VARIANT_OP_OR_Object = cast(type_of(Int_method_store.VARIANT_OP_OR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .INT, .OBJECT)
  Int_method_store.VARIANT_OP_XOR_Object = cast(type_of(Int_method_store.VARIANT_OP_XOR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .INT, .OBJECT)
  Int_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Int_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .DICTIONARY)
  Int_method_store.VARIANT_OP_IN_Array = cast(type_of(Int_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .ARRAY)
  Int_method_store.VARIANT_OP_IN_PackedByteArray = cast(type_of(Int_method_store.VARIANT_OP_IN_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_BYTE_ARRAY)
  Int_method_store.VARIANT_OP_IN_PackedInt32Array = cast(type_of(Int_method_store.VARIANT_OP_IN_PackedInt32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_INT32_ARRAY)
  Int_method_store.VARIANT_OP_IN_PackedInt64Array = cast(type_of(Int_method_store.VARIANT_OP_IN_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_INT64_ARRAY)
  Int_method_store.VARIANT_OP_IN_PackedFloat32Array = cast(type_of(Int_method_store.VARIANT_OP_IN_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_FLOAT32_ARRAY)
  Int_method_store.VARIANT_OP_IN_PackedFloat64Array = cast(type_of(Int_method_store.VARIANT_OP_IN_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .INT, .PACKED_FLOAT64_ARRAY)
}
