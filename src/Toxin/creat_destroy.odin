package Toxin

import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import "core:reflect"
import "base:builtin"
import "base:runtime"

Destroy_Callable :: proc "c" (base: ^Callable) {
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.Callable_M_List.Destroy!=nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.Callable_M_List.Destroy(base)
}
Destroy_Dictionary :: proc "c" (base: ^Dictionary){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.Dictionary_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.Dictionary_M_List.Destroy(base)
}
Destroy_GDString :: proc "c" (base: ^gdstring){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.gdstring_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.gdstring_M_List.Destroy(base)
}
Destroy_NodePath :: proc "c" (base: ^NodePath){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.NodePath_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.NodePath_M_List.Destroy(base)
}
Destroy_Signal :: proc "c" (base: ^Signal){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.Signal_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.Signal_M_List.Destroy(base)
}
Destroy_StringName :: proc "c" (base: ^StringName){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.StringName_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.StringName_M_List.Destroy(base)
}
Destroy_Array :: proc "c" (base: ^Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.Array_M_List.Destroy(base)
}
Destroy_PackedByteArray :: proc "c" (base: ^PackedByteArray){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedByteArray_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedByteArray_M_List.Destroy(base)
}
Destroy_PackedColorArray :: proc "c" (base: ^PackedColorArray){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedColorArray_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedColorArray_M_List.Destroy(base)
}
Destroy_PackedFloat32Array :: proc "c" (base: ^PackedFloat32Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedFloat32Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedFloat32Array_M_List.Destroy(base)
}
Destroy_PackedFloat64Array :: proc "c" (base: ^PackedFloat64Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedFloat64Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedFloat64Array_M_List.Destroy(base)
}
Destroy_PackedInt32Array :: proc "c" (base: ^PackedInt32Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedInt32Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedInt32Array_M_List.Destroy(base)
}
Destroy_PackedInt64Array :: proc "c" (base: ^PackedInt64Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedInt64Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedInt64Array_M_List.Destroy(base)
}
Destroy_PackedStringArray :: proc "c" (base: ^PackedStringArray){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedStringArray_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedStringArray_M_List.Destroy(base)
}
Destroy_PackedVector2Array :: proc "c" (base: ^PackedVector2Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedVector2Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedVector2Array_M_List.Destroy(base)
}
Destroy_PackedVector3Array :: proc "c" (base: ^PackedVector3Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedVector3Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedVector3Array_M_List.Destroy(base)
}
Destroy_PackedVector4Array :: proc "c" (base: ^PackedVector4Array){
    when builtin.ODIN_DEBUG {
        context = runtime.default_context()
        assert(GDW.PackedVector4Array_M_List.Destroy != nil, "Attempted to call Destroy while mb is null. Method list must be initialized before being called.")
    }
    GDW.PackedVector4Array_M_List.Destroy(base)
}

Destroy :: proc {
    Destroy_Callable,
    Destroy_Dictionary,
    Destroy_GDString,
    Destroy_NodePath,
    Destroy_Signal,
    Destroy_StringName,
    Destroy_Array,
    Destroy_PackedByteArray,
    Destroy_PackedColorArray,
    Destroy_PackedFloat32Array,
    Destroy_PackedFloat64Array,
    Destroy_PackedInt32Array,
    Destroy_PackedInt64Array,
    Destroy_PackedStringArray,
    Destroy_PackedVector2Array,
    Destroy_PackedVector3Array,
    Destroy_PackedVector4Array,
}
