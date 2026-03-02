package Toxin

import GDW "shared:GDWrapper"

//Will likely need to make some build specific definitions since the size of things changes based on the Godot build used.

/******************/
/******************/
/*******DEFS*******/
/******************/
/******************/

//Check Godot's docs for more info about each variant type: https://docs.godotengine.org/en/stable/classes/index.html#variant-types
//Set to 40Bytes if double is double precision
//Data itself is in the _data union : https://github.com/godotengine/godot/blob/45fc515ae3574e9c1f9deacaa6960dec68a7d38b/core/variant/variant.h#L263
//After testing won't always need to use Godot's functions. Check Godot's _data union to know if the info is stack or heap and needs to be freed.
Variant :: GDW.Variant


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

Int     :: GDW.Int
Bool    :: GDW.Bool
float   :: GDW.float
ObjectInstanceID :: GDW.ObjectInstanceID


//I'm sorry. I made all of these distinct. Godot has so many overlapping types in their Variant system that it makes the conversion procs easier.


//The use 16 bytes if your Godot version was built with double precision support, which is not the default.
//else use 8 bytes
//Doesn't have to be x,y pos. Also used in Godot as width height. They use a union to be able to switch between..
Vector2 :: GDW.Vector2

Vector2i :: GDW.Vector2i

//Original has 2 Vector2
Rect2 :: GDW.Rect2
    

//Original has 2 Vector2i
Rect2i :: GDW.Rect2i

Vector3 :: GDW.Vector3

Vector3i :: GDW.Vector3i


Vector4 :: GDW.Vector4

Vector4i :: GDW.Vector4i

//Vector3 + d
Plane :: GDW.Plane

//Quaternion is quaternion
Quaternion :: GDW.Quaternion

/*Represents an axis-aligned bounding box in a 3D space.
It is defined by its position and size, which are Vector3.*/
AABB :: GDW.AABB

//3×3 matrix used to represent 3D rotation, scale, and shear.
Basis :: GDW.Basis

//Note: Godot uses a right-handed coordinate system, which is a common standard. For directions,
//the convention for built-in types like Camera3D is for -Z to point forward (+X is right, +Y is up, and +Z is back). 


/*4×4 matrix used for 3D projective transformations. It can represent transformations such as
translation, rotation, scaling, shearing, and perspective division. It consists of four Vector4 columns.
*/
Projection :: GDW.Projection

/*2×3 matrix. three Vector2 values: x, y, and origin.
Will need to test to determine if major or minor. Likely reimplements C# version.
 */
Transform2D ::  GDW.Transform2D
//Transform2D :: distinct [6]f32

/*3×4 matrix. A Basis, scale and shear. Combine with origin to do translations.
Will need to test to determine if major or minor. Likely reimplements C# version.
*/
Transform3D :: GDW.Transform3D

//Color represented in RGBA
Color :: GDW.Color

//The value we get back for a string name is just the pointer to the Godot's interned string pool.
//If you've use the name once you'll already created a string name with the specific text you'll have already added that string to the pool.
//What we have access to is just the pointer.
StringName :: GDW.StringName

/*
* Pointer to a string stored in Godot. Format Unicode.
* Variable size.
* Warning: during class create process set ptr to nil
*/
gdstring :: GDW.gdstring

/*https://docs.godotengine.org/en/stable/classes/class_nodepath.html
A filesystem representation of the node tree. Is not a direct pointer to the Node.
Represented by a String.
* Warning: during class create process set ptr to nil
*/
NodePath :: GDW.NodePath

/*The RID Variant type is used to access a low-level resource by its unique ID. RIDs are opaque,
which means they do not grant access to the resource by themselves. They are used by the low-level
server classes, such as DisplayServer, RenderingServer, TextServer, etc.
*/
RID :: GDW.RID

//extension_api says size is dependent on the build config, but callable uses u64 with no typedef.
Object :: GDW.Object

/*Represents a function. It can either be a method within an Object instance,
or a custom callable used for different purposes.
object is a union of u64 (objectID) or ^custom callable.
Use gdAPI.ObjectGetInstanceFromId to get the ObjectPtr
*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L47
Callable :: GDW.Callable

/*Represents a signal of an Object instance. Like all Variant types,
it can be stored in variables and passed to functions. Signals allow all connected
Callables (and by extension their respective objects) to listen and react to events,
without directly referencing one another.*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L177
Signal :: GDW.Signal

/*
* Dictionaries are associative containers that contain values referenced by unique keys.
* Dictionaries will preserve the insertion order when adding new entries.
* Size changes based on Godot build config.
* Godot's dictionaries can have a mix of different types in each key and each value.
* key1 : gdstring; value : int,
* key2 : Int; value : gdstring,
* key3 : Array; value : float,
* Verify the type of each key and their value before assuming that the type is correct.
* get_typed_key_builtin and get_typed_value_builtin methods will return the type as a VariantType.
*/
//WARNING: set id to nil during creation step. Godot allocation does not zero allocate by default.
Dictionary :: GDW.Dictionary

/*An array of Variants.
Size changes based on Godot build config.*/
//WARNING: set id to nil during creation step. Godot allocation does not zero allocate by default.
Array :: GDW.Array


/*
* Variables here are not defined by Godot but are useful for defining Properties.
* Primarily centered around differing versions of int or strings
*/

//gdstring with multiple lines
MULTILINE_TEXT :: distinct gdstring

//Specifies that an string is the name of an input action.
//may contain two options separated by comma
//If it contains "show_builtin", built-in input actions are included in the selection.
//If it contains "loose_mode", loose mode is enabled. This allows inserting any action name even if it's not present in the input map.
INPUT_NAME_STRING :: distinct gdstring
INPUT_NAME_STRINGNAME :: distinct gdstring


//struct holding NodePath and allowed node info.
//Allowed Nodes is comma separated stringof valid node types
NodePath_Hint :: GDW.NodePath_Hint

//struct holding Array[NodePath] and allowed node info.
//Allowed Nodes is comma separated stringof valid node types
NodePathArray_Hint :: GDW.NodePathArray_Hint

//Use to export a callable as a clickable button with a lable and icon.
//When the button is pressed the callable is called.
Tool_Button :: GDW.Tool_Button

/*First value is not used by anything other tha C#. Second value is where the data begins.
The size and ref count are offset -1uintptr to the left of where the data begins.
Use Godot's built-ins to make and manage these. Otherwise you risk heap corruption if/when Godot tries writing memory in your dynlib.
*/
//WARNING: if Exported you must initialize arrays them with at least create0 at some point.
PackedByteArray :: GDW.PackedByteArray

PackedInt32Array :: GDW.PackedInt32Array

PackedInt64Array :: GDW.PackedInt64Array

PackedFloat32Array :: GDW.PackedFloat32Array

PackedFloat64Array :: GDW.PackedFloat64Array

PackedStringArray :: GDW.PackedStringArray

//Godot only has one type for both an array of vecN and vecNi.
PackedVector2Array :: GDW.PackedVector2Array

PackedVector3Array :: GDW.PackedVector3Array

PackedColorArray :: GDW.PackedColorArray

PackedVector4Array :: GDW.PackedVector4Array

PackedArrayContainer :: struct ($packed_type: typeid) {
    _: [3]u64,
    array: ^packed_type,
}

//To know what to actually do with this flag set check docs linked below.
//https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-propertyhint
PropertyHint :: GDW.PropertyHint


PROPERTY_USAGE_DEFAULT :: GDW.PROPERTY_USAGE_DEFAULT
PropertyUsageFlagsbits:: GDW.PropertyUsageFlagsbits
//To know what to actually do with this flag set check docs linked below.
//https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-propertyusageflags
//PROPERTY_USAGE_DEFAULT = 6,
//An export preset property with this flag contains confidential information and is stored separately from the rest of the export preset configuration.

PropertyUsageFlags:: GDW.PropertyUsageFlags

ConnectFlags :: GDW.ConnectFlags

Connect:: GDW.Connect

//WARNING: if the order of the variantType enum changes, this needs to be updated as well.
GDTypes := GDW.GDTypes

GDTypes_strings := GDW.GDTypes_strings
