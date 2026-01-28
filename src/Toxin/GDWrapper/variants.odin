package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import "base:runtime"
import "core:mem"
import "core:slice"
import "core:math/linalg"
import sics "base:intrinsics"

/*
* Variants are Godot's special class of types.
* Under the hood it's
* an enum Type that holds the type
* a union _data which holds either the variable information or the pointer to the mem location
* In the class there's also an array that holds true/false to say whether the Variant type needs to be deinit. We could have this as a bitfield on our end.
* Reference for definitions : https://github.com/godotengine/godot/blob/45fc515ae3574e9c1f9deacaa6960dec68a7d38b/core/variant/variant.h
* In Godot there isn't a single function to do the type conversions to/from a Variant, so each needs to be fetched and stored independently.
* Some types can be directly converted as they are not ref counted or added to a bucket of memory.
*/

//Variant types found in the enum GDE.VariantType ref original C bindings for updates to the list.



/* Pass a type (int, i32, f64 etc.) and get the corresponding enum value that Godot will ID the variant type as.
* These are going to be very fragile. If th enum changes order, the union will need to change to match it.
* Reduces repetition on the gdAPI side, but might not be great long-term.
* Godot only has 'int', so use Int or i64
* Strings set here should not be normal Odin strings or cstrings. Godot has its own string storage system.
*/
typetoenum :: proc($U: typeid) -> GDE.VariantType {
    ret, _ := (slice.linear_search(GDTypes[:], U))
    return cast(GDE.VariantType)ret
}


//Give me the pointer each and every time.
//Use types from GDDEfs.odin
variantOperator :: proc(p_operator: GDE.VariantOperator, p_type_a: ^GDE.Variant,
                        p_type_b: ^GDE.Variant, r_return: $T)
                        where sics.type_is_pointer(T) {
    variant_op: GDE.PtrOperatorEvaluator = gdAPI.variantGetPtrOperatorEvaluator(p_operator, p_type_a.VType, p_type_b.VType)

    variant_op(&p_type_a.data, &p_type_b.data, r_return)

}


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

//We aren't preloading these so that it doesn't take time at launch.
//This also helps with ease of writing.
//This is done at the cost of one extra if statement.
//You can always separate these out to make it more direct.
    BooltoVariant       :: proc(p_variant: ^GDE.Variant, p_from: ^Bool, loc:=#caller_location) {
        p_variant.VType = .BOOL
        p_variant.data[0] = 0
        mem.copy(&p_variant.data[0], p_from, 1)
    }
    InttoVariant       :: proc(p_variant: ^GDE.Variant, p_from: ^Int, loc:=#caller_location) {
        p_variant.VType = .INT
        mem.copy(&p_variant.data, p_from, 8)
    }
    PtrtoVariant       :: proc(p_variant: ^GDE.Variant, p_from: ^rawptr, loc:=#caller_location) {
        p_variant.VType = .INT
        mem.copy(&p_variant.data, p_from, 8)
    }
    FloattoVariant      :: proc(p_variant: ^GDE.Variant, p_from: ^float, loc:=#caller_location) {
        p_variant.VType = .FLOAT
        mem.copy(&p_variant.data, p_from, 8)
    }
    
    StringtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^gdstring, loc:=#caller_location) {
        @(static) string2v: GDE.VariantFromTypeConstructorFunc
        if string2v == nil do string2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING)
        string2v(p_variant, p_from)
    }
    Vec2toVariant       :: proc(p_variant: ^GDE.Variant, p_from: ^Vector2, loc:=#caller_location) {
        p_variant.VType = .VECTOR2
        mem.copy(&p_variant.data, p_from, 8)
    }
    Vec2itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector2i, loc:=#caller_location) {
        p_variant.VType = .VECTOR2I
        mem.copy(&p_variant.data, p_from, 8)
    }
    Recf32toVariant     :: proc(p_variant: ^GDE.Variant, p_from: ^Rec2, loc:=#caller_location) {
        p_variant.VType = .RECT2
        mem.copy(&p_variant.data, p_from, 16)
    }
    
    Rec2itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Rec2i, loc:=#caller_location) {
        p_variant.VType = .RECT2I
        mem.copy(&p_variant.data, p_from, 16)
    }
    Vec3toVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector3, loc:=#caller_location) {
        p_variant.VType = .VECTOR3
        mem.copy(&p_variant.data, p_from, 12)
    }
    Vec3itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector3i, loc:=#caller_location) {
        p_variant.VType = .VECTOR3I
        mem.copy(&p_variant.data, p_from, 12)
    }
    Vec4toVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector4, loc:=#caller_location) {
        p_variant.VType = .VECTOR4
        mem.copy(&p_variant.data, p_from, 16)
    }
    Vec4itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector4i, loc:=#caller_location) {
        p_variant.VType = .VECTOR4I
        mem.copy(&p_variant.data, p_from, 16)
    }
    PlanetoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Plane, loc:=#caller_location) {
        p_variant.VType = .PLANE
        mem.copy(&p_variant.data, p_from, 16)
    }
    QuaterniontoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Quaternion, loc:=#caller_location) {
        p_variant.VType = .QUATERNION
        mem.copy(&p_variant.data, p_from, 16)
    }
    AABBtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^AABB, loc:=#caller_location) {
        @(static) aabb2v: GDE.VariantFromTypeConstructorFunc
        if aabb2v == nil do aabb2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.AABB)
        aabb2v(p_variant, p_from)
    }
    BasistoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Basis, loc:=#caller_location) {
        @(static) basis2v: GDE.VariantFromTypeConstructorFunc
        if basis2v == nil do basis2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BASIS)
        basis2v(p_variant, p_from)
    }
    Transform3dtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Transform3D, loc:=#caller_location) {
        @(static) trans3d2v: GDE.VariantFromTypeConstructorFunc
        if trans3d2v == nil do trans3d2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM3D)
        trans3d2v(p_variant, p_from)
    }
    ProjectiontoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Projection, loc:=#caller_location) {
        @(static) proj2v: GDE.VariantFromTypeConstructorFunc
        if proj2v == nil do proj2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PROJECTION)
        proj2v(p_variant, p_from)
    }
    Transform2DtoVariant    :: proc(p_variant: ^GDE.Variant, p_from: ^Transform2D, loc:=#caller_location) {
        @(static) trans2d2V: GDE.VariantFromTypeConstructorFunc
        if trans2d2V == nil do trans2d2V = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM2D)
        trans2d2V(p_variant, &(p_from[0]))
    }

    ColortoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Color, loc:=#caller_location) {
        p_variant.VType = .COLOR
        mem.copy(&p_variant.data, p_from, 16)
    }
    StringNametoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^StringName, loc:=#caller_location) {
        @(static) stringname2V: GDE.VariantFromTypeConstructorFunc
        if stringname2V == nil do stringname2V = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING_NAME)
        stringname2V(p_variant, p_from)
    }
    
    NodePathtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^NodePath, loc:=#caller_location) {
        @(static) nodepath2v: GDE.VariantFromTypeConstructorFunc
        if nodepath2v == nil do nodepath2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.NODE_PATH)
        nodepath2v(p_variant, p_from)
    }
    RidtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^RID, loc:=#caller_location) {
        @(static) rid2v: GDE.VariantFromTypeConstructorFunc
        if rid2v == nil do rid2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RID)
        rid2v(p_variant, p_from)
    }
    ObjecttoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Object, loc:=#caller_location) {
        @(static) object2v: GDE.VariantFromTypeConstructorFunc
        if object2v == nil do object2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.OBJECT)
        object2v(p_variant, p_from)
    }
    CallabletoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Callable, loc:=#caller_location) {
        @(static) callabele2v: GDE.VariantFromTypeConstructorFunc
        if callabele2v == nil do callabele2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.CALLABLE)
        callabele2v(p_variant, p_from)
    }
    SignaltoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Signal, loc:=#caller_location) {
        @(static) signale2v: GDE.VariantFromTypeConstructorFunc
        if signale2v == nil do signale2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.SIGNAL)
        signale2v(p_variant, p_from)
    }
    DictionarytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Dictionary, loc:=#caller_location) {
        @(static) dictionary2v: GDE.VariantFromTypeConstructorFunc
        if dictionary2v == nil do dictionary2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.DICTIONARY)
        //Godot doesn't seem to handle receiving nil very well for this particular type.
        if p_from.id != nil {
            dictionary2v(p_variant, p_from)
        }
    }

    ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Array, loc:=#caller_location) {
        @(static) array2v: GDE.VariantFromTypeConstructorFunc
        if array2v == nil do array2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.ARRAY)
        array2v(p_variant, p_from)
    }
    PackedByteArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedByteArray, loc:=#caller_location) {
        @(static) packedbyte2v: GDE.VariantFromTypeConstructorFunc
        if packedbyte2v == nil do packedbyte2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_BYTE_ARRAY)
        packedbyte2v(p_variant, p_from)
    }
    Packedi32ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedInt32Array, loc:=#caller_location) {
        @(static) packedi322v: GDE.VariantFromTypeConstructorFunc
        if packedi322v == nil do packedi322v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT32_ARRAY)
        packedi322v(p_variant, p_from)
    }
    Packedi64ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedInt64Array, loc:=#caller_location) {
        @(static) packedi642v: GDE.VariantFromTypeConstructorFunc
        if packedi642v == nil do packedi642v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT64_ARRAY)
        packedi642v(p_variant, p_from)
    }
    Packedf32ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedFloat32Array, loc:=#caller_location) {
        @(static) packedf322v: GDE.VariantFromTypeConstructorFunc
        if packedf322v == nil do packedf322v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT32_ARRAY)
        packedf322v(p_variant, p_from)
    }
    Packedf64ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedFloat64Array, loc:=#caller_location) {
        @(static) packedf642v: GDE.VariantFromTypeConstructorFunc
        if packedf642v == nil do packedf642v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT64_ARRAY)
        packedf642v(p_variant, p_from)
    }
    PackedStringArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedStringArray, loc:=#caller_location) {
        @(static) packedstring2v: GDE.VariantFromTypeConstructorFunc
        if packedstring2v == nil do packedstring2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_STRING_ARRAY)
        packedstring2v(p_variant, p_from)
    }
    PackedVec2ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector2Array, loc:=#caller_location) {
        @(static) packedvec22v: GDE.VariantFromTypeConstructorFunc
        if packedvec22v == nil do packedvec22v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR2_ARRAY)
        packedvec22v(p_variant, p_from)
    }
    PackedVec3ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector3Array, loc:=#caller_location) {
        @(static) packedvec32v: GDE.VariantFromTypeConstructorFunc
        if packedvec32v == nil do packedvec32v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR3_ARRAY)
        packedvec32v(p_variant, p_from)
    }
    PackedColorArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedColorArray, loc:=#caller_location) {
        @(static) packedcolor2v: GDE.VariantFromTypeConstructorFunc
        if packedcolor2v == nil do packedcolor2v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_COLOR_ARRAY)
        packedcolor2v(p_variant, p_from)
    }
    PackedVec4ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector4Array, loc:=#caller_location) {
        @(static) packedvec42v: GDE.VariantFromTypeConstructorFunc
        if packedvec42v == nil do packedvec42v = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR4_ARRAY)
        packedvec42v(p_variant, p_from)
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


//Use this if you need a return based on the typeID instead of passing it to a pointer.
fromvariant :: proc(variant: GDE.VariantPtr, $T: typeid) -> T {
    ret: T

    when T == bool || T == Bool{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BOOL)
        
        construct(&ret, variant)
    } else when T == i64 || T == Int {
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.INT)
        
        construct(&ret, variant)
    } else when T == f64 || T == float {
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.FLOAT)
        
        construct(&ret, variant)
    } else when T == Vector2{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2)
        
        construct(&ret, variant)
    } else when T == Vector2i{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2I)
        
        construct(&ret, variant)
    } else when T == Rec2{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2)
        
        construct(&ret, variant)
    } else when T == Rec2i{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2I)
        
        construct(&ret, variant)
    } else when T == Vector3{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3)
        
        construct(&ret, variant)
    } else when T == Vector3i{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3I)
        
        construct(&ret, variant)
    } else when T == Transform2D{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM2D)
        
        construct(&ret, variant)
    } else when T == Vector4{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4)
        
        construct(&ret, variant)
    } else when T == Vector4i{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4I)
        
        construct(&ret, variant)
    } else when T == Plane{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PLANE)
        
        construct(&ret, variant)
    } else when T == Quaternion{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.QUATERNION)
        
        construct(&ret, variant)
    } else when T == AABB{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.AABB)
        
        construct(&ret, variant)
    } else when T == Basis{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BASIS)
        
        construct(&ret, variant)
    } else when T == Projection{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PROJECTION)
        
        construct(&ret, variant)
    } else when T == Color{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.COLOR)
        
        construct(&ret, variant)
    } else when T == StringName{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING_NAME)
        
        construct(&ret, variant)
    } else when T == gdstring{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING)
        
        construct(&ret, variant)
    } else when T == NodePath{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.NODE_PATH)
        
        construct(&ret, variant)
    } else when T == RID{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RID)
        
        construct(&ret, variant)
    } else when T == Object{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.OBJECT)
        
        construct(&ret, variant)
    } else when T == Callable{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.CALLABLE)
        
        construct(&ret, variant)
    } else when T == Signal{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.SIGNAL)
        
        construct(&ret, variant)
    } else when T == Dictionary{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.DICTIONARY)
        
        construct(&ret, variant)
    } else when T == Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedByteArray{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_BYTE_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedInt32Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT32_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedInt64Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT64_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedFloat32Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT32_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedFloat64Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT64_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedStringArray{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_STRING_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector2Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR2_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector3Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR3_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedColorArray{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_COLOR_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector4Array{
        @(static)construct: GDE.TypeFromVariantConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR4_ARRAY)
        
        construct(&ret, variant)
    }
    return ret
}



//Use this if you need a return based on the typeID instead of passing it to a pointer.
tovariant :: proc(variant: rawptr, $T: typeid) -> GDE.Variant {
    ret: GDE.Variant

    when T == bool || T == Bool {
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BOOL)
        
        construct(&ret, variant)
    } else when T == i64 || T == Int {
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.INT)
        
        construct(&ret, variant)
    } else when T == f64 || T == float {
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.FLOAT)
        
        construct(&ret, variant)
    } else when T == Vector2{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2)
        
        construct(&ret, variant)
    } else when T == Vector2i{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2I)
        
        construct(&ret, variant)
    } else when T == Rec2{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2)
        
        construct(&ret, variant)
    } else when T == Rec2i{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2I)
        
        construct(&ret, variant)
    } else when T == Vector3{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3)
        
        construct(&ret, variant)
    } else when T == Vector3i{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3I)
        
        construct(&ret, variant)
    } else when T == Transform2D{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM2D)
        
        construct(&ret, variant)
    } else when T == Transform3D{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM3D)
        
        construct(&ret, variant)
    } else when T == Vector4{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4)
        
        construct(&ret, variant)
    } else when T == Vector4i{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4I)
        
        construct(&ret, variant)
    } else when T == Plane{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PLANE)
        
        construct(&ret, variant)
    } else when T == Quaternion{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.QUATERNION)
        
        construct(&ret, variant)
    } else when T == AABB{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.AABB)
        
        construct(&ret, variant)
    } else when T == Basis{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BASIS)
        
        construct(&ret, variant)
    } else when T == Projection{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PROJECTION)
        
        construct(&ret, variant)
    } else when T == Color{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.COLOR)
        
        construct(&ret, variant)
    } else when T == StringName{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING_NAME)
        
        construct(&ret, variant)
    } else when T == gdstring{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING)
        
        construct(&ret, variant)
    } else when T == NodePath{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.NODE_PATH)
        
        construct(&ret, variant)
    } else when T == RID{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RID)
        
        construct(&ret, variant)
    } else when T == Object{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.OBJECT)
        
        construct(&ret, variant)
    } else when T == Callable{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.CALLABLE)
        
        construct(&ret, variant)
    } else when T == Signal{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.SIGNAL)
        
        construct(&ret, variant)
    } else when T == Dictionary{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.DICTIONARY)
        
        construct(&ret, variant)
    } else when T == Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedByteArray{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_BYTE_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedInt32Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT32_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedInt64Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT64_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedFloat32Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT32_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedFloat64Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT64_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedStringArray{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_STRING_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector2Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR2_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector3Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR3_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedColorArray{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_COLOR_ARRAY)
        
        construct(&ret, variant)
    } else when T == PackedVector4Array{
        @(static)construct: GDE.VariantFromTypeConstructorFunc
        if construct == nil do construct = gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR4_ARRAY)
        
        construct(&ret, variant)
    }
    return ret
}