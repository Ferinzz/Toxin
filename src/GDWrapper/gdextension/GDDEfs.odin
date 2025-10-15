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
    proxy:rawptr,
}

/*Represents a function. It can either be a method within an Object instance,
or a custom callable used for different purposes.
object is a union of u64 (objectID) or ^custom callable.
Use gdAPI.ObjectGetInstanceFromId to get the ObjectPtr
*/
//https://github.com/godotengine/godot/blob/c6d130abd9188f313e6701d01a0ddd6ea32166a0/core/variant/callable.h#L47
Callable :: distinct struct{
    stringName: StringName,
    objectId: u64,
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


/*
* Variables here are not defined by Godot but are useful for defining Properties.
* Primarily centered around differing versions of int or strings
*/

//Godot's layers are limited by the engine. Check below link for their values.
//https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-layer-names-2d-navigation-layer-1
//bit flag field for layers.
//The widget in the Inspector dock will use the layer names defined in ProjectSettings.layer_names
layers_2d_render:: bit_set[0..=20; Int]
layers_3d_render:: bit_set[0..=20; Int]

layers_2d_physics:: bit_set[0..=32; Int]
layers_3d_physics:: bit_set[0..=32; Int]

layers_2d_navigation:: bit_set[0..=32; Int]
layers_3d_navigation:: bit_set[0..=32; Int]

layers_avoidance:: bit_set[0..=32; Int]


//Specifies a locale.
//Editing will show locale dialog for picking language and country.
LOCALE_ID :: distinct gdstring

//Specifies a password
PASSWORD :: distinct gdstring

//gdstring with a placeholder text specified in the propertyHints
GDSTRING_WITH_PLACEHOLDER_TEXT :: struct{
  input_string: gdstring,
  placeholder: gdstring,
}

STRINGARRAY_WITH_PLACEHOLDER_TEXT :: struct{
  input_string: Array,
  placeholder: gdstring,
}

//gdstring with multiple lines
MULTILINE_TEXT :: distinct gdstring

//Specifies that an string is the name of an input action.
//may contain two options separated by comma
//If it contains "show_builtin", built-in input actions are included in the selection.
//If it contains "loose_mode", loose mode is enabled. This allows inserting any action name even if it's not present in the input map.
INPUT_NAME_STRING :: distinct gdstring
INPUT_NAME_STRINGNAME :: distinct gdstring

//String to a path to a file or directory.
Path:: gdstring

//Specifies a path to something.
//When making public specify what kind of path it is.
PATH :: struct {
  path: Path,
  type: PATH_TYPES,
}

PATH_TYPES :: enum {
  DIR, //path to a directory
  FILE, //path to a file filters with wildcards like "*.png,*.jpg"
  FILE_PATH, //stored as raw path instead of UID
  GLOBAL_DIR, //absolute path to directory
  GLOBAL_FILE, //absolute path to file
  SAVE_FILE, //file path. can have wildcards like "*.png,*.jpg".
  GLOBAL_SAVE_FILE, //absoulte file path. can have wildcards like "*.png,*.jpg".
}

/*Struct to pass data for a ranged variable.
* Supports: float, int
* min: lowest value allowed by the editor.
* max: largest value allowed by the editor.
* step: by how much it should increment. 0 will be ignored.
* flags: additional usage information.
* validate: Not implemented. if Odin's callback should verify the range.
*/
Ranged_Num :: struct ($T: typeid) {
  min: T,
  max: T,
  step: T,
  flags: Range_Flags,
  //validate: bool, //Specify if you want Odin callbacks to validate the range.
}

/*
* Supports: Array[int], Array[float], PackedByteArray, PackedInt32Array, PackedInt64Array, PackedFloat32Array, or PackedFloat64Array
* indexType should be one of GDE.Int or GDE.float
* min: lowest value allowed by the editor.
* max: largest value allowed by the editor.
* step: by how much it should increment. 0 will be ignored.
* flags: additional usage information.
* validate: Not implemented. if Odin's callback should verify the range.
*/
Ranged_Array :: struct ($indexType: typeid) {
  min: indexType,
  max: indexType,
  step: indexType,
  flags: Range_Flags,
  //validate: bool, //Specify if you want Odin callbacks to validate the range.
}

Range_Flags :: bit_set [Range; Int]

Range :: enum {
  or_greater,
  or_less,
  exp,
  hide_slider,
  radians_as_degrees,
  degrees,
}

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
  icon: Path,
}

Easing_Type: [Easing_Options]string = {
  .none = "",
  .attenuation= "attenuation",
  .positive_only = "positive_only",
}

Easing_Options :: enum {
  none,
  attenuation,
  positive_only,
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
PropertyUsageFlagsbits:: bit_set [PropertyUsageFlags; u32]
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



//*********************\\
//*******GLOBALS*******\\
//*********************\\



MouseButtonMask :: enum i32 {
    MOUSE_BUTTON_MASK_LEFT = 1,
    MOUSE_BUTTON_MASK_RIGHT = 2,
    MOUSE_BUTTON_MASK_MIDDLE = 4,
    MOUSE_BUTTON_MASK_MB_XBUTTON1 = 128,
    MOUSE_BUTTON_MASK_MB_XBUTTON2 = 256,
}

MouseButton :: enum i32 {
    MOUSE_BUTTON_NONE,
    MOUSE_BUTTON_LEFT,
    MOUSE_BUTTON_RIGHT,
    MOUSE_BUTTON_MIDDLE,
    MOUSE_BUTTON_WHEEL_UP,
    MOUSE_BUTTON_WHEEL_DOWN,
    MOUSE_BUTTON_WHEEL_LEFT,
    MOUSE_BUTTON_WHEEL_RIGHT,
    MOUSE_BUTTON_XBUTTON1,
    MOUSE_BUTTON_XBUTTON2,
}
    
Key :: enum i32 {
    KEY_NONE= 0,
    KEY_SPECIAL= 4194304,
    KEY_ESCAPE= 4194305,
    KEY_TAB= 4194306,
    KEY_BACKTAB= 4194307,
    KEY_BACKSPACE= 4194308,
    KEY_ENTER= 4194309,
    KEY_KP_ENTER= 4194310,
    KEY_INSERT= 4194311,
    KEY_DELETE= 4194312,
    KEY_PAUSE= 4194313,
    KEY_PRINT= 4194314,
    KEY_SYSREQ= 4194315,
    KEY_CLEAR= 4194316,
    KEY_HOME= 4194317,
    KEY_END= 4194318,
    KEY_LEFT= 4194319,
    KEY_UP= 4194320,
    KEY_RIGHT= 4194321,
    KEY_DOWN= 4194322,
    KEY_PAGEUP= 4194323,
    KEY_PAGEDOWN= 4194324,
    KEY_SHIFT= 4194325,
    KEY_CTRL= 4194326,
    KEY_META= 4194327,
    KEY_ALT= 4194328,
    KEY_CAPSLOCK= 4194329,
    KEY_NUMLOCK= 4194330,
    KEY_SCROLLLOCK= 4194331,
    KEY_F1= 4194332,
    KEY_F2= 4194333,
    KEY_F3= 4194334,
    KEY_F4= 4194335,
    KEY_F5= 4194336,
    KEY_F6= 4194337,
    KEY_F7= 4194338,
    KEY_F8= 4194339,
    KEY_F9= 4194340,
    KEY_F10= 4194341,
    KEY_F11= 4194342,
    KEY_F12= 4194343,
    KEY_F13= 4194344,
    KEY_F14= 4194345,
    KEY_F15= 4194346,
    KEY_F16= 4194347,
    KEY_F17= 4194348,
    KEY_F18= 4194349,
    KEY_F19= 4194350,
    KEY_F20= 4194351,
    KEY_F21= 4194352,
    KEY_F22= 4194353,
    KEY_F23= 4194354,
    KEY_F24= 4194355,
    KEY_F25= 4194356,
    KEY_F26= 4194357,
    KEY_F27= 4194358,
    KEY_F28= 4194359,
    KEY_F29= 4194360,
    KEY_F30= 4194361,
    KEY_F31= 4194362,
    KEY_F32= 4194363,
    KEY_F33= 4194364,
    KEY_F34= 4194365,
    KEY_F35= 4194366,
    KEY_KP_MULTIPLY= 4194433,
    KEY_KP_DIVIDE= 4194434,
    KEY_KP_SUBTRACT= 4194435,
    KEY_KP_PERIOD= 4194436,
    KEY_KP_ADD= 4194437,
    KEY_KP_0= 4194438,
    KEY_KP_1= 4194439,
    KEY_KP_2= 4194440,
    KEY_KP_3= 4194441,
    KEY_KP_4= 4194442,
    KEY_KP_5= 4194443,
    KEY_KP_6= 4194444,
    KEY_KP_7= 4194445,
    KEY_KP_8= 4194446,
    KEY_KP_9= 4194447,
    KEY_MENU= 4194370,
    KEY_HYPER= 4194371,
    KEY_HELP= 4194373,
    KEY_BACK= 4194376,
    KEY_FORWARD= 4194377,
    KEY_STOP= 4194378,
    KEY_REFRESH= 4194379,
    KEY_VOLUMEDOWN= 4194380,
    KEY_VOLUMEMUTE= 4194381,
    KEY_VOLUMEUP= 4194382,
    KEY_MEDIAPLAY= 4194388,
    KEY_MEDIASTOP= 4194389,
    KEY_MEDIAPREVIOUS= 4194390,
    KEY_MEDIANEXT= 4194391,
    KEY_MEDIARECORD= 4194392,
    KEY_HOMEPAGE= 4194393,
    KEY_FAVORITES= 4194394,
    KEY_SEARCH= 4194395,
    KEY_STANDBY= 4194396,
    KEY_OPENURL= 4194397,
    KEY_LAUNCHMAIL= 4194398,
    KEY_LAUNCHMEDIA= 4194399,
    KEY_LAUNCH0= 4194400,
    KEY_LAUNCH1= 4194401,
    KEY_LAUNCH2= 4194402,
    KEY_LAUNCH3= 4194403,
    KEY_LAUNCH4= 4194404,
    KEY_LAUNCH5= 4194405,
    KEY_LAUNCH6= 4194406,
    KEY_LAUNCH7= 4194407,
    KEY_LAUNCH8= 4194408,
    KEY_LAUNCH9= 4194409,
    KEY_LAUNCHA= 4194410,
    KEY_LAUNCHB= 4194411,
    KEY_LAUNCHC= 4194412,
    KEY_LAUNCHD= 4194413,
    KEY_LAUNCHE= 4194414,
    KEY_LAUNCHF= 4194415,
    KEY_GLOBE= 4194416,
    KEY_KEYBOARD= 4194417,
    KEY_JIS_EISU= 4194418,
    KEY_JIS_KANA= 4194419,
    KEY_UNKNOWN= 8388607,
    KEY_SPACE= 32,
    KEY_EXCLAM= 33,
    KEY_QUOTEDBL= 34,
    KEY_NUMBERSIGN= 35,
    KEY_DOLLAR= 36,
    KEY_PERCENT= 37,
    KEY_AMPERSAND= 38,
    KEY_APOSTROPHE= 39,
    KEY_PARENLEFT= 40,
    KEY_PARENRIGHT= 41,
    KEY_ASTERISK= 42,
    KEY_PLUS= 43,
    KEY_COMMA= 44,
    KEY_MINUS= 45,
    KEY_PERIOD= 46,
    KEY_SLASH= 47,
    KEY_0= 48,
    KEY_1= 49,
    KEY_2= 50,
    KEY_3= 51,
    KEY_4= 52,
    KEY_5= 53,
    KEY_6= 54,
    KEY_7= 55,
    KEY_8= 56,
    KEY_9= 57,
    KEY_COLON= 58,
    KEY_SEMICOLON= 59,
    KEY_LESS= 60,
    KEY_EQUAL= 61,
    KEY_GREATER= 62,
    KEY_QUESTION= 63,
    KEY_AT= 64,
    KEY_A= 65,
    KEY_B= 66,
    KEY_C= 67,
    KEY_D= 68,
    KEY_E= 69,
    KEY_F= 70,
    KEY_G= 71,
    KEY_H= 72,
    KEY_I= 73,
    KEY_J= 74,
    KEY_K= 75,
    KEY_L= 76,
    KEY_M= 77,
    KEY_N= 78,
    KEY_O= 79,
    KEY_P= 80,
    KEY_Q= 81,
    KEY_R= 82,
    KEY_S= 83,
    KEY_T= 84,
    KEY_U= 85,
    KEY_V= 86,
    KEY_W= 87,
    KEY_X= 88,
    KEY_Y= 89,
    KEY_Z= 90,
    KEY_BRACKETLEFT= 91,
    KEY_BACKSLASH= 92,
    KEY_BRACKETRIGHT= 93,
    KEY_ASCIICIRCUM= 94,
    KEY_UNDERSCORE= 95,
    KEY_QUOTELEFT= 96,
    KEY_BRACELEFT= 123,
    KEY_BAR= 124,
    KEY_BRACERIGHT= 125,
    KEY_ASCIITILDE= 126,
    KEY_YEN= 165,
    KEY_SECTION= 167,
}

//*****************************\\
//****Input Singleton enums****\\
//*****************************\\
//These are the enums specific to the Input Singleton itself, not necessarily used for the methods.

MouseMode :: enum i32 {
    MOUSE_MODE_VISIBLE = 0,
    MOUSE_MODE_HIDDEN = 1,
    MOUSE_MODE_CAPTURED = 2,
    MOUSE_MODE_CONFINED = 3,
    MOUSE_MODE_CONFINED_HIDDEN = 4,
    MOUSE_MODE_MAX = 5
}
    
CursorShape :: enum i32 {
    CURSOR_ARROW = 0,
    CURSOR_IBEAM = 1,
    CURSOR_POINTING_HAND = 2,
    CURSOR_CROSS = 3,
    CURSOR_WAIT = 4,
    CURSOR_BUSY = 5,
    CURSOR_DRAG = 6,
    CURSOR_CAN_DROP = 7,
    CURSOR_FORBIDDEN = 8,
    CURSOR_VSIZE = 9,
    CURSOR_HSIZE = 10,
    CURSOR_BDIAGSIZE = 11,
    CURSOR_FDIAGSIZE = 12,
    CURSOR_MOVE = 13,
    CURSOR_VSPLIT = 14,
    CURSOR_HSPLIT = 15,
    CURSOR_HELP = 16
}