package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

Node2D_Get_Global_Position :: proc (self: ^Object, r_Vector: ^Vector2) {
    @(static)GetGlobalPosition: GDE.MethodBindPtr
    if GetGlobalPosition == nil {
        GetGlobalPosition = classDBGetMethodBind3(.Node2D, "get_global_position", 3341600327)
    }
    gdAPI.Object_Utils.MethodBindPtrcall(GetGlobalPosition, self, nil, r_Vector)
}


//CanvasItem Methods

CanvasItem_draw_texture_rect :: proc(canvas_parent: ^Object, texture: ^^Object, rect: ^Rec2,\
    tile: ^Bool, modulate: ^Color, transpose: ^Bool) {
    @(static)drawtexturerect: GDE.MethodBindPtr
    if drawtexturerect == nil {
        drawtexturerect = classDBGetMethodBind3(.CanvasItem, "draw_texture_rect", 3832805018)
    }

    args:= [?]rawptr {texture, rect, tile, modulate, transpose}

    gdAPI.Object_Utils.MethodBindPtrcall(drawtexturerect, canvas_parent, raw_data(args[:]), nil)
}

//Node methods
Node_get_node :: proc(node: ^Object, path: ^NodePath, r_node: ^^Object) {
    @(static)getnode: GDE.MethodBindPtr
    if getnode == nil {
        getnode = classDBGetMethodBind3(.Node, "get_node", 2734337346)
    }

    args:= [?]rawptr {path}

    gdAPI.Object_Utils.MethodBindPtrcall(getnode, node, raw_data(args[:]), r_node)
}

Node_set_name :: proc(node: ^Object, name: ^StringName) {
    @(static)Nodesetname: GDE.MethodBindPtr
    if Nodesetname == nil {
        Nodesetname = classDBGetMethodBind3(.Node, "set_name", 3304788590)
    }

    args:= [?]rawptr {name}

    gdAPI.Object_Utils.MethodBindPtrcall(Nodesetname, node, raw_data(args[:]), nil)
}