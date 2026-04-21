package Toxin

import Classes "../GD_Classes"
import "base:runtime"
import GDE "../GDWrapper/gdAPI/gdextension"
import "core:c"

@(export)
inits: struct {
    core: Core_Init_Callback,
    servers: Servers_Init_Callback,
    scene: Scene_Init_Callback,
    editor: Editor_Init_Callback,
}

Core_Init_Callback :: #type proc "c" (userdata: rawptr);
Servers_Init_Callback :: #type proc "c" (userdata: rawptr);
Scene_Init_Callback :: #type proc "c" (userdata: rawptr);
Editor_Init_Callback :: #type proc "c" (userdata: rawptr);

@(export)
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

@(export)
extensionInit :: proc "c" (userdata: rawptr, init_Level: GDE.InitializationLevel) {
    _extensionInit(userdata, init_Level)
}

@(export)
extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    _extensionDeinit(userdata, deinitLevel)
}

@(export)
Init_Singletons :: proc "c" (singletons: ^Singletons) {
    context = runtime.default_context()
    _Init_Singletons(singletons)
}

@(export)
getMainLoop :: proc"c"(singletons: Singletons) -> ^Object {
    context = runtime.default_context()
    return _getMainLoop(singletons)
}

@(export)
getRoot :: proc "c" (singletons: Singletons, scenetree_class: Classes.SceneTree_MethodBind_List) -> ^Object {
    context = runtime.default_context()
    return _getRoot(singletons, scenetree_class)
}

@(export)
EngineObj :: proc "c" () -> ^Object {
    context = runtime.default_context()
    return _EngineObj()
}

singletons: Singletons

Singletons :: struct {
    Performance: ^Object,
    Performance_M_List: Classes.Performance_MethodBind_List,
    Engine: ^Object,
    Engine_M_List: Classes.Engine_MethodBind_List,
    ProjectSettings: ^Object,
    ProjectSettings_M_List: Classes.ProjectSettings_MethodBind_List,
    OS: ^Object,
    OS_M_List: Classes.OS_MethodBind_List,
    Time: ^Object,
    Time_M_List: Classes.Time_MethodBind_List,
    TextServerManager: ^Object,
    TextServerManager_M_List: Classes.TextServerManager_MethodBind_List,
    PhysicsServer2DManager: ^Object,
    PhysicsServer2DManager_M_List: Classes.PhysicsServer2DManager_MethodBind_List,
    PhysicsServer3DManager: ^Object,
    PhysicsServer3DManager_M_List: Classes.PhysicsServer3DManager_MethodBind_List,
    NavigationMeshGenerator: ^Object,
    NavigationMeshGenerator_M_List: Classes.NavigationMeshGenerator_MethodBind_List,
    IP: ^Object,
    IP_M_List: Classes.IP_MethodBind_List,
    Geometry2D: ^Object,
    Geometry2D_M_List: Classes.Geometry2D_MethodBind_List,
    Geometry3D: ^Object,
    Geometry3D_M_List: Classes.Geometry3D_MethodBind_List,
    ResourceLoader: ^Object,
    ResourceLoader_M_List: Classes.ResourceLoader_MethodBind_List,
    ResourceSaver: ^Object,
    ResourceSaver_M_List: Classes.ResourceSaver_MethodBind_List,
    ClassDB: ^Object,
    ClassDB_M_List: Classes.ClassDB_MethodBind_List,
    Marshalls: ^Object,
    Marshalls_M_List: Classes.Marshalls_MethodBind_List,
    TranslationServer: ^Object,
    TranslationServer_M_List: Classes.TranslationServer_MethodBind_List,
    Input: ^Object,
    Input_M_List: Classes.Input_MethodBind_List,
    InputMap: ^Object,
    InputMap_M_List: Classes.InputMap_MethodBind_List,
    EngineDebugger: ^Object,
    EngineDebugger_M_List: Classes.EngineDebugger_MethodBind_List,
    GDExtensionManager: ^Object,
    GDExtensionManager_M_List: Classes.GDExtensionManager_MethodBind_List,
    ResourceUID: ^Object,
    ResourceUID_M_List: Classes.ResourceUID_MethodBind_List,
    WorkerThreadPool: ^Object,
    WorkerThreadPool_M_List: Classes.WorkerThreadPool_MethodBind_List,
    ThemeDB: ^Object,
    ThemeDB_M_List: Classes.ThemeDB_MethodBind_List,
    EditorInterface: ^Object,
    EditorInterface_M_List: Classes.EditorInterface_MethodBind_List,
    JavaClassWrapper: ^Object,
    JavaClassWrapper_M_List: Classes.JavaClassWrapper_MethodBind_List,
    JavaScriptBridge: ^Object,
    JavaScriptBridge_M_List: Classes.JavaScriptBridge_MethodBind_List,
    AudioServer: ^Object,
    AudioServer_M_List: Classes.AudioServer_MethodBind_List,
    CameraServer: ^Object,
    CameraServer_M_List: Classes.CameraServer_MethodBind_List,
    DisplayServer: ^Object,
    DisplayServer_M_List: Classes.DisplayServer_MethodBind_List,
    NativeMenu: ^Object,
    NativeMenu_M_List: Classes.NativeMenu_MethodBind_List,
    RenderingServer: ^Object,
    RenderingServer_M_List: Classes.RenderingServer_MethodBind_List,
    NavigationServer2D: ^Object,
    NavigationServer2D_M_List: Classes.NavigationServer2D_MethodBind_List,
    NavigationServer3D: ^Object,
    NavigationServer3D_M_List: Classes.NavigationServer3D_MethodBind_List,
    PhysicsServer2D: ^Object,
    PhysicsServer2D_M_List: Classes.PhysicsServer2D_MethodBind_List,
    PhysicsServer3D: ^Object,
    PhysicsServer3D_M_List: Classes.PhysicsServer3D_MethodBind_List,
    XRServer: ^Object,
    XRServer_M_List: Classes.XRServer_MethodBind_List,
}


/*
* Function used to register a custom class with Godot. This will use the information provided in class_info or default to bltn equivalents.
* This will need to be called by you at some point during your extension's initialization.
* deets: the struct describing the class which you are registering.
* init_level: the current initialization level of Godot's startup procedure.
* class_info: the information about the class which you would like to use when customizing.
*/
@(export)
Register :: proc "c" (deets: ^Class_Deets, init_level: InitializationLevel, \
    class_info: GDE.ClassCreationInfo4) {
        context = runtime.default_context()
        _Register(deets, init_level, class_info)
}


//**********************\\
//*******Variants*******\\
//**********************\\

@(export)
_variant_get_ptr :: proc "c" (variant: ^Variant) -> rawptr {
    context = runtime.default_context()
    return _variant_get_ptr(variant)
}