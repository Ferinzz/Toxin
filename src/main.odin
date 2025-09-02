package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"


controlClass: GDE.ObjectPtr

@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, initialization: ^GDE.Initialization) {
    GDW.initGodotContext()
    context = GDW.godotContext

    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    initialization.minimum_initialization_level = .INITIALIZATION_SCENE
    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit

}

extensionDeinit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}

extensionInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    context = GDW.godotContext

    if initLevel != .INITIALIZATION_SCENE{
        return
    }
    when ODIN_DEBUG {
        fmt.println(`RUNNING ODIN ARRAYS LIBRARY IN DEBUNG MODE
    ADDITIONAL WARNINGS WILL BE SHOWN`)
    }
    
    

    /*
    Initialize the different classes.
    classInitProc(classStruct)
    */
    gameInit(userdata, initLevel)
    //OdinArrayObjInit(userdata, initLevel)
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


    //WARNING! When using these you Must free them. Unliked ref counted these are not freed based on the scope of their declaration.
    OdinArrayNoRefBindMethod(Odini64ArrayNoRef, Odini64ArrayNoRef_CString, &Odini64ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinBoolArrayNoRef, OdinBoolArrayNoRef_CString, &OdinBoolArrayNoRef_SN)
    OdinArrayNoRefBindMethod(Odinf64ArrayNoRef, Odinf64ArrayNoRef_CString, &Odinf64ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinGDStringArrayNoRef, OdinGDStringArrayNoRef_CString, &OdinGDStringArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec2ArrayNoRef, OdinVec2ArrayNoRef_CString, &OdinVec2ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec2iArrayNoRef, OdinVec2iArrayNoRef_CString, &OdinVec2iArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinRec2ArrayNoRef, OdinRec2ArrayNoRef_CString, &OdinRec2ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinRec2iArrayNoRef, OdinRec2iArrayNoRef_CString, &OdinRec2iArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec3ArrayNoRef, OdinVec3ArrayNoRef_CString, &OdinVec3ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec3iArrayNoRef, OdinVec3iArrayNoRef_CString, &OdinVec3iArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinTrans2DArrayNoRef, OdinTrans2DArrayNoRef_CString, &OdinTrans2DArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec4ArrayNoRef, OdinVec4ArrayNoRef_CString, &OdinVec4ArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinVec4iArrayNoRef, OdinVec4iArrayNoRef_CString, &OdinVec4iArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinPlaneArrayNoRef, OdinPlaneArrayNoRef_CString, &OdinPlaneArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinQuatArrayNoRef, OdinQuatArrayNoRef_CString, &OdinQuatArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinAABBArrayNoRef, OdinAABBArrayNoRef_CString, &OdinAABBArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinBasisArrayNoRef, OdinBasisArrayNoRef_CString, &OdinBasisArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinTrans3DArrayNoRef, OdinTrans3DArrayNoRef_CString, &OdinTrans3DArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinProjectionArrayNoRef, OdinProjArrayNoRef_CString, &OdinProjArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinColorArrayNoRef, OdinColorArrayNoRef_CString, &OdinColorArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinStringNameArrayNoRef, OdinStringNameArrayNoRef_CString, &OdinStringNameArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinNodePathArrayNoRef, OdinNodePathArrayNoRef_CString, &OdinNodePathArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinRIDArrayNoRef, OdinRIDArrayNoRef_CString, &OdinRIDArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinObjectArrayNoRef, OdinObjectArrayNoRef_CString, &OdinObjectArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinCallableArrayNoRef, OdinCallableArrayNoRef_CString, &OdinCallableArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinSignalArrayNoRef, OdinSignalArrayNoRef_CString, &OdinSignalArrayNoRef_SN)
    OdinArrayNoRefBindMethod(OdinDicArrayNoRef, OdinDicArrayNoRef_CString, &OdinDicArrayNoRef_SN)    

    OdinSliceBindMethod(Odini64Slice, Odini64Slice_CString, &Odini64Slice_SN)
}


//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}