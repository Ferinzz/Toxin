package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"


/*
* This procedure will be called by Godot at the very beginning.
* At this time built-ins are available.
* p_get_proc_address: A pointer to Godot's Interface which you will use to request method pointers at runtime.
* p_library: Godot will provide a pointer to your extension ClassLibrary. This should be stored by your extension.
* initialization: A struct which Godot will reference in order to handle ---
** initialize: The procedure which Godot will call at each init level.
** deinitialize: The procedure which Godot will call when it wants to remove your extension. (untested)
** minimum_initialization_level: At what point in engine init should Godot start calling the procedure specified in initialize.
*/
@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, initialization: ^GDE.Initialization) {
    GDW.initGodotContext()
    context = GDW.godotContext

    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit
    initialization.userdata     = nil
    initialization.minimum_initialization_level = .INITIALIZATION_CORE

}

extensionDeinit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}

/*
* This function will be called at each step of Godot's initialization process.
* Add the procedure call for the class's registration procedure based on the init level you want.
* Most classes will be initialized at the Scene level.
* Different classes are not available at different levels of initialization.
* userdata: Pointer specified in the initialize struct.
* initLevel: The current init level that the Godot engine is going through.
*/
extensionInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    //There are multiple steps to the init process which Godot goes through.
    //You may want to register or intitialize certain aspects of your extension at different times.
    switch initLevel{
        case .INITIALIZATION_CORE:
            /*
            * Register the different classes which should be considered Core to the rest of the system.
            */
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Register the different classes which depend on core classes.
            */
            return    
        case .INITIALIZATION_SCENE:
            GDW.getInputSingleton()
            /*
            * Register the different classes which depend on servers classes.
            */
            THIS_CLASS_NAME_Register(THIS_CLASS_NAME, initLevel)
            return
        //This can only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Register the different classes which depend on servers classes.
            */
            return
        case :
            assert(true, "This should be impossible!!")
    }

    return
}


//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil,
}