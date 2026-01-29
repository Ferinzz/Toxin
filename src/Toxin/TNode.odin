package Toxin

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"

Node :: ^GDW.Object
make_Node :: proc(p_Node_C: ^Node_C) {
    p_Node_C.self = cast(Node)gdAPI.ClassDB.ConstructObject(GDW.GDClass_StringName_get(.Node))
    p_Node_C.methods = &Node_methods
    p_Node_C.objectc_methods = cast(^Objectc_methods_list(Node_C))&Objectc_methods
    GDW.Node_Input(&Node_methods)
}

Node_C :: struct {
    self: Node,
    using methods: ^Node_methods_list,
    using objectc_methods: ^Objectc_methods_list(Node_C),
}

Node_methods: Node_methods_list

Node_methods_list:: struct {
    set_name: proc (self: ^Node_C, vals: struct{r_name: ^StringName}, loc := #caller_location),
    get_name: proc (self: ^Node_C, r_ret: ^StringName, loc := #caller_location),
    get_child_count: proc (self: ^Node_C, check_inheritance: struct{^Bool}, r_count: ^Int, loc := #caller_location),
}

@(require_results)
fdjkafdj ::  proc (self: ^Node_C, padding: struct{rawptr}, r_ret: ^StringName) -> ^StringName {
    return nil
}