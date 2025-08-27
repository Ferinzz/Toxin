package gdextension

//Will likely need to make some build specific definitions since the size of things changes based on the Godot build used.

/******************/
/******************/
/*******DEFS********/
/******************/
/******************/

//Check Godot's docs for more info about each variant type: https://docs.godotengine.org/en/stable/classes/index.html#variant-types
//Set to 40 if double is double precision
//Data itself is in the _data union : https://github.com/godotengine/godot/blob/45fc515ae3574e9c1f9deacaa6960dec68a7d38b/core/variant/variant.h#L263
//After testing won't always need to use Godot's functions. Check Godot's _data union to know if the info is stack or heap and needs to be freed.
Variant :: struct #align(8) {
    VType: VariantType,
    data: [2]u64
}


/*This is what Godot's data is represented as in C++.
Could use this in Odin if we made it a #raw_union
But we would still need to know the type ahead of time to cast it back when received from Godot.
VariantData :: union #align(16) {
		Bool,
		i64,
		f64,
		^Transform2D,
		^AABB,
		^Basis,
		^Transform3D,
		^Projection,
		rawptr, //pointer to packedarrayrefbase, Godot specific type. Do Not Handle Directly. Use associated built-in Methods.
        Vector2,
        Vector2i,
        Vector3i,
        Vector3,
        Vector4,
        Vector4i,
		//Won't be handling the object stuff directly.
        //Below is the original Godot C++ code which reserves its struct size.
		//[sizeof(ObjData) > (sizeof(real_t) * 4) ? sizeof(ObjData) : (sizeof(real_t) * 4)]{ 0 },
	} 
*/

//optional in Godot. These are mainly to define pointer etc variable lengths in C.
Int     :: int    
Bool    :: b8
float   :: f64


//I'm sorry. I made all of these distinct. Godot has so many overlapping types in their Variant system that it makes the conversion procs easier.


//The use 16 bytes if your Godot version was built with double precision support, which is not the default.
//else use 8 bytes
//Doesn't have to be x,y pos. Also used in Godot as width height. They use a union to be able to switch between..
Vector2 :: distinct struct{
    x: f32,
    y: f32,
}

Vector2i :: distinct struct {
    x: i32,
    y: i32,
}

//Original has 2 Vector2
Rec2 :: distinct struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
}
    

//Original has 2 Vector2i
Rec2i :: distinct struct {
    x: i32,
    y: i32,
    width:  i32,
    height: i32,
}

Vector3 :: distinct struct{
    x: f32,
    y: f32,
    z: f32,
}

Vector3i :: distinct struct{
    x: i32,
    y: i32,
    z: i32,
}


Vector4 :: distinct struct{
    x: f32,
    y: f32,
    z: f32,
    w: f32,
}

Vector4i :: distinct struct{
    x: i32,
    y: i32,
    z: i32,
    w: i32,
}

//Vector3 + d
Plane :: distinct [4]f32

//Quaternion is quaternion
Quaternion :: distinct quaternion128

/*Represents an axis-aligned bounding box in a 3D space.
It is defined by its position and size, which are Vector3.*/
AABB :: distinct [6]f32

//3×3 matrix used to represent 3D rotation, scale, and shear.
Basis :: distinct #row_major matrix[3,3]f32

//Note: Godot uses a right-handed coordinate system, which is a common standard. For directions,
//the convention for built-in types like Camera3D is for -Z to point forward (+X is right, +Y is up, and +Z is back). 


/*4×4 matrix used for 3D projective transformations. It can represent transformations such as
translation, rotation, scaling, shearing, and perspective division. It consists of four Vector4 columns.
*/
Projection :: distinct #row_major matrix[4,4]f32

/*2×3 matrix. three Vector2 values: x, y, and origin.
Will need to test to determine if major or minor. Likely reimplements C# version.
 */
Transform2D ::  distinct #row_major matrix[3,2]f32
//Transform2D :: distinct [6]f32

/*3×4 matrix. A Basis, scale and shear. Combine with origin to do translations.
Will need to test to determine if major or minor. Likely reimplements C# version.
*/
Transform3D :: distinct #row_major matrix[3,4]f32

//Color represented in RGBA
Color :: distinct Vector4

//The value we get back for a string name is just the pointer to the Godot's interned string pool.
//If you've use the name once you'll already created a string name with the specific text you'll have already added that string to the pool.
//What we have access to is just the pointer.
StringName :: distinct struct{
    ptr: rawptr
}

/*Pointer to a string stored in Godot. Format Unicode.
Variable size.*/
gdstring :: distinct struct{
    ptr:rawptr
}

/*https://docs.godotengine.org/en/stable/classes/class_nodepath.html
A filesystem representation of the node tree. Is not a direct pointer to the Node.
Represented by a String.*/
NodePath :: distinct gdstring

/*The RID Variant type is used to access a low-level resource by its unique ID. RIDs are opaque,
which means they do not grant access to the resource by themselves. They are used by the low-level
server classes, such as DisplayServer, RenderingServer, TextServer, etc.
*/
RID :: distinct struct{
id:u64,
ptr:u64 //probaby?? or it's a u128.
}

//extension_api says size is dependent on the build config, but callable uses u64 with no typedef.
Object :: distinct struct{
    proxy:u64,
}

/*Represents a function. It can either be a method within an Object instance,
or a custom callable used for different purposes.
object is a union of u64 (object) or ^custom callable.*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L47
Callable :: distinct struct{
    stringName: StringName,
    object: u64,
}

/*Represents a signal of an Object instance. Like all Variant types,
it can be stored in variables and passed to functions. Signals allow all connected
Callables (and by extension their respective objects) to listen and react to events,
without directly referencing one another.*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L177
Signal :: distinct struct {
    stringname: StringName,
    objectid: Object,
}

/*Dictionaries are associative containers that contain values referenced by unique keys.
Dictionaries will preserve the insertion order when adding new entries.
Size changes based on Godot build config.*/
Dictionary :: distinct struct{
    id: u32
}

/*An array of Variants.
Size changes based on Godot build config.*/
Array :: distinct struct{
    id: u32
}

/*First value is not used by anything other tha C#. Second value is where the data begins.
The size and ref count are offset -1uintptr to the left of where the data begins.
Use Godot's built-ins to make and manage these. Otherwise you risk heap corruption if/when Godot tries writing memory in your dynlib.
*/
PackedByteArray :: packedArray(u8)

PackedInt32Array :: packedArray(i32)

PackedInt64Array :: packedArray(i64)

PackedFloat32Array :: packedArray(f32)

PackedFloat64Array :: packedArray(f64)


//Godot only has one type for both an array of vecN and vecNi.
PackedStringArray :: packedArray(gdstring)

PackedVector2Array :: packedArray(Vector2)

PackedVector3Array :: packedArray(Vector3)

PackedColorArray :: packedArray(Color)

PackedVector4Array :: packedArray(Vector4)

packedArray :: struct($T: typeid) { 
    proxy: rawptr, //This is only used for C#. C# is a safe language and as a result it needs to provide its pointer to itself in the struct itself. We add this for the padding.
    data: [^]T
}


//To know what to actually do with this flag set check docs linked below.
//https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-propertyhint
PropertyHint :: enum {
    PROPERTY_HINT_NONE
}

//To know what to actually do with this flag set check docs linked below.
//https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-propertyusageflags
PropertyUsageFlags :: enum {
    PROPERTY_USAGE_NONE,
    PROPERTY_USAGE_STORAGE = 2,
    PROPERTY_USAGE_EDITOR = 4,
    PROPERTY_USAGE_DEFAULT = PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR
}


//WARNING: if the order of the variantType enum changes, this needs to be updated as well.
GDTypes := [?]typeid {
nil,
typeid_of(Int),
typeid_of(Bool),
typeid_of(float),
typeid_of(Vector2),
typeid_of(Vector2i),
typeid_of(Rec2),
typeid_of(Rec2i),
typeid_of(Vector3),
typeid_of(Vector3i),
typeid_of(Transform2D),
typeid_of(Vector4),
typeid_of(Vector4i),
typeid_of(Plane),
typeid_of(Quaternion),
typeid_of(AABB),
typeid_of(Basis),
typeid_of(Projection),
typeid_of(Color),
typeid_of(StringName),
typeid_of(gdstring),
typeid_of(NodePath),
typeid_of(RID),
typeid_of(Object),
typeid_of(Callable),
typeid_of(Signal),
typeid_of(Dictionary),
typeid_of(Array),
typeid_of(PackedByteArray),
typeid_of(PackedInt32Array),
typeid_of(PackedInt64Array),
typeid_of(PackedFloat32Array),
typeid_of(PackedFloat64Array),
typeid_of(PackedStringArray),
typeid_of(PackedVector2Array),
typeid_of(PackedVector3Array),
typeid_of(PackedColorArray),
typeid_of(PackedVector4Array),
}