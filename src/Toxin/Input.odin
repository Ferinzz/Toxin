package Toxin

import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"
import "GDWrapper/gdAPI"

make_Input :: proc(Input: ^Input_C) {
    Input.methods = &Input_methods
    //padding[0] = (gdAPI.ClassDB.ConstructObject(GDW.GDClass_StringName_get(.Node)))
    //Input.self = padding[0]
    GDW.init_Input(&Input_methods)
}

padding: [3]^GDW.InputEvent

Input_C :: struct {
    self: ^GDW.InputEvent,
    using methods: ^Input_methods_list,
}

Input_methods_list:: struct {
    Get_Class_List: GDE.MethodBindPtr,
    is_action_released: proc "fastcall" (self: ^GDW.InputEvent, dummy: rawptr),
    get_name: proc "fastcall" (self: ^GDW.InputEvent, dummy: rawptr) -> ^GDW.StringName,
    get_child_count: proc "fastcall" (self: ^GDW.InputEvent, dummy: bool) -> int,
    //class_get_signal: proc(self: Input_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}

Input_methods: Input_methods_list

Input: Input_C = {
    methods = &Input_methods
}