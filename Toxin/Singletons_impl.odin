package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"
import "base:runtime"
import "base:builtin"

_getMainLoop :: proc() -> (mainLoop: GDE.ObjectPtr) {
    when builtin.ODIN_DEBUG {
        assertMessage:= "Need to init the Singletons before using them. Call Init_Singletons_C before calling this function"
        assert(Engine != nil, assertMessage)
        assert(Classes.Engine_get_main_loop._get_main_loop != nil, assertMessage)
    }
    Classes.Engine_get_main_loop->m_call(singletons.Engine, nil, &mainLoop)
    return
}

_getRoot :: proc() -> (root: GDE.ObjectPtr) {
    Classes.SceneTree_get_root->m_call(_getMainLoop(), nil, &root)
    return
}

get_current_scene :: proc() -> (scene: ^Object) {
    Classes.SceneTree_get_current_scene->m_call(scene_tree_obj, r_ret = &scene)
    return
}

_EngineObj :: proc() -> ^Object {
    return gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
}



_Init_Singletons :: proc(singletons: ^Singletons) {
    singletons.Performance = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Performance))
    singletons.Engine = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
    singletons.ProjectSettings = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ProjectSettings))
    singletons.OS = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.OS))
    singletons.Time = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Time))
    singletons.TextServerManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TextServerManager))
    singletons.PhysicsServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2DManager))
    singletons.NavigationServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2DManager))
    singletons.NavigationServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3DManager))
    singletons.PhysicsServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3DManager))
    singletons.NavigationMeshGenerator = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationMeshGenerator))
    singletons.IP = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.IP))
    singletons.Geometry2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry2D))
    singletons.Geometry3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry3D))
    singletons.ResourceLoader = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceLoader))
    singletons.ResourceSaver = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceSaver))
    singletons.ClassDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ClassDB))
    singletons.Marshalls = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Marshalls))
    singletons.TranslationServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TranslationServer))
    singletons.Input = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Input))
    singletons.InputMap = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.InputMap))
    singletons.EngineDebugger = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EngineDebugger))
    singletons.GDExtensionManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.GDExtensionManager))
    singletons.ResourceUID = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceUID))
    singletons.WorkerThreadPool = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.WorkerThreadPool))
    singletons.ThemeDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ThemeDB))
    singletons.EditorInterface = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EditorInterface))
    singletons.JavaClassWrapper = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaClassWrapper))
    singletons.JavaScriptBridge = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaScriptBridge))
    singletons.AudioServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.AudioServer))
    singletons.CameraServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.CameraServer))
    singletons.DisplayServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.DisplayServer))
    singletons.NativeMenu = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NativeMenu))
    singletons.RenderingServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.RenderingServer))
    singletons.NavigationServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2D))
    singletons.NavigationServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3D))
    singletons.PhysicsServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2D))
    singletons.PhysicsServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3D))
    singletons.XRServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.XRServer))
    Classes.Performance_Init_()
    Classes.Engine_Init_()
    Classes.ProjectSettings_Init_()
    Classes.OS_Init_()
    Classes.Time_Init_()
    Classes.TextServerManager_Init_()
    Classes.NavigationServer2D_Init_()
    Classes.PhysicsServer2DManager_Init_()
    Classes.PhysicsServer3DManager_Init_()
    Classes.NavigationServer2DManager_Init_()
    Classes.NavigationServer3DManager_Init_()
    Classes.NavigationMeshGenerator_Init_()
    Classes.IP_Init_()
    Classes.Geometry2D_Init_()
    Classes.Geometry3D_Init_()
    Classes.ResourceLoader_Init_()
    Classes.ResourceSaver_Init_()
    Classes.ClassDB_Init_()
    Classes.Marshalls_Init_()
    Classes.TranslationServer_Init_()
    Classes.Input_Init_()
    Classes.InputMap_Init_()
    Classes.EngineDebugger_Init_()
    Classes.GDExtensionManager_Init_()
    Classes.ResourceUID_Init_()
    Classes.WorkerThreadPool_Init_()
    Classes.EditorInterface_Init_()
    Classes.JavaClassWrapper_Init_()
    Classes.JavaScriptBridge_Init_()
    Classes.AudioServer_Init_()
    Classes.CameraServer_Init_()
    Classes.DisplayServer_Init_()
    Classes.ThemeDB_Init_()
    Classes.NativeMenu_Init_()
    Classes.RenderingServer_Init_()
    Classes.NavigationServer3D_Init_()
    Classes.PhysicsServer2D_Init_()
    Classes.PhysicsServer3D_Init_()
    Classes.XRServer_Init_()
}

_Init_Singletons2 :: proc(singletons: singleton_options) {
    Classes.Performance_Init_()
    Performance = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Performance))
    Classes.Engine_Init_()
    Engine = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
    Classes.ProjectSettings_Init_()
    ProjectSettings = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ProjectSettings))
    Classes.OS_Init_()
    OS = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.OS))
    Classes.Time_Init_()
    Time = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Time))
    Classes.TextServerManager_Init_()
    TextServerManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TextServerManager))
    Classes.NavigationServer2D_Init_()
    NavigationServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2D))
    Classes.PhysicsServer2DManager_Init_()
    PhysicsServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2DManager))
    Classes.PhysicsServer3DManager_Init_()
    PhysicsServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3DManager))
    Classes.NavigationServer2DManager_Init_()
    NavigationServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2DManager))
    Classes.NavigationServer3DManager_Init_()
    NavigationServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3DManager))
    Classes.NavigationMeshGenerator_Init_()
    NavigationMeshGenerator = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationMeshGenerator))
    Classes.IP_Init_()
    IP = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.IP))
    Classes.Geometry2D_Init_()
    Geometry2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry2D))
    Classes.Geometry3D_Init_()
    Geometry3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry3D))
    Classes.ResourceLoader_Init_()
    ResourceLoader = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceLoader))
    Classes.ResourceSaver_Init_()
    ResourceSaver = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceSaver))
    Classes.ClassDB_Init_()
    ClassDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ClassDB))
    Classes.Marshalls_Init_()
    Marshalls = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Marshalls))
    Classes.TranslationServer_Init_()
    TranslationServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TranslationServer))
    Classes.Input_Init_()
    Input = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Input))
    Classes.InputMap_Init_()
    InputMap = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.InputMap))
    Classes.EngineDebugger_Init_()
    EngineDebugger = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EngineDebugger))
    Classes.GDExtensionManager_Init_()
    GDExtensionManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.GDExtensionManager))
    Classes.ResourceUID_Init_()
    ResourceUID = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceUID))
    Classes.WorkerThreadPool_Init_()
    WorkerThreadPool = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.WorkerThreadPool))
    Classes.EditorInterface_Init_()
    EditorInterface = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EditorInterface))
    Classes.JavaClassWrapper_Init_()
    JavaClassWrapper = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaClassWrapper))
    Classes.JavaScriptBridge_Init_()
    JavaScriptBridge = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaScriptBridge))
    Classes.AudioServer_Init_()
    AudioServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.AudioServer))
    Classes.CameraServer_Init_()
    CameraServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.CameraServer))
    Classes.DisplayServer_Init_()
    DisplayServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.DisplayServer))
    Classes.ThemeDB_Init_()
    ThemeDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ThemeDB))
    Classes.NativeMenu_Init_()
    NativeMenu = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NativeMenu))
    Classes.RenderingServer_Init_()
    RenderingServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.RenderingServer))
    Classes.NavigationServer3D_Init_()
    NavigationServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3D))
    Classes.PhysicsServer2D_Init_()
    PhysicsServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2D))
    Classes.PhysicsServer3D_Init_()
    PhysicsServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3D))
    Classes.XRServer_Init_()
    XRServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.XRServer))
}

init_engine_procs :: proc() {
    Classes.Engine_Init_()
    Engine = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
}
init_renderserver_procs :: proc() {
    Classes.RenderingServer_Init_()
    RenderingServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.RenderingServer))
}

init_input_procs :: proc() {
    Classes.Input_Init_()
    Input = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Input))
}
init_textservermanager_procs :: proc() {
    Classes.TextServerManager_Init_()
    TextServerManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TextServerManager))
}
init_ThemeDB_procs :: proc() {
    Classes.ThemeDB_Init_()
    ThemeDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ThemeDB))
}
init_Time_procs :: proc() {
    Classes.Time_Init_()
    Time = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Time))
}
singleton_options:: bit_set[singleton_list]
singleton_list:: enum {
    Performance,
    Engine,
    ProjectSettings,
    OS,
    Time,
    TextServerManager,
    PhysicsServer2DManager,
    NavigationServer2DManager,
    NavigationServer3DManager,
    PhysicsServer3DManager,
    NavigationMeshGenerator,
    IP,
    Geometry2D,
    Geometry3D,
    ResourceLoader,
    ResourceSaver,
    ClassDB,
    Marshalls,
    TranslationServer,
    Input,
    InputMap,
    EngineDebugger,
    GDExtensionManager,
    ResourceUID,
    WorkerThreadPool,
    ThemeDB,
    EditorInterface,
    JavaClassWrapper,
    JavaScriptBridge,
    AudioServer,
    CameraServer,
    DisplayServer,
    NativeMenu,
    RenderingServer,
    NavigationServer2D,
    NavigationServer3D,
    PhysicsServer2D,
    PhysicsServer3D,
    XRServer,
}