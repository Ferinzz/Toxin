package main

import "Toxin"
import "base:runtime"
import Classes "GD_Classes"
import GDE "GDWrapper/gdAPI/gdextension"


@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) -> b8 {
    context = runtime.default_context()
    return Toxin.toxin_entry(p_get_proc_address, p_library, initialization, &core_setup)
}

//@(rodata)
core_setup: Toxin.inits_deinits= {
    nil,
    core_init,
    servers_init,
    scene_init,
    editor_init,
    core_deinit,
    servers_deinit,
    scene_deinit,
    editor_deinit,
}
core_init :: proc "c" (userdata: rawptr) {

}

servers_init :: proc "c" (userdata: rawptr) {

}

scene_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
    THIS_CLASS_NAME_deets->registerer(.INITIALIZATION_SCENE)
}

editor_init :: proc "c" (userdata: rawptr) {

}

core_deinit :: proc "c" (userdata: rawptr) {

}
servers_deinit :: proc "c" (userdata: rawptr) {

}
scene_deinit :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
    Toxin.unregister(&THIS_CLASS_NAME_deets)
}
editor_deinit :: proc "c" (userdata: rawptr) {

}

post_init_class_init :: proc() {
    Toxin._Init_Singletons(&singletons)

    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.Window_Init_(&Window_MethodBind_List)
    Classes.SceneTree_Init_(&SceneTree_Class)

    scene_tree_obj= Toxin._getMainLoop(singletons)
    Toxin._getRoot(singletons, SceneTree_Class)
    scene: ^Toxin.Object
    SceneTree_Class.get_current_scene->m_call(scene_tree_obj, nil, &scene)
    Classes.Window_Init_(&Window_MethodBind_List)
}

main_loop_startup :: proc() {

}