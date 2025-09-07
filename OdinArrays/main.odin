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
    //gameInit(userdata, initLevel)
    //OdinArrayObjInit(userdata, initLevel)
    OdinArrayBindMethod(Odini64Array, Odini64Array_CString, &Odini64Array_SN, &Odini64Arrayprocs, Class_String)
    OdinArrayBindMethod(Odinf64Array, Odinf64Array_CString, &Odinf64Array_SN, &Odinf64Arrayprocs, Class_String)
    OdinArrayBindMethod(OdinBoolArray, OdinBoolArray_CString, &OdinBoolArray_SN, &OdinBoolArrayprocs, Class_String)
    OdinArrayBindMethod(OdinGDStringArray, OdinGDStringArray_CString, &OdinGDStringArray_SN, &OdinGDStringArrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec2Array, OdinVec2Array_CString, &OdinVec2Array_SN, &OdinVec2Arrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec2iArray, OdinVec2iArray_CString, &OdinVec2iArray_SN, &OdinVec2iArrayprocs, Class_String)
    OdinArrayBindMethod(OdinRec2Array, OdinRec2Array_CString, &OdinRec2Array_SN, &OdinRec2Arrayprocs, Class_String)
    OdinArrayBindMethod(OdinRec2iArray, OdinRec2iArray_CString, &OdinRec2iArray_SN, &OdinRec2iArrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec3Array, OdinVec3Array_CString, &OdinVec3Array_SN, &OdinVec3Arrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec3iArray, OdinVec3iArray_CString, &OdinVec3iArray_SN, &OdinVec3iArrayprocs, Class_String)
    OdinArrayBindMethod(OdinTrans2DArray, OdinTrans2DArray_CString, &OdinTrans2DArray_SN, &OdinTrans2DArrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec4Array, OdinVec4Array_CString, &OdinVec4Array_SN, &OdinVec4Arrayprocs, Class_String)
    OdinArrayBindMethod(OdinVec4iArray, OdinVec4iArray_CString, &OdinVec4iArray_SN, &OdinVec4iArrayprocs, Class_String)
    OdinArrayBindMethod(OdinPlaneArray, OdinPlaneArray_CString, &OdinPlaneArray_SN, &OdinPlaneArrayprocs, Class_String)
    OdinArrayBindMethod(OdinQuatArray, OdinQuatArray_CString, &OdinQuatArray_SN, &OdinQuatArrayprocs, Class_String)
    OdinArrayBindMethod(OdinAABBArray, OdinAABBArray_CString, &OdinAABBArray_SN, &OdinAABBArrayprocs, Class_String)
    OdinArrayBindMethod(OdinBasisArray, OdinBasisArray_CString, &OdinBasisArray_SN, &OdinBasisArrayprocs, Class_String)
    OdinArrayBindMethod(OdinTrans3DArray, OdinTrans3DArray_CString, &OdinTrans3DArray_SN, &OdinTrans3DArrayprocs, Class_String)
    OdinArrayBindMethod(OdinProjectionArray, OdinProjArray_CString, &OdinProjArray_SN, &OdinProjectionArrayprocs, Class_String)
    OdinArrayBindMethod(OdinColorArray, OdinColorArray_CString, &OdinColorArray_SN, &OdinColorArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinStringNameArray, OdinStringNameArray_CString, &OdinStringNameArray_SN, &OdinStringNameArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinNodePathArray, OdinNodePathArray_CString, &OdinNodePathArray_SN, &OdinNodePathArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinRIDArray, OdinRIDArray_CString, &OdinRIDArray_SN, &OdinRIDArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinObjectArray, OdinObjectArray_CString, &OdinObjectArray_SN, &OdinObjectArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinCallableArray, OdinCallableArray_CString, &OdinCallableArray_SN, &OdinCallableArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinSignalArray, OdinSignalArray_CString, &OdinSignalArray_SN, &OdinSignalArrayprocs, Class_String)
    //OdinArrayBindMethod(OdinDicArray, OdinDicArray_CString, &OdinDicArray_SN, &OdinDicArrayprocs, Class_String)
    
    //WARNING! When using these you Must free them. Unliked ref counted these are not freed based on the scope of their declaration.
    OdinArrayNoRefBindMethod(Odini64ArrayNoRef, Odini64ArrayNoRef_CString, &Odini64ArrayNoRef_SN, &Odini64ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinBoolArrayNoRef, OdinBoolArrayNoRef_CString, &OdinBoolArrayNoRef_SN, &OdinBoolArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(Odinf64ArrayNoRef, Odinf64ArrayNoRef_CString, &Odinf64ArrayNoRef_SN, &Odinf64ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinGDStringArrayNoRef, OdinGDStringArrayNoRef_CString, &OdinGDStringArrayNoRef_SN, &OdinGDStringArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec2ArrayNoRef, OdinVec2ArrayNoRef_CString, &OdinVec2ArrayNoRef_SN,                    &OdinVec2ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec2iArrayNoRef, OdinVec2iArrayNoRef_CString, &OdinVec2iArrayNoRef_SN,                 &OdinVec2iArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinRec2ArrayNoRef, OdinRec2ArrayNoRef_CString, &OdinRec2ArrayNoRef_SN,                    &OdinRec2ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinRec2iArrayNoRef, OdinRec2iArrayNoRef_CString, &OdinRec2iArrayNoRef_SN,                 &OdinRec2iArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec3ArrayNoRef, OdinVec3ArrayNoRef_CString, &OdinVec3ArrayNoRef_SN,                    &OdinVec3ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec3iArrayNoRef, OdinVec3iArrayNoRef_CString, &OdinVec3iArrayNoRef_SN,                 &OdinVec3iArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinTrans2DArrayNoRef, OdinTrans2DArrayNoRef_CString, &OdinTrans2DArrayNoRef_SN,           &OdinTrans2DArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec4ArrayNoRef, OdinVec4ArrayNoRef_CString, &OdinVec4ArrayNoRef_SN,                    &OdinVec4ArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinVec4iArrayNoRef, OdinVec4iArrayNoRef_CString, &OdinVec4iArrayNoRef_SN,                 &OdinVec4iArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinPlaneArrayNoRef, OdinPlaneArrayNoRef_CString, &OdinPlaneArrayNoRef_SN,                 &OdinPlaneArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinQuatArrayNoRef, OdinQuatArrayNoRef_CString, &OdinQuatArrayNoRef_SN,                    &OdinQuatArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinAABBArrayNoRef, OdinAABBArrayNoRef_CString, &OdinAABBArrayNoRef_SN,                    &OdinAABBArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinBasisArrayNoRef, OdinBasisArrayNoRef_CString, &OdinBasisArrayNoRef_SN,                 &OdinBasisArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinTrans3DArrayNoRef, OdinTrans3DArrayNoRef_CString, &OdinTrans3DArrayNoRef_SN,           &OdinTrans3DArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinProjectionArrayNoRef, OdinProjArrayNoRef_CString, &OdinProjArrayNoRef_SN,              &OdinProjectionArrayNoRefprocs, Class_StringNoRef)
    OdinArrayNoRefBindMethod(OdinColorArrayNoRef, OdinColorArrayNoRef_CString, &OdinColorArrayNoRef_SN,                 &OdinColorArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinStringNameArrayNoRef, OdinStringNameArrayNoRef_CString, &OdinStringNameArrayNoRef_SN,  &OdinStringNameArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinNodePathArrayNoRef, OdinNodePathArrayNoRef_CString, &OdinNodePathArrayNoRef_SN,        &OdinNodePathArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinRIDArrayNoRef, OdinRIDArrayNoRef_CString, &OdinRIDArrayNoRef_SN,                       &OdinRIDArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinObjectArrayNoRef, OdinObjectArrayNoRef_CString, &OdinObjectArrayNoRef_SN,              &OdinObjectArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinCallableArrayNoRef, OdinCallableArrayNoRef_CString, &OdinCallableArrayNoRef_SN,        &OdinCallableArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinSignalArrayNoRef, OdinSignalArrayNoRef_CString, &OdinSignalArrayNoRef_SN,              &OdinSignalArrayNoRefprocs, Class_StringNoRef)
    //OdinArrayNoRefBindMethod(OdinDicArrayNoRef, OdinDicArrayNoRef_CString, &OdinDicArrayNoRef_SN, &OdinDicArrayNoRefprocs, Class_StringNoRef)

    //OdinSliceBindMethod(Odini64Slice, Odini64Slice_CString, &Odini64Slice_SN)
}


//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}