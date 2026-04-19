package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"
import "base:runtime"
import "base:builtin"

_getMainLoop :: proc(singletons: Singletons) -> (mainLoop: GDE.ObjectPtr) {
    when builtin.ODIN_DEBUG {
        assertMessage:= "Need to init the Singletons before using them. Call Init_Singletons_C before calling this function"
        assert(singletons.Engine == nil, assertMessage)
        assert(singletons.Engine_M_List.get_main_loop._get_main_loop != nil, assertMessage)
    }
    singletons.Engine_M_List.get_main_loop->m_call(singletons.Engine, nil, &mainLoop)
    return
}

_getRoot :: proc(singletons: Singletons, scenetree_class: Classes.SceneTree_MethodBind_List) -> (root: GDE.ObjectPtr) {
    scenetree_class.get_root->m_call(getMainLoop_C(singletons), nil, &root)
    return
}

_Init_Singletons :: proc(singletons: ^Singletons) {
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Performance))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Engine))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ProjectSettings))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.OS))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Time))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TextServerManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2DManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2DManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3DManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3DManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationMeshGenerator))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.IP))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry2D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Geometry3D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceLoader))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceSaver))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ClassDB))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Marshalls))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.TranslationServer))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.Input))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.InputMap))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EngineDebugger))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.GDExtensionManager))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ResourceUID))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.WorkerThreadPool))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.ThemeDB))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.EditorInterface))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaClassWrapper))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.JavaScriptBridge))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.AudioServer))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.CameraServer))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.DisplayServer))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NativeMenu))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.RenderingServer))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer2D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.NavigationServer3D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer2D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.PhysicsServer3D))
    gdAPI.GlobalGetSingleton(Classes.GDClass_StringName_get(.XRServer))
    Classes.Performance_Init_(&singletons.Performance_M_List)
    Classes.Engine_Init_(&singletons.Engine_M_List)
    Classes.ProjectSettings_Init_(&singletons.ProjectSettings_M_List)
    Classes.OS_Init_(&singletons.OS_M_List)
    Classes.Time_Init_(&singletons.Time_M_List)
    Classes.TextServerManager_Init_(&singletons.TextServerManager_M_List)
    Classes.NavigationServer2D_Init_(&singletons.NavigationServer2D_M_List)
    Classes.PhysicsServer2DManager_Init_(&singletons.PhysicsServer2DManager_M_List)
    Classes.NavigationServer3D_Init_(&singletons.NavigationServer3D_M_List)
    Classes.PhysicsServer3DManager_Init_(&singletons.PhysicsServer3DManager_M_List)
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
    Classes.NavigationServer2D_Init_(&singletons.NavigationServer2D_M_List)
    Classes.NavigationServer3D_Init_(&singletons.NavigationServer3D_M_List)
    Classes.PhysicsServer2D_Init_(&singletons.PhysicsServer2D_M_List)
    Classes.PhysicsServer3D_Init_(&singletons.PhysicsServer3D_M_List)
    Classes.XRServer_Init_(&singletons.XRServer_M_List)
}

