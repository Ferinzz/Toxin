package Toxin

import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"
import "GDWrapper/gdAPI"

Node :: distinct ^GDW.Object
make_Node :: proc(p_Node_C: ^Node_C) {
    p_Node_C.self = cast(Node)gdAPI.ClassDB.ConstructObject(GDW.GDClass_StringName_get(.Node))
    p_Node_C.methods = &Node_methods
    GDW.Node_Input(&Node_methods)
}

Node_C :: struct {
    self: Node,
    using methods: ^Node_methods_list,
}

Node_methods: Node_methods_list

Node_methods_list:: struct {
    Get_Class_List: GDE.MethodBindPtr,
    set_name: proc (self: Node_C, vals: struct{r_name: ^GDW.StringName}),
    get_name: proc (self: Node_C, padding: struct{rawptr}, r_ret: ^GDW.StringName) -> ^GDW.StringName,
    get_child_count: proc (self: Node_C, padding: struct{^bool}, r_count: ^GDE.Int) -> int,
    //class_get_signal: proc(self: Node_C, ret: rawptr, className: ^GDW.StringName, signalName: ^GDW.StringName) -> GDW.Array,
    //class_has_signal
}