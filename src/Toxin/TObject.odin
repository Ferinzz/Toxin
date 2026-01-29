package Toxin

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"


Objectc :: ^GDW.Object

make_Objectc :: proc(p_Objectc_C: ^Objectc_C) {
    p_Objectc_C.self = cast(Objectc)gdAPI.ClassDB.ConstructObject(GDW.GDClass_StringName_get(.Object))
    p_Objectc_C.methods = &Objectc_methods
    //GDW.Objectc_Input(&Objectc_methods)
}

Objectc_C :: struct {
    self: Objectc,
    using methods: ^Objectc_methods_list(Objectc_C),
}

Objectc_methods: Objectc_methods_list(Objectc_C)

Objectc_methods_list:: struct($T:typeid) {
    add_user_signal: proc (self: ^T, vals: struct{r_name: ^StringName}),
    call: proc (self: ^T, padding: struct{rawptr}, r_ret: ^StringName) -> ^StringName,
    call_deferred: proc (self: ^T, padding: struct{^bool}, r_count: ^Int) -> int,
    emit_signal: proc (self: ^T, padding: struct{^bool}, r_count: ^Int) -> int,
    disconnect: proc (self: ^T, padding: struct{^bool}, r_count: ^Int) -> int,
    //class_get_signal: proc(self: Objectc_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}