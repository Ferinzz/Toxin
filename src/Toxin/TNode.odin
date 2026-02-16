package Toxin

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import Classes "shared:Godot_Odin_Binds/GD_Classes"

Node :: ^GDW.Object
make_Node :: proc(p_Node_C: ^Node_C) {
    p_Node_C.self = gdAPI.ClassDB.ConstructObject(GDW.GDClass_StringName_get(.Node))
    p_Node_C.methods = &Node_methods
    p_Node_C.objectc_methods = cast(^Objectc_methods_list)&Objectc_methods
    //GDW.Node_Input(&Node_methods)
    Fill_Node_Methods()
}

Node_C :: struct {
    self: Node,
    using methods: ^Node_methods_list,
    using objectc_methods: ^Objectc_methods_list,
}

Node_methods: Node_methods_list

Node_mb: Classes.Node_MethodBind_List

Node_methods_list:: struct {
    set_name: proc (self: ^Node_C, vals: struct{r_name: ^StringName}, loc := #caller_location),
    get_name: proc (self: ^Node_C, r_ret: ^StringName, loc := #caller_location),
    get_child_count: proc (self: ^Node_C, check_inheritance: struct{^Bool}, r_count: ^Int, loc := #caller_location),
}

Fill_Node_Methods :: proc() {

    Classes.Node_Init_(&Node_mb)

    Node_methods.get_child_count = proc (self: ^Node_C, check_inheritance: struct{^Bool}, r_count: ^Int, loc := #caller_location) {
        args:=check_inheritance
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_mb.get_child_count, self.self, cast([^]rawptr)&args, r_count)
    }
    Node_methods.set_name = proc (self: ^Node_C, vals: struct{r_name: ^StringName}, loc := #caller_location){
        args:=vals
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_mb.get_child_count, self.self, cast([^]rawptr)&args, nil)
    }
    Node_methods.get_name = proc (self: ^Node_C, r_ret: ^StringName, loc := #caller_location){
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_mb.get_child_count, self.self, nil, r_ret)
    }

}

Node_Signals :: struct {
    ready: proc "c" (self: ^Object),
    renamed: proc "c" (self: ^Object),
    tree_entered: proc "c" (self: ^Object),
    tree_exiting: proc "c" (self: ^Object),
    tree_exited: proc "c" (self: ^Object),
    child_entered_tree: proc "c" (self: ^Object, node: Node),
    // "arguments": [
    // {
    // "name": "node",
    // "type": "Node"
    // }
    child_exiting_tree: proc "c" (self: ^Object, node: Node),
    // "arguments": [
    // {
    // "name": "node",
    // "type": "Node"
    // }
    child_order_changed: proc "c" (self: ^Object),
    replacing_by: proc "c" (self: ^Object, node: Node),
    // "arguments": [
    // {
    // "name": "node",
    // "type": "Node"
    //}
    editor_description_changed: proc "c" (self: ^Object, node: Node),
    // {
    // "name": "node",
    // "type": "Node"
    // }
    editor_state_changed: proc "c" (self: ^Object),
}