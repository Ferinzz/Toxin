package Toxin

import GDE "shared:GDWrapper/gdAPI/gdextension"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"


getIndex_v:: proc {
    GetArrayIndex,
    GetPackStringIndex,
}
GetArrayIndex:: proc(p_base: ^GDW.Class_Array, index: GDW.Int, r_ret: ^GDW.Variant) {
    GDW.GDArray_Methods.GetIndex(p_base, index, r_ret)
}
GetPackStringIndex :: proc(p_base: ^GDW.PackedStringArray, index: GDW.Int, r_ret: ^GDW.Variant) {
    GDW.PackedStringArray_Methods.GetIndex(p_base, index, r_ret)
}

BuiltinMake:: proc{
    gdMakeArray,
}

Class_Array :: GDW.Class_Array

gdMakeArray:: proc(p_array: ^Class_Array) {
    p_array.methods = &GDW.GDArray_Methods
    p_array->create0(nil)
}


/*
Tmake:: proc {
    makeArray,
}
makeArray :: proc(p_base: ^Array) {
    args :rawptr= nil
    GDWrapper.GDArray.create0(p_base, &args)
}

getIndex_GDArray_v :: proc(p_base: ^Array, index: Int, r_ret: ^GDE.Variant) {
    GDWrapper.GDArray.GetIndex(p_base, index, r_ret)
}*/