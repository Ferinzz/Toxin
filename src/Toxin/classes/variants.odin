#+ignore
package Toxin

import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import "base:runtime"
import "core:mem"
import "core:slice"
import "core:math/linalg"
import sics "base:intrinsics"

variant_from2::GDW.new_variant_from_methods

/*
* WARNING: Going back and forth between ref counted variants will increment the ref counts!
* New allocations will happen for large static types such as AABB, plane etc.
*/
variant_from :: proc {
    BooltoVariant,
    InttoVariant,
    PtrtoVariant,
    FloattoVariant,
    StringtoVariant,
    Vec2toVariant,
    Vec2itoVariant,
    Recf32toVariant,
    Rec2itoVariant,
    Vec3toVariant,
    Vec3itoVariant,
    Transform2DtoVariant,
    Vec4toVariant,
    Vec4itoVariant,
    PlanetoVariant,
    QuaterniontoVariant,
    AABBtoVariant,
    BasistoVariant,
    Transform3dtoVariant,
    ProjectiontoVariant,

    ColortoVariant,
    StringNametoVariant,
    NodePathtoVariant,
    RidtoVariant,
    ObjecttoVariant,
    CallabletoVariant,
    SignaltoVariant,
    DictionarytoVariant,

    ArraytoVariant,
    PackedByteArraytoVariant,
    Packedi32ArraytoVariant,
    Packedi64ArraytoVariant,
    Packedf32ArraytoVariant,
    Packedf64ArraytoVariant,
    PackedStringArraytoVariant,
    PackedVec2ArraytoVariant,
    PackedVec3ArraytoVariant,
    PackedColorArraytoVariant,
    PackedVec4ArraytoVariant,

}

/*
* WARNING: Going back and forth between ref counted variants will increment the ref counts!
* New allocations will happen for large static types such as AABB, plane etc.
*/
variant_to :: proc {
    BoolFromVariant,
    IntFromVariant,
    FloatFromVariant,
    StringFromVariant,
    Vec2FromVariant,
    Vec2iFromVariant,
    Recf32FromVariant,
    Rec2iFromVariant,
    Vec3FromVariant,
    Vec3iFromVariant,
    Transform2DFromVariant,
    Vec4FromVariant,
    Vec4iFromVariant,
    PlaneFromVariant,
    QuaternionFromVariant,
    AABBFromVariant,
    BasisFromVariant,
    Transform3dFromVariant,
    ProjectionFromVariant,
    ColorFromVariant,
    
    
    StringNameFromVariant,
    NodePathFromVariant,
    RidFromVariant,
    ObjectFromVariant,
    CallableFromVariant,
    SignalFromVariant,


    DictionaryFromVariant,
    ArrayFromVariant,
    PackedByteArrayFromVariant,
    Packedi32ArrayFromVariant,
    Packedi64ArrayFromVariant,
    Packedf32ArrayFromVariant,
    Packedf64ArrayFromVariant,
    PackedStringArrayFromVariant,
    PackedVec2ArrayFromVariant,
    PackedVec3ArrayFromVariant,
    PackedColorArrayFromVariant,
    PackedVec4ArrayFromVariant,

}




    ///////////////////////////////////
    BoolFromVariant       :: proc(p_variant: ^GDE.Variant, p_dest: ^Bool, loc := #caller_location) {
        assert(p_variant.VType == .BOOL, loc = loc)
        mem.copy(p_dest, &p_variant.data,  8)
    }
    IntFromVariant       :: proc(p_variant: ^GDE.Variant, p_dest: ^Int, loc := #caller_location) {
        assert(p_variant.VType == .INT, loc = loc)
        p_variant.VType = .INT
        mem.copy(p_dest, &p_variant.data, 8)
    }
    FloatFromVariant      :: proc(p_variant: ^GDE.Variant, p_dest: ^f64, loc := #caller_location) {
        assert(p_variant.VType == .FLOAT, loc = loc)
        mem.copy(p_dest, &p_variant.data, 8)
    }
    StringFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^gdstring, loc := #caller_location) {
        @(static) string2v: GDE.TypeFromVariantConstructorFunc
        if string2v == nil do string2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING)
        assert(p_variant.VType == .STRING, loc = loc)
        string2v(p_dest, p_variant)
    }
    Vec2FromVariant       :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector2, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR2, loc = loc)
        mem.copy(p_dest, &p_variant.data, 8)
    }
    Vec2iFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector2i, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR2I, loc = loc)
        mem.copy(p_dest, &p_variant.data, 8)
    }
    Recf32FromVariant     :: proc(p_variant: ^GDE.Variant, p_dest: ^Rec2, loc := #caller_location) {
        assert(p_variant.VType == .RECT2, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    
    Rec2iFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Rec2i, loc := #caller_location) {
        assert(p_variant.VType == .RECT2I, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    Vec3FromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector3, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR3, loc = loc)
        mem.copy(p_dest, &p_variant.data, 12)
    }
    Vec3iFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector3i, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR3I, loc = loc)
        mem.copy(p_dest, &p_variant.data, 12)
    }
    Vec4FromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector4, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR4, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    Vec4iFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Vector4i, loc := #caller_location) {
        assert(p_variant.VType == .VECTOR4I, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    PlaneFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Plane, loc := #caller_location) {
        assert(p_variant.VType == .PLANE, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    QuaternionFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Quaternion, loc := #caller_location) {
        assert(p_variant.VType == .QUATERNION, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    AABBFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^AABB, loc := #caller_location) {
        assert(p_variant.VType == .AABB, loc = loc)
        @(static) aabb2v: GDE.TypeFromVariantConstructorFunc
        if aabb2v == nil do aabb2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.AABB)
        aabb2v(p_dest, p_variant)
    }
    BasisFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Basis, loc := #caller_location) {
        assert(p_variant.VType == .BASIS, loc = loc)
        @(static) basis2v: GDE.TypeFromVariantConstructorFunc
        if basis2v == nil do basis2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BASIS)
        basis2v(p_dest, p_variant)
    }
    Transform3dFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Transform3D, loc := #caller_location) {
        assert(p_variant.VType == .TRANSFORM3D, loc = loc)
        @(static) trans3d2v: GDE.TypeFromVariantConstructorFunc
        if trans3d2v == nil do trans3d2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM3D)
        trans3d2v(p_dest, p_variant)
    }
    ProjectionFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Projection, loc := #caller_location) {
        assert(p_variant.VType == .PROJECTION, loc = loc)
        @(static) proj2v: GDE.TypeFromVariantConstructorFunc
        if proj2v == nil do proj2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PROJECTION)
        proj2v(p_dest, p_variant)
    }
    Transform2DFromVariant    :: proc(p_variant: ^GDE.Variant, p_dest: ^Transform2D, loc := #caller_location) {
        assert(p_variant.VType == .TRANSFORM2D, loc = loc)
        @(static) trans2d2V: GDE.TypeFromVariantConstructorFunc
        if trans2d2V == nil do trans2d2V = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM2D)
        trans2d2V(p_dest, p_variant)
    }
    ColorFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Color, loc := #caller_location) {
        assert(p_variant.VType == .COLOR, loc = loc)
        mem.copy(p_dest, &p_variant.data, 16)
    }
    StringNameFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^StringName, loc := #caller_location) {
        assert(p_variant.VType == .STRING_NAME, loc = loc)
        @(static) stringname2V: GDE.TypeFromVariantConstructorFunc
        if stringname2V == nil do stringname2V = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING_NAME)
        stringname2V(p_dest, p_variant)
    }
    
    NodePathFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^NodePath, loc := #caller_location) {
        assert(p_variant.VType == .NODE_PATH, loc = loc)
        @(static) nodepath2v: GDE.TypeFromVariantConstructorFunc
        if nodepath2v == nil do nodepath2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.NODE_PATH)
        nodepath2v(p_dest, p_variant)
    }
    RidFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^RID, loc := #caller_location) {
        assert(p_variant.VType == .RID, loc = loc)
        @(static) rid2v: GDE.TypeFromVariantConstructorFunc
        if rid2v == nil do rid2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RID)
        rid2v(p_dest, p_variant)
    }
    ObjectFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Object, loc := #caller_location) {
        assert(p_variant.VType == .OBJECT, loc = loc)
        @(static) object2v: GDE.TypeFromVariantConstructorFunc
        if object2v == nil do object2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.OBJECT)
        object2v(p_dest, p_variant)
    }
    CallableFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Callable, loc := #caller_location) {
        assert(p_variant.VType == .CALLABLE, loc = loc)
        @(static) callabele2v: GDE.TypeFromVariantConstructorFunc
        if callabele2v == nil do callabele2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.CALLABLE)
        callabele2v(p_dest, p_variant)
    }
    SignalFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Signal, loc := #caller_location) {
        assert(p_variant.VType == .SIGNAL, loc = loc)
        @(static) signale2v: GDE.TypeFromVariantConstructorFunc
        if signale2v == nil do signale2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.SIGNAL)
        signale2v(p_dest, p_variant)
    }
    DictionaryFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Dictionary, loc := #caller_location) {
        assert(p_variant.VType == .DICTIONARY, loc = loc)
        @(static) dictionary2v: GDE.TypeFromVariantConstructorFunc
        if dictionary2v == nil do dictionary2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.DICTIONARY)
        dictionary2v(p_dest, p_variant)
    }
    ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^Array, loc := #caller_location) {
        assert(p_variant.VType == .ARRAY, loc = loc)
        @(static) array2v: GDE.TypeFromVariantConstructorFunc
        if array2v == nil do array2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.ARRAY)
        array2v(p_dest, p_variant)
    }
    PackedByteArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedByteArray, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_BYTE_ARRAY, loc = loc)
        @(static) packedbyte2v: GDE.TypeFromVariantConstructorFunc
        if packedbyte2v == nil do packedbyte2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_BYTE_ARRAY)
        packedbyte2v(p_dest, p_variant)
    }
    Packedi32ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedInt32Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_INT32_ARRAY, loc = loc)
        @(static) packedi322v: GDE.TypeFromVariantConstructorFunc
        if packedi322v == nil do packedi322v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT32_ARRAY)
        packedi322v(p_dest, p_variant)
    }
    Packedi64ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedInt64Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_INT64_ARRAY, loc = loc)
        @(static) packedi642v: GDE.TypeFromVariantConstructorFunc
        if packedi642v == nil do packedi642v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT64_ARRAY)
        packedi642v(p_dest, p_variant)
    }
    Packedf32ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedFloat32Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_FLOAT32_ARRAY, loc = loc)
        @(static) packedf322v: GDE.TypeFromVariantConstructorFunc
        if packedf322v == nil do packedf322v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT32_ARRAY)
        packedf322v(p_dest, p_variant)
    }
    Packedf64ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedFloat64Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_INT64_ARRAY, loc = loc)
        @(static) packedf642v: GDE.TypeFromVariantConstructorFunc
        if packedf642v == nil do packedf642v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT64_ARRAY)
        packedf642v(p_dest, p_variant)
    }
    PackedStringArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedStringArray, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_STRING_ARRAY, loc = loc)
        @(static) packedstring2v: GDE.TypeFromVariantConstructorFunc
        if packedstring2v == nil do packedstring2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_STRING_ARRAY)
        packedstring2v(p_dest, p_variant)
    }
    PackedVec2ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedVector2Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_VECTOR2_ARRAY, loc = loc)
        @(static) packedvec22v: GDE.TypeFromVariantConstructorFunc
        if packedvec22v == nil do packedvec22v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR2_ARRAY)
        packedvec22v(p_dest, p_variant)
    }
    PackedVec3ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedVector3Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_VECTOR3_ARRAY, loc = loc)
        @(static) packedvec32v: GDE.TypeFromVariantConstructorFunc
        if packedvec32v == nil do packedvec32v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR3_ARRAY)
        packedvec32v(p_dest, p_variant)
    }
    PackedColorArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedColorArray, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_COLOR_ARRAY, loc = loc)
        @(static) packedcolor2v: GDE.TypeFromVariantConstructorFunc
        if packedcolor2v == nil do packedcolor2v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_COLOR_ARRAY)
        packedcolor2v(p_dest, p_variant)
    }
    PackedVec4ArrayFromVariant :: proc(p_variant: ^GDE.Variant, p_dest: ^PackedVector4Array, loc := #caller_location) {
        assert(p_variant.VType == .PACKED_VECTOR4_ARRAY, loc = loc)
        @(static) packedvec42v: GDE.TypeFromVariantConstructorFunc
        if packedvec42v == nil do packedvec42v = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR4_ARRAY)
        packedvec42v(p_dest, p_variant)
    }

