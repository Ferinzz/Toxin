package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import "core:fmt"
import sics "base:intrinsics"

/*
init_classDB :: proc (classDB_methods: ^$T) {
    classDB_methods.class_get_method_list = cast(sics.type_field_type(T, "class_get_method_list"))(cast(^MethodBind)classDBGetMethodBind3(.ClassDB, "class_get_method_list", 3504980660)).method
    classDB_methods.class_get_signal = cast(sics.type_field_type(T, "class_get_signal"))(cast(^MethodBind)classDBGetMethodBind3(.ClassDB, "class_get_signal", 3061114238)).method
}
*/

get_name2_mb: ^MethodBind
set_name2_mb: ^MethodBind

/*
class_get_method_list :: proc() {
    SN: StringName = StringConstruct.stringNameNewString_r("ClassDB")
    args:= [?]rawptr{&SN}
    ret: Class_Array
    gdAPI.Object_Utils.MethodBindPtrcall(classDB_methods.class_get_method_list, cast(^Object)(&Library), raw_data(args[:]), &ret)
    index:Variant
    index.VType = .DICTIONARY
    GDArray_Methods.GetIndex(&ret, 0, &index)
    //fmt.println((cast(^[4]rawptr)index)^)
    gdAPI.Strings_Utils.NewWithLatin1Chars(&SN, "name")
    key:GDE.Variant = tovariant(&SN, gdstring)
    gdAPI.Dictionary_Utils.OperatorIndex(&index.data, &key)
    fmt.println(gdAPI.Dictionary_Utils.OperatorIndex(&index.data, &key))
}*/