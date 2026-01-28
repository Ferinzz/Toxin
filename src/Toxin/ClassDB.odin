package Toxin

import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"
import "GDWrapper/gdAPI"

init_classDB :: proc(classdb: ^ClassDB_C) {
    classdb.methods = &classDB_methods
    GDW.init_classDB(classdb.methods)
}

ClassDB_C :: struct {
    self: struct{obj: GDE.ClassDB, padding: rawptr},
    using methods: ^classDB_methods_list,
}

classDB_methods_list:: struct {
    Get_Class_List: GDE.MethodBindPtr,
    class_get_method_list: proc(self: ClassDB_C, ret: rawptr, className: ^GDW.StringName, inheritance: GDW.Bool) ->GDW.Array,
    class_get_signal: proc(self: ClassDB_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}

classDB_methods: classDB_methods_list

ClassDB: ClassDB_C = {
    methods = &classDB_methods
}