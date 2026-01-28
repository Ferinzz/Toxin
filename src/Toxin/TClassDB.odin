package Toxin

import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"
import "GDWrapper/gdAPI"

/*
make_ClassDB :: proc(ClassDB: ^ClassDB_C) {
    ClassDB.methods = &ClassDB_methods
    GDW.ClassDB_Input(&ClassDB_methods)
}

ClassDB_C :: struct {
    self: GDW.ClassDB,
    using methods: ^ClassDB_methods_list,
}

ClassDB_methods_list:: struct {
    Get_Class_List: GDE.MethodBindPtr,
    set_name: proc "fastcall" (self: GDW.ClassDB, name: rawptr),
    set_name2: proc (self: GDW.ClassDB, vals: struct{r_name: ^GDW.StringName}),
    get_name: proc "fastcall" (self: GDW.ClassDB, r_name: rawptr) -> ^GDW.StringName,
    get_name2: proc (self: GDW.ClassDB, vals: struct{r_name: ^GDW.StringName}, r_ret: ^GDW.StringName) -> ^GDW.StringName,
    get_child_count: proc "fastcall" (self: GDW.ClassDB, r_count: bool) -> int,
    get_child_count2: proc (self: GDW.ClassDB, r_count: ^bool) -> int,
    //class_get_signal: proc(self: ClassDB_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}

ClassDB_methods: ClassDB_methods_list

ClassDB: ClassDB_C = {
    methods = &ClassDB_methods
}*/