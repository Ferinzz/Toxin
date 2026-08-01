package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"
import "base:builtin"
import "base:runtime"


RefTag: GDE.ClassTag

safeRef_Error :: enum u8 {
    NONE,
    FAILED_TO_REF,
    NOT_REF_COUNTED_OBJECT,
    NIL_OBJECT,
}


/*
* Godot will verify if the object needs to be ref counted and return false if it does not need to be ref counted.
* Godot can pass an Object containing a nil obj.proxy, particularly when the editor calls set. Need to verify that this is correct.
*/
safeRef_Object :: proc "c" (obj: ^Object) -> safeRef_Error {
    if obj == nil || obj.proxy == nil {
        return .NIL_OBJECT
    }
    b:Bool
    Ref_Count(obj, &b)
    return safeRef_Error(!b)
}

//Returns true if the increment was successful, false otherwise.
Reference :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    Classes.RefCounted_reference->m_call(ref, nil, r_bool)
}

//Returns true if the increment was successful, false otherwise.
Unreference :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    Classes.RefCounted_unreference->m_call(ref, nil, r_bool)
}

Reference_init :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    Classes.RefCounted_init_ref->m_call(ref, nil, r_bool)
}

Ref_Count :: proc {
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
    Reference,
    safeRef_Object,
    ref_count_AABB_r,
    ref_count_BASIS_r,
    ref_count_TRANSFORM2D_r,
    ref_count_TRANSFORM3D_r,
    ref_count_PROJECTION_r,
    ref_count_STRING_r,
    ref_count_STRING_NAME_r,
    ref_count_NODE_PATH_r,
    ref_count_SIGNAL_r,
    ref_count_CALLABLE_r,
    ref_count_DICTIONARY_r,
    ref_count_ARRAY_r,
    ref_count_PACKED_BYTE_ARRAY_r,
    ref_count_PACKED_INT32_ARRAY_r,
    ref_count_PACKED_INT64_ARRAY_r,
    ref_count_PACKED_FLOAT32_ARRAY_r,
    ref_count_PACKED_FLOAT64_ARRAY_r,
    ref_count_PACKED_STRING_ARRAY_r,
    ref_count_PACKED_VECTOR2_ARRAY_r,
    ref_count_PACKED_VECTOR3_ARRAY_r,
    ref_count_PACKED_COLOR_ARRAY_r,
    ref_count_PACKED_VECTOR4_ARRAY_r,
}

ref_count_AABB :: proc "c" (source: ^AABB, copy: ^AABB) {
    GDW.AABB_M_List.Create1(copy, {source})
}
ref_count_BASIS :: proc "c" (source: ^Basis, copy: ^Basis) {
    GDW.Basis_M_List.Create1(copy, {source})
}
ref_count_TRANSFORM2D :: proc "c" (source: ^Transform2D, copy: ^Transform2D) {
    GDW.Transform2D_M_List.Create1(copy, {source})
}
ref_count_TRANSFORM3D :: proc "c" (source: ^Transform3D, copy: ^Transform3D) {
    GDW.Transform3D_M_List.Create1(copy, {source})
}
ref_count_PROJECTION :: proc "c" (source: ^Projection, copy: ^Projection) {
    GDW.Projection_M_List.Create1(copy, {source})
}
ref_count_STRING :: proc "c" (source: ^gdstring, copy: ^gdstring) {
    Destroy(copy)
    GDW.gdstring_M_List.Create1(copy, {source})
}
ref_count_STRING_NAME :: proc "c" (source: ^StringName, copy: ^StringName) {
    Destroy(copy)
    GDW.StringName_M_List.Create1(copy, {source})
}
ref_count_NODE_PATH :: proc "c" (source: ^NodePath, copy: ^NodePath) {
    Destroy(copy)
    GDW.NodePath_M_List.Create1(copy, {source})
}
ref_count_SIGNAL :: proc "c" (source: ^Signal, copy: ^Signal) {
    Destroy(copy)
    GDW.Signal_M_List.Create1(copy, {source})
}
ref_count_CALLABLE :: proc "c" (source: ^Callable, copy: ^Callable) {
    Destroy(copy)
    GDW.Callable_M_List.Create1(copy, {source})
}
ref_count_DICTIONARY :: proc "c" (source: ^Dictionary, copy: ^Dictionary) {
    Destroy(copy)
    GDW.Dictionary_M_List.Create1(copy, {source})
}
//Array ref is deprecated but it ensures that if destination is already initialized it will clear it.
ref_count_ARRAY :: proc "c" (source: ^Array, copy: ^Array) {
    gdAPI.Packed_Array_Utils.ArrayRef(copy, source)
}
ref_count_PACKED_BYTE_ARRAY :: proc "c" (source: ^PackedByteArray, copy: ^PackedByteArray) {
    Destroy(copy)
    GDW.PackedByteArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT32_ARRAY :: proc "c" (source: ^PackedInt32Array, copy: ^PackedInt32Array) {
    Destroy(copy)
    GDW.PackedInt32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT64_ARRAY :: proc "c" (source: ^PackedInt64Array, copy: ^PackedInt64Array) {
    Destroy(copy)
    GDW.PackedInt64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT32_ARRAY :: proc "c" (source: ^PackedFloat32Array, copy: ^PackedFloat32Array) {
    Destroy(copy)
    GDW.PackedFloat32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT64_ARRAY :: proc "c" (source: ^PackedFloat64Array, copy: ^PackedFloat64Array) {
    Destroy(copy)
    GDW.PackedFloat64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_STRING_ARRAY :: proc "c" (source: ^PackedStringArray, copy: ^PackedStringArray) {
    Destroy(copy)
    GDW.PackedStringArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR2_ARRAY :: proc "c" (source: ^PackedVector2Array, copy: ^PackedVector2Array) {
    Destroy(copy)
    GDW.PackedVector2Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR3_ARRAY :: proc "c" (source: ^PackedVector3Array, copy: ^PackedVector3Array) {
    Destroy(copy)
    GDW.PackedVector3Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_COLOR_ARRAY :: proc "c" (source: ^PackedColorArray, copy: ^PackedColorArray) {
    Destroy(copy)
    GDW.PackedColorArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR4_ARRAY :: proc "c" (source: ^PackedVector4Array, copy: ^PackedVector4Array) {
    Destroy(copy)
    GDW.PackedVector4Array_M_List.Create1(copy, {source})
}


ref_count_AABB_r :: proc "c" (source: ^AABB) -> (copy: AABB) {
    GDW.AABB_M_List.Create1(&copy, {source})
    return
}
ref_count_BASIS_r :: proc "c" (source: ^Basis) -> (copy: Basis) {
    GDW.Basis_M_List.Create1(&copy, {source})
    return
}
ref_count_TRANSFORM2D_r :: proc "c" (source: ^Transform2D) -> (copy: Transform2D) {
    GDW.Transform2D_M_List.Create1(&copy, {source})
    return
}
ref_count_TRANSFORM3D_r :: proc "c" (source: ^Transform3D) -> (copy: Transform3D) {
    GDW.Transform3D_M_List.Create1(&copy, {source})
    return
}
ref_count_PROJECTION_r :: proc "c" (source: ^Projection) -> (copy: Projection) {
    GDW.Projection_M_List.Create1(&copy, {source})
    return
}
ref_count_STRING_r :: proc "c" (source: ^gdstring) -> (copy: gdstring) {
    GDW.gdstring_M_List.Create1(&copy, {source})
    return
}
ref_count_STRING_NAME_r :: proc "c" (source: ^StringName) -> (copy: StringName) {
    GDW.StringName_M_List.Create1(&copy, {source})
    return
}
ref_count_NODE_PATH_r :: proc "c" (source: ^NodePath) -> (copy: NodePath) {
    GDW.NodePath_M_List.Create1(&copy, {source})
    return
}
ref_count_SIGNAL_r :: proc "c" (source: ^Signal) -> (copy: Signal) {
    GDW.Signal_M_List.Create1(&copy, {source})
    return
}
ref_count_CALLABLE_r :: proc "c" (source: ^Callable) -> (copy: Callable) {
    GDW.Callable_M_List.Create1(&copy, {source})
    return
}
ref_count_DICTIONARY_r :: proc "c" (source: ^Dictionary) -> (copy: Dictionary) {
    GDW.Dictionary_M_List.Create1(&copy, {source})
    return
}
//Array ref is deprecated but it ensures that if destination is already initialized it will clear it.
ref_count_ARRAY_r :: proc "c" (source: ^Array) -> (copy: Array) {
    gdAPI.Packed_Array_Utils.ArrayRef(&copy, source)
    return
}
ref_count_PACKED_BYTE_ARRAY_r :: proc "c" (source: ^PackedByteArray) -> (copy: PackedByteArray) {
    GDW.PackedByteArray_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_INT32_ARRAY_r :: proc "c" (source: ^PackedInt32Array) -> (copy: PackedInt32Array) {
    GDW.PackedInt32Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_INT64_ARRAY_r :: proc "c" (source: ^PackedInt64Array) -> (copy: PackedInt64Array) {
    GDW.PackedInt64Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_FLOAT32_ARRAY_r :: proc "c" (source: ^PackedFloat32Array) -> (copy: PackedFloat32Array) {
    GDW.PackedFloat32Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_FLOAT64_ARRAY_r :: proc "c" (source: ^PackedFloat64Array) -> (copy: PackedFloat64Array) {
    GDW.PackedFloat64Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_STRING_ARRAY_r :: proc "c" (source: ^PackedStringArray) -> (copy: PackedStringArray) {
    GDW.PackedStringArray_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_VECTOR2_ARRAY_r :: proc "c" (source: ^PackedVector2Array) -> (copy: PackedVector2Array) {
    GDW.PackedVector2Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_VECTOR3_ARRAY_r :: proc "c" (source: ^PackedVector3Array) -> (copy: PackedVector3Array) {
    GDW.PackedVector3Array_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_COLOR_ARRAY_r :: proc "c" (source: ^PackedColorArray) -> (copy: PackedColorArray) {
    GDW.PackedColorArray_M_List.Create1(&copy, {source})
    return
}
ref_count_PACKED_VECTOR4_ARRAY_r :: proc "c" (source: ^PackedVector4Array) -> (copy: PackedVector4Array) {
    GDW.PackedVector4Array_M_List.Create1(&copy, {source})
    return
}
