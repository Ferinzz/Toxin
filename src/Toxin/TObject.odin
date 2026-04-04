package Toxin

import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"


Objectc :: ^GDW.Object

make_Objectc :: proc(p_Objectc_C: ^Objectc_C) {
    p_Objectc_C.self = gdAPI.ClassDB.ConstructObject(GDClass_StringName_get(.Object))
    p_Objectc_C.methods = &Objectc_methods
    //GDW.Objectc_Input(&Objectc_methods)
}

Objectc_C :: struct {
    self: Objectc,
    using methods: ^Objectc_methods_list,
}

Objectc_methods: Objectc_methods_list
/*
Objectc_methods_list:: struct($T:typeid) {
    add_user_signal: proc (self: ^T, vals: struct{r_name: ^StringName}),
    call: proc (self: ^T, padding: struct{rawptr}, r_ret: ^StringName),
    call_deferred: proc (self: ^T, padding: struct{^bool}, r_count: ^Int),
    emit_signal: proc (self: ^T, padding: struct{^bool}, r_count: ^Int),
    disconnect: proc (self: ^T, padding: struct{^bool}, r_count: ^Int),
    //class_get_signal: proc(self: Objectc_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}*/

Objectc_methods_list:: struct {
    add_user_signal: proc (self: ^Object, vals: struct{r_name: ^StringName}),
    call: proc (self: ^Object, padding: struct{rawptr}, r_ret: ^StringName),
    call_deferred: proc (self: ^Object, padding: struct{^bool}, r_count: ^Int),
    emit_signal: proc (self: ^Object, padding: struct{^bool}, r_count: ^Int),
    disconnect: proc (self: ^Object, padding: struct{^bool}, r_count: ^Int),
    //class_get_signal: proc(self: Objectc_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}