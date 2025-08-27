package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"


controlClass: GDE.ObjectPtr

@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, initialization: ^GDE.Initialization) {
    context = runtime.default_context()

    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    initialization.minimum_initialization_level = .INITIALIZATION_SCENE
    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit

}

extensionDeinit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}

extensionInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {

    context = runtime.default_context()
    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    /*
    Initialize the different classes.
    classInitProc(classStruct)
    */
    gameInit(userdata, initLevel)
    //remapButtonInit(userdata, initLevel)
    //initialize_gdexample_module(userdata, initLevel)
    //OdinArraysInit(userdata, initLevel)
    OdinArrayObjInit(userdata, initLevel)
    SliceObjectInit(userdata, initLevel)
    //Odini64ArrayInit(userdata, initLevel)
    OdinArrayBindMethod(Odini64Array)
    
}


//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}