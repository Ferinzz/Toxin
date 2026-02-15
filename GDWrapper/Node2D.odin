package GDWrapper

import GDE "gdextension"

Node2D_Get_Global_Position :: proc (self: GDE.ObjectPtr, r_Vector: ^GDE.Vector2) {
    @(static)GetGlobalPosition: GDE.MethodBindPtr
    if GetGlobalPosition == nil {
        GetGlobalPosition = classDBGetMethodBind2(GDClass_StringName_get(.Node2D), "get_global_position", 3341600327)
    }
    gdAPI.objectMethodBindPtrCall(GetGlobalPosition, self, nil, r_Vector)
}


//CanvasItem Methods

CanvasItem_draw_texture_rect :: proc(canvas_parent: GDE.ObjectPtr, texture: ^GDE.ObjectPtr, rect: ^GDE.Rect2,\
    tile: ^GDE.Bool, modulate: ^GDE.Color, transpose: ^GDE.Bool) {
    @(static)drawtexturerect: GDE.MethodBindPtr
    if drawtexturerect == nil {
        drawtexturerect = classDBGetMethodBind2(GDClass_StringName_get(.CanvasItem), "draw_texture_rect", 3832805018)
    }

    args:= [?]rawptr {texture, rect, tile, modulate, transpose}

    gdAPI.objectMethodBindPtrCall(drawtexturerect, canvas_parent, raw_data(args[:]), nil)
}

//Node methods
Node_get_node :: proc(node: GDE.ObjectPtr, path: ^GDE.NodePath, r_node: ^GDE.ObjectPtr) {
    @(static)getnode: GDE.MethodBindPtr
    if getnode == nil {
        getnode = classDBGetMethodBind2(GDClass_StringName_get(.Node), "get_node", 2734337346)
    }

    args:= [?]rawptr {path}

    gdAPI.objectMethodBindPtrCall(getnode, node, raw_data(args[:]), r_node)
}

Node_set_name :: proc(node: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)Nodesetname: GDE.MethodBindPtr
    if Nodesetname == nil {
        Nodesetname = classDBGetMethodBind2(GDClass_StringName_get(.Node), "set_name", 3304788590)
    }

    args:= [?]rawptr {name}

    gdAPI.objectMethodBindPtrCall(Nodesetname, node, raw_data(args[:]), nil)
}