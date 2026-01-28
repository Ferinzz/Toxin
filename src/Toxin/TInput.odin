package Toxin

import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"
import "GDWrapper/gdAPI"

make_Input :: proc(Input: ^Input_C) {
    Input.methods = &Input_methods
    //GDW.init_Input(&Input_methods)
}

Input_C :: struct {
    self: ^GDW.InputEvent,
    using methods: ^Input_methods_list,
}

Input_methods_list:: struct {
    Get_Class_List: GDE.MethodBindPtr,
    set_name: proc "fastcall" (self: ^GDW.InputEvent, name: rawptr),
    set_name2: proc (self: ^GDW.InputEvent, name: rawptr),
    get_name: proc "fastcall" (self: ^GDW.InputEvent, r_name: rawptr) -> ^GDW.StringName,
    get_name2: proc (self: ^GDW.InputEvent, r_name: rawptr) -> ^GDW.StringName,
    get_child_count: proc "fastcall" (self: ^GDW.InputEvent, r_count: bool) -> int,
    get_child_count2: proc (self: ^GDW.InputEvent, r_count: bool) -> int,
    //class_get_signal: proc(self: Input_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}

Input_methods: Input_methods_list

Input: Input_C = {
    methods = &Input_methods
}