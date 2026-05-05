package Toxin

import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
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

enumtotype :: proc(varType: GDE.VariantType) -> typeid {
    return type_of(GDTypes[varType])
}


//Give me the pointer each and every time.
//Use types from GDDEfs.odin
@(deprecated="Use builtin VARIANT_OP_* isntead")
variantOperator :: proc(p_operator: GDE.VariantOperator, p_type_a: ^GDE.Variant,
                        p_type_b: ^GDE.Variant, r_return: $T)
                        where sics.type_is_pointer(T) {
    variant_op: GDE.PtrOperatorEvaluator = gdAPI.variantGetPtrOperatorEvaluator(p_operator, p_type_a.VType, p_type_b.VType)

    variant_op(&p_type_a.data, &p_type_b.data, r_return)

}

/*
* Helper method. Nothing special.
* Does not allocate new. Simply returns a pointer to the data. If the value is a stack value then it will only be valid as long as that stack value is valid.
* If it's a packed array it will call that get_ptr Godot method in order to get the correct pointer.
*/
variant_get_ptr :: proc "c" (variant: ^Variant) -> rawptr {
    switch variant.VType {
    case .NIL,
    /*  atomic types */
	.BOOL, .INT, .FLOAT, .STRING,
	/* math types */
	.VECTOR2, .VECTOR2I, .RECT2, .RECT2I, .VECTOR3, .VECTOR3I,
	.VECTOR4, .VECTOR4I, .PLANE, .QUATERNION,
	/* misc types */
	.COLOR, .STRING_NAME, .NODE_PATH, .RID,
    .OBJECT, .CALLABLE, .SIGNAL, .DICTIONARY, .ARRAY:
        return raw_data(variant.data[:])

    //These are passed by pointer from a bucket in Godot's memory. Owner cleans it up.
    //Remember to copy!
	case .AABB, .BASIS, .TRANSFORM3D, .TRANSFORM2D, .PROJECTION:
        return transmute(rawptr)(variant.data[0])

	/* typed arrays */
	case .PACKED_BYTE_ARRAY:
        return GDW.PackedByteArray_M_List.get_ptr(variant)
	case .PACKED_INT32_ARRAY:
        return GDW.PackedInt32Array_M_List.get_ptr(variant)
	case .PACKED_INT64_ARRAY:
        return GDW.PackedInt64Array_M_List.get_ptr(variant)
	case .PACKED_FLOAT32_ARRAY:
        return GDW.PackedFloat32Array_M_List.get_ptr(variant)
	case .PACKED_FLOAT64_ARRAY:
        return GDW.PackedFloat64Array_M_List.get_ptr(variant)
	case .PACKED_STRING_ARRAY:
        return GDW.PackedStringArray_M_List.get_ptr(variant)
	case .PACKED_VECTOR2_ARRAY:
        return GDW.PackedVector2Array_M_List.get_ptr(variant)
	case .PACKED_VECTOR3_ARRAY:
        return GDW.PackedVector3Array_M_List.get_ptr(variant)
	case .PACKED_COLOR_ARRAY:
        return GDW.PackedColorArray_M_List.get_ptr(variant)
	case .PACKED_VECTOR4_ARRAY:
        return GDW.PackedVector4Array_M_List.get_ptr(variant)

	case .VARIANT_MAX:
        context = runtime.default_context()
        assert(true, "Variant without a correct type provided!")
    case:
        context = runtime.default_context()
        assert(true, "Variant without a correct type provided!")
    }
    return nil
}

/*
* Use to check the type that Godot provides from its side.
* Returns early with ok or an error.
*/
variantTypeCheck :: proc(typeList: []GDE.VariantType, argList: GDE.ConstVariantPtrargs, r_error: ^GDE.CallError) {
    for type, index in typeList {
        if type != argList[index].VType {
            r_error.error = .CALL_ERROR_INVALID_ARGUMENT
            r_error.argument = i32(argList[index].VType)
            r_error.expected = i32(type)
            return
        }
    }
}

/*
* Matching Godot's raw_union for easy transfer of values.
* 
*/
variant_union_raw :: struct #raw_union {
    Bool: Bool,
    Int: Int,
    float: float,
    Vector2: Vector2,
    Vector2i: Vector2i,
    Rect2: Rect2,
    Rect2i: Rect2i,
    Vector3: Vector3,
    Vector3i: Vector3i,
    Vector4: Vector4,
    Vector4i: Vector4i,
    Plane: Plane,
    Color: Color,
    Quaternion: Quaternion,
    gdstring: gdstring, // RefCounted
    StringName: StringName, // RefCounted
    NodePath: NodePath, // RefCounted
    RID: RID,
    Object: Object, // RefCounted
    Callable: Callable, // RefCounted
    Signal: Signal, // RefCounted
    Dictionary: Dictionary, //Godot: construct dict, ref count dict, copy class ptr.
    Transform2D: ^Transform2D, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    AABB: ^AABB, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Basis: ^Basis, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Transform3D: ^Transform3D, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Projection: ^Projection, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Array: Array, //Godot: create then loop through to alloc each value.
    PackedByteArray: PackedByteArray, //Godot: create
    PackedInt32Array: PackedInt32Array, //Godot: create
    PackedInt64Array: PackedInt64Array, //Godot: create
    PackedFloat32Array: PackedFloat32Array, //Godot: create
    PackedFloat64Array: PackedFloat64Array, //Godot: create
    PackedStringArray: PackedStringArray, //Godot: create
    PackedVector2Array: PackedVector2Array, //Godot: create
    PackedVector3Array: PackedVector3Array, //Godot: create
    PackedColorArray: PackedColorArray, //Godot: create
    PackedVector4Array: PackedVector4Array, //Godot: create
}

variant_index :: proc($field: typeid, loc:=#caller_location) -> GDE.VariantType {
    index :: GDE.VariantType(sics.type_variant_index_of(variant_union, field))
    return index
}

/*
* To use sics.type_variant_index_of
*/
variant_union :: union {
    rawptr, //Godot's Nil Should always be nil

	/*  atomic types */
	Bool,
	Int,
	float,
	gdstring,

	/* math types */
	Vector2,
	Vector2i,
	Rect2,
	Rect2i,
	Vector3,
	Vector3i,
	Transform2D,
	Vector4,
	Vector4i,
	Plane,
	Quaternion,
	AABB,
	Basis,
	Transform3D,
	Projection,

	/* misc types */
	Color,
	StringName,
	NodePath,
	RID,
	Object,
	Callable,
	Signal,
	Dictionary,
	Array,

	/* typed arrays */
	PackedByteArray,
	PackedInt32Array,
	PackedInt64Array,
	PackedFloat32Array,
	PackedFloat64Array,
	PackedStringArray,
	PackedVector2Array,
	PackedVector3Array,
    PackedColorArray,
	PackedVector4Array,
}

copy_from_variant :: proc{
    BoolfromVariant,
    IntfromVariant,
    PtrfromVariant,
    FloatfromVariant,
    StringfromVariant,
    Vec2fromVariant,
    Vec2ifromVariant,
    Recf32fromVariant,
    Rect2ifromVariant,
    Vec3fromVariant,
    Vec3ifromVariant,
    Transform2DfromVariant,
    Vec4fromVariant,
    Vec4ifromVariant,
    PlanefromVariant,
    QuaternionfromVariant,
    AABBfromVariant,
    BasisfromVariant,
    Transform3dfromVariant,
    ProjectionfromVariant,

    ColorfromVariant,
    StringNamefromVariant,
    NodePathfromVariant,
    RidfromVariant,
    ObjectfromVariant,
    CallablefromVariant,
    SignalfromVariant,
    DictionaryfromVariant,

    ArrayfromVariant,
    PackedByteArrayfromVariant,
    Packedi32ArrayfromVariant,
    PackedStringArrayfromVariant,
    Packedi64ArrayfromVariant,
    Packedf32ArrayfromVariant,
    Packedf64ArrayfromVariant,
    PackedVec2ArrayfromVariant,
    PackedVec3ArrayfromVariant,
    PackedVec4ArrayfromVariant,
    PackedColorArrayfromVariant,
}

//Use this if you need a quick return based on the typeID instead of passing it to a pointer.
copy_to_variant_r :: proc(variant: ^$T) -> (ret: GDE.Variant) {
    copy_to_variant(&ret, variant)
    return
}

copy_to_variant :: proc{
    BooltoVariant,
    InttoVariant,
    PtrtoVariant,
    FloattoVariant,
    StringtoVariant,
    Vec2toVariant,
    Vec2itoVariant,
    Recf32toVariant,
    Rect2itoVariant,
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

VAR_ERROR:: enum {
    WRONG_TYPE,
    SUPPORTED_CONVERSION,
}

type_from_variant_error :: struct {
    error: VAR_ERROR,
    expected: GDE.VariantType,
    received: GDE.VariantType,
}

deinit_list:: bit_set[GDE.VariantType; i64]

needs_deinit: deinit_list : {
	.AABB,
	.BASIS,
	.TRANSFORM2D,
    .TRANSFORM3D,
	.PROJECTION,

    // misc types
    .STRING,
	.STRING_NAME,
	.NODE_PATH,
	.OBJECT,
	.CALLABLE,
	.SIGNAL,
	.DICTIONARY,
	.ARRAY,

	// typed arrays
	.PACKED_BYTE_ARRAY,
	.PACKED_INT32_ARRAY,
	.PACKED_INT64_ARRAY,
	.PACKED_FLOAT32_ARRAY,
	.PACKED_FLOAT64_ARRAY,
	.PACKED_STRING_ARRAY,
	.PACKED_VECTOR2_ARRAY,
	.PACKED_VECTOR3_ARRAY,
	.PACKED_COLOR_ARRAY,
	.PACKED_VECTOR4_ARRAY,
};

variant_Destroy :: proc(var: ^Variant) {
    if  (needs_deinit & {var.VType}) == {var.VType} {
        gdAPI.Variant_Utils.Destroy(var)
    } else do var^ = {}
}


//Use this if you need a return based on the typeID instead of passing it to a pointer.
copy_from_variant_r :: proc(variant: ^Variant, $T: typeid) -> T {
    ret: T

    when T == bool || T == Bool{
        copy_from_variant(&ret, variant)
    } else when T == i64 || T == Int {
        copy_from_variant(&ret, variant)
    } else when T == f64 || T == float {
        copy_from_variant(&ret, variant)
    } else when T == Vector2{
        copy_from_variant(&ret, variant)
    } else when T == Vector2i{
        copy_from_variant(&ret, variant)
    } else when T == Rect2{
        copy_from_variant(&ret, variant)
    } else when T == Rect2i{
        copy_from_variant(&ret, variant)
    } else when T == Vector3{
        copy_from_variant(&ret, variant)
    } else when T == Vector3i{
        copy_from_variant(&ret, variant)
    } else when T == Transform2D{
        copy_from_variant(&ret, variant)
    } else when T == Vector4{
        copy_from_variant(&ret, variant)
    } else when T == Vector4i{
        copy_from_variant(&ret, variant)
    } else when T == Plane{
        copy_from_variant(&ret, variant)
    } else when T == Quaternion{
        copy_from_variant(&ret, variant)
    } else when T == AABB{
        copy_from_variant(&ret, variant)
    } else when T == Basis{
        copy_from_variant(&ret, variant)
    } else when T == Projection{
        copy_from_variant(&ret, variant)
    } else when T == Color{
        copy_from_variant(&ret, variant)
    } else when T == StringName{
        copy_from_variant(&ret, variant)
    } else when T == gdstring{
        copy_from_variant(&ret, variant)
    } else when T == NodePath{
        copy_from_variant(&ret, variant)
    } else when T == RID{
        copy_from_variant(&ret, variant)
    } else when T == Object{
        copy_from_variant(&ret, variant)
    } else when T == Callable{
        copy_from_variant(&ret, variant)
    } else when T == Signal{
        copy_from_variant(&ret, variant)
    } else when T == Dictionary{
        copy_from_variant(&ret, variant)
    } else when T == Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedByteArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedInt32Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedInt64Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedFloat32Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedFloat64Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedStringArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector2Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector3Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedColorArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector4Array{
        copy_from_variant(&ret, variant)
    }
    return ret
}

/*
* Copies data directly from the value Godot passes to us.
* This should be safe as the Variant we receive Should be ref incremented by Godot before being passed to us.
*/
BoolfromVariant :: proc(P_dest: ^Bool, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .BOOL {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Bool
        return {}
    } else do return {.WRONG_TYPE, .BOOL, p_source.VType}
}
IntfromVariant :: proc(P_dest: ^Int, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .INT {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Int
        return {}
    } else do return {.WRONG_TYPE, .INT, p_source.VType}
}
PtrfromVariant :: proc(P_dest: ^rawptr, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .INT {
        P_dest^=transmute(rawptr)((cast(^variant_union_raw)(&p_source.data[0])).Int)
        return {}
    } else do return {.WRONG_TYPE, .INT, p_source.VType}
}
FloatfromVariant :: proc(P_dest: ^float, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .FLOAT {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).float
        return {}
    } else do return {.WRONG_TYPE, .FLOAT, p_source.VType}
}
StringfromVariant :: proc(P_dest: ^gdstring, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .STRING {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).gdstring
        return {}
    } else do return {.WRONG_TYPE, .STRING, p_source.VType}
}
Vec2fromVariant :: proc(P_dest: ^Vector2, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR2 {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector2
        return {}
    } else do return {.WRONG_TYPE, .VECTOR2, p_source.VType}
}
Vec2ifromVariant :: proc(P_dest: ^Vector2i, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR2I {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector2i
        return {}
    } else do return {.WRONG_TYPE, .VECTOR2I, p_source.VType}
}
Recf32fromVariant :: proc(P_dest: ^Rect2, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .RECT2 {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Rect2
        return {}
    } else do return {.WRONG_TYPE, .RECT2, p_source.VType}
}
Rect2ifromVariant :: proc(P_dest: ^Rect2i, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .RECT2I {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Rect2i
        return {}
    } else do return {.WRONG_TYPE, .RECT2I, p_source.VType}
}
Vec3fromVariant :: proc(P_dest: ^Vector3, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR3 {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector3
        return {}
    } else do return {.WRONG_TYPE, .VECTOR3, p_source.VType}
}
Vec3ifromVariant :: proc(P_dest: ^Vector3i, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR3I {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector3i
        return {}
    } else do return {.WRONG_TYPE, .VECTOR3I, p_source.VType}
}
Transform2DfromVariant :: proc(P_dest: ^Transform2D, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .TRANSFORM2D {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Transform2D^
        return {}
    } else do return {.WRONG_TYPE, .TRANSFORM2D, p_source.VType}
}
Vec4fromVariant :: proc(P_dest: ^Vector4, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR4 {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector4
        return {}
    } else do return {.WRONG_TYPE, .VECTOR4, p_source.VType}
}
Vec4ifromVariant :: proc(P_dest: ^Vector4i, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .VECTOR4I {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Vector4i
        return {}
    } else do return {.WRONG_TYPE, .VECTOR4I, p_source.VType}
}
PlanefromVariant :: proc(P_dest: ^Plane, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PLANE {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Plane
        return {}
    } else do return {.WRONG_TYPE, .PLANE, p_source.VType}
}
QuaternionfromVariant :: proc(P_dest: ^Quaternion, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .QUATERNION {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Quaternion
        return {}
    } else do return {.WRONG_TYPE, .QUATERNION, p_source.VType}
}
AABBfromVariant :: proc(P_dest: ^AABB, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .AABB {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).AABB^
        return {}
    } else do return {.WRONG_TYPE, .AABB, p_source.VType}
}
BasisfromVariant :: proc(P_dest: ^Basis, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .BASIS {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Basis^
        return {}
    } else do return {.WRONG_TYPE, .BASIS, p_source.VType}
}
Transform3dfromVariant :: proc(P_dest: ^Transform3D, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .TRANSFORM3D {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Transform3D^
        return {}
    } else do return {.WRONG_TYPE, .TRANSFORM3D, p_source.VType}
}
ProjectionfromVariant :: proc(P_dest: ^Projection, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PROJECTION {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Projection^
        return {}
    } else do return {.WRONG_TYPE, .PROJECTION, p_source.VType}
}
ColorfromVariant :: proc(P_dest: ^Color, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .COLOR {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Color
        return {}
    } else do return {.WRONG_TYPE, .COLOR, p_source.VType}
}
StringNamefromVariant :: proc(P_dest: ^StringName, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .STRING_NAME {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).StringName
        return {}
    } else do return {.WRONG_TYPE, .STRING_NAME, p_source.VType}
}
NodePathfromVariant :: proc(P_dest: ^NodePath, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .NODE_PATH {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).NodePath
        return {}
    } else do return {.WRONG_TYPE, .NODE_PATH, p_source.VType}
}
RidfromVariant :: proc(P_dest: ^RID, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .RID {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).RID
        return {}
    } else do return {.WRONG_TYPE, .RID, p_source.VType}
}
ObjectfromVariant :: proc(P_dest: ^Object, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .OBJECT {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Object
        return {}
    } else do return {.WRONG_TYPE, .OBJECT, p_source.VType}
}
CallablefromVariant :: proc(P_dest: ^Callable, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .CALLABLE {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Callable
        return {}
    } else do return {.WRONG_TYPE, .CALLABLE, p_source.VType}
}
SignalfromVariant :: proc(P_dest: ^Signal, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .SIGNAL {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Signal
        return {}
    } else do return {.WRONG_TYPE, .SIGNAL, p_source.VType}
}
DictionaryfromVariant :: proc(P_dest: ^Dictionary, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .DICTIONARY {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Dictionary
        return {}
    } else do return {.WRONG_TYPE, .DICTIONARY, p_source.VType}
}
ArrayfromVariant :: proc(P_dest: ^Array, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .ARRAY {
        P_dest^=(cast(^variant_union_raw)(&p_source.data[0])).Array
        return {}
    } else do return {.WRONG_TYPE, .ARRAY, p_source.VType}
}
PackedByteArrayfromVariant :: proc(P_dest: ^GDW.packedArray(u8), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_BYTE_ARRAY {
        P_dest^ = GDW.PackedByteArray_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedByteArray_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_BYTE_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_BYTE_ARRAY, p_source.VType}
}
Packedi32ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(i32), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_INT32_ARRAY {
        P_dest^ = GDW.PackedInt32Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedInt32Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_INT32_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_INT32_ARRAY, p_source.VType}
}
PackedStringArrayfromVariant :: proc(P_dest: ^GDE.PackedStringArray, p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_STRING_ARRAY {
        P_dest^ = GDW.PackedStringArray_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedStringArray_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_STRING_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_STRING_ARRAY, p_source.VType}
}
Packedi64ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(i64), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_INT64_ARRAY {
        P_dest^ = GDW.PackedInt64Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedInt64Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_INT64_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_INT64_ARRAY, p_source.VType}
}
Packedf32ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(f32), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_FLOAT32_ARRAY {
        P_dest^ = GDW.PackedFloat32Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedFloat32Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_FLOAT32_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_FLOAT32_ARRAY, p_source.VType}
}
Packedf64ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(f64), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_FLOAT64_ARRAY {
        P_dest^ = GDW.PackedFloat64Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedFloat64Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_FLOAT64_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_FLOAT64_ARRAY, p_source.VType}
}
PackedVec2ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(Vector2), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_VECTOR2_ARRAY {
        P_dest^ = GDW.PackedVector2Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedVector2Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_VECTOR2_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_VECTOR2_ARRAY, p_source.VType}
}
PackedVec3ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(Vector3), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_VECTOR3_ARRAY {
        P_dest^ = GDW.PackedVector3Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedVector3Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_VECTOR3_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_VECTOR3_ARRAY, p_source.VType}
}
PackedVec4ArrayfromVariant :: proc(P_dest: ^GDW.packedArray(Vector4), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_VECTOR4_ARRAY {
        P_dest^ = GDW.PackedVector4Array_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedVector4Array_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_VECTOR4_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_VECTOR4_ARRAY, p_source.VType}
}
PackedColorArrayfromVariant :: proc(P_dest: ^GDW.packedArray(Color), p_source: ^Variant) -> type_from_variant_error {
    if p_source.VType == .PACKED_COLOR_ARRAY {
        P_dest^ = GDW.PackedColorArray_M_List.get_ptr(p_source)^
        return {}
    } else if p_source.VType == .ARRAY {
        GDW.PackedColorArray_M_List.Create2(P_dest, {&(cast(^variant_union_raw)(&p_source.data[0])).Array})
        return {.SUPPORTED_CONVERSION, .PACKED_COLOR_ARRAY, p_source.VType}
    }
    return {.WRONG_TYPE, .PACKED_COLOR_ARRAY, p_source.VType}
}

packedHolder:: struct ($packed_type: typeid) {
    ptr: ^PackedArrayContainer(packed_type)
}

/*
* If a type fits in 128 bits it will be copied into the variant data section.
* if it could be larger than 128 bits, this will use Godot's built-in variant creation methods.
* if it is a type which is ref counted, this will use Godot's built-in variant creation methods.
* MUST delete the variants based on bit_set list needs_deinit.
* variant_Destroy will take care of the type check.
* Call the destructor directly from gdAPI if you want on less cycle.
*/
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
    GDW.new_variant_from_methods(p_variant, p_from)
}
Vec2toVariant       :: proc(p_variant: ^GDE.Variant, p_from: ^Vector2, loc:=#caller_location) {
    p_variant.VType = .VECTOR2
    mem.copy(&p_variant.data, p_from, 8)
}
Vec2itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Vector2i, loc:=#caller_location) {
    p_variant.VType = .VECTOR2I
    mem.copy(&p_variant.data, p_from, 8)
}
Recf32toVariant     :: proc(p_variant: ^GDE.Variant, p_from: ^Rect2, loc:=#caller_location) {
    p_variant.VType = .RECT2
    mem.copy(&p_variant.data, p_from, 16)
}    
Rect2itoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Rect2i, loc:=#caller_location) {
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
    GDW.new_variant_from_methods(p_variant, p_from)
}
BasistoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Basis, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
Transform3dtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Transform3D, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
ProjectiontoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Projection, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
Transform2DtoVariant    :: proc(p_variant: ^GDE.Variant, p_from: ^Transform2D, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}

ColortoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Color, loc:=#caller_location) {
    p_variant.VType = .COLOR
    mem.copy(&p_variant.data, p_from, 16)
}
StringNametoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^StringName, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}    
NodePathtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^NodePath, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
RidtoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^RID, loc:=#caller_location) {
    p_variant.VType = .RID
    mem.copy(&p_variant.data, p_from, 8)
}
ObjecttoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Object, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
CallabletoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Callable, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
SignaltoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Signal, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
}
DictionarytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Dictionary, loc:=#caller_location) {        
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.id != nil {
        panic("Dictionary was not initialized before using with Godot method.", loc)
    }
}

ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.id == nil {
        panic("Array was not initialized before using with Godot method.", loc)
    }
}
PackedByteArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedByteArray, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedByteArray was not initialized before using with Godot method.", loc)
    }
}
Packedi32ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedInt32Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedInt32Array was not initialized before using with Godot method.", loc)
    }
}
Packedi64ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedInt64Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedInt64Array was not initialized before using with Godot method.", loc)
    }
}
Packedf32ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedFloat32Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedFloat32Array was not initialized before using with Godot method.", loc)
    }
}
PackedStringArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedStringArray, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedFloat32Array was not initialized before using with Godot method.", loc)
    }
}
Packedf64ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedFloat64Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedFloat64Array was not initialized before using with Godot method.", loc)
    }
}
PackedVec2ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector2Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedVector2Array was not initialized before using with Godot method.", loc)
    }
}
PackedVec3ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector3Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedVector3Array was not initialized before using with Godot method.", loc)
    }
}
PackedColorArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedColorArray, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedColorArray was not initialized before using with Godot method.", loc)
    }
}
PackedVec4ArraytoVariant :: proc(p_variant: ^GDE.Variant, p_from: ^PackedVector4Array, loc:=#caller_location) {
    GDW.new_variant_from_methods(p_variant, p_from)
    //Godot doesn't seem to handle receiving nil very well for this particular type.
    if p_from.data == nil {
        panic("PackedVector4Array was not initialized before using with Godot method.", loc)
    }
}

//Use this if you need a return based on the typeID instead of passing it to a pointer.
fromvariant :: proc(variant: ^Variant, $T: typeid) -> T {
    ret: T

    when T == bool || T == Bool{
        copy_from_variant(&ret, variant)
    } else when T == i64 || T == Int {
        copy_from_variant(&ret, variant)
    } else when T == f64 || T == float {
        copy_from_variant(&ret, variant)
    } else when T == Vector2{
        copy_from_variant(&ret, variant)
    } else when T == Vector2i{
        copy_from_variant(&ret, variant)
    } else when T == Rect2{
        copy_from_variant(&ret, variant)
    } else when T == Rect2i{
        copy_from_variant(&ret, variant)
    } else when T == Vector3{
        copy_from_variant(&ret, variant)
    } else when T == Vector3i{
        copy_from_variant(&ret, variant)
    } else when T == Transform2D{
        copy_from_variant(&ret, variant)
    } else when T == Vector4{
        copy_from_variant(&ret, variant)
    } else when T == Vector4i{
        copy_from_variant(&ret, variant)
    } else when T == Plane{
        copy_from_variant(&ret, variant)
    } else when T == Quaternion{
        copy_from_variant(&ret, variant)
    } else when T == AABB{
        copy_from_variant(&ret, variant)
    } else when T == Basis{
        copy_from_variant(&ret, variant)
    } else when T == Projection{
        copy_from_variant(&ret, variant)
    } else when T == Color{
        copy_from_variant(&ret, variant)
    } else when T == StringName{
        copy_from_variant(&ret, variant)
    } else when T == gdstring{
        copy_from_variant(&ret, variant)
    } else when T == NodePath{
        copy_from_variant(&ret, variant)
    } else when T == RID{
        copy_from_variant(&ret, variant)
    } else when T == Object{
        copy_from_variant(&ret, variant)
    } else when T == Callable{
        copy_from_variant(&ret, variant)
    } else when T == Signal{
        copy_from_variant(&ret, variant)
    } else when T == Dictionary{
        copy_from_variant(&ret, variant)
    } else when T == Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedByteArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedInt32Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedInt64Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedFloat32Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedFloat64Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedStringArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector2Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector3Array{
        copy_from_variant(&ret, variant)
    } else when T == PackedColorArray{
        copy_from_variant(&ret, variant)
    } else when T == PackedVector4Array{
        copy_from_variant(&ret, variant)
    }
    return ret
}
