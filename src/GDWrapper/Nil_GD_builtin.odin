package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Nil_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Rect2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Rect2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Plane: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Plane: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Projection: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Projection: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Color: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Color: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_NodePath: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_NodePath: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_AND_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_OR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_XOR_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Callable: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Callable: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Signal: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Signal: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedFloat64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedFloat64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedVector2Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector2Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedVector3Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector3Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedColorArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedColorArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedVector4Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedVector4Array: GDE.PtrOperatorEvaluator,
}
init_Nil_Methods :: proc(Nil_method_store: ^Nil_Methods_list) {
  Nil_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 0)
  Nil_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.NIL, 1)
  Nil_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .NIL, .NIL)
  Nil_method_store.VARIANT_OP_EQUAL_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .BOOL)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .BOOL)
  Nil_method_store.VARIANT_OP_AND_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .BOOL)
  Nil_method_store.VARIANT_OP_OR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .BOOL)
  Nil_method_store.VARIANT_OP_XOR_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .BOOL)
  Nil_method_store.VARIANT_OP_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .INT)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .INT)
  Nil_method_store.VARIANT_OP_AND_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .INT)
  Nil_method_store.VARIANT_OP_OR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .INT)
  Nil_method_store.VARIANT_OP_XOR_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .INT)
  Nil_method_store.VARIANT_OP_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .FLOAT)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .FLOAT)
  Nil_method_store.VARIANT_OP_AND_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .FLOAT)
  Nil_method_store.VARIANT_OP_OR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .FLOAT)
  Nil_method_store.VARIANT_OP_XOR_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .FLOAT)
  Nil_method_store.VARIANT_OP_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .STRING)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .STRING)
  Nil_method_store.VARIANT_OP_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR2)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR2)
  Nil_method_store.VARIANT_OP_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR2I)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR2I)
  Nil_method_store.VARIANT_OP_EQUAL_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .RECT2)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .RECT2)
  Nil_method_store.VARIANT_OP_EQUAL_Rect2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .RECT2I)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Rect2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .RECT2I)
  Nil_method_store.VARIANT_OP_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR3)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR3)
  Nil_method_store.VARIANT_OP_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR3I)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR3I)
  Nil_method_store.VARIANT_OP_EQUAL_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .TRANSFORM2D)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .TRANSFORM2D)
  Nil_method_store.VARIANT_OP_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR4)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR4)
  Nil_method_store.VARIANT_OP_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .VECTOR4I)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .VECTOR4I)
  Nil_method_store.VARIANT_OP_EQUAL_Plane = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PLANE)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Plane = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PLANE)
  Nil_method_store.VARIANT_OP_EQUAL_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .QUATERNION)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .QUATERNION)
  Nil_method_store.VARIANT_OP_EQUAL_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .AABB)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .AABB)
  Nil_method_store.VARIANT_OP_EQUAL_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .BASIS)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .BASIS)
  Nil_method_store.VARIANT_OP_EQUAL_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .TRANSFORM3D)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .TRANSFORM3D)
  Nil_method_store.VARIANT_OP_EQUAL_Projection = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PROJECTION)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Projection = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PROJECTION)
  Nil_method_store.VARIANT_OP_EQUAL_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .COLOR)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .COLOR)
  Nil_method_store.VARIANT_OP_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .STRING_NAME)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .STRING_NAME)
  Nil_method_store.VARIANT_OP_EQUAL_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .NODE_PATH)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .NODE_PATH)
  Nil_method_store.VARIANT_OP_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .RID)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .RID)
  Nil_method_store.VARIANT_OP_EQUAL_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .OBJECT)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .OBJECT)
  Nil_method_store.VARIANT_OP_AND_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_AND, .NIL, .OBJECT)
  Nil_method_store.VARIANT_OP_OR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_OR, .NIL, .OBJECT)
  Nil_method_store.VARIANT_OP_XOR_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_XOR, .NIL, .OBJECT)
  Nil_method_store.VARIANT_OP_EQUAL_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .CALLABLE)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .CALLABLE)
  Nil_method_store.VARIANT_OP_EQUAL_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .SIGNAL)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .SIGNAL)
  Nil_method_store.VARIANT_OP_EQUAL_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .DICTIONARY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .DICTIONARY)
  Nil_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NIL, .DICTIONARY)
  Nil_method_store.VARIANT_OP_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .ARRAY)
  Nil_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NIL, .ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_BYTE_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_BYTE_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_INT32_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_INT32_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_INT64_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_INT64_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_FLOAT32_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_FLOAT32_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_FLOAT64_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_FLOAT64_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_STRING_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_STRING_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_VECTOR2_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_VECTOR2_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_VECTOR3_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_VECTOR3_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_COLOR_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_COLOR_ARRAY)
  Nil_method_store.VARIANT_OP_EQUAL_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NIL, .PACKED_VECTOR4_ARRAY)
  Nil_method_store.VARIANT_OP_NOT_EQUAL_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NIL, .PACKED_VECTOR4_ARRAY)
}
