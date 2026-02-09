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
    GDArray_Methods.Destroy(del)
}
    
PackedStringArray_Destroy :: proc(del: ^PackedStringArray) {
    PackedStringArray_Methods.Destroy(del)
}
    
GDDictionary_Destroy :: proc(del: ^Dictionary) {
    GDDictionary_Methods.Destroy(del)
}
    
PackedByteArray_Destroy :: proc(del: ^PackedByteArray) {
    PackedByteArray_Methods.Destroy(del)
}
    
PackedInt32Array_Destroy :: proc(del: ^PackedInt32Array) {
    PackedInt32Array_Methods.Destroy(del)
}
    
PackedInt64Array_Destroy :: proc(del: ^PackedInt64Array) {
    PackedInt64Array_Methods.Destroy(del)
}
    
PackedFloat32Array_Destroy :: proc(del: ^PackedFloat32Array) {
    PackedFloat32Array_Methods.Destroy(del)
}
    
PackedFloat64Array_Destroy :: proc(del: ^PackedFloat64Array) {
    PackedFloat64Array_Methods.Destroy(del)
}
    
PackedVector2Array_Destroy :: proc(del: ^PackedVector2Array) {
    PackedVector2Array_Methods.Destroy(del)
}
    
PackedVector3Array_Destroy :: proc(del: ^PackedVector3Array) {
    PackedVector3Array_Methods.Destroy(del)
}
    
PackedVector4Array_Destroy :: proc(del: ^PackedVector4Array) {
    PackedVector4Array_Methods.Destroy(del)
}
    
PackedColorArray_Destroy :: proc(del: ^PackedColorArray) {
    PackedColorArray_Methods.Destroy(del)
}
    
StringName_Destroy :: proc(del: ^StringName) {
    GDW.StringName_Methods.Destroy(del)
}
    
String_Destroy :: proc(del: ^gdstring) {
    GDW.String_Methods.Destroy(del)
}
    
NodePath_Destroy :: proc(del: ^NodePath) {
    GDW.NodePath_Methods.Destroy(del)
}
    
Callable_Destroy :: proc(del: ^Callable) {
    GDW.Callable_Methods.Destroy(del)
}
    
Signal_Destroy :: proc(del: ^Signal) {
    GDW.Signal_Methods.Destroy(del)
}