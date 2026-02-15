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
    _: [16]u8,
    array: packed_type,
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



//*********************\\
//*******GLOBALS*******\\
//*********************\\



MouseButtonMask :: enum i64 {
    MOUSE_BUTTON_MASK_LEFT = 1,
    MOUSE_BUTTON_MASK_RIGHT = 2,
    MOUSE_BUTTON_MASK_MIDDLE = 4,
    MOUSE_BUTTON_MASK_MB_XBUTTON1 = 128,
    MOUSE_BUTTON_MASK_MB_XBUTTON2 = 256,
}

MouseButton :: enum i64 {
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
    
Key :: enum i64 {
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

MouseMode :: enum i64 {
    MOUSE_MODE_VISIBLE = 0,
    MOUSE_MODE_HIDDEN = 1,
    MOUSE_MODE_CAPTURED = 2,
    MOUSE_MODE_CONFINED = 3,
    MOUSE_MODE_CONFINED_HIDDEN = 4,
    MOUSE_MODE_MAX = 5
}
    
CursorShape :: enum i64 {
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

PlaybackType :: enum i64 {
  //The playback will be considered of the type declared at ProjectSettings.audio/general/default_playback_type.
  PLAYBACK_TYPE_DEFAULT,
  //Force the playback to be considered as a stream.
	PLAYBACK_TYPE_STREAM,
  /*
  * Force the playback to be considered as a sample. This can provide lower latency and more stable playback (with less risk of audio crackling), at the cost of having less flexibility.
  * Note: Only currently supported on the web platform.
  * Note: AudioEffects are not supported when playback is considered as a sample.
  */
  PLAYBACK_TYPE_SAMPLE,
  //IGNORE Represents the size of the PlaybackType enum.
  PLAYBACK_TYPE_MAX,
}