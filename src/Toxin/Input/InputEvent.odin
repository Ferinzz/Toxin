package Input

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"

make_Input :: proc(Input: ^Input_C) {
    Input.methods = &Input_methods
    //GDW.init_Input(&Input_methods)
}

Input_C :: struct {
    self: ^InputEvent,
    using methods: ^Input_methods_list,
}

Input_methods_list:: struct {
    set_name: proc "fastcall" (self: ^InputEvent, name: rawptr),
    set_name2: proc (self: ^InputEvent, name: rawptr),
    get_name: proc "fastcall" (self: ^InputEvent, r_name: rawptr) -> ^GDW.StringName,
    get_name2: proc (self: ^InputEvent, r_name: rawptr) -> ^GDW.StringName,
    get_child_count: proc "fastcall" (self: ^InputEvent, r_count: bool) -> int,
    get_child_count2: proc (self: ^InputEvent, r_count: bool) -> int,
    //class_get_signal: proc(self: Input_C, ret: rawptr, className: ^StringName, signalName: ^StringName) -> GDW.Array,
    //class_has_signal
}

Input_methods: Input_methods_list

Input: Input_C = {
    methods = &Input_methods,
}


/*
* Goes through the list of ClassTags to determine what Input_Event was used.
* Does not check inheritance. A InputEventMouseButton is also a InputEventMouse.
* event: Pointer to an InputEvent, usually received from an _input virtual method.
* return: The enum value which the InputEvent corresponds with.
*/
InputEvent_get_ClassTag :: proc(event: ^InputEvent) -> InputEvent_Options {
    for &eventClassTag, index in InputEvent_Tags {
        if gdAPI.Object_Utils.CastTo(event, eventClassTag) != nil {
            return index
        }
    }
    return nil
}