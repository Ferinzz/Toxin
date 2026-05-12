package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"
import "base:builtin"
import "base:runtime"


RefCounted_Methods_list: Classes.RefCounted_MethodBind_List
RefTag: GDE.ClassTag

safeRef_Error :: enum {
    NONE,
    FAILED_TO_REF,
    NOT_REF_COUNTED_OBJECT,
}

safeRef_Object :: proc "c" (obj: ^Object) -> safeRef_Error {
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(RefTag != nil, "Reference Tag pointer was not initialized. Cannot cast check to RefCounted. Must initialize.")
    }
    casted:= gdAPI.Object_Utils.CastTo(obj, RefTag)
    if casted != nil {
        b:Bool
        Ref_Count(casted, &b)
        when builtin.ODIN_DEBUG {
            context = runtime.default_context()
            assert(bool(b), "failed to ref count an object which is a RefCount object. This is a bug.")
        }
        if b {
            return .NONE
        } else {
            return .FAILED_TO_REF
        }
    }
    return .NOT_REF_COUNTED_OBJECT
}

//Returns true if the increment was successful, false otherwise.
Reference :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.reference.m_call, ref, nil, r_bool)
}

//Returns true if the increment was successful, false otherwise.
Unreference :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.unreference.m_call, ref, nil, r_bool)
}

Reference_init :: proc "c" (ref: ^Object, r_bool: ^Bool) {
    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)RefCounted_Methods_list.init_ref.m_call, ref, nil, r_bool)
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
    GDW.gdstring_M_List.Create1(copy, {source})
}
ref_count_STRING_NAME :: proc "c" (source: ^StringName, copy: ^StringName) {
    GDW.StringName_M_List.Create1(copy, {source})
}
ref_count_NODE_PATH :: proc "c" (source: ^NodePath, copy: ^NodePath) {
    GDW.NodePath_M_List.Create1(copy, {source})
}
ref_count_SIGNAL :: proc "c" (source: ^Signal, copy: ^Signal) {
    GDW.Signal_M_List.Create1(copy, {source})
}
ref_count_CALLABLE :: proc "c" (source: ^Callable, copy: ^Callable) {
    GDW.Callable_M_List.Create1(copy, {source})
}
ref_count_DICTIONARY :: proc "c" (source: ^Dictionary, copy: ^Dictionary) {
    GDW.Dictionary_M_List.Create1(copy, {source})
}
ref_count_ARRAY :: proc "c" (source: ^Array, copy: ^Array) {
    GDW.Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_BYTE_ARRAY :: proc "c" (source: ^PackedByteArray, copy: ^PackedByteArray) {
    GDW.PackedByteArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT32_ARRAY :: proc "c" (source: ^PackedInt32Array, copy: ^PackedInt32Array) {
    GDW.PackedInt32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_INT64_ARRAY :: proc "c" (source: ^PackedInt64Array, copy: ^PackedInt64Array) {
    GDW.PackedInt64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT32_ARRAY :: proc "c" (source: ^PackedFloat32Array, copy: ^PackedFloat32Array) {
    GDW.PackedFloat32Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_FLOAT64_ARRAY :: proc "c" (source: ^PackedFloat64Array, copy: ^PackedFloat64Array) {
    GDW.PackedFloat64Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_STRING_ARRAY :: proc "c" (source: ^PackedStringArray, copy: ^PackedStringArray) {
    GDW.PackedStringArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR2_ARRAY :: proc "c" (source: ^PackedVector2Array, copy: ^PackedVector2Array) {
    GDW.PackedVector2Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR3_ARRAY :: proc "c" (source: ^PackedVector3Array, copy: ^PackedVector3Array) {
    GDW.PackedVector3Array_M_List.Create1(copy, {source})
}
ref_count_PACKED_COLOR_ARRAY :: proc "c" (source: ^PackedColorArray, copy: ^PackedColorArray) {
    GDW.PackedColorArray_M_List.Create1(copy, {source})
}
ref_count_PACKED_VECTOR4_ARRAY :: proc "c" (source: ^PackedVector4Array, copy: ^PackedVector4Array) {
    GDW.PackedVector4Array_M_List.Create1(copy, {source})
}
