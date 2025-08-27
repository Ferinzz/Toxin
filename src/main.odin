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
    OdinArrayBindMethod(Odini64Array, Odini64Array_CString, &Odini64Array_SN)
    OdinArrayBindMethod(Odinf64Array, Odinf64Array_CString, &Odinf64Array_SN)
    OdinArrayBindMethod(OdinBoolArray, OdinBoolArray_CString, &OdinBoolArray_SN)
    OdinArrayBindMethod(OdinGDStringArray, OdinGDStringArray_CString, &OdinGDStringArray_SN)
    OdinArrayBindMethod(OdinVec2Array, OdinVec2Array_CString, &OdinVec2Array_SN)
    OdinArrayBindMethod(OdinVec2iArray, OdinVec2iArray_CString, &OdinVec2iArray_SN)
    OdinArrayBindMethod(OdinRec2Array, OdinRec2Array_CString, &OdinRec2Array_SN)
    OdinArrayBindMethod(OdinRec2iArray, OdinRec2iArray_CString, &OdinRec2iArray_SN)
    OdinArrayBindMethod(OdinVec3Array, OdinVec3Array_CString, &OdinVec3Array_SN)
    OdinArrayBindMethod(OdinVec3iArray, OdinVec3iArray_CString, &OdinVec3iArray_SN)
    OdinArrayBindMethod(OdinTrans2DArray, OdinTrans2DArray_CString, &OdinTrans2DArray_SN)
    OdinArrayBindMethod(OdinVec4Array, OdinVec4Array_CString, &OdinVec4Array_SN)
    OdinArrayBindMethod(OdinVec4iArray, OdinVec4iArray_CString, &OdinVec4iArray_SN)
    OdinArrayBindMethod(OdinPlaneArray, OdinPlaneArray_CString, &OdinPlaneArray_SN)
    OdinArrayBindMethod(OdinQuatArray, OdinQuatArray_CString, &OdinQuatArray_SN)
    OdinArrayBindMethod(OdinAABBArray, OdinAABBArray_CString, &OdinAABBArray_SN)
    OdinArrayBindMethod(OdinBasisArray, OdinBasisArray_CString, &OdinBasisArray_SN)
    OdinArrayBindMethod(OdinTrans3DArray, OdinTrans3DArray_CString, &OdinTrans3DArray_SN)
    OdinArrayBindMethod(OdinProjectionArray, OdinProjArray_CString, &OdinProjArray_SN)
    OdinArrayBindMethod(OdinColorArray, OdinColorArray_CString, &OdinColorArray_SN)
    OdinArrayBindMethod(OdinStringNameArray, OdinStringNameArray_CString, &OdinStringNameArray_SN)
    OdinArrayBindMethod(OdinNodePathArray, OdinNodePathArray_CString, &OdinNodePathArray_SN)
    OdinArrayBindMethod(OdinRIDArray, OdinRIDArray_CString, &OdinRIDArray_SN)
    OdinArrayBindMethod(OdinObjectArray, OdinObjectArray_CString, &OdinObjectArray_SN)
    OdinArrayBindMethod(OdinCallableArray, OdinCallableArray_CString, &OdinCallableArray_SN)
    OdinArrayBindMethod(OdinSignalArray, OdinSignalArray_CString, &OdinSignalArray_SN)
    OdinArrayBindMethod(OdinDicArray, OdinDicArray_CString, &OdinDicArray_SN)
    
}


//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}