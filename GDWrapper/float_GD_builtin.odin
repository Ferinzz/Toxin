package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


float_Methods_list :: struct {
    Create0: proc "c" (p_base: ^float, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^float,  #by_ptr p_args: struct{ from: ^float, }),
    Create2: proc "c" (p_base: ^float,  #by_ptr p_args: struct{ from: ^Int, }),
    Create3: proc "c" (p_base: ^float,  #by_ptr p_args: struct{ from: ^Bool, }),
    Create4: proc "c" (p_base: ^float,  #by_ptr p_args: struct{ from: ^gdstring, }),
    get_ptr: proc "c" (base: ^Variant) -> ^float,
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^float, p_right: rawptr = nil,  r_result: ^float),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^float, p_right: rawptr = nil,  r_result: ^float),
    VARIANT_OP_NOT_: proc "c" (p_left: ^float, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_AND_Bool: proc "c" (p_left: ^float, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_OR_Bool: proc "c" (p_left: ^float, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_XOR_Bool: proc "c" (p_left: ^float, p_right: ^Bool, r_result: ^Bool),
    VARIANT_OP_EQUAL_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_LESS_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_GREATER_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_ADD_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^float),
    VARIANT_OP_SUBTRACT_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^float),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^float),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^float),
    VARIANT_OP_POWER_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^float),
    VARIANT_OP_AND_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_OR_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_XOR_Int: proc "c" (p_left: ^float, p_right: ^Int, r_result: ^Bool),
    VARIANT_OP_EQUAL_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_LESS_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_GREATER_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_ADD_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^float),
    VARIANT_OP_SUBTRACT_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^float),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^float),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^float),
    VARIANT_OP_POWER_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^float),
    VARIANT_OP_AND_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_OR_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_XOR_float: proc "c" (p_left: ^float, p_right: ^float, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Vector2: proc "c" (p_left: ^float, p_right: ^Vector2, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Vector2i: proc "c" (p_left: ^float, p_right: ^Vector2i, r_result: ^Vector2),
    VARIANT_OP_MULTIPLY_Vector3: proc "c" (p_left: ^float, p_right: ^Vector3, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Vector3i: proc "c" (p_left: ^float, p_right: ^Vector3i, r_result: ^Vector3),
    VARIANT_OP_MULTIPLY_Vector4: proc "c" (p_left: ^float, p_right: ^Vector4, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_Vector4i: proc "c" (p_left: ^float, p_right: ^Vector4i, r_result: ^Vector4),
    VARIANT_OP_MULTIPLY_Quaternion: proc "c" (p_left: ^float, p_right: ^Quaternion, r_result: ^Quaternion),
    VARIANT_OP_MULTIPLY_Color: proc "c" (p_left: ^float, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_AND_Object: proc "c" (p_left: ^float, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_OR_Object: proc "c" (p_left: ^float, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_XOR_Object: proc "c" (p_left: ^float, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^float, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^float, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedByteArray: proc "c" (p_left: ^float, p_right: ^PackedByteArray, r_result: ^Bool),
    VARIANT_OP_IN_PackedInt32Array: proc "c" (p_left: ^float, p_right: ^PackedInt32Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedInt64Array: proc "c" (p_left: ^float, p_right: ^PackedInt64Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedFloat32Array: proc "c" (p_left: ^float, p_right: ^PackedFloat32Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedFloat64Array: proc "c" (p_left: ^float, p_right: ^PackedFloat64Array, r_result: ^Bool),
}
init_float_Methods :: proc(float_method_store: ^float_Methods_list) {
  float_method_store.Create0 = cast(type_of(float_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 0)
  float_method_store.Create1 = cast(type_of(float_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 1)
  float_method_store.Create2 = cast(type_of(float_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 2)
  float_method_store.Create3 = cast(type_of(float_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 3)
  float_method_store.Create4 = cast(type_of(float_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 4)
    float_method_store.get_ptr = cast(type_of(float_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.FLOAT)
  float_method_store.VARIANT_OP_NEGATE_ = cast(type_of(float_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(float_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_NOT_ = cast(type_of(float_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .FLOAT, .NIL)
  float_method_store.VARIANT_OP_AND_Bool = cast(type_of(float_method_store.VARIANT_OP_AND_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_OR_Bool = cast(type_of(float_method_store.VARIANT_OP_OR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_XOR_Bool = cast(type_of(float_method_store.VARIANT_OP_XOR_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .BOOL)
  float_method_store.VARIANT_OP_EQUAL_Int = cast(type_of(float_method_store.VARIANT_OP_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_NOT_EQUAL_Int = cast(type_of(float_method_store.VARIANT_OP_NOT_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_LESS_Int = cast(type_of(float_method_store.VARIANT_OP_LESS_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .FLOAT, .INT)
  float_method_store.VARIANT_OP_LESS_EQUAL_Int = cast(type_of(float_method_store.VARIANT_OP_LESS_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_GREATER_Int = cast(type_of(float_method_store.VARIANT_OP_GREATER_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .FLOAT, .INT)
  float_method_store.VARIANT_OP_GREATER_EQUAL_Int = cast(type_of(float_method_store.VARIANT_OP_GREATER_EQUAL_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .FLOAT, .INT)
  float_method_store.VARIANT_OP_ADD_Int = cast(type_of(float_method_store.VARIANT_OP_ADD_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .FLOAT, .INT)
  float_method_store.VARIANT_OP_SUBTRACT_Int = cast(type_of(float_method_store.VARIANT_OP_SUBTRACT_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .FLOAT, .INT)
  float_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .INT)
  float_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(float_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .FLOAT, .INT)
  float_method_store.VARIANT_OP_POWER_Int = cast(type_of(float_method_store.VARIANT_OP_POWER_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .FLOAT, .INT)
  float_method_store.VARIANT_OP_AND_Int = cast(type_of(float_method_store.VARIANT_OP_AND_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .INT)
  float_method_store.VARIANT_OP_OR_Int = cast(type_of(float_method_store.VARIANT_OP_OR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .INT)
  float_method_store.VARIANT_OP_XOR_Int = cast(type_of(float_method_store.VARIANT_OP_XOR_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .INT)
  float_method_store.VARIANT_OP_EQUAL_float = cast(type_of(float_method_store.VARIANT_OP_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_NOT_EQUAL_float = cast(type_of(float_method_store.VARIANT_OP_NOT_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_LESS_float = cast(type_of(float_method_store.VARIANT_OP_LESS_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_LESS_EQUAL_float = cast(type_of(float_method_store.VARIANT_OP_LESS_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_GREATER_float = cast(type_of(float_method_store.VARIANT_OP_GREATER_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_GREATER_EQUAL_float = cast(type_of(float_method_store.VARIANT_OP_GREATER_EQUAL_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_ADD_float = cast(type_of(float_method_store.VARIANT_OP_ADD_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_SUBTRACT_float = cast(type_of(float_method_store.VARIANT_OP_SUBTRACT_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(float_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_POWER_float = cast(type_of(float_method_store.VARIANT_OP_POWER_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POWER, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_AND_float = cast(type_of(float_method_store.VARIANT_OP_AND_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_OR_float = cast(type_of(float_method_store.VARIANT_OP_OR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_XOR_float = cast(type_of(float_method_store.VARIANT_OP_XOR_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .FLOAT)
  float_method_store.VARIANT_OP_MULTIPLY_Vector2 = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR2)
  float_method_store.VARIANT_OP_MULTIPLY_Vector2i = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR2I)
  float_method_store.VARIANT_OP_MULTIPLY_Vector3 = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR3)
  float_method_store.VARIANT_OP_MULTIPLY_Vector3i = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR3I)
  float_method_store.VARIANT_OP_MULTIPLY_Vector4 = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR4)
  float_method_store.VARIANT_OP_MULTIPLY_Vector4i = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .VECTOR4I)
  float_method_store.VARIANT_OP_MULTIPLY_Quaternion = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .QUATERNION)
  float_method_store.VARIANT_OP_MULTIPLY_Color = cast(type_of(float_method_store.VARIANT_OP_MULTIPLY_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .FLOAT, .COLOR)
  float_method_store.VARIANT_OP_AND_Object = cast(type_of(float_method_store.VARIANT_OP_AND_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_OR_Object = cast(type_of(float_method_store.VARIANT_OP_OR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_XOR_Object = cast(type_of(float_method_store.VARIANT_OP_XOR_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .FLOAT, .OBJECT)
  float_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(float_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .DICTIONARY)
  float_method_store.VARIANT_OP_IN_Array = cast(type_of(float_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .ARRAY)
  float_method_store.VARIANT_OP_IN_PackedByteArray = cast(type_of(float_method_store.VARIANT_OP_IN_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_BYTE_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedInt32Array = cast(type_of(float_method_store.VARIANT_OP_IN_PackedInt32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_INT32_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedInt64Array = cast(type_of(float_method_store.VARIANT_OP_IN_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_INT64_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedFloat32Array = cast(type_of(float_method_store.VARIANT_OP_IN_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_FLOAT32_ARRAY)
  float_method_store.VARIANT_OP_IN_PackedFloat64Array = cast(type_of(float_method_store.VARIANT_OP_IN_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .FLOAT, .PACKED_FLOAT64_ARRAY)
}
