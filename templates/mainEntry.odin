package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"

/*
* As of 4.5 there is a binding which allows you to register MainLoop callbacks
* This example shows how to setup a callback which will be triggered by Godot at certain phases of MainLoop's run.
* 1. Create MainLoopCallback procedures based on the MainLoopCallbacks struct
** /* Called when starting the main loop. */
** MainLoopStartupCallback :: proc "c" ();
** /* Called when shutting down the main loop. */
** MainLoopShutdownCallback :: proc "c" ();
** /* Called for every frame iteration of the main loop. */
** MainLoopFrameCallback :: proc "c" (); 
* 2. Assign the procedures to a MainLoopCallbacks struct ensure the struct will be available for registration.
* 3. At any point call GDW.register_main_loop_callbacks with the Library and the struct MainLoopCallbacks.
* 4. If successful the callbacks will be called at the appropriate time.
* 5. Be aware, if you're adding a class to the root scene of sceneTree, there will be no scene when running the editor.
* 6. For consideration. The GDW.register_main_loop_callbacks can be called multiple times, updating the proc pointers which Godot will be calling.
*
*/



/* Called when starting the main loop. */
MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    fmt.println("THERE'S A LOOP CALBACK")

    //Setup an object to hold the MainLoop object.
    scene_tree_obj: GDE.ObjectPtr
    scene_tree_obj = GDW.getMainLoop()
    fmt.println(scene_tree_obj)
}
/* Called when shutting down the main loop. */
MainLoopShutdownCallback :: proc "c" () {
    context = runtime.default_context()
    fmt.println("Welp, Bye.")
}

callOnce:bool=false
/* Called for every frame iteration of the main loop.
* If you only need the first frame you can register a new set of callbacks.
*/
MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    //fmt.println("WTAF MAINLOOP TICKS?!")
    
    if !callOnce {
        //These are good to set in a singleton at some point.
        //These are statically stored and thus only need to be called once when the game engine is fully initialize.
        GDW.getPhysServer2dObj()
        GDW.getRenderServer2dObj()
        callOnce = true
    }
}

//create a GDE.MainLoopCallbacks struct which will hold the pointers to the callbacks
myMainLoopCallbacks: GDE.MainLoopCallbacks = {
	/* Will be called after Godot is started and is fully initialized. */
	startup_func = MainLoopStartupCallback,
	/* Will be called before Godot is shutdown when it is still fully initialized. */
	shutdown_func = MainLoopShutdownCallback,
	/* Will be called for each process frame. This will run after all `_process()` methods on Node, and before `ScriptServer::frame()`.
	 * This is intended to be the equivalent of `ScriptLanguage::frame()` for GDExtension language bindings that don't use the script API.
	 */
	frame_func = MainLoopFrameCallback,
};


//I register the GDE.MainLoopCallbacks struct in the init of the Extension.

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
    initialization.minimum_initialization_level = .INITIALIZATION_SCENE

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
    context = GDW.godotContext

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

            //Need to register our MainLoop callbacks at some point.
            GDW.gd_Main_Loop.register_main_loop_callbacks(GDW.Library, &myMainLoopCallbacks)
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Register the different classes which should be used with the Editor.
            */
            return
        //Prettys 
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            GDW.Print.WarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
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


//This function will be called when the Godot program is closing.
//It will be called once at each level of the deinit process.
//deinit is in reverse order with INITIALIZATION_EDITOR first and INITIALIZATION_CORE last.
extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    context = GDW.godotContext

    switch deinitLevel{
        case .INITIALIZATION_CORE:
            /*
            * Free the different classes which should be considered Core to the rest of the system.
            */
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Free the different classes which depend on core classes.
            */
            return    
        case .INITIALIZATION_SCENE:
            /*
            * Free the different classes which depend on servers classes.
            */
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Free the different classes which should be used with the Editor.
            */
            return
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            GDW.Print.WarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
            return
        case :
            assert(true, "This should not be impossible!!")
    }
}