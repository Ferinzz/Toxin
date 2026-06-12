package main

import "Toxin"
import "base:runtime"
import Classes "GD_Classes"
import "GDWrapper/gdAPI"
import GDW "GDWrapper"
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
    {},
}
core_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()

    Toxin.register_mainloop_callbacks({main_loop_startup, MainLoopFrameCallback, main_loop_shutdown})
}

servers_init :: proc "c" (userdata: rawptr) {

}

scene_init :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
    append(&core_setup.classes.scene, &THIS_CLASS_NAME_deets)
}

editor_init :: proc "c" (userdata: rawptr) {

}

core_deinit :: proc "c" (userdata: rawptr) {

}
servers_deinit :: proc "c" (userdata: rawptr) {

}
scene_deinit :: proc "c" (userdata: rawptr) {
    context = runtime.default_context()
}
editor_deinit :: proc "c" (userdata: rawptr) {

}

main_loop_startup :: proc "c" () {
    context = runtime.default_context()

    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.Window_Init_(&Window_MethodBind_List)

    Classes.Window_Init_(&Window_MethodBind_List)
    scene: ^Toxin.Object = Toxin.get_current_scene()
    
    //A scene is not added when running editor mode first time. Check for the scene before trying to add the child to it.
    if scene != nil {
    }
}

main_loop_shutdown :: proc "c" () {
}