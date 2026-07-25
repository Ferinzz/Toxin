package main

//import GDW "shared:GDWrapper"
import "../../Toxin"
import class "../../Toxin/classes"
import "base:runtime"
import "core:fmt"
import Classes "../../GD_Classes"
import "../../GDWrapper/gdAPI"
import GDE "../../GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.

//Godot will be passing us a pointer to this struct during callbacks.
THIS_CLASS_NAME :: struct {
    speed: f32,
    angle: Toxin.float,
    position: Toxin.Vector2,
    window: Toxin.Vector2i,
    size: Toxin.Vector2i,
}

size_half:Toxin.Vector2={32,32}


THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Sprite2D,
    class_struct_size = size_of(THIS_CLASS_NAME),
    name = Toxin.get_name(THIS_CLASS_NAME),
    },
    create = THIS_CLASS_NAME_Init,
    Exporter = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

THIS_CLASS_NAME_Init :: proc(userdata: ^Toxin.Class_Deets, self: rawptr) {
    context = runtime.default_context()
    self:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))self

    self.class.angle=rand.float64_range(0, Math.PI*2)
    self.class.speed=rand.float32_range(100, 600)
    self.class.window = w_size
    self.class.position = {f32(w_size.x)/2, f32(w_size.y)/2}
    self.class.size = tex_size
    size_half = {f32(tex_size.x)/2, f32(tex_size.y)/2}
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\
//@(require)
/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: Classes.Node2D_vtable(THIS_CLASS_NAME) = {
    _ready= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), args: rawptr = nil, r_ret: rawptr = nil) {
        class.Sprite2D_set_texture(self.self, &texture)
        class.Node2D_set_position(self.self, &self.class.position)
    },
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), #by_ptr p_args: struct{delta: ^Toxin.float},  r_ret: rawptr = nil){
        if self.class.position.y < size_half.y || self.position.y > (f32(self.window.y) - size_half.y) do self.angle = -self.class.angle
        if self.class.position.x < size_half.x || self.position.x > (f32(self.window.x) - size_half.x) do self.angle = Math.PI - self.class.angle
        self.class.position += {(Math.cos_f32(f32(self.class.angle))), (Math.sin_f32(f32(self.class.angle)))}*f32(p_args.delta^)*self.class.speed
        class.Node2D_set_position(self.self, &self.class.position)
    },
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
}