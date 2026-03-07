package Variant_type_tests

import "../../GDWrapper/gdAPI"
import GDE "../../GDWrapper/gdAPI/gdextension"
import GDW "../../GDWrapper"
//import "core:testing"
import "base:runtime"
import "core:fmt"
import "core:strings"
import "core:reflect"

verify_gdAPI :: proc() {
/* GDE.Interface: WorkerThreadPool Utilities */
    val_check(gdAPI.Threading, expand_values(gdAPI.Threading))

/* GDE.Interface: Memory */
    val_check(gdAPI.Memory_Uils, expand_values(gdAPI.Memory_Uils))


/* GDE.Interface: Godot Logging */
    val_check(gdAPI.Logging, expand_values(gdAPI.Logging))

/* GDE.Interface: Variant */
    val_check(gdAPI.Variant_Utils, expand_values(gdAPI.Variant_Utils))


/* GDE.Interface: String Utilities */
    val_check(gdAPI.Strings_Utils, expand_values(gdAPI.Strings_Utils))


/* GDE.Interface: StringName Utilities */
    val_check(gdAPI.StringName_Utils, expand_values(gdAPI.StringName_Utils))

/* GDE.Interface: XMLParser Utilities */
    val_check(gdAPI.XMLParse_Utils, expand_values(gdAPI.XMLParse_Utils))

/* GDE.Interface: FileAccess Utilities */
    val_check(gdAPI.FileAccess_Utils, expand_values(gdAPI.FileAccess_Utils))

/* GDE.Interface: Image Utilities */
    val_check(gdAPI.Image_Utils, expand_values(gdAPI.Image_Utils))

/* GDE.Interface: Packed Array */
    val_check(gdAPI.Packed_Array_Utils, expand_values(gdAPI.Packed_Array_Utils))


/* GDE.Interface: Dictionary */
    val_check(gdAPI.Dictionary_Utils, expand_values(gdAPI.Dictionary_Utils))


/* GDE.Interface: Object */
    val_check(gdAPI.Object_Utils, expand_values(gdAPI.Object_Utils))


/* GDE.Interface: Reference */
    val_check(gdAPI.Reference_Utils, expand_values(gdAPI.Reference_Utils))


/* GDE.Interface: Script Instance */
    val_check(gdAPI.Script_Utils, expand_values(gdAPI.Script_Utils))

/* GDE.Interface: Callable */
    val_check(gdAPI.Callable_Utils, expand_values(gdAPI.Callable_Utils))

/* GDE.Interface: ClassDB */
    val_check(gdAPI.ClassDB, expand_values(gdAPI.ClassDB))

/* GDE.Interface: Plugin */
    val_check(gdAPI.Plugin, expand_values(gdAPI.Plugin))
}

verify_builtin_procs :: proc() {
    val_check(GDW.StringName_M_List, expand_values(GDW.StringName_M_List))
    val_check(GDW.Bool_M_List, expand_values(GDW.Bool_M_List))
    val_check(GDW.Int_M_List, expand_values(GDW.Int_M_List))
    val_check(GDW.float_M_List, expand_values(GDW.float_M_List))
    val_check(GDW.Vector2_M_List, expand_values(GDW.Vector2_M_List))
    val_check(GDW.Vector2i_M_List, expand_values(GDW.Vector2i_M_List))
    val_check(GDW.Rect2_M_List, expand_values(GDW.Rect2_M_List))
    val_check(GDW.Rect2i_M_List, expand_values(GDW.Rect2i_M_List))
    val_check(GDW.Vector3_M_List, expand_values(GDW.Vector3_M_List))
    val_check(GDW.Vector3i_M_List, expand_values(GDW.Vector3i_M_List))
    val_check(GDW.Vector4_M_List, expand_values(GDW.Vector4_M_List))
    val_check(GDW.Vector4i_M_List, expand_values(GDW.Vector4i_M_List))
    val_check(GDW.Plane_M_List, expand_values(GDW.Plane_M_List))
    val_check(GDW.Color_M_List, expand_values(GDW.Color_M_List))
    val_check(GDW.Quaternion_M_List, expand_values(GDW.Quaternion_M_List))
    val_check(GDW.gdstring_M_List, expand_values(GDW.gdstring_M_List))
    val_check(GDW.NodePath_M_List, expand_values(GDW.NodePath_M_List))
    val_check(GDW.RID_M_List, expand_values(GDW.RID_M_List))
    val_check(GDW.Callable_M_List, expand_values(GDW.Callable_M_List))
    val_check(GDW.Signal_M_List, expand_values(GDW.Signal_M_List))
    val_check(GDW.Dictionary_M_List, expand_values(GDW.Dictionary_M_List))
    val_check(GDW.Transform2D_M_List, expand_values(GDW.Transform2D_M_List))
    val_check(GDW.AABB_M_List, expand_values(GDW.AABB_M_List))
    val_check(GDW.Basis_M_List, expand_values(GDW.Basis_M_List))
    val_check(GDW.Transform3D_M_List, expand_values(GDW.Transform3D_M_List))
    val_check(GDW.Projection_M_List, expand_values(GDW.Projection_M_List))
    val_check(GDW.Array_M_List, expand_values(GDW.Array_M_List))
    val_check(GDW.PackedByteArray_M_List, expand_values(GDW.PackedByteArray_M_List))
    val_check(GDW.PackedInt32Array_M_List, expand_values(GDW.PackedInt32Array_M_List))
    val_check(GDW.PackedInt64Array_M_List, expand_values(GDW.PackedInt64Array_M_List))
    val_check(GDW.PackedFloat32Array_M_List, expand_values(GDW.PackedFloat32Array_M_List))
    val_check(GDW.PackedFloat64Array_M_List, expand_values(GDW.PackedFloat64Array_M_List))
    val_check(GDW.PackedStringArray_M_List, expand_values(GDW.PackedStringArray_M_List))
    val_check(GDW.PackedVector2Array_M_List, expand_values(GDW.PackedVector2Array_M_List))
    val_check(GDW.PackedVector3Array_M_List, expand_values(GDW.PackedVector3Array_M_List))
    val_check(GDW.PackedColorArray_M_List, expand_values(GDW.PackedColorArray_M_List))
    val_check(GDW.PackedVector4Array_M_List, expand_values(GDW.PackedVector4Array_M_List))
    fmt.println(GDW.Dictionary_M_List)
}

val_check :: proc(source: any, values: ..any, loc:= #caller_location, struct_name:= #caller_expression(source)) {
    struct_name_c:= fmt.caprint("validating fields of:", struct_name, "if any fail verify their init code is valid.")
    defer(delete(struct_name_c))
    procedure := fmt.caprint(struct_name)
    file_path:= strings.clone_to_cstring(loc.file_path)
    gdAPI.Logging.PrintWarning(struct_name_c, procedure, file_path, int(loc.line), true)
    for val, idx in values {
        if (^rawptr)(val.data)^ == nil {
            gdAPI.Logging.PrintError(fmt.caprint(val), procedure, file_path, loc.line, true)
        }
    }
    delete(procedure)
    delete(file_path)
}


@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) {
    //GDW.initGodotContext()
    context = runtime.default_context()
    fmt.println("running")
    GDW.Library = p_library
    GDW.Init_Wrapper(p_get_proc_address)
    verify_gdAPI()
    verify_builtin_procs()
    //Init_Builtins()
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
            //Initialize the Methods of Array types for later use.
            /*GDW.init_array_types(&GDArray_Methods,
            &PackedByteArray_Methods,
            &PackedInt32Array_Methods,
            &PackedInt64Array_Methods,
            &PackedFloat32Array_Methods,
            &PackedFloat64Array_Methods,
            &PackedStringArray_Methods,
            &PackedVector2Array_Methods,
            &PackedVector3Array_Methods,
            &PackedColorArray_Methods,
            &PackedVector4Array_Methods,
            &GDDictionary_Methods,)*/
            
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Register the different classes which depend on core classes.
            */
            return
        case .INITIALIZATION_SCENE:
            /*
            * Register the different classes which depend on servers classes.
            */
            //THIS_CLASS_NAME_deets->self_register(init_Level)
            //if inits.scene() != nil {
            //    inits.scene()
            //}
            //Need to register our MainLoop callbacks at some point.
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