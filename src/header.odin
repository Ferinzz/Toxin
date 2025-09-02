package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import sics "base:intrinsics"

/*
Odini64Array :: OdinArrays(GDE.Int) == the class struct that will hold the info
Odini64Array_SN: GDE.StringName == strignName that will be reused for several procedures. We're keeping it in memory because it's expensive to make anew
Odini64Array_CString:: "Odini64Array" == name that will be visible in Godot as class name. name that will be hashed to stringName.
@export
odini64Arrayprocs: ArrayProcs(Odini64Array) == holds all the procedures. Without this they won't be accessible outside Godot due to the way they are being created.
*/

/*
* Odin arrays are a struct with three values cap, len, [^]data. Do not copy the struct, only reference it.
* newData = data will get out of sync and cause memory issues if either of them resize the cap of the array.
* 
*/
OdinArrays :: struct ($T: typeid){
    selfPtr: ^GDE.Object,
    type: typeid, //Because if we pass these between two classes then back to Odin we would(?) lose the type info.
    data: [dynamic]T,
}


/*
* Exposing these to Godot was simple enough, but because
* these are created from within the scope of a function they
* are not available directly. Also name collisions.
*/
ArrayProcs :: struct ($T: typeid) {
    unref : proc "c" (p_instance: GDE.ClassInstancePtr),
    Destroy : proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr),
    Create : proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr,
    arcreate : proc "c" (T: ^T),
    arappend : proc "c" (aclassStruct: ^T, value: sics.type_elem_type(type_of(aclassStruct.data))),
    arpop : proc "c" (aclassStruct: ^T) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))),
    arset : proc "c" (aclassStruct: ^T, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))),
    arlength : proc "c" (aclassStruct: ^T) -> GDE.Int,
    arraw_data : proc "c" (aclassStruct: ^T) -> GDE.Int,
    arcap : proc "c" (aclassStruct: ^T) -> GDE.Int,
    arunordered_remove : proc "c" (aclassStruct: ^T, index: int),
    arordered_remove : proc "c" (aclassStruct: ^T, index: int),
    arremove_range : proc "c" (aclassStruct: ^T, low: int, high: int),
    arpop_safe : proc "c" (aclassStruct: ^T) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))),
    arpop_front : proc "c" (aclassStruct: ^T) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))),
    arpop_front_safe : proc "c" (aclassStruct: ^T) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))),
    ardelete : proc "c" (aclassStruct: ^T),
    armake_len : proc "c" (aclassStruct: ^T, len: int),
    arappend_nothing : proc "c" (aclassStruct: ^T),
    arinject_at_elem : proc "c" (aclassStruct: ^T, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))),
    arassign_at_elem : proc "c" (aclassStruct: ^T, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))),
    arclear : proc "c" (aclassStruct: ^T),
    arresize : proc "c" (aclassStruct: ^T, size: int),
    arreserve : proc "c" (aclassStruct: ^T, size: int),
    arshrink : proc "c" (aclassStruct: ^T),
    argetIndex : proc "c" (aclassStruct: ^T, index: GDE.Int) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))),
    arforAll : proc "c" (aclassStruct: ^T),
    arforEachbyStringName : proc "c" (aclassStruct: ^T, object: GDE.Object, func_SN: GDE.StringName),
    arforEach : proc "c" (aclassStruct: ^T, func: GDE.Callable),
    arFill : proc "c" (aclassStruct: ^T, value: sics.type_elem_type(type_of(aclassStruct.data))),
    arFillEach : proc "c" (aclassStruct: ^T, func: GDE.Callable),
    arSlice : proc "c" (aclassStruct: ^T) -> GDE.Object,
    arSliceRange : proc "c" (aclassStruct: ^T, min: GDE.Int, max: GDE.Int),
}

Odini64Array :: OdinArrays(GDE.Int)
Odini64Array_SN: GDE.StringName
Odini64Array_CString:: "Odini64Array"
@export
odini64Arrayprocs: ArrayProcs(Odini64Array)


OdinBoolArray :: OdinArrays(GDE.Bool)
OdinBoolArray_SN: GDE.StringName
OdinBoolArray_CString:: "OdinBoolArray"
@export
OdinBoolprocs: ArrayProcs(OdinBoolArray)


Odinf64Array :: OdinArrays(GDE.float)
Odinf64Array_SN: GDE.StringName
Odinf64Array_CString:: "Odinf64Array"
@export
Odinf64Arrayprocs: ArrayProcs(Odinf64Array)


OdinGDStringArray :: OdinArrays(GDE.gdstring)
OdinGDStringArray_SN: GDE.StringName
OdinGDStringArray_CString:: "OdinGDStringArray"
@export
OdinGDStringArrayprocs: ArrayProcs(OdinGDStringArray)


OdinVec2Array :: OdinArrays(GDE.Vector2)
OdinVec2Array_SN: GDE.StringName
OdinVec2Array_CString:: "OdinVec2Array"
@export
OdinVec2Arrayprocs: ArrayProcs(OdinVec2Array)


OdinVec2iArray :: OdinArrays(GDE.Vector2i)
OdinVec2iArray_SN: GDE.StringName
OdinVec2iArray_CString:: "OdinVec2iArray"
@export
OdinVec2iArrayprocs: ArrayProcs(OdinVec2iArray)


OdinRec2Array :: OdinArrays(GDE.Rec2)
OdinRec2Array_SN: GDE.StringName
OdinRec2Array_CString:: "OdinRec2Array"
@export
OdinRec2Arrayprocs: ArrayProcs(OdinRec2Array)


OdinRec2iArray :: OdinArrays(GDE.Rec2i)
OdinRec2iArray_SN: GDE.StringName
OdinRec2iArray_CString:: "OdinRec2iArray"
@export
OdinRec2iArrayprocs: ArrayProcs(OdinRec2iArray)


OdinVec3Array :: OdinArrays(GDE.Vector3)
OdinVec3Array_SN: GDE.StringName
OdinVec3Array_CString:: "OdinVec3Array"
@export
OdinVec3Arrayprocs: ArrayProcs(OdinVec3Array)


OdinVec3iArray :: OdinArrays(GDE.Vector3i)
OdinVec3iArray_SN: GDE.StringName
OdinVec3iArray_CString:: "OdinVec3iArray"
@export
OdinVec3iArrayprocs: ArrayProcs(OdinVec3iArray)


OdinTrans2DArray :: OdinArrays(GDE.Transform2D)
OdinTrans2DArray_SN: GDE.StringName
OdinTrans2DArray_CString:: "OdinTrans2DArray"
@export
OdinTrans2DArrayprocs: ArrayProcs(OdinTrans2DArray)


OdinVec4Array :: OdinArrays(GDE.Vector4)
OdinVec4Array_SN: GDE.StringName
OdinVec4Array_CString:: "OdinVec4Array"
@export
OdinVec4Arrayprocs: ArrayProcs(OdinVec4Array)


OdinVec4iArray :: OdinArrays(GDE.Vector4i)
OdinVec4iArray_SN: GDE.StringName
OdinVec4iArray_CString:: "OdinVec4iArray"
@export
OdinVec4iArrayprocs: ArrayProcs(OdinVec4iArray)


OdinPlaneArray :: OdinArrays(GDE.Plane)
OdinPlaneArray_SN: GDE.StringName
OdinPlaneArray_CString:: "OdinPlaneArray"
@export
OdinPlaneArrayprocs: ArrayProcs(OdinPlaneArray)


OdinQuatArray :: OdinArrays(GDE.Quaternion)
OdinQuatArray_SN: GDE.StringName
OdinQuatArray_CString:: "OdinQuatArray"
@export
OdinQuatArrayprocs: ArrayProcs(OdinQuatArray)


OdinAABBArray :: OdinArrays(GDE.AABB)
OdinAABBArray_SN: GDE.StringName
OdinAABBArray_CString:: "OdinAABBArray"
@export
OdinAABBArrayprocs: ArrayProcs(OdinAABBArray)


OdinBasisArray :: OdinArrays(GDE.Basis)
OdinBasisArray_SN: GDE.StringName
OdinBasisArray_CString:: "OdinBasisArray"
@export
OdinBasisArrayprocs: ArrayProcs(OdinBasisArray)


OdinTrans3DArray :: OdinArrays(GDE.Transform3D)
OdinTrans3DArray_SN: GDE.StringName
OdinTrans3DArray_CString:: "OdinTrans3DArray"
@export
OdinTrans3DArrayprocs: ArrayProcs(OdinTrans3DArray)


OdinProjectionArray :: OdinArrays(GDE.Projection)
OdinProjArray_SN: GDE.StringName
OdinProjArray_CString:: "OdinProjectionArray"
@export
OdinProjectionArrayprocs: ArrayProcs(OdinProjectionArray)


OdinColorArray :: OdinArrays(GDE.Color)
OdinColorArray_SN: GDE.StringName
OdinColorArray_CString:: "OdinColorArray"
@export
OdinColorArrayprocs: ArrayProcs(OdinColorArray)


OdinStringNameArray :: OdinArrays(GDE.StringName)
OdinStringNameArray_SN: GDE.StringName
OdinStringNameArray_CString:: "OdinStrinNameArray"
@export
OdinStringNameArrayprocs: ArrayProcs(OdinStringNameArray)


OdinNodePathArray :: OdinArrays(GDE.NodePath)
OdinNodePathArray_SN: GDE.StringName
OdinNodePathArray_CString:: "OdinNodePathArray"
@export
OdinNodePathArrayprocs: ArrayProcs(OdinNodePathArray)


OdinRIDArray :: OdinArrays(GDE.RID)
OdinRIDArray_SN: GDE.StringName
OdinRIDArray_CString:: "OdinRIDArray"
@export
OdinRIDArrayprocs: ArrayProcs(OdinRIDArray)


OdinObjectArray :: OdinArrays(GDE.Object)
OdinObjectArray_SN: GDE.StringName
OdinObjectArray_CString:: "OdinObjectArray"
@export
OdinObjectArrayprocs: ArrayProcs(OdinObjectArray)


OdinCallableArray :: OdinArrays(GDE.Callable)
OdinCallableArray_SN: GDE.StringName
OdinCallableArray_CString:: "OdinCallableArray"
@export
OdinCallableArrayprocs: ArrayProcs(OdinCallableArray)


OdinSignalArray :: OdinArrays(GDE.Signal)
OdinSignalArray_SN: GDE.StringName
OdinSignalArray_CString:: "OdinSignalArray"
@export
OdinSignalArrayprocs: ArrayProcs(OdinSignalArray)


OdinDicArray :: OdinArrays(GDE.Dictionary)
OdinDicArray_SN: GDE.StringName
OdinDicArray_CString:: "OdinDicArray"
@export
OdinDicArrayprocs: ArrayProcs(OdinDicArray)



OdinSlice :: struct (T: typeid) {
    selfPtr: ^GDE.Object,
    type: typeid, //Because if we pass these between two classes then back to Odin we would(?) lose the type info.
    data: []T,
}

Odini64Slice :: OdinSlice(GDE.Int)
Odini64Slice_SN: GDE.StringName
Odini64Slice_CString:: "Odini64Slice"

OdinBoolSlice :: OdinSlice(GDE.Bool)
OdinBoolSlice_SN: GDE.StringName
OdinBoolSlice_CString:: "OdinBoolSlice"

Odinf64Slice :: OdinSlice(GDE.float)
Odinf64Slice_SN: GDE.StringName
Odinf64Slice_CString:: "Odinf64Slice"

OdinGDStringSlice :: OdinSlice(GDE.gdstring)
OdinGDStringSlice_SN: GDE.StringName
OdinGDStringSlice_CString:: "OdinGDStringSlice"

OdinVec2Slice :: OdinSlice(GDE.Vector2)
OdinVec2Slice_SN: GDE.StringName
OdinVec2Slice_CString:: "OdinVec2Slice"

OdinVec2iSlice :: OdinSlice(GDE.Vector2i)
OdinVec2iSlice_SN: GDE.StringName
OdinVec2iSlice_CString:: "OdinVec2iSlice"

OdinRec2Slice :: OdinSlice(GDE.Rec2)
OdinRec2Slice_SN: GDE.StringName
OdinRec2Slice_CString:: "OdinRec2Slice"

OdinRec2iSlice :: OdinSlice(GDE.Rec2i)
OdinRec2iSlice_SN: GDE.StringName
OdinRec2iSlice_CString:: "OdinRec2iSlice"

OdinVec3Slice :: OdinSlice(GDE.Vector3)
OdinVec3Slice_SN: GDE.StringName
OdinVec3Slice_CString:: "OdinVec3Slice"

OdinVec3iSlice :: OdinSlice(GDE.Vector3i)
OdinVec3iSlice_SN: GDE.StringName
OdinVec3iSlice_CString:: "OdinVec3iSlice"

OdinTrans2DSlice :: OdinSlice(GDE.Transform2D)
OdinTrans2DSlice_SN: GDE.StringName
OdinTrans2DSlice_CString:: "OdinTrans2DSlice"

OdinVec4Slice :: OdinSlice(GDE.Vector4)
OdinVec4Slice_SN: GDE.StringName
OdinVec4Slice_CString:: "OdinVec4Slice"

OdinVec4iSlice :: OdinSlice(GDE.Vector4i)
OdinVec4iSlice_SN: GDE.StringName
OdinVec4iSlice_CString:: "OdinVec4iSlice"

OdinPlaneSlice :: OdinSlice(GDE.Plane)
OdinPlaneSlice_SN: GDE.StringName
OdinPlaneSlice_CString:: "OdinPlaneSlice"

OdinQuatSlice :: OdinSlice(GDE.Quaternion)
OdinQuatSlice_SN: GDE.StringName
OdinQuatSlice_CString:: "OdinQuatSlice"

OdinAABBSlice :: OdinSlice(GDE.AABB)
OdinAABBSlice_SN: GDE.StringName
OdinAABBSlice_CString:: "OdinAABBSlice"

OdinBasisSlice :: OdinSlice(GDE.Basis)
OdinBasisSlice_SN: GDE.StringName
OdinBasisSlice_CString:: "OdinBasisSlice"

OdinTrans3DSlice :: OdinSlice(GDE.Transform3D)
OdinTrans3DSlice_SN: GDE.StringName
OdinTrans3DSlice_CString:: "OdinTrans3DSlice"

OdinProjectionSlice :: OdinSlice(GDE.Projection)
OdinProjSlice_SN: GDE.StringName
OdinProjSlice_CString:: "OdinProjectionSlice"

OdinColorSlice :: OdinSlice(GDE.Color)
OdinColorSlice_SN: GDE.StringName
OdinColorSlice_CString:: "OdinColorSlice"

OdinStringNameSlice :: OdinSlice(GDE.StringName)
OdinStringNameSlice_SN: GDE.StringName
OdinStringNameSlice_CString:: "OdinStrinNameSlice"

OdinNodePathSlice :: OdinSlice(GDE.NodePath)
OdinNodePathSlice_SN: GDE.StringName
OdinNodePathSlice_CString:: "OdinNodePathSlice"

OdinRIDSlice :: OdinSlice(GDE.RID)
OdinRIDSlice_SN: GDE.StringName
OdinRIDSlice_CString:: "OdinRIDSlice"

OdinObjectSlice :: OdinSlice(GDE.Object)
OdinObjectSlice_SN: GDE.StringName
OdinObjectSlice_CString:: "OdinObjectSlice"

OdinCallableSlice :: OdinSlice(GDE.Callable)
OdinCallableSlice_SN: GDE.StringName
OdinCallableSlice_CString:: "OdinCallableSlice"

OdinSignalSlice :: OdinSlice(GDE.Signal)
OdinSignalSlice_SN: GDE.StringName
OdinSignalSlice_CString:: "OdinSignalSlice"

OdinDicSlice :: OdinSlice(GDE.Dictionary)
OdinDicSlice_SN: GDE.StringName
OdinDicSlice_CString:: "OdinDicSlice"