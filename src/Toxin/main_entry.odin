package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import "base:runtime"
import "core:fmt"
import Classes "../GD_Classes"


scene_inits:[500]^Class_Deets

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
@(entry_point_only)
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) -> b8 {
    //GDW.initGodotContext()
    context = runtime.default_context()

    GDW.Library = p_library
    GDW.Init_Wrapper(p_get_proc_address)
    
    //This can only run if building directly from Odin (right?) if that's the case assuming that the entry should be Toxin's
    initialization.initialize = _extensionInit
    initialization.deinitialize = _extensionDeinit
    initialization.userdata     = nil
    initialization.minimum_initialization_level = .INITIALIZATION_SCENE
    return true
};

/*
* This function will be called at each step of Godot's initialization process.
* Add the procedure call for the class's registration procedure based on the init level you want.
* Most classes will be initialized at the Scene level.
* Different classes are not available at different levels of initialization.
* userdata: Pointer specified in the initialize struct.
* initLevel: The current init level that the Godot engine is going through.
*/
_extensionInit :: proc "c" (userdata: rawptr, init_Level: GDE.InitializationLevel) {
    context = runtime.default_context()
    //fmt.println(Toxin.reg_list)
    //There are multiple steps to the init process which Godot goes through.
    //You may want to register or intitialize certain aspects of your extension at different times.
    switch init_Level{
        case .INITIALIZATION_CORE:
            /*
            * Register the different classes which should be considered Core to the rest of the system.
            */
            if inits.core != nil {
                inits.core(userdata)
            }
            //Classes.Engine_Init_(&Engine_M_List)
            init_Node_Virtuals_Info()
            init_CanvasItem_Virtuals_Info()
            init_Texture2D_Virtuals_Info()
            init_MainLoop_Virtual_Info()
            Classes.RefCounted_Init_(&RefCounted_Methods_list)
            objectEmitSignal = GDW.classDBGetMethodBind3(.Object, "emit_signal", 4047867050)
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Register the different classes which depend on core classes.
            */
            if inits.servers != nil {
                inits.servers(userdata)
            }
            return
        case .INITIALIZATION_SCENE:
            /*
            * Register the different classes which depend on servers classes.
            */
            //THIS_CLASS_NAME_deets->self_register(init_Level)
            if inits.scene != nil {
                inits.scene(userdata)
            } else {
                fmt.println("WARNING! scene init proc was not setup.")
            }
            //Need to register our MainLoop callbacks at some point.
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Register the different classes which should be used with the Editor.
            */
            if inits.editor != nil {
                inits.editor(userdata)
            }
            return
        //Prettys 
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            gdAPI.Logging.PrintWarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
        case :
            assert(true, "This should be impossible!!")
    };

    return
};;


//This function will be called when the Godot program is closing.
//It will be called once at each level of the deinit process.
//deinit is in reverse order with INITIALIZATION_EDITOR first and INITIALIZATION_CORE last.
_extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    switch deinitLevel{
        case .INITIALIZATION_CORE:
            /*
            * Free the different classes which should be considered Core to the rest of the system.
            */
            if Deinits.core != nil {
                Deinits.core(userdata)
            }
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Free the different classes which depend on core classes.
            */
            if Deinits.servers != nil {
                Deinits.servers(userdata)
            }
            return
        case .INITIALIZATION_SCENE:
            /*
            * Free the different classes which depend on servers classes.
            */
            if Deinits.scene != nil {
                Deinits.scene(userdata)
            }
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Free the different classes which should be used with the Editor.
            */
            if Deinits.editor != nil {
                Deinits.editor(userdata)
            }
            return
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            gdAPI.Logging.PrintWarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
            return
        case :
            assert(true, "This should not be impossible!!")
    };
};;