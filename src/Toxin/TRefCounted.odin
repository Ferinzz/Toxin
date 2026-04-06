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
