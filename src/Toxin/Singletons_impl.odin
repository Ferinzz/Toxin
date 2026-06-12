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
        assert(Engine_M_List.get_main_loop._get_main_loop != nil, assertMessage)
    }
    Engine_M_List.get_main_loop->m_call(singletons.Engine, nil, &mainLoop)
    return
}

_getRoot :: proc() -> (root: GDE.ObjectPtr) {
    SceneTree_Class.get_root->m_call(_getMainLoop(), nil, &root)
    return
}

get_current_scene :: proc() -> (scene: ^Object) {
    SceneTree_Class.get_current_scene->m_call(scene_tree_obj, r_ret = &scene)
    return
}

_EngineObj :: proc() -> ^Object {
    return gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
}


SceneTree_M_List: Classes.SceneTree_MethodBind_List

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
    Classes.Performance_Init_(&singletons.Performance_M_List)
    Classes.Engine_Init_(&singletons.Engine_M_List)
    Classes.ProjectSettings_Init_(&singletons.ProjectSettings_M_List)
    Classes.OS_Init_(&singletons.OS_M_List)
    Classes.Time_Init_(&singletons.Time_M_List)
    Classes.TextServerManager_Init_(&singletons.TextServerManager_M_List)
    Classes.NavigationServer2D_Init_(&singletons.NavigationServer2D_M_List)
    Classes.PhysicsServer2DManager_Init_(&singletons.PhysicsServer2DManager_M_List)
    Classes.PhysicsServer3DManager_Init_(&singletons.PhysicsServer3DManager_M_List)
    Classes.NavigationServer2DManager_Init_(&singletons.NavigationServer2DManager_M_List)
    Classes.NavigationServer3DManager_Init_(&singletons.NavigationServer3DManager_M_List)
    Classes.NavigationMeshGenerator_Init_(&singletons.NavigationMeshGenerator_M_List)
    Classes.IP_Init_(&singletons.IP_M_List)
    Classes.Geometry2D_Init_(&singletons.Geometry2D_M_List)
    Classes.Geometry3D_Init_(&singletons.Geometry3D_M_List)
    Classes.ResourceLoader_Init_(&singletons.ResourceLoader_M_List)
    Classes.ResourceSaver_Init_(&singletons.ResourceSaver_M_List)
    Classes.ClassDB_Init_(&singletons.ClassDB_M_List)
    Classes.Marshalls_Init_(&singletons.Marshalls_M_List)
    Classes.TranslationServer_Init_(&singletons.TranslationServer_M_List)
    Classes.Input_Init_(&singletons.Input_M_List)
    Classes.InputMap_Init_(&singletons.InputMap_M_List)
    Classes.EngineDebugger_Init_(&singletons.EngineDebugger_M_List)
    Classes.GDExtensionManager_Init_(&singletons.GDExtensionManager_M_List)
    Classes.ResourceUID_Init_(&singletons.ResourceUID_M_List)
    Classes.WorkerThreadPool_Init_(&singletons.WorkerThreadPool_M_List)
    Classes.EditorInterface_Init_(&singletons.EditorInterface_M_List)
    Classes.JavaClassWrapper_Init_(&singletons.JavaClassWrapper_M_List)
    Classes.JavaScriptBridge_Init_(&singletons.JavaScriptBridge_M_List)
    Classes.AudioServer_Init_(&singletons.AudioServer_M_List)
    Classes.CameraServer_Init_(&singletons.CameraServer_M_List)
    Classes.DisplayServer_Init_(&singletons.DisplayServer_M_List)
    Classes.ThemeDB_Init_(&singletons.ThemeDB_M_List)
    Classes.NativeMenu_Init_(&singletons.NativeMenu_M_List)
    Classes.RenderingServer_Init_(&singletons.RenderingServer_M_List)
    Classes.NavigationServer3D_Init_(&singletons.NavigationServer3D_M_List)
    Classes.PhysicsServer2D_Init_(&singletons.PhysicsServer2D_M_List)
    Classes.PhysicsServer3D_Init_(&singletons.PhysicsServer3D_M_List)
    Classes.XRServer_Init_(&singletons.XRServer_M_List)
}

_Init_Singletons2 :: proc(singletons: singleton_options) {
    Classes.Performance_Init_(&Performance_M_List)
    Performance = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Performance))
    Classes.Engine_Init_(&Engine_M_List)
    Engine = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
    Classes.ProjectSettings_Init_(&ProjectSettings_M_List)
    ProjectSettings = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ProjectSettings))
    Classes.OS_Init_(&OS_M_List)
    OS = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.OS))
    Classes.Time_Init_(&Time_M_List)
    Time = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Time))
    Classes.TextServerManager_Init_(&TextServerManager_M_List)
    TextServerManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TextServerManager))
    Classes.NavigationServer2D_Init_(&NavigationServer2D_M_List)
    NavigationServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2D))
    Classes.PhysicsServer2DManager_Init_(&PhysicsServer2DManager_M_List)
    PhysicsServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2DManager))
    Classes.PhysicsServer3DManager_Init_(&PhysicsServer3DManager_M_List)
    PhysicsServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3DManager))
    Classes.NavigationServer2DManager_Init_(&NavigationServer2DManager_M_List)
    NavigationServer2DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2DManager))
    Classes.NavigationServer3DManager_Init_(&NavigationServer3DManager_M_List)
    NavigationServer3DManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3DManager))
    Classes.NavigationMeshGenerator_Init_(&NavigationMeshGenerator_M_List)
    NavigationMeshGenerator = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationMeshGenerator))
    Classes.IP_Init_(&IP_M_List)
    IP = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.IP))
    Classes.Geometry2D_Init_(&Geometry2D_M_List)
    Geometry2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry2D))
    Classes.Geometry3D_Init_(&Geometry3D_M_List)
    Geometry3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry3D))
    Classes.ResourceLoader_Init_(&ResourceLoader_M_List)
    ResourceLoader = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceLoader))
    Classes.ResourceSaver_Init_(&ResourceSaver_M_List)
    ResourceSaver = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceSaver))
    Classes.ClassDB_Init_(&ClassDB_M_List)
    ClassDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ClassDB))
    Classes.Marshalls_Init_(&Marshalls_M_List)
    Marshalls = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Marshalls))
    Classes.TranslationServer_Init_(&TranslationServer_M_List)
    TranslationServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TranslationServer))
    Classes.Input_Init_(&Input_M_List)
    Input = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Input))
    Classes.InputMap_Init_(&InputMap_M_List)
    InputMap = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.InputMap))
    Classes.EngineDebugger_Init_(&EngineDebugger_M_List)
    EngineDebugger = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EngineDebugger))
    Classes.GDExtensionManager_Init_(&GDExtensionManager_M_List)
    GDExtensionManager = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.GDExtensionManager))
    Classes.ResourceUID_Init_(&ResourceUID_M_List)
    ResourceUID = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceUID))
    Classes.WorkerThreadPool_Init_(&WorkerThreadPool_M_List)
    WorkerThreadPool = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.WorkerThreadPool))
    Classes.EditorInterface_Init_(&EditorInterface_M_List)
    EditorInterface = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EditorInterface))
    Classes.JavaClassWrapper_Init_(&JavaClassWrapper_M_List)
    JavaClassWrapper = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaClassWrapper))
    Classes.JavaScriptBridge_Init_(&JavaScriptBridge_M_List)
    JavaScriptBridge = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaScriptBridge))
    Classes.AudioServer_Init_(&AudioServer_M_List)
    AudioServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.AudioServer))
    Classes.CameraServer_Init_(&CameraServer_M_List)
    CameraServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.CameraServer))
    Classes.DisplayServer_Init_(&DisplayServer_M_List)
    DisplayServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.DisplayServer))
    Classes.ThemeDB_Init_(&ThemeDB_M_List)
    ThemeDB = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ThemeDB))
    Classes.NativeMenu_Init_(&NativeMenu_M_List)
    NativeMenu = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NativeMenu))
    Classes.RenderingServer_Init_(&RenderingServer_M_List)
    RenderingServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.RenderingServer))
    Classes.NavigationServer3D_Init_(&NavigationServer3D_M_List)
    NavigationServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3D))
    Classes.PhysicsServer2D_Init_(&PhysicsServer2D_M_List)
    PhysicsServer2D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2D))
    Classes.PhysicsServer3D_Init_(&PhysicsServer3D_M_List)
    PhysicsServer3D = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3D))
    Classes.XRServer_Init_(&XRServer_M_List)
    XRServer = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.XRServer))
}

init_engine_procs :: proc() {
    Classes.Engine_Init_(&singletons.Engine_M_List)
    Engine = gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
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