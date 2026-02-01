package Toxin

import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import "base:runtime"
import "core:fmt"

Scene_Init_Callback:: proc ();

scene_inits:[500]^Class_Deets

inits: struct {
    scene: Scene_Init_Callback,
}

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
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) {
    //GDW.initGodotContext()
    context = runtime.default_context()

    GDW.Library = p_library
    GDW.Init_Wrapper(p_get_proc_address)
    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit
    initialization.userdata     = nil
    initialization.minimum_initialization_level = .INITIALIZATION_SCENE

};

/*
* This function will be called at each step of Godot's initialization process.
* Add the procedure call for the class's registration procedure based on the init level you want.
* Most classes will be initialized at the Scene level.
* Different classes are not available at different levels of initialization.
* userdata: Pointer specified in the initialize struct.
* initLevel: The current init level that the Godot engine is going through.
*/
extensionInit :: proc "c" (userdata: rawptr, init_Level: GDE.InitializationLevel) {
    context = runtime.default_context()
    //fmt.println(Toxin.reg_list)
    //There are multiple steps to the init process which Godot goes through.
    //You may want to register or intitialize certain aspects of your extension at different times.
    switch init_Level{
        case .INITIALIZATION_CORE:
            /*
            * Register the different classes which should be considered Core to the rest of the system.
            */
            GDW.init_array_types(&GDArray_Methods)
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Register the different classes which depend on core classes.
            */
            // ClassDB.self.obj = GDW.Library
            // init_classDB(&ClassDB)
            // 
            // SN: StringName = GDW.StringConstruct.stringNameNewString_r("ClassDB")
            // SN_p: ^StringName = &SN
            // ret: Class_Array
            // gdMakeArray(&ret)
            // ret2: Class_Array
            // gdMakeArray(&ret2)
            // rando: rawptr = new(rawptr)
            // ret2.self^ = ClassDB -> class_get_method_list(rando, SN_p, false)
            // dict: GDW.Dictionary
            // ret2.self^ = ClassDB -> class_get_signal(rando, SN_p, SN_p)

            return
        case .INITIALIZATION_SCENE:
            /*
            * Register the different classes which depend on servers classes.
            */
            //THIS_CLASS_NAME_deets->self_register(init_Level)
            inits.scene()
            //Need to register our MainLoop callbacks at some point.
            gdAPI.RegisterMainLoopCallbacks(GDW.Library, &myMainLoopCallbacks)
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
extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

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
            gdAPI.Logging.PrintWarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
            return
        case :
            assert(true, "This should not be impossible!!")
    };
};;