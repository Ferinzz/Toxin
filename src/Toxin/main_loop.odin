package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"


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
* 6. For consideration. GDW.register_main_loop_callbacks can be called multiple times, updating the proc pointers which Godot will be calling.
*/


scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object

/* Called when starting the main loop.
* This is the point in time to grab the reference to a mainLoop. For example if you wrote your own and want to listen in on it.
* This is also the point after which the servers should have been booted up. You can safely get their Singletons.
* Fake singletons. :Experimental: Add your own class to the root of the scene. Based on Godot's management of Singletons this should be how you can make your own singleton system. This hasn't been tested with scene switching.
*/
MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    /////////////////////////////////////////////////
    //DO NOT USE THIS WITH OPTIMIZED CODE!!!!!
    /////////////////////////////////////////////////
    //Classes.INIT_ALL_OF_THEM()

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
};

/* Called when shutting down the main loop. */
MainLoopShutdownCallback :: proc "c" () {
    context = runtime.default_context()
};

callOnce:bool=false
/*
* Called for every frame iteration of the main loop.
* This example sets the callback to null after the first frame.
*/
MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    if callOnce {
        callOnce = false
        myMainLoopCallbacks.frame_func = nil
    }

};
myMainLoopCallbacks: GDE.MainLoopCallbacks
/*
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
};*/

//I register the GDE.MainLoopCallbacks struct in the init of the Extension.