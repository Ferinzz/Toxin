package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"
import "base:runtime"

PhysServer2dObj: Classes.PhysicsServer2D
Engine: Classes.Engine
Engine_M_List: Classes.Engine_MethodBind_List

Singletons :: struct {
    Performance: GDE.ObjectPtr,
    Performance_M_List: Classes.Performance_MethodBind_List,
    Engine: GDE.ObjectPtr,
    Engine_M_List: Classes.Engine_MethodBind_List,
    ProjectSettings: GDE.ObjectPtr,
    ProjectSettings_M_List: Classes.ProjectSettings_MethodBind_List,
    OS: GDE.ObjectPtr,
    OS_M_List: Classes.OS_MethodBind_List,
    Time: GDE.ObjectPtr,
    Time_M_List: Classes.Time_MethodBind_List,
    TextServerManager: GDE.ObjectPtr,
    TextServerManager_M_List: Classes.TextServerManager_MethodBind_List,
    PhysicsServer2DManager: GDE.ObjectPtr,
    PhysicsServer2DManager_M_List: Classes.PhysicsServer2DManager_MethodBind_List,
    PhysicsServer3DManager: GDE.ObjectPtr,
    PhysicsServer3DManager_M_List: Classes.PhysicsServer3DManager_MethodBind_List,
    NavigationMeshGenerator: GDE.ObjectPtr,
    NavigationMeshGenerator_M_List: Classes.NavigationMeshGenerator_MethodBind_List,
    IP: GDE.ObjectPtr,
    IP_M_List: Classes.IP_MethodBind_List,
    Geometry2D: GDE.ObjectPtr,
    Geometry2D_M_List: Classes.Geometry2D_MethodBind_List,
    Geometry3D: GDE.ObjectPtr,
    Geometry3D_M_List: Classes.Geometry3D_MethodBind_List,
    ResourceLoader: GDE.ObjectPtr,
    ResourceLoader_M_List: Classes.ResourceLoader_MethodBind_List,
    ResourceSaver: GDE.ObjectPtr,
    ResourceSaver_M_List: Classes.ResourceSaver_MethodBind_List,
    ClassDB: GDE.ObjectPtr,
    ClassDB_M_List: Classes.ClassDB_MethodBind_List,
    Marshalls: GDE.ObjectPtr,
    Marshalls_M_List: Classes.Marshalls_MethodBind_List,
    TranslationServer: GDE.ObjectPtr,
    TranslationServer_M_List: Classes.TranslationServer_MethodBind_List,
    Input: GDE.ObjectPtr,
    Input_M_List: Classes.Input_MethodBind_List,
    InputMap: GDE.ObjectPtr,
    InputMap_M_List: Classes.InputMap_MethodBind_List,
    EngineDebugger: GDE.ObjectPtr,
    EngineDebugger_M_List: Classes.EngineDebugger_MethodBind_List,
    GDExtensionManager: GDE.ObjectPtr,
    GDExtensionManager_M_List: Classes.GDExtensionManager_MethodBind_List,
    ResourceUID: GDE.ObjectPtr,
    ResourceUID_M_List: Classes.ResourceUID_MethodBind_List,
    WorkerThreadPool: GDE.ObjectPtr,
    WorkerThreadPool_M_List: Classes.WorkerThreadPool_MethodBind_List,
    ThemeDB: GDE.ObjectPtr,
    ThemeDB_M_List: Classes.ThemeDB_MethodBind_List,
    EditorInterface: GDE.ObjectPtr,
    EditorInterface_M_List: Classes.EditorInterface_MethodBind_List,
    JavaClassWrapper: GDE.ObjectPtr,
    JavaClassWrapper_M_List: Classes.JavaClassWrapper_MethodBind_List,
    JavaScriptBridge: GDE.ObjectPtr,
    JavaScriptBridge_M_List: Classes.JavaScriptBridge_MethodBind_List,
    AudioServer: GDE.ObjectPtr,
    AudioServer_M_List: Classes.AudioServer_MethodBind_List,
    CameraServer: GDE.ObjectPtr,
    CameraServer_M_List: Classes.CameraServer_MethodBind_List,
    DisplayServer: GDE.ObjectPtr,
    DisplayServer_M_List: Classes.DisplayServer_MethodBind_List,
    NativeMenu: GDE.ObjectPtr,
    NativeMenu_M_List: Classes.NativeMenu_MethodBind_List,
    RenderingServer: GDE.ObjectPtr,
    RenderingServer_M_List: Classes.RenderingServer_MethodBind_List,
    NavigationServer2D: GDE.ObjectPtr,
    NavigationServer2D_M_List: Classes.NavigationServer2D_MethodBind_List,
    NavigationServer3D: GDE.ObjectPtr,
    NavigationServer3D_M_List: Classes.NavigationServer3D_MethodBind_List,
    PhysicsServer2D: GDE.ObjectPtr,
    PhysicsServer2D_M_List: Classes.PhysicsServer2D_MethodBind_List,
    PhysicsServer3D: GDE.ObjectPtr,
    PhysicsServer3D_M_List: Classes.PhysicsServer3D_MethodBind_List,
    XRServer: GDE.ObjectPtr,
    XRServer_M_List: Classes.XRServer_MethodBind_List,
}
//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getPhysServer2dObj :: proc() -> Classes.PhysicsServer2D {
    if PhysServer2dObj == nil do PhysServer2dObj = gdAPI.GlobalGetSingleton(GDClass_StringName_get(.PhysicsServer2D))
    return PhysServer2dObj
}
//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
EngineObj :: proc() -> Classes.Engine {
    if Engine == nil do Engine = gdAPI.GlobalGetSingleton(GDClass_StringName_get(.Engine))
    return Engine
}

@(export)
Init_Singletons_C :: proc "c" (singletons: ^Singletons) {
    context = runtime.default_context()
    _Init_Singletons(singletons)
}

@(export)
getMainLoop_C :: proc"c"(singletons: Singletons) -> GDE.ObjectPtr {
    context = runtime.default_context()
    return _getMainLoop(singletons)
}

@(export)
getRoot_C :: proc "c" (singletons: Singletons, scenetree_class: Classes.SceneTree_MethodBind_List) -> GDE.ObjectPtr {
    context = runtime.default_context()
    return _getRoot(singletons, scenetree_class)
}