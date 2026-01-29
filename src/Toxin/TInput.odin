package Toxin

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"

make_Input :: proc(Input: ^Input_C) {
    Input.methods = &Input_methods
    //GDW.init_Input(&Input_methods)
}

Input_C :: struct {
    self: ^GDW.InputEvent,
    using methods: ^Input_methods_list,
}

Input_methods_list:: struct {
    set_name: proc "fastcall" (self: ^GDW.InputEvent, name: rawptr),
    set_name2: proc (self: ^GDW.InputEvent, name: rawptr),
    get_name: proc "fastcall" (self: ^GDW.InputEvent, r_name: rawptr) -> ^StringName,
    get_name2: proc (self: ^GDW.InputEvent, r_name: rawptr) -> ^StringName,
    get_child_count: proc "fastcall" (self: ^GDW.InputEvent, r_count: bool) -> int,
    get_child_count2: proc (self: ^GDW.InputEvent, r_count: bool) -> int,
    //class_get_signal: proc(self: Input_C, ret: rawptr, className: ^StringName, signalName: ^StringName) -> GDW.Array,
    //class_has_signal
}

Input_methods: Input_methods_list

Input: Input_C = {
    methods = &Input_methods
}