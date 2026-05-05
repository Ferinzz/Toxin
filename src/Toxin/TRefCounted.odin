package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"


RefCounted_Methods_list: Classes.RefCounted_MethodBind_List
Reference :: proc(ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.reference.m_call, ref, nil, r_bool)
}

Unreference :: proc(ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.unreference.m_call, ref, nil, r_bool)
}

Reference_init :: proc(ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.init_ref.m_call, ref, nil, r_bool)
}

Ref_Count :: proc {
    Reference,
    ref_count_AABB,
    ref_count_BASIS,
    ref_count_TRANSFORM2D,
    ref_count_TRANSFORM3D,
    ref_count_PROJECTION,
    ref_count_STRING,
    ref_count_STRING_NAME,
    ref_count_NODE_PATH,
    ref_count_SIGNAL,
    ref_count_CALLABLE,
    ref_count_DICTIONARY,
    ref_count_ARRAY,
    ref_count_PACKED_BYTE_ARRAY,
    ref_count_PACKED_INT32_ARRAY,
    ref_count_PACKED_INT64_ARRAY,
    ref_count_PACKED_FLOAT32_ARRAY,
    ref_count_PACKED_FLOAT64_ARRAY,
    ref_count_PACKED_STRING_ARRAY,
    ref_count_PACKED_VECTOR2_ARRAY,
    ref_count_PACKED_VECTOR3_ARRAY,
    ref_count_PACKED_COLOR_ARRAY,
    ref_count_PACKED_VECTOR4_ARRAY,
}

ref_count_AABB :: proc(source: ^AABB, copy: ^AABB) {
    GDW.AABB_M_List.Create1(copy, {source})
}
ref_count_BASIS :: proc(source: ^Basis, copy: ^Basis) {
    GDW.Basis_M_List.Create1(copy, {source})
}
ref_count_TRANSFORM2D :: proc(source: ^Transform2D, copy: ^Transform2D) {
    GDW.Transform2D_M_List.Create1(copy, {source})
}
ref_count_TRANSFORM3D :: proc(source: ^Transform3D, copy: ^Transform3D) {
    GDW.Transform3D_M_List.Create1(copy, {source})
}
ref_count_PROJECTION :: proc(source: ^Projection, copy: ^Projection) {
    GDW.Projection_M_List.Create1(copy, {source})
}
ref_count_STRING :: proc(source: ^gdstring, copy: ^gdstring) {
    GDW.gdstring_M_List.Create1(copy, {source})
}
ref_count_STRING_NAME :: proc(source: ^StringName, copy: ^StringName) {
    GDW.StringName_M_List.Create1(copy, {source})
}
ref_count_NODE_PATH :: proc(source: ^NodePath, copy: ^NodePath) {
    GDW.NodePath_M_List.Create1(copy, {source})
}
ref_count_SIGNAL :: proc(source: ^Signal, copy: ^Signal) {
    GDW.Signal_M_List.Create1(copy, {source})
}
ref_count_CALLABLE :: proc(source: ^Callable, copy: ^Callable) {
    GDW.Callable_M_List.Create1(copy, {source})
}
ref_count_DICTIONARY :: proc(source: ^Dictionary, copy: ^Dictionary) {
    GDW.Dictionary_M_List.Create1(copy, {source})
}
ref_count_ARRAY :: proc "c" (source: ^Array, copy: ^Array) {
    GDW.Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_BYTE_ARRAY :: proc(source: ^PackedByteArray, copy: ^PackedByteArray) {
    GDW.PackedByteArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT32_ARRAY :: proc "c" (source: ^PackedInt32Array, copy: ^PackedInt32Array) {
    GDW.PackedInt32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT64_ARRAY :: proc(source: ^PackedInt64Array, copy: ^PackedInt64Array) {
    GDW.PackedInt64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT32_ARRAY :: proc(source: ^PackedFloat32Array, copy: ^PackedFloat32Array) {
    GDW.PackedFloat32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT64_ARRAY :: proc(source: ^PackedFloat64Array, copy: ^PackedFloat64Array) {
    GDW.PackedFloat64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_STRING_ARRAY :: proc(source: ^PackedStringArray, copy: ^PackedStringArray) {
    GDW.PackedStringArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR2_ARRAY :: proc(source: ^PackedVector2Array, copy: ^PackedVector2Array) {
    GDW.PackedVector2Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR3_ARRAY :: proc(source: ^PackedVector3Array, copy: ^PackedVector3Array) {
    GDW.PackedVector3Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_COLOR_ARRAY :: proc(source: ^PackedColorArray, copy: ^PackedColorArray) {
    GDW.PackedColorArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR4_ARRAY :: proc(source: ^PackedVector4Array, copy: ^PackedVector4Array) {
    GDW.PackedVector4Array_M_List.Create1(copy, {source})
}
