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
    Rect2iFromVariant,
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
    Rect2iToVariant,
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

    BoolFromVariant:        proc "c" (dest: ^Bool, source: ^Variant)
    IntFromVariant:         proc "c" (dest: ^Int, source: ^Variant)
    FloatFromVariant:       proc "c" (dest: ^float, source: ^Variant)
    StringFromVariant:      proc "c" (dest: ^gdstring, source: ^Variant)
    Vec2FromVariant:        proc "c" (dest: ^Vector2, source: ^Variant)
    Vec2iFromVariant:       proc "c" (dest: ^Vector2i, source: ^Variant)
    Recf32FromVariant:      proc "c" (dest: ^Rect2, source: ^Variant)
    Rect2iFromVariant:       proc "c" (dest: ^Rect2i, source: ^Variant)
    Vec3FromVariant:        proc "c" (dest: ^Vector3, source: ^Variant)
    Vec3iFromVariant:       proc "c" (dest: ^Vector3i, source: ^Variant)
    Transform2DFromVariant: proc "c" (dest: ^Transform2D, source: ^Variant)
    Vec4FromVariant:        proc "c" (dest: ^Vector4, source: ^Variant)
    Vec4iFromVariant:       proc "c" (dest: ^Vector4i, source: ^Variant)
    PlaneFromVariant:       proc "c" (dest: ^Plane, source: ^Variant)
    QuaternionFromVariant:  proc "c" (dest: ^Quaternion, source: ^Variant)
    AABBFromVariant:        proc "c" (dest: ^AABB, source: ^Variant)
    BasisFromVariant:       proc "c" (dest: ^Basis, source: ^Variant)
    Transform3dFromVariant: proc "c" (dest: ^Transform3D, source: ^Variant)
    ProjectionFromVariant:  proc "c" (dest: ^Projection, source: ^Variant)
    ColorFromVariant:       proc "c" (dest: ^Color, source: ^Variant)
    StringNameFromVariant:  proc "c" (dest: ^StringName, source: ^Variant)
    NodePathFromVariant:    proc "c" (dest: ^NodePath, source: ^Variant)
    RidFromVariant:         proc "c" (dest: ^RID, source: ^Variant)
    ObjectFromVariant:      proc "c" (dest: ^Object, source: ^Variant)
    CallableFromVariant:    proc "c" (dest: ^Callable, source: ^Variant)
    SignalFromVariant:      proc "c" (dest: ^Signal, source: ^Variant)
    DictionaryFromVariant:        proc "c" (dest: ^Dictionary, source: ^Variant)
    ArrayFromVariant:             proc "c" (dest: ^Array, source: ^Variant)
    PackedByteArrayFromVariant:   proc "c" (dest: ^PackedByteArray, source: ^Variant)
    Packedi32ArrayFromVariant:    proc "c" (dest: ^PackedInt32Array, source: ^Variant)
    Packedi64ArrayFromVariant:    proc "c" (dest: ^PackedInt64Array, source: ^Variant)
    Packedf32ArrayFromVariant:    proc "c" (dest: ^PackedFloat32Array, source: ^Variant)
    Packedf64ArrayFromVariant:    proc "c" (dest: ^PackedFloat64Array, source: ^Variant)
    PackedStringArrayFromVariant: proc "c" (dest: ^PackedStringArray, source: ^Variant)
    PackedVec2ArrayFromVariant:   proc "c" (dest: ^PackedVector2Array, source: ^Variant)
    PackedVec3ArrayFromVariant:   proc "c" (dest: ^PackedVector3Array, source: ^Variant)
    PackedColorArrayFromVariant:  proc "c" (dest: ^PackedColorArray, source: ^Variant)
    PackedVec4ArrayFromVariant:   proc "c" (dest: ^PackedVector4Array, source: ^Variant)


    BoolToVariant:        proc "c" (dest: ^Variant, source: ^Bool)
    IntToVariant:         proc "c" (dest: ^Variant, source: ^Int)
    FloatToVariant:       proc "c" (dest: ^Variant, source: ^float)
    StringToVariant:      proc "c" (dest: ^Variant, source: ^gdstring)
    Vec2ToVariant:        proc "c" (dest: ^Variant, source: ^Vector2)
    Vec2iToVariant:       proc "c" (dest: ^Variant, source: ^Vector2i)
    Recf32ToVariant:      proc "c" (dest: ^Variant, source: ^Rect2)
    Rect2iToVariant:       proc "c" (dest: ^Variant, source: ^Rect2i)
    Vec3ToVariant:        proc "c" (dest: ^Variant, source: ^Vector3)
    Vec3iToVariant:       proc "c" (dest: ^Variant, source: ^Vector3i)
    Transform2DToVariant: proc "c" (dest: ^Variant, source: ^Transform2D)
    Vec4ToVariant:        proc "c" (dest: ^Variant, source: ^Vector4)
    Vec4iToVariant:       proc "c" (dest: ^Variant, source: ^Vector4i)
    PlaneToVariant:       proc "c" (dest: ^Variant, source: ^Plane)
    QuaternionToVariant:  proc "c" (dest: ^Variant, source: ^Quaternion)
    AABBToVariant:        proc "c" (dest: ^Variant, source: ^AABB)
    BasisToVariant:       proc "c" (dest: ^Variant, source: ^Basis)
    Transform3dToVariant: proc "c" (dest: ^Variant, source: ^Transform3D)
    ProjectionToVariant:  proc "c" (dest: ^Variant, source: ^Projection)
    ColorToVariant:       proc "c" (dest: ^Variant, source: ^Color)

    StringNameToVariant: proc "c" (dest: ^Variant, source: ^StringName)
    NodePathToVariant:   proc "c" (dest: ^Variant, source: ^NodePath)
    RidToVariant:        proc "c" (dest: ^Variant, source: ^RID)
    ObjectToVariant:     proc "c" (dest: ^Variant, source: ^Object)
    CallableToVariant:   proc "c" (dest: ^Variant, source: ^Callable)
    SignalToVariant:     proc "c" (dest: ^Variant, source: ^Signal)

    DictionaryToVariant:        proc "c" (dest: ^Variant, source: ^Dictionary)
    ArrayToVariant:             proc "c" (dest: ^Variant, source: ^Array)
    PackedByteArrayToVariant:   proc "c" (dest: ^Variant, source: ^PackedByteArray)
    Packedi32ArrayToVariant:    proc "c" (dest: ^Variant, source: ^PackedInt32Array)
    Packedi64ArrayToVariant:    proc "c" (dest: ^Variant, source: ^PackedInt64Array)
    Packedf32ArrayToVariant:    proc "c" (dest: ^Variant, source: ^PackedFloat32Array)
    Packedf64ArrayToVariant:    proc "c" (dest: ^Variant, source: ^PackedFloat64Array)
    PackedStringArrayToVariant: proc "c" (dest: ^Variant, source: ^PackedStringArray)
    PackedVec2ArrayToVariant:   proc "c" (dest: ^Variant, source: ^PackedVector2Array)
    PackedVec3ArrayToVariant:   proc "c" (dest: ^Variant, source: ^PackedVector3Array)
    PackedColorArrayToVariant:  proc "c" (dest: ^Variant, source: ^PackedColorArray)
    PackedVec4ArrayToVariant:   proc "c" (dest: ^Variant, source: ^PackedVector4Array)


Init_Variant_Converters :: proc() {
    
    BoolFromVariant = cast(proc "c" (dest: ^b8, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BOOL)
    IntFromVariant = cast(proc "c" (dest: ^Int, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.INT)
    FloatFromVariant = cast(proc "c" (dest: ^float, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.FLOAT)
    StringFromVariant = cast(proc "c" (dest: ^gdstring, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING)
    Vec2FromVariant = cast(proc "c" (dest: ^Vector2, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2)
    Vec2iFromVariant = cast(proc "c" (dest: ^Vector2i, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR2I)
    Recf32FromVariant = cast(proc "c" (dest: ^Rect2, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2)
    Rect2iFromVariant = cast(proc "c" (dest: ^Rect2i, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RECT2I)
    Vec3FromVariant = cast(proc "c" (dest: ^Vector3, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3)
    Vec3iFromVariant = cast(proc "c" (dest: ^Vector3i, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR3I)
    Transform2DFromVariant = cast(proc "c" (dest: ^Transform2D, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM2D)
    Vec4FromVariant = cast(proc "c" (dest: ^Vector4, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4)
    Vec4iFromVariant = cast(proc "c" (dest: ^Vector4i, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.VECTOR4I)
    PlaneFromVariant = cast(proc "c" (dest: ^Plane, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PLANE)
    QuaternionFromVariant = cast(proc "c" (dest: ^Quaternion, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.QUATERNION)
    AABBFromVariant = cast(proc "c" (dest: ^AABB, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.AABB)
    BasisFromVariant = cast(proc "c" (dest: ^Basis, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.BASIS)
    Transform3dFromVariant = cast(proc "c" (dest: ^Transform3D, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.TRANSFORM3D)
    ProjectionFromVariant = cast(proc "c" (dest: ^Projection, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PROJECTION)
    ColorFromVariant = cast(proc "c" (dest: ^Color, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.COLOR)

    StringNameFromVariant = cast(proc "c" (dest: ^StringName, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.STRING_NAME)
    NodePathFromVariant = cast(proc "c" (dest: ^NodePath, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.NODE_PATH)
    RidFromVariant = cast(proc "c" (dest: ^RID, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.RID)
    ObjectFromVariant = cast(proc "c" (dest: ^Object, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.OBJECT)
    CallableFromVariant = cast(proc "c" (dest: ^Callable, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.CALLABLE)
    SignalFromVariant = cast(proc "c" (dest: ^Signal, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.SIGNAL)

    DictionaryFromVariant = cast(proc "c" (dest: ^Dictionary, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.DICTIONARY)
    ArrayFromVariant = cast(proc "c" (dest: ^Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.ARRAY)
    PackedByteArrayFromVariant = cast(proc "c" (dest: ^PackedByteArray, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_BYTE_ARRAY)
    Packedi32ArrayFromVariant = cast(proc "c" (dest: ^PackedInt32Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT32_ARRAY)
    Packedi64ArrayFromVariant = cast(proc "c" (dest: ^PackedInt64Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_INT64_ARRAY)
    Packedf32ArrayFromVariant = cast(proc "c" (dest: ^PackedFloat32Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT32_ARRAY)
    Packedf64ArrayFromVariant = cast(proc "c" (dest: ^PackedFloat64Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_FLOAT64_ARRAY)
    PackedStringArrayFromVariant = cast(proc "c" (dest: ^PackedStringArray, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_STRING_ARRAY)
    PackedVec2ArrayFromVariant = cast(proc "c" (dest: ^PackedVector2Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR2_ARRAY)
    PackedVec3ArrayFromVariant = cast(proc "c" (dest: ^PackedVector3Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR3_ARRAY)
    PackedColorArrayFromVariant = cast(proc "c" (dest: ^PackedColorArray, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_COLOR_ARRAY)
    PackedVec4ArrayFromVariant = cast(proc "c" (dest: ^PackedVector4Array, source: ^Variant))gdAPI.Variant_Utils.GetVariantToTypeConstructor(.PACKED_VECTOR4_ARRAY)


    BoolToVariant = cast(proc "c" (dest: ^Variant, source: ^Bool))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BOOL)
    IntToVariant = cast(proc "c" (dest: ^Variant, source: ^Int))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.INT)
    FloatToVariant = cast(proc "c" (dest: ^Variant, source: ^float))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.FLOAT)
    StringToVariant = cast(proc "c" (dest: ^Variant, source: ^gdstring))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING)
    //StringwPlaceholderToVariant = StringToVariant
    Vec2ToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector2))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2)
    Vec2iToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector2i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR2I)
    Recf32ToVariant = cast(proc "c" (dest: ^Variant, source: ^Rect2))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2)
    Rect2iToVariant = cast(proc "c" (dest: ^Variant, source: ^Rect2i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RECT2I)
    Vec3ToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector3))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3)
    Vec3iToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector3i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR3I)
    Transform2DToVariant = cast(proc "c" (dest: ^Variant, source: ^Transform2D))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM2D)
    Vec4ToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector4))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4)
    Vec4iToVariant = cast(proc "c" (dest: ^Variant, source: ^Vector4i))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.VECTOR4I)
    PlaneToVariant = cast(proc "c" (dest: ^Variant, source: ^Plane))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PLANE)
    QuaternionToVariant = cast(proc "c" (dest: ^Variant, source: ^Quaternion))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.QUATERNION)
    AABBToVariant = cast(proc "c" (dest: ^Variant, source: ^AABB))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.AABB)
    BasisToVariant = cast(proc "c" (dest: ^Variant, source: ^Basis))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.BASIS)
    Transform3dToVariant = cast(proc "c" (dest: ^Variant, source: ^Transform3D))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.TRANSFORM3D)
    ProjectionToVariant = cast(proc "c" (dest: ^Variant, source: ^Projection))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PROJECTION)
    ColorToVariant = cast(proc "c" (dest: ^Variant, source: ^Color))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.COLOR)

    StringNameToVariant = cast(proc "c" (dest: ^Variant, source: ^StringName))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.STRING_NAME)
    NodePathToVariant = cast(proc "c" (dest: ^Variant, source: ^NodePath))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.NODE_PATH)
    RidToVariant = cast(proc "c" (dest: ^Variant, source: ^RID))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.RID)
    ObjectToVariant = cast(proc "c" (dest: ^Variant, source: ^Object))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.OBJECT)
    CallableToVariant = cast(proc "c" (dest: ^Variant, source: ^Callable))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.CALLABLE)
    SignalToVariant = cast(proc "c" (dest: ^Variant, source: ^Signal))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.SIGNAL)

    DictionaryToVariant = cast(proc "c" (dest: ^Variant, source: ^Dictionary))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.DICTIONARY)
    ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.ARRAY)
    PackedByteArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedByteArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_BYTE_ARRAY)
    Packedi32ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedInt32Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT32_ARRAY)
    Packedi64ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedInt64Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_INT64_ARRAY)
    Packedf32ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedFloat32Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT32_ARRAY)
    Packedf64ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedFloat64Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_FLOAT64_ARRAY)
    PackedStringArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedStringArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_STRING_ARRAY)
    PackedVec2ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedVector2Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR2_ARRAY)
    PackedVec3ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedVector3Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR3_ARRAY)
    PackedColorArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedColorArray))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_COLOR_ARRAY)
    PackedVec4ArrayToVariant = cast(proc "c" (dest: ^Variant, source: ^PackedVector4Array))gdAPI.Variant_Utils.GetVariantFromTypeConstructor(.PACKED_VECTOR4_ARRAY)
}
