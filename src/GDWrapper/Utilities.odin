package GDWrapper

@(export)
Init_Builtins :: proc "c" () {

init_StringName_Methods(&StringName_M_List) //MUST be first in order to destroy the StringNames which will be created for retrieving MethodBind
init_Bool_Methods(&Bool_M_List)
init_Int_Methods(&Int_M_List)
init_float_Methods(&float_M_List)
init_Vector2_Methods(&Vector2_M_List)
init_Vector2i_Methods(&Vector2i_M_List)
init_Rect2_Methods(&Rect2_M_List)
init_Rect2i_Methods(&Rect2i_M_List)
init_Vector3_Methods(&Vector3_M_List)
init_Vector3i_Methods(&Vector3i_M_List)
init_Vector4_Methods(&Vector4_M_List)
init_Vector4i_Methods(&Vector4i_M_List)
init_Plane_Methods(&Plane_M_List)
init_Color_Methods(&Color_M_List)
init_Quaternion_Methods(&Quaternion_M_List)
init_gdstring_Methods(&gdstring_M_List)
init_NodePath_Methods(&NodePath_M_List)
init_RID_Methods(&RID_M_List)
init_Callable_Methods(&Callable_M_List)
init_Signal_Methods(&Signal_M_List)
init_Dictionary_Methods(&Dictionary_M_List)
init_Transform2D_Methods(&Transform2D_M_List)
init_AABB_Methods(&AABB_M_List)
init_Basis_Methods(&Basis_M_List)
init_Transform3D_Methods(&Transform3D_M_List)
init_Projection_Methods(&Projection_M_List)
init_Array_Methods(&Array_M_List)
init_PackedByteArray_Methods(&PackedByteArray_M_List)
init_PackedInt32Array_Methods(&PackedInt32Array_M_List)
init_PackedInt64Array_Methods(&PackedInt64Array_M_List)
init_PackedFloat32Array_Methods(&PackedFloat32Array_M_List)
init_PackedFloat64Array_Methods(&PackedFloat64Array_M_List)
init_PackedStringArray_Methods(&PackedStringArray_M_List)
init_PackedVector2Array_Methods(&PackedVector2Array_M_List)
init_PackedVector3Array_Methods(&PackedVector3Array_M_List)
init_PackedColorArray_Methods(&PackedColorArray_M_List)
init_PackedVector4Array_Methods(&PackedVector4Array_M_List)
}

@(export)
StringName_M_List: StringName_Methods_list //StringName utilities will use this specific Method List. Make sure this is initialized before doing anything yourself.
@(export)
Bool_M_List: Bool_Methods_list
@(export)
Int_M_List: Int_Methods_list
@(export)
float_M_List: float_Methods_list
@(export)
Vector2_M_List: Vector2_Methods_list
@(export)
Vector2i_M_List: Vector2i_Methods_list
@(export)
Rect2_M_List: Rect2_Methods_list
@(export)
Rect2i_M_List: Rect2i_Methods_list
@(export)
Vector3_M_List: Vector3_Methods_list
@(export)
Vector3i_M_List: Vector3i_Methods_list
@(export)
Vector4_M_List: Vector4_Methods_list
@(export)
Vector4i_M_List: Vector4i_Methods_list
@(export)
Plane_M_List: Plane_Methods_list
@(export)
Color_M_List: Color_Methods_list
@(export)
Quaternion_M_List: Quaternion_Methods_list
@(export)
gdstring_M_List: gdstring_Methods_list
@(export)
NodePath_M_List: NodePath_Methods_list
@(export)
RID_M_List: RID_Methods_list
@(export)
Callable_M_List: Callable_Methods_list
@(export)
Signal_M_List: Signal_Methods_list
@(export)
Dictionary_M_List: Dictionary_Methods_list
@(export)
Transform2D_M_List: Transform2D_Methods_list
@(export)
AABB_M_List: AABB_Methods_list
@(export)
Basis_M_List: Basis_Methods_list
@(export)
Transform3D_M_List: Transform3D_Methods_list
@(export)
Projection_M_List: Projection_Methods_list
@(export)
Array_M_List: Array_Methods_list
@(export)
PackedByteArray_M_List: PackedByteArray_Methods_list
@(export)
PackedInt32Array_M_List: PackedInt32Array_Methods_list
@(export)
PackedInt64Array_M_List: PackedInt64Array_Methods_list
@(export)
PackedFloat32Array_M_List: PackedFloat32Array_Methods_list
@(export)
PackedFloat64Array_M_List: PackedFloat64Array_Methods_list
@(export)
PackedStringArray_M_List: PackedStringArray_Methods_list
@(export)
PackedVector2Array_M_List: PackedVector2Array_Methods_list
@(export)
PackedVector3Array_M_List: PackedVector3Array_Methods_list
@(export)
PackedColorArray_M_List: PackedColorArray_Methods_list
@(export)
PackedVector4Array_M_List: PackedVector4Array_Methods_list