package GDWrapper

import GDE "gdAPI/gdextension"

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
Variant :: GDE.Variant
VariantType :: GDE.VariantType

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

Int     :: GDE.Int
Bool    :: b8
float   :: f64
ObjectInstanceID :: u64
//Because there's 7 methods that take in a const void*...
void :: struct {
  ptr: rawptr
}



//I'm sorry. I made all of these distinct. Godot has so many overlapping types in their Variant system that it makes the conversion procs easier.


//The use 16 bytes if your Godot version was built with double precision support, which is not the default.
//else use 8 bytes
//Doesn't have to be x,y pos. Also used in Godot as width height. They use a union to be able to switch between..
Vector2 :: distinct struct #simple {
    x: f32,
    y: f32,
}

Vector2i :: distinct struct {
    x: i32,
    y: i32,
}

//Original has 2 Vector2
Rect2 :: distinct struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
}


//Original has 2 Vector2i
Rect2i :: distinct struct {
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

Vector4i :: distinct struct #packed{
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

/*3×4 matrix. A Basis, scale and shear. Combine with origin to do translations.
Will need to test to determine if major or minor. Likely reimplements C# version.
*/
Transform3D :: distinct #row_major matrix[3,4]f32

//Color represented in RGBA
Color :: GDE.Color

//The value we get back for a string name is just the pointer to the Godot's interned string pool.
//If you've use the name once you'll already created a string name with the specific text you'll have already added that string to the pool.
//What we have access to is just the pointer.
StringName :: GDE.StringName

/*
* Pointer to a string stored in Godot. Format Unicode.
* Variable size.
* Warning: during class create process set ptr to nil
*/
gdstring :: GDE.gdstring

/*https://docs.godotengine.org/en/stable/classes/class_nodepath.html
A filesystem representation of the node tree. Is not a direct pointer to the Node.
Represented by a String.
* Warning: during class create process set ptr to nil
*/
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
Object :: GDE.Object

//a pointer uniquely identifying the given built-in class in the ClassDB.
ClassTag:: GDE.ClassTag

/*Represents a function. It can either be a method within an Object instance,
or a custom callable used for different purposes.
object is a union of u64 (objectID) or ^custom callable.
Use gdAPI.ObjectGetInstanceFromId to get the ObjectPtr
Callable contains a union on Godot's side. We should only be making CustomCallables through our system.
*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L47
Callable :: struct {
  call_p: ^Callable_Class,
  ref: CustomCallable,
}

Callable_Class :: distinct struct{
    stringName: StringName, //Blank for us. Can put what we want in the 64 bit. Teehee.
    ref: CustomCallable,
}

CustomCallable:: distinct rawptr

/*Represents a signal of an Object instance. Like all Variant types,
it can be stored in variables and passed to functions. Signals allow all connected
Callables (and by extension their respective objects) to listen and react to events,
without directly referencing one another.*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L177
Signal :: distinct struct {
    stringname: StringName,
    objectid: Object,
}

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
Dictionary :: distinct struct{
    id: rawptr
}

/*An array of Variants.
Size changes based on Godot build config.*/
//WARNING: set id to nil during creation step. Godot allocation does not zero allocate by default.
Array :: distinct struct{
    id: rawptr
}


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
NodePath_Hint :: struct {
  Path: NodePath,
  Allowed_Nodes: gdstring,
}

//struct holding Array[NodePath] and allowed node info.
//Allowed Nodes is comma separated stringof valid node types
NodePathArray_Hint :: struct {
  Path: Array,
  Allowed_Nodes: gdstring,
}

//Use to export a callable as a clickable button with a lable and icon.
//When the button is pressed the callable is called.
Tool_Button :: struct {
  call: Callable,
  text: gdstring,
  //icon: Path,
}

/*First value is not used by anything other tha C#. Second value is where the data begins.
The size and ref count are offset -1uintptr to the left of where the data begins.
Use Godot's built-ins to make and manage these. Otherwise you risk heap corruption if/when Godot tries writing memory in your dynlib.
*/
//WARNING: if Exported you must initialize arrays them with at least create0 at some point.
PackedByteArray :: packedArray(u8)

PackedInt32Array :: packedArray(i32)

PackedInt64Array :: packedArray(i64)

PackedFloat32Array :: packedArray(f32)

PackedFloat64Array :: packedArray(f64)

PackedStringArray :: GDE.PackedStringArray

//Godot only has one type for both an array of vecN and vecNi.
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
PropertyHint :: enum u32 {
    //The property has no hint for the editor.
    NONE = 0,
    
    //Hints that an int or float property should be within a range specified via the hint string "min,max" or "min,max,step". The hint string can optionally include "or_greater" and/or "or_less" to allow manual input going respectively above the max or below the min values.
    //Example: "-360,360,1,or_greater,or_less".
    //Additionally, other keywords can be included: "exp" for exponential range editing, "radians_as_degrees" for editing radian angles in degrees (the range values are also in degrees), "degrees" to hint at an angle and "hide_slider" to hide the slider.
    RANGE = 1,
    
    //Hints that an int or String property is an enumerated value to pick in a list specified via a hint string.
    //The hint string is a comma separated list of names such as "Hello,Something,Else". Whitespaces are not removed from either end of a name. For integer properties, the first name in the list has value 0, the next 1, and so on. Explicit values can also be specified by appending :integer to the name, e.g. "Zero,One,Three:3,Four,Six:6".
    ENUM = 2,

    //Hints that a String property can be an enumerated value to pick in a list specified via a hint string such as "Hello,Something,Else".
    //Unlike PROPERTY_HINT_ENUM, a property with this hint still accepts arbitrary values and can be empty. The list of values serves to suggest possible values.
    ENUM_SUGGESTION = 3,

    //Hints that a float property should be edited via an exponential easing function. The hint string can include "attenuation" to flip the curve horizontally and/or "positive_only" to exclude in/out easing and limit values to be greater than or equal to zero.
    EXP_EASING = 4,

    //Hints that a vector property should allow its components to be linked. For example, this allows Vector2.x and Vector2.y to be edited together.
    LINK = 5,

    //Hints that an int property is a bitmask with named bit flags.
    //The hint string is a comma separated list of names such as "Bit0,Bit1,Bit2,Bit3". Whitespaces are not removed from either end of a name. The first name in the list has value 1, the next 2, then 4, 8, 16 and so on. Explicit values can also be specified by appending :integer to the name, e.g. "A:4,B:8,C:16". You can also combine several flags ("A:4,B:8,AB:12,C:16").
    //Note: A flag value must be at least 1 and at most 2 ** 32 - 1.
    //Note: Unlike PROPERTY_HINT_ENUM, the previous explicit value is not taken into account. For the hint "A:16,B,C", A is 16, B is 2, C is 4.
    FLAGS = 6,

    //Hints that an int property is a bitmask using the optionally named 2D render layers.
    LAYERS_2D_RENDER = 7,

    //Hints that an int property is a bitmask using the optionally named 2D physics layers.
    LAYERS_2D_PHYSICS = 8,

    //Hints that an int property is a bitmask using the optionally named 2D navigation layers.
    LAYERS_2D_NAVIGATION = 9,

    //Hints that an int property is a bitmask using the optionally named 3D render layers.
    LAYERS_3D_RENDER = 10,

    //Hints that an int property is a bitmask using the optionally named 3D physics layers.
    LAYERS_3D_PHYSICS = 11,

    //Hints that an int property is a bitmask using the optionally named 3D navigation layers.
    LAYERS_3D_NAVIGATION = 12,

    //Hints that a String property is a path to a file. Editing it will show a file dialog for picking the path. The hint string can be a set of filters with wildcards like "*.png,*.jpg".
    FILE = 13,

    //Hints that a String property is a path to a directory. Editing it will show a file dialog for picking the path.
    DIR = 14,

    //Hints that a String property is an absolute path to a file outside the project folder. Editing it will show a file dialog for picking the path. The hint string can be a set of filters with wildcards, like "*.png,*.jpg".
    GLOBAL_FILE = 15,

    //Hints that a String property is an absolute path to a directory outside the project folder. Editing it will show a file dialog for picking the path.
    GLOBAL_DIR = 16,

    //Hints that a property is an instance of a Resource-derived type, optionally specified via the hint string (e.g. "Texture2D"). Editing it will show a popup menu of valid resource types to instantiate.
    RESOURCE_TYPE = 17,

    //Hints that a String property is text with line breaks. Editing it will show a text input field where line breaks can be typed.
    MULTILINE_TEXT = 18,

    //Hints that a String property is an Expression.
    EXPRESSION = 19,

    //Hints that a String property should show a placeholder text on its input field, if empty. The hint string is the placeholder text to use.
    PLACEHOLDER_TEXT = 20,

    //Hints that a Color property should be edited without affecting its transparency (Color.a is not editable).
    COLOR_NO_ALPHA = 21,

    //Hints that the property's value is an object encoded as object ID, with its type specified in the hint string. Used by the debugger.
    OBJECT_ID = 22,

    //If a property is String, hints that the property represents a particular type (class). This allows to select a type from the create dialog. The property will store the selected type as a string.
    //If a property is Array, hints the editor how to show elements. The hint_string must encode nested types using ":" and "/".
    TYPE_STRING = 23,

    //Deprecated: This hint is not used by the engine.
    NODE_PATH_TO_EDITED_NODE = 24,

    //Hints that an object is too big to be sent via the debugger.
    OBJECT_TOO_BIG = 25,

    //Hints that the hint string specifies valid node types for property of type NodePath.
    NODE_PATH_VALID_TYPES = 26,

    //Hints that a String property is a path to a file. Editing it will show a file dialog for picking the path for the file to be saved at. The dialog has access to the project's directory. The hint string can be a set of filters with wildcards like "*.png,*.jpg". See also FileDialog.filters.
    SAVE_FILE = 27,

    //Hints that a String property is a path to a file. Editing it will show a file dialog for picking the path for the file to be saved at. The dialog has access to the entire filesystem. The hint string can be a set of filters with wildcards like "*.png,*.jpg". See also FileDialog.filters.
    GLOBAL_SAVE_FILE = 28,

    //Deprecated: This hint is not used by the engine.
    INT_IS_OBJECTID = 29,

    //Hints that an int property is a pointer. Used by GDExtension.
    INT_IS_POINTER = 30,

    //Hints that a property is an Array with the stored type specified in the hint string. The hint string contains the type of the array (e.g. "String").
    //Use the hint string format from PROPERTY_HINT_TYPE_STRING for more control over the stored type.
    ARRAY_TYPE = 31,

    //Hints that a string property is a locale code. Editing it will show a locale dialog for picking language and country.
    LOCALE_ID = 32,

    //Hints that a dictionary property is string translation map. Dictionary keys are locale codes and, values are translated strings.
    LOCALIZABLE_STRING = 33,

    //Hints that a property is an instance of a Node-derived type, optionally specified via the hint string (e.g. "Node2D"). Editing it will show a dialog for picking a node from the scene.
    //This is saved as a NodePath in the tscn. Seeing as there's no Node type itself, it seems like this is mainly to allow you to ref the correct thing based on the NodePath.
    NODE_TYPE = 34,

    //Hints that a quaternion property should disable the temporary euler editor.
    HIDE_QUATERNION_EDIT = 35,

    //Hints that a string property is a password, and every character is replaced with the secret character.
    PASSWORD = 36,

    //Hints that an integer property is a bitmask using the optionally named avoidance layers.
    LAYERS_AVOIDANCE = 37,

    //Hints that a property is a Dictionary with the stored types specified in the hint string. The hint string contains the key and value types separated by a semicolon (e.g. "int;String").
    //Use the hint string format from PROPERTY_HINT_TYPE_STRING for more control over the stored types.
    DICTIONARY_TYPE = 38,

    //Hints that a Callable property should be displayed as a clickable button. When the button is pressed, the callable is called. The hint string specifies the button text and optionally an icon from the "EditorIcons" theme type.
    //"Click me!" - A button with the text "Click me!" and the default "Callable" icon.
    //"Click me!,ColorRect" - A button with the text "Click me!" and the "ColorRect" icon.
    //Note: A Callable cannot be properly serialized and stored in a file, so it is recommended to use PROPERTY_USAGE_EDITOR instead of PROPERTY_USAGE_DEFAULT.
    TOOL_BUTTON = 39,

    //Hints that a property will be changed on its own after setting, such as AudioStreamPlayer.playing or GPUParticles3D.emitting.
    ONESHOT = 40,

    //Hints that a boolean property will enable the feature associated with the group that it occurs in. The property will be displayed as a checkbox on the group header. Only works within a group or subgroup.
    //By default, disabling the property hides all properties in the group. Use the optional hint string "checkbox_only" to disable this behavior.
    GROUP_ENABLE = 42,

    //Hints that a String or StringName property is the name of an input action. This allows the selection of any action name from the Input Map in the Project Settings. The hint string may contain two options separated by commas:
    //If it contains "show_builtin", built-in input actions are included in the selection.
    //If it contains "loose_mode", loose mode is enabled. This allows inserting any action name even if it's not present in the input map.
    INPUT_NAME = 43,

    //Like PROPERTY_HINT_FILE, but the property is stored as a raw path, not UID. That means the reference will be broken if you move the file. Consider using PROPERTY_HINT_FILE when possible.
    FILE_PATH = 44,

    //Represents the size of the PropertyHint enum.
    MAX = 45,

}


PROPERTY_USAGE_DEFAULT : PropertyUsageFlagsbits: {PropertyUsageFlags.STORAGE, PropertyUsageFlags.EDITOR}
PropertyUsageFlagsbits:: distinct bit_set [PropertyUsageFlags; u32]
//To know what to actually do with this flag set check docs linked below.
//https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-propertyusageflags
//PROPERTY_USAGE_DEFAULT = 6,
//An export preset property with this flag contains confidential information and is stored separately from the rest of the export preset configuration.

PropertyUsageFlags:: enum u32 {
//The property is not stored, and does not display in the editor. This is the default for non-exported properties.
//Odin calls this nil
//PROPERTY_USAGE_NONE = 0,

  Not_A_Value, //Because there is no '1'

  STORAGE,
  //NO_EDITOR = 2
//Default usage but without showing the property in the editor (storage).
//The property is serialized and saved in the scene file (default for exported properties).


  EDITOR,
//The property is shown in the EditorInspector (default for exported properties).

  //PROPERTY_USAGE_DEFAULT = 6,
//Default usage (storage and editor).

  INTERNAL,
//The property is excluded from the class reference.

  CHECKABLE, 
//The property can be checked in the EditorInspector.

  CHECKED, 
//The property is checked in the EditorInspector.

  GROUP, 
//Used to group properties together in the editor. See EditorInspector.

  CATEGORY, 
//Used to categorize properties together in the editor

  SUBGROUP, 
//Used to group properties together in the editor in a subgroup (under a group). See EditorInspector.

  CLASS_IS_BITFIELD,
//The property is a bitfield, i.e. it contains multiple flags represented as bits.

  NO_INSTANCE_STATE,
//The property does not save its state in PackedScene.

  RESTART_IF_CHANGED,
//Editing the property prompts the user for restarting the editor.

  SCRIPT_VARIABLE,
//The property is a script variable. PROPERTY_USAGE_SCRIPT_VARIABLE can be used to distinguish between exported script variables from built-in variables (which don't have this usage flag). By default, PROPERTY_USAGE_SCRIPT_VARIABLE is not applied to variables that are created by overriding Object._get_property_list() in a script.

  STORE_IF_NULL,
//The property value of type Object will be stored even if its value is null.

  UPDATE_ALL_IF_MODIFIED, 
//If this property is modified, all inspector fields will be refreshed.

  SCRIPT_DEFAULT_VALUE,
//Deprecated: This flag is not used by the engine.

  CLASS_IS_ENUM,
//The property is a variable of enum type, i.e. it only takes named integer constants from its associated enumeration.

  NIL_IS_VARIANT,
//If property has nil as default value, its type will be Variant.

  ARRAY,
//The property is an array.

  ALWAYS_DUPLICATE, 
//When duplicating a resource with Resource.duplicate(), and this flag is set on a property of that resource, the property should always be duplicated, regardless of the subresources bool parameter.

  NEVER_DUPLICATE, 
//When duplicating a resource with Resource.duplicate(), and this flag is set on a property of that resource, the property should never be duplicated, regardless of the subresources bool parameter.

  HIGH_END_GFX, 
//The property is only shown in the editor if modern renderers are supported (the Compatibility rendering method is excluded).

  NODE_PATH_FROM_SCENE_ROOT, 
//The NodePath property will always be relative to the scene's root. Mostly useful for local resources.

  RESOURCE_NOT_PERSISTENT, 
//Use when a resource is created on the fly, i.e. the getter will always return a different instance. ResourceSaver needs this information to properly save such resources.

  KEYING_INCREMENTS, 
//Inserting an animation key frame of this property will automatically increment the value, allowing to easily keyframe multiple values in a row.

  DEFERRED_SET_RESOURCE, 
//Deprecated: This flag is not used by the engine.

  EDITOR_INSTANTIATE_OBJECT, 
//When this property is a Resource and base object is a Node, a resource instance will be automatically created whenever the node is created in the editor.

  EDITOR_BASIC_SETTING, 
//The property is considered a basic setting and will appear even when advanced mode is disabled. Used for project settings.

  READ_ONLY, 
//The property is read-only in the EditorInspector.

  SECRET, 
//An export preset property with this flag contains confidential information and is stored separately from the rest of the export preset configuration.

}

ConnectFlags :: bit_set [Connect; u32]

Connect:: enum {
  DEFERRED = 1,
  //Deferred connections trigger their Callables on idle time (at the end of the frame), rather than instantly.

  PERSIST = 2,
  //Persisting connections are stored when the object is serialized (such as when using PackedScene.pack()). In the editor, connections created through the Node dock are always persisting.

  ONE_SHOT = 4,
  //One-shot connections disconnect themselves after emission.

  REFERENCE_COUNTED = 8,
  //Reference-counted connections can be assigned to the same Callable multiple times. Each disconnection decreases the internal counter. The signal fully disconnects only when the counter reaches 0.

  APPEND_SOURCE_OBJECT = 16,
  //The source object is automatically bound when a PackedScene is instantiated. If this flag bit is enabled, the source object will be appended right after the original arguments of the signal.
}

//WARNING: if the order of the variantType enum changes, this needs to be updated as well.
GDTypes := [?]typeid {
  nil,
  typeid_of(Bool),
  typeid_of(Int),
  typeid_of(float),
  typeid_of(gdstring),
  typeid_of(Vector2),
  typeid_of(Vector2i),
  typeid_of(Rect2),
  typeid_of(Rect2i),
  typeid_of(Vector3),
  typeid_of(Vector3i),
  typeid_of(Transform2D),
  typeid_of(Vector4),
  typeid_of(Vector4i),
  typeid_of(Plane),
  typeid_of(Quaternion),
  typeid_of(AABB),
  typeid_of(Basis),
  typeid_of(Transform3D),
  typeid_of(Projection),
  typeid_of(Color),
  typeid_of(StringName),
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

GDTypes_strings := [GDE.VariantType]string {
  .NIL = "nil",
  .BOOL = "bool",
  .INT = "int",
  .FLOAT = "float",
  .STRING = "String",
  .VECTOR2 = "Vector2",
  .VECTOR2I = "Vector2i",
  .RECT2 = "Rect2",
  .RECT2I = "Rect2i",
  .VECTOR3 = "Vector3",
  .VECTOR3I = "Vector3i",
  .TRANSFORM2D = "Transform2D",
  .VECTOR4 = "Vector4",
  .VECTOR4I = "Vector4i",
  .PLANE = "Plane",
  .QUATERNION = "Quaternion",
  .AABB = "AABB",
  .BASIS = "Basis",
  .TRANSFORM3D = "Transform3D",
  .PROJECTION = "Projection",
  .COLOR = "Color",
  .STRING_NAME = "StringName",
  .NODE_PATH = "NodePath",
  .RID = "RID",
  .OBJECT = "Object",
  .CALLABLE = "Callable",
  .SIGNAL = "Signal",
  .DICTIONARY = "Dictionary",
  .ARRAY = "Array",
  .PACKED_BYTE_ARRAY = "PackedByteArray",
  .PACKED_INT32_ARRAY = "PackedInt32Array",
  .PACKED_INT64_ARRAY = "PackedInt64Array",
  .PACKED_FLOAT32_ARRAY = "PackedFloat32Array",
  .PACKED_FLOAT64_ARRAY = "PackedFloat64Array",
  .PACKED_STRING_ARRAY = "PackedStringArray",
  .PACKED_VECTOR2_ARRAY = "PackedVector2Array",
  .PACKED_VECTOR3_ARRAY = "PackedVector3Array",
  .PACKED_COLOR_ARRAY = "PackedColorArray",
  .PACKED_VECTOR4_ARRAY = "PackedVector4Array",
  .VARIANT_MAX = "Variant",
}

