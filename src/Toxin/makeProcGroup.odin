package Toxin

import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"

Maker :: proc {
    make_Node
}

Destroy_Builtin :: proc {
    GDArray_Destroy,
    PackedStringArray_Destroy,
    GDDictionary_Destroy,
    PackedByteArray_Destroy,
    PackedInt32Array_Destroy,
    PackedInt64Array_Destroy,
    PackedFloat32Array_Destroy,
    PackedFloat64Array_Destroy,
    PackedVector2Array_Destroy,
    PackedVector3Array_Destroy,
    PackedVector4Array_Destroy,
    PackedColorArray_Destroy,
    String_Destroy,
    StringName_Destroy,
    NodePath_Destroy,
    Callable_Destroy,
    Signal_Destroy,
}


GDArray_Destroy :: proc(del: ^Array) {
    GDW.Array_M_List.Destroy(del)
}
    
PackedStringArray_Destroy :: proc(del: ^PackedStringArray) {
    GDW.PackedStringArray_M_List.Destroy(del)
}
    
GDDictionary_Destroy :: proc(del: ^Dictionary) {
    GDW.Dictionary_M_List.Destroy(del)
}
    
PackedByteArray_Destroy :: proc(del: ^PackedByteArray) {
    GDW.PackedByteArray_M_List.Destroy(del)
}
    
PackedInt32Array_Destroy :: proc(del: ^PackedInt32Array) {
    GDW.PackedInt32Array_M_List.Destroy(del)
}
    
PackedInt64Array_Destroy :: proc(del: ^PackedInt64Array) {
    GDW.PackedInt64Array_M_List.Destroy(del)
}
    
PackedFloat32Array_Destroy :: proc(del: ^PackedFloat32Array) {
    GDW.PackedFloat32Array_M_List.Destroy(del)
}
    
PackedFloat64Array_Destroy :: proc(del: ^PackedFloat64Array) {
    GDW.PackedFloat64Array_M_List.Destroy(del)
}
    
PackedVector2Array_Destroy :: proc(del: ^PackedVector2Array) {
    GDW.PackedVector2Array_M_List.Destroy(del)
}
    
PackedVector3Array_Destroy :: proc(del: ^PackedVector3Array) {
    GDW.PackedVector3Array_M_List.Destroy(del)
}
    
PackedVector4Array_Destroy :: proc(del: ^PackedVector4Array) {
    GDW.PackedVector4Array_M_List.Destroy(del)
}
    
PackedColorArray_Destroy :: proc(del: ^PackedColorArray) {
    GDW.PackedColorArray_M_List.Destroy(del)
}
    
StringName_Destroy :: proc(del: ^StringName) {
    GDW.StringName_M_List.Destroy(del)
}
    
String_Destroy :: proc(del: ^gdstring) {
    GDW.gdstring_M_List.Destroy(del)
}
    
NodePath_Destroy :: proc(del: ^NodePath) {
    GDW.NodePath_M_List.Destroy(del)
}
    
Callable_Destroy :: proc(del: ^Callable) {
    GDW.Callable_M_List.Destroy(del)
}
    
Signal_Destroy :: proc(del: ^Signal) {
    GDW.Signal_M_List.Destroy(del)
}


texture2D :: ^Object

//TODO: fix texture destructor
@(deprecated="Is borked. No fix yet.")
destroy_texture :: proc(texture: texture2D) {
    die:RID
    if texture != nil && texture.proxy != nil {
        GDW.getRid(texture, &die)
        //GDW.freeRenderRID(&die)
    }
}