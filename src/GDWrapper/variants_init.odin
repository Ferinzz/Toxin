package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import "base:runtime"
import "core:mem"
import "core:slice"
import "core:math/linalg"
import sics "base:intrinsics"

/*
* These methods will provide the Constructors for Variants via type conversion.
* As these are constructors, expect that they may allocate memory wherever possible.
* If you want to completely avoid unnecessary allocations take the pointer to the Variant's data field rather than converting to/from a type.
* except PACKEDARRAYS.
* If you do want a deep copy or reference increment, use these constructors.
* Types which allocate memory:
* Transform2DFromVariant
* Vec4FromVariant
* Vec4iFromVariant
* PlaneFromVariant
* QuaternionFromVariant
* AABBFromVariant
* BasisFromVariant
* Transform3dFromVariant
* ProjectionFromVariant
* ColorFromVariant
* Types which increment a reference are:
* StringNameFromVariant
* StringFromVariant
* NodePathFromVariant
* RidFromVariant
* ObjectFromVariant
* CallableFromVariant
* SignalFromVariant
* DictionaryFromVariant
* ArrayFromVariant
* PackedByteArrayFromVariant
* Packedi32ArrayFromVariant
* Packedi64ArrayFromVariant
* Packedf32ArrayFromVariant
* Packedf64ArrayFromVariant
* PackedStringArrayFromVariant
* PackedVec2ArrayFromVariant
* PackedVec3ArrayFromVariant
* PackedColorArrayFromVariant
* PackedVec4ArrayFromVariant
* Additional Copy on Write rules apply to reference counted types. Be sure to review those rules.
*/

new_type_from_methods :: proc {
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

new_variant_from_methods :: proc {
    BoolToVariant,
    IntToVariant,
    FloatToVariant,
    StringToVariant,
    Vec2ToVariant,
    Vec2iToVariant,
    Recf32ToVariant,
    Rec2iToVariant,
    Vec3ToVariant,
    Vec3iToVariant,
    Transform2DToVariant,
    Vec4ToVariant,
    Vec4iToVariant,
    PlaneToVariant,
    QuaternionToVariant,
    AABBToVariant,
    BasisToVariant,
    Transform3dToVariant,
    ProjectionToVariant,
    ColorToVariant,
    StringNameToVariant,
    NodePathToVariant,
    RidToVariant,
    ObjectToVariant,
    CallableToVariant,
    SignalToVariant,
    DictionaryToVariant,
    ArrayToVariant,
    PackedByteArrayToVariant,
    Packedi32ArrayToVariant,
    Packedi64ArrayToVariant,
    Packedf32ArrayToVariant,
    Packedf64ArrayToVariant,
    PackedStringArrayToVariant,
    PackedVec2ArrayToVariant,
    PackedVec3ArrayToVariant,
    PackedColorArrayToVariant,
    PackedVec4ArrayToVariant,
}

    BoolFromVariant:        proc "c" (_: ^Bool, _: ^Variant)
    IntFromVariant:         proc "c" (_: ^Int, _: ^Variant)
    FloatFromVariant:       proc "c" (_: ^float, _: ^Variant)
    StringFromVariant:      proc "c" (_: ^gdstring, _: ^Variant)
    Vec2FromVariant:        proc "c" (_: ^Vector2, _: ^Variant)
    Vec2iFromVariant:       proc "c" (_: ^Vector2i, _: ^Variant)
    Recf32FromVariant:      proc "c" (_: ^Rec2, _: ^Variant)
    Rec2iFromVariant:       proc "c" (_: ^Rec2i, _: ^Variant)
    Vec3FromVariant:        proc "c" (_: ^Vector3, _: ^Variant)
    Vec3iFromVariant:       proc "c" (_: ^Vector3i, _: ^Variant)
    Transform2DFromVariant: proc "c" (_: ^Transform2D, _: ^Variant)
    Vec4FromVariant:        proc "c" (_: ^Vector4, _: ^Variant)
    Vec4iFromVariant:       proc "c" (_: ^Vector4i, _: ^Variant)
    PlaneFromVariant:       proc "c" (_: ^Plane, _: ^Variant)
    QuaternionFromVariant:  proc "c" (_: ^Quaternion, _: ^Variant)
    AABBFromVariant:        proc "c" (_: ^AABB, _: ^Variant)
    BasisFromVariant:       proc "c" (_: ^Basis, _: ^Variant)
    Transform3dFromVariant: proc "c" (_: ^Transform3D, _: ^Variant)
    ProjectionFromVariant:  proc "c" (_: ^Projection, _: ^Variant)
    ColorFromVariant:       proc "c" (_: ^Color, _: ^Variant)
    StringNameFromVariant:  proc "c" (_: ^StringName, _: ^Variant)
    NodePathFromVariant:    proc "c" (_: ^NodePath, _: ^Variant)
    RidFromVariant:         proc "c" (_: ^RID, _: ^Variant)
    ObjectFromVariant:      proc "c" (_: ^Object, _: ^Variant)
    CallableFromVariant:    proc "c" (_: ^Callable, _: ^Variant)
    SignalFromVariant:      proc "c" (_: ^Signal, _: ^Variant)
    DictionaryFromVariant:        proc "c" (_: ^Dictionary, _: ^Variant)
    ArrayFromVariant:             proc "c" (_: ^Array, _: ^Variant)
    PackedByteArrayFromVariant:   proc "c" (_: ^PackedByteArray, _: ^Variant)
    Packedi32ArrayFromVariant:    proc "c" (_: ^PackedInt32Array, _: ^Variant)
    Packedi64ArrayFromVariant:    proc "c" (_: ^PackedInt64Array, _: ^Variant)
    Packedf32ArrayFromVariant:    proc "c" (_: ^PackedFloat32Array, _: ^Variant)
    Packedf64ArrayFromVariant:    proc "c" (_: ^PackedFloat64Array, _: ^Variant)
    PackedStringArrayFromVariant: proc "c" (_: ^PackedStringArray, _: ^Variant)
    PackedVec2ArrayFromVariant:   proc "c" (_: ^PackedVector2Array, _: ^Variant)
    PackedVec3ArrayFromVariant:   proc "c" (_: ^PackedVector3Array, _: ^Variant)
    PackedColorArrayFromVariant:  proc "c" (_: ^PackedColorArray, _: ^Variant)
    PackedVec4ArrayFromVariant:   proc "c" (_: ^PackedVector4Array, _: ^Variant)


    BoolToVariant:        proc "c" (_: ^Variant, _: ^Bool)
    IntToVariant:         proc "c" (_: ^Variant, _: ^Int)
    FloatToVariant:       proc "c" (_: ^Variant, _: ^float)
    StringToVariant:      proc "c" (_: ^Variant, _: ^gdstring)
    Vec2ToVariant:        proc "c" (_: ^Variant, _: ^Vector2)
    Vec2iToVariant:       proc "c" (_: ^Variant, _: ^Vector2i)
    Recf32ToVariant:      proc "c" (_: ^Variant, _: ^Rec2)
    Rec2iToVariant:       proc "c" (_: ^Variant, _: ^Rec2i)
    Vec3ToVariant:        proc "c" (_: ^Variant, _: ^Vector3)
    Vec3iToVariant:       proc "c" (_: ^Variant, _: ^Vector3i)
    Transform2DToVariant: proc "c" (_: ^Variant, _: ^Transform2D)
    Vec4ToVariant:        proc "c" (_: ^Variant, _: ^Vector4)
    Vec4iToVariant:       proc "c" (_: ^Variant, _: ^Vector4i)
    PlaneToVariant:       proc "c" (_: ^Variant, _: ^Plane)
    QuaternionToVariant:  proc "c" (_: ^Variant, _: ^Quaternion)
    AABBToVariant:        proc "c" (_: ^Variant, _: ^AABB)
    BasisToVariant:       proc "c" (_: ^Variant, _: ^Basis)
    Transform3dToVariant: proc "c" (_: ^Variant, _: ^Transform3D)
    ProjectionToVariant:  proc "c" (_: ^Variant, _: ^Projection)
    ColorToVariant:       proc "c" (_: ^Variant, _: ^Color)

    StringNameToVariant: proc "c" (_: ^Variant, _: ^StringName)
    NodePathToVariant:   proc "c" (_: ^Variant, _: ^NodePath)
    RidToVariant:        proc "c" (_: ^Variant, _: ^RID)
    ObjectToVariant:     proc "c" (_: ^Variant, _: ^Object)
    CallableToVariant:   proc "c" (_: ^Variant, _: ^Callable)
    SignalToVariant:     proc "c" (_: ^Variant, _: ^Signal)

    DictionaryToVariant:        proc "c" (_: ^Variant, _: ^Dictionary)
    ArrayToVariant:             proc "c" (_: ^Variant, _: ^Array)
    PackedByteArrayToVariant:   proc "c" (_: ^Variant, _: ^PackedByteArray)
    Packedi32ArrayToVariant:    proc "c" (_: ^Variant, _: ^PackedInt32Array)
    Packedi64ArrayToVariant:    proc "c" (_: ^Variant, _: ^PackedInt64Array)
    Packedf32ArrayToVariant:    proc "c" (_: ^Variant, _: ^PackedFloat32Array)
    Packedf64ArrayToVariant:    proc "c" (_: ^Variant, _: ^PackedFloat64Array)
    PackedStringArrayToVariant: proc "c" (_: ^Variant, _: ^PackedStringArray)
    PackedVec2ArrayToVariant:   proc "c" (_: ^Variant, _: ^PackedVector2Array)
    PackedVec3ArrayToVariant:   proc "c" (_: ^Variant, _: ^PackedVector3Array)
    PackedColorArrayToVariant:  proc "c" (_: ^Variant, _: ^PackedColorArray)
    PackedVec4ArrayToVariant:   proc "c" (_: ^Variant, _: ^PackedVector4Array)


Init_Variant_Converters :: proc() {
    
    BoolFromVariant = cast(proc "c" (_: ^b8, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BOOL)
    IntFromVariant = cast(proc "c" (_: ^Int, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.INT)
    FloatFromVariant = cast(proc "c" (_: ^float, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.FLOAT)
    StringFromVariant = cast(proc "c" (_: ^gdstring, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING)
    Vec2FromVariant = cast(proc "c" (_: ^Vector2, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2)
    Vec2iFromVariant = cast(proc "c" (_: ^Vector2i, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2I)
    Recf32FromVariant = cast(proc "c" (_: ^Rec2, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2)
    Rec2iFromVariant = cast(proc "c" (_: ^Rec2i, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2I)
    Vec3FromVariant = cast(proc "c" (_: ^Vector3, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3)
    Vec3iFromVariant = cast(proc "c" (_: ^Vector3i, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3I)
    Transform2DFromVariant = cast(proc "c" (_: ^Transform2D, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM2D)
    Vec4FromVariant = cast(proc "c" (_: ^Vector4, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4)
    Vec4iFromVariant = cast(proc "c" (_: ^Vector4i, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4I)
    PlaneFromVariant = cast(proc "c" (_: ^Plane, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PLANE)
    QuaternionFromVariant = cast(proc "c" (_: ^Quaternion, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.QUATERNION)
    AABBFromVariant = cast(proc "c" (_: ^AABB, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.AABB)
    BasisFromVariant = cast(proc "c" (_: ^Basis, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BASIS)
    Transform3dFromVariant = cast(proc "c" (_: ^Transform3D, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM3D)
    ProjectionFromVariant = cast(proc "c" (_: ^Projection, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PROJECTION)
    ColorFromVariant = cast(proc "c" (_: ^Color, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.COLOR)

    StringNameFromVariant = cast(proc "c" (_: ^StringName, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING_NAME)
    NodePathFromVariant = cast(proc "c" (_: ^NodePath, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.NODE_PATH)
    RidFromVariant = cast(proc "c" (_: ^RID, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RID)
    ObjectFromVariant = cast(proc "c" (_: ^Object, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.OBJECT)
    CallableFromVariant = cast(proc "c" (_: ^Callable, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.CALLABLE)
    SignalFromVariant = cast(proc "c" (_: ^Signal, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.SIGNAL)

    DictionaryFromVariant = cast(proc "c" (_: ^Dictionary, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.DICTIONARY)
    ArrayFromVariant = cast(proc "c" (_: ^Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.ARRAY)
    PackedByteArrayFromVariant = cast(proc "c" (_: ^PackedByteArray, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_BYTE_ARRAY)
    Packedi32ArrayFromVariant = cast(proc "c" (_: ^PackedInt32Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT32_ARRAY)
    Packedi64ArrayFromVariant = cast(proc "c" (_: ^PackedInt64Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT64_ARRAY)
    Packedf32ArrayFromVariant = cast(proc "c" (_: ^PackedFloat32Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT32_ARRAY)
    Packedf64ArrayFromVariant = cast(proc "c" (_: ^PackedFloat64Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT64_ARRAY)
    PackedStringArrayFromVariant = cast(proc "c" (_: ^PackedStringArray, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_STRING_ARRAY)
    PackedVec2ArrayFromVariant = cast(proc "c" (_: ^PackedVector2Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR2_ARRAY)
    PackedVec3ArrayFromVariant = cast(proc "c" (_: ^PackedVector3Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR3_ARRAY)
    PackedColorArrayFromVariant = cast(proc "c" (_: ^PackedColorArray, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_COLOR_ARRAY)
    PackedVec4ArrayFromVariant = cast(proc "c" (_: ^PackedVector4Array, _: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR4_ARRAY)


    BoolToVariant = cast(proc "c" (_: ^Variant, _: ^Bool))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BOOL)
    IntToVariant = cast(proc "c" (_: ^Variant, _: ^Int))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.INT)
    FloatToVariant = cast(proc "c" (_: ^Variant, _: ^float))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.FLOAT)
    StringToVariant = cast(proc "c" (_: ^Variant, _: ^gdstring))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING)
    //StringwPlaceholderToVariant = StringToVariant
    Vec2ToVariant = cast(proc "c" (_: ^Variant, _: ^Vector2))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2)
    Vec2iToVariant = cast(proc "c" (_: ^Variant, _: ^Vector2i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2I)
    Recf32ToVariant = cast(proc "c" (_: ^Variant, _: ^Rec2))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2)
    Rec2iToVariant = cast(proc "c" (_: ^Variant, _: ^Rec2i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2I)
    Vec3ToVariant = cast(proc "c" (_: ^Variant, _: ^Vector3))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3)
    Vec3iToVariant = cast(proc "c" (_: ^Variant, _: ^Vector3i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3I)
    Transform2DToVariant = cast(proc "c" (_: ^Variant, _: ^Transform2D))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM2D)
    Vec4ToVariant = cast(proc "c" (_: ^Variant, _: ^Vector4))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4)
    Vec4iToVariant = cast(proc "c" (_: ^Variant, _: ^Vector4i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4I)
    PlaneToVariant = cast(proc "c" (_: ^Variant, _: ^Plane))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PLANE)
    QuaternionToVariant = cast(proc "c" (_: ^Variant, _: ^Quaternion))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.QUATERNION)
    AABBToVariant = cast(proc "c" (_: ^Variant, _: ^AABB))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.AABB)
    BasisToVariant = cast(proc "c" (_: ^Variant, _: ^Basis))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BASIS)
    Transform3dToVariant = cast(proc "c" (_: ^Variant, _: ^Transform3D))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM3D)
    ProjectionToVariant = cast(proc "c" (_: ^Variant, _: ^Projection))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PROJECTION)
    ColorToVariant = cast(proc "c" (_: ^Variant, _: ^Color))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.COLOR)

    StringNameToVariant = cast(proc "c" (_: ^Variant, _: ^StringName))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING_NAME)
    NodePathToVariant = cast(proc "c" (_: ^Variant, _: ^NodePath))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.NODE_PATH)
    RidToVariant = cast(proc "c" (_: ^Variant, _: ^RID))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RID)
    ObjectToVariant = cast(proc "c" (_: ^Variant, _: ^Object))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.OBJECT)
    CallableToVariant = cast(proc "c" (_: ^Variant, _: ^Callable))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.CALLABLE)
    SignalToVariant = cast(proc "c" (_: ^Variant, _: ^Signal))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.SIGNAL)

    DictionaryToVariant = cast(proc "c" (_: ^Variant, _: ^Dictionary))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.DICTIONARY)
    ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.ARRAY)
    PackedByteArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedByteArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_BYTE_ARRAY)
    Packedi32ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedInt32Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT32_ARRAY)
    Packedi64ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedInt64Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT64_ARRAY)
    Packedf32ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedFloat32Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT32_ARRAY)
    Packedf64ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedFloat64Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT64_ARRAY)
    PackedStringArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedStringArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_STRING_ARRAY)
    PackedVec2ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedVector2Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR2_ARRAY)
    PackedVec3ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedVector3Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR3_ARRAY)
    PackedColorArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedColorArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_COLOR_ARRAY)
    PackedVec4ArrayToVariant = cast(proc "c" (_: ^Variant, _: ^PackedVector4Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR4_ARRAY)
}
