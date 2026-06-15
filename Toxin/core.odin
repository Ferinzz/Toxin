package Toxin

import Classes "../GD_Classes"
import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import "base:runtime"
import GDE "../GDWrapper/gdAPI/gdextension"
import "core:c"


inits: struct {
    core: Core_Init_Callback,
    servers: Servers_Init_Callback,
    scene: Scene_Init_Callback,
    editor: Editor_Init_Callback,
}

inits_deinits :: struct {
    userdata: rawptr,
    core_init: Core_Init_Callback,
    servers_init: Servers_Init_Callback,
    scene_init: Scene_Init_Callback,
    editor_init: Editor_Init_Callback,
    core_deinit: Core_deInit_Callback,
    servers_deinit: Servers_deInit_Callback,
    scene_deinit: Scene_deInit_Callback,
    editor_deinit: Editor_deInit_Callback,
    classes: registered_classes,
}

core_inits :: struct {
    core_init: Core_Init_Callback,
    servers_init: Servers_Init_Callback,
    scene_init: Scene_Init_Callback,
    editor_init: Editor_Init_Callback,
}

core_deinits :: struct {
    core_deinit: Core_deInit_Callback,
    servers_deinit: Servers_deInit_Callback,
    scene_deinit: Scene_deInit_Callback,
    editor_deinit: Editor_deInit_Callback,
}

Source_Code_Location :: struct {
	file_path:    string,
	line, column: i32,
	procedure:    string,
}

Core_Init_Callback :: #type proc "c" (userdata: rawptr);
Servers_Init_Callback :: #type proc "c" (userdata: rawptr);
Scene_Init_Callback :: #type proc "c" (userdata: rawptr);
Editor_Init_Callback :: #type proc "c" (userdata: rawptr);

Core_deInit_Callback :: #type proc "c" (userdata: rawptr);
Servers_deInit_Callback :: #type proc "c" (userdata: rawptr);
Scene_deInit_Callback :: #type proc "c" (userdata: rawptr);
Editor_deInit_Callback :: #type proc "c" (userdata: rawptr);


Deinits: struct {
    core: Core_DeInit_Callback,
    servers: Servers_DeInit_Callback,
    scene: Scene_DeInit_Callback,
    editor: Editor_DeInit_Callback,
}

Core_DeInit_Callback :: #type proc "c" (userdata: rawptr);
Scene_DeInit_Callback :: #type proc "c" (userdata: rawptr);
Servers_DeInit_Callback :: #type proc "c" (userdata: rawptr);
Editor_DeInit_Callback :: #type proc "c" (userdata: rawptr);

extensionInit :: proc "c" (userdata: rawptr, init_Level: GDE.InitializationLevel) {
    _extensionInit(userdata, init_Level)
}

extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    _extensionDeinit(userdata, deinitLevel)
}

Init_Singletons :: proc "c" (singletons: ^Singletons) {
    context = runtime.default_context()
    _Init_Singletons(singletons)
}

getMainLoop :: proc "c" () -> ^Object {
    context = runtime.default_context()
    return _getMainLoop()
}

getRoot :: proc "c" () -> ^Object {
    context = runtime.default_context()
    return _getRoot()
}

EngineObj :: proc "c" () -> ^Object {
    context = runtime.default_context()
    return _EngineObj()
}

get_delta_time :: proc() -> (delta: float) {
    Classes.Node_get_process_delta_time->m_call(root_node_instance, r_ret = &delta)
    return
}

Library : GDE.ClassDB = nil
singletons: Singletons
scene_tree_obj: ^Object
root_node_instance: ^Object



//singletons: Singletons

Singletons :: struct {
    Performance: ^Object,
    Engine: ^Object,
    ProjectSettings: ^Object,
    OS: ^Object,

    Time: ^Object,
    TextServerManager: ^Object,
    PhysicsServer2DManager: ^Object,
    PhysicsServer3DManager: ^Object,
    NavigationServer2DManager: ^Object,
    NavigationServer3DManager: ^Object,
    NavigationMeshGenerator: ^Object,
    IP: ^Object,
    Geometry2D: ^Object,
    Geometry3D: ^Object,
    ResourceLoader: ^Object,
    ResourceSaver: ^Object,
    ClassDB: ^Object,
    Marshalls: ^Object,
    TranslationServer: ^Object,
    Input: ^Object,
    InputMap: ^Object,
    EngineDebugger: ^Object,
    GDExtensionManager: ^Object,

    ResourceUID: ^Object,

    WorkerThreadPool: ^Object,

    ThemeDB: ^Object,

    EditorInterface: ^Object,

    JavaClassWrapper: ^Object,

    JavaScriptBridge: ^Object,

    AudioServer: ^Object,

    CameraServer: ^Object,

    DisplayServer: ^Object,

    NativeMenu: ^Object,

    RenderingServer: ^Object,

    NavigationServer2D: ^Object,

    NavigationServer3D: ^Object,

    PhysicsServer2D: ^Object,

    PhysicsServer3D: ^Object,

    XRServer: ^Object,

}

Performance: ^Object

Engine: ^Object

ProjectSettings: ^Object

OS: ^Object

Time: ^Object

TextServerManager: ^Object

PhysicsServer2DManager: ^Object

PhysicsServer3DManager: ^Object


NavigationServer2DManager: ^Object

NavigationServer3DManager: ^Object
NavigationMeshGenerator: ^Object

IP: ^Object

Geometry2D: ^Object

Geometry3D: ^Object

ResourceLoader: ^Object

ResourceSaver: ^Object

ClassDB: ^Object

Marshalls: ^Object

TranslationServer: ^Object

Input: ^Object

InputMap: ^Object

EngineDebugger: ^Object

GDExtensionManager: ^Object

ResourceUID: ^Object

WorkerThreadPool: ^Object

ThemeDB: ^Object

EditorInterface: ^Object

JavaClassWrapper: ^Object

JavaScriptBridge: ^Object

AudioServer: ^Object

CameraServer: ^Object

DisplayServer: ^Object

NativeMenu: ^Object

RenderingServer: ^Object

NavigationServer2D: ^Object

NavigationServer3D: ^Object

PhysicsServer2D: ^Object

PhysicsServer3D: ^Object

XRServer: ^Object


/*
* Function used to register a custom class with Godot. This will use the information provided in class_info or default to bltn equivalents.
* This will need to be called by you at some point during your extension's initialization.
* deets: the struct describing the class which you are registering.
* init_level: the current initialization level of Godot's startup procedure.
* class_info: the information about the class which you would like to use when customizing.
*/

Register :: proc "c" (deets: ^Class_Deets, init_level: InitializationLevel, class_info: GDE.ClassCreationInfo4) {
        context = runtime.default_context()
        _Register(deets, init_level, class_info)
}

/*
* default for class_info would be just to expose it.
* read definition of GDE.ClassCreationInfo4 for more details on each field.
*/
class_info_Default: GDE.ClassCreationInfo4 = {
    is_virtual = false,
    is_abstract = false,
    is_exposed = true,
    is_runtime = false,
}

InitializationLevel :: enum {
	INITIALIZATION_CORE,
	INITIALIZATION_SERVERS,
	INITIALIZATION_SCENE,
	INITIALIZATION_EDITOR,
	MAX_INITIALIZATION_LEVEL,
}

//Optional. Toxin will default to Godot's memory if you do not provide this.
//Pass TMAlloc_Create via classCreateInfo during Registration if you use this.
TMAlloc : proc "c" (p_class_user_data: ^Class_Deets, p_bytes: Int) -> rawptr

//Optional. Toxin will default to Godot's memory if you do not provide this.
//Pass TMAlloc_Destroy via classCreateInfo during Registration if you use this.
TMFree : proc "c" (p_class_user_data: ^Class_Deets, p_ptr: rawptr)

/*
* Container type for the class Node.
* Self: pointer to the Godot Class as instantiated by Create.
* Will be used in Create and Destroy to allocate size and add pointer to the Godot base Node which gets created (aka Node2D)
* Will be passed into the procedures you create, as well as the virtuals that come with the Godot Node.
*/
Class_Container_c :: struct #packed {
    self: ^Object, //Keep as first so it can be trivially cast.
    class: struct{},
}

//Called by Godot
//This is the default constructor used. You do not need to pass this explicitly.
bltn_Alloc_Create:= bltn_Create

//Called by Godot
//pass to register via ClassCreateInfo to override default.
cstm_Alloc_Create2 := TMAlloc_Create

//Called by Godot
//This is the default destructor used. No need to pass to Register.
bltn_Alloc_Destroy:= bltn_Destroy

//Called by Godot
//pass to register via ClassCreateInfo to override default.
cstm_Free_Destroy:= TMFree_Destroy

//Pass to Register via ClassCreateInfo if your class will use any virtual methods.
get_virtual:= _get_virtual

/*
* These are not necessary for the custom classes, but are useful if you want to include side-effects to an object that has no association with this GDE.
* Main example is to make your own wrapper around the object through create.
* create_callback is used when get_instance_binding is unable to find the GDE associated with an object
* free_callback is called whenever the object is freed. Use for destructor side-effects (all the children are dead, kill parent)
* reference_callback called on reference. Reply if this can be destroyed.
*/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil,
};

//**********************\\
//*******Variants*******\\
//**********************\\


_variant_get_ptr :: proc "c" (variant: ^Variant) -> rawptr {
    context = runtime.default_context()
    return _variant_get_ptr(variant)
}

get_version :: #force_inline proc() -> (version: GDE.GodotVersion2) {
    gdAPI.GD_Version_Get.GetGodotVersion2(&version)
    return 
}

make_property :: #force_inline proc(type: GDE.VariantType, name: string) -> GDE.PropertyInfo {
    return makePropertyFull_string(type, name, GDE.PropertyHint.NONE, "", "", GDE.PROPERTY_USAGE_DEFAULT)
}

Make_Property_Full :: proc {
    makePropertyFull_cstring,
    makePropertyFull_string,
}

//TODO : See if I really need to malloc these variables or if that's just something for C to do.
//Odin has a bunch of memory management. If all we need is to malloc memory to heap we can do that with new().
makePropertyFull_cstring :: proc(type: GDE.VariantType, name: cstring, hint: GDE.PropertyHint, hintString: cstring, className: cstring, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {

    prop_name:= new(StringName)
    gdAPI.StringName_Utils.Latin1Chars(prop_name, name, false)

    propHintString:= new(gdstring)
    gdAPI.Strings_Utils.NewWithUtf8Chars(propHintString, hintString)

    propClassName:= new(StringName)
    gdAPI.StringName_Utils.Latin1Chars(propClassName, className, false)
    
    info: GDE.PropertyInfo = {
        name = prop_name,
        type = type, //is an enum specifying type. Meh.
        hint = hint, //Hints are hints for the Editor. GDScript doesn't always respect them.
        hint_string = propHintString,
        class_name = propClassName,
        usage = usageFlags,
    }

    return info
}

makePropertyFull_string :: proc(type: GDE.VariantType, name: string, hint: PropertyHint, hintString: string, className: string, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {

    prop_name:= new(StringName)
    gdAPI.StringName_Utils.Utf8CharsAndLen(prop_name, raw_data(name), i64(len(name)))

    propHintString:= new(gdstring)
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(propHintString, raw_data(hintString), i64(len(hintString)))

    propClassName:= new(StringName)
    gdAPI.StringName_Utils.Utf8CharsAndLen(propClassName, raw_data(className), i64(len(className)))
    
    info: GDE.PropertyInfo = {
        name = prop_name,
        type = type, //is an enum specifying type. Meh.
        hint = hint, //Hints are hints for the Editor. GDScript doesn't always respect them.
        hint_string = propHintString,
        class_name = propClassName,
        usage = usageFlags
    }

    return info
}


destructProperty :: proc(info: ^GDE.PropertyInfo) {
    
    if info.name != nil{
        GDW.StringName_M_List.Destroy(info.name)
    }
    if info.class_name != nil {
        GDW.StringName_M_List.Destroy(info.class_name)
    }
    if info.hint_string != nil {
        GDW.gdstring_M_List.Destroy(info.hint_string)
    }
    
    //See above TODO. If malloc is not needed, wouldn't need to free.
    if info.name != nil{
    free(info.name)}
    if info.hint_string != nil {
    free(info.class_name)}
    if info.class_name != nil {
    free(info.hint_string)}
}


Bind_Property :: proc {
    bindProperty,
    Bind_Property_Prop_Info,
}

Bind_Property_Prop_Info :: #force_inline proc(className: ^StringName, name: string, type: GDE.VariantType, prop_hint: ^GDE.PropertyInfo, getter, setter: string, loc:=#caller_location) {

    getterName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&getterName, raw_data(getter[:]), i64(len(getter)))
    setterName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&setterName, raw_data(setter[:]), i64(len(setter)))
    gdAPI.ClassDB.RegisterExtensionClassProperty(Library, className, prop_hint, &setterName, &getterName)
    
    fmethod_name:= GDE.Variant{VType = .STRING_NAME}
    fmethod_name.data[0] = transmute(u64)(getterName.ptr)
    gdAPI.Variant_Utils.Destroy(&fmethod_name)
    fmethod_name.data[0] = transmute(u64)(setterName.ptr)
    gdAPI.Variant_Utils.Destroy(&fmethod_name)
    
}

/*
* bindProperty is used to make your variable public.
* Prior to calling this you should have registered the get and/or set functions with Godot.
* Provide their names as cstrings. Check the makePublic function for a general workflow.
* Use makePublic to auto-gen basic get/set functions for simple variables. (I haven't tested with arrays.)
*/
bindProperty :: #force_inline proc(className: ^StringName, name: string, type: GDE.VariantType, getter, setter: cstring, loc:=#caller_location) {
    
    info: GDE.PropertyInfo = make_property(type, name)

    getterName: StringName
    gdAPI.StringName_Utils.Latin1Chars(&getterName, getter, false)
    setterName: StringName
    gdAPI.StringName_Utils.Latin1Chars(&setterName, setter, false)
    gdAPI.ClassDB.RegisterExtensionClassProperty(Library, className, &info, &setterName, &getterName)

    //Destructor stuff
    destructProperty(&info)
}



gdstring_new :: proc(text: string) -> (ret: gdstring) {
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(&ret, raw_data(text), Int(len(text)))
    return
}