package main

//import GDW "shared:GDWrapper"
import "shared:Toxin"
import "base:runtime"
import "core:fmt"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.

//Godot will be passing us a pointer to this struct during callbacks.
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    angle: Toxin.float,
    position: Toxin.Vector2,
    window: Toxin.Vector2,
    size: Toxin.Vector2,
}


windowSize:Toxin.Vector2i
Window_MethodBind_List: Classes.Window_MethodBind_List
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1150, 750}
size:Toxin.Vector2={64,64}


self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable), THIS_CLASS_NAME_Init)

    fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        registerer = {self_register = self_reggy,},
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Sprite2D,
    class_struct = THIS_CLASS_NAME,
    },
    Exporter = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)

    class.class.angle=rand.float64_range(0, Math.PI*2)
    class.class.speed=rand.int64_range(100, 600)
    class.class.window = {rand.float32_range(window.x-64, window.x), rand.float32_range(window.y-64, window.y)}
    class.class.position = {rand.float32_range(64,class.class.window.x-64), rand.float32_range(64,class.class.window.y-64)}
    class.class.size = {rand.float32_range(0,32), rand.float32_range(0,32)}
    //fmt.println("ïnit")
    return class.self
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: Toxin.vNode2D(THIS_CLASS_NAME) = {
    _ready= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
        context = runtime.default_context();
        Texture_Class.set_texture->m_call(self.self, {&texture}, nil)
        Node2D_Class.set_position->m_call(self.self, {&self.class.position})
    },
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context();
        self.class.position.x+=Math.cos_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        self.class.position.y+=Math.sin_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        Node2D_Class.set_position->m_call(self.self, {&self.class.position})
        if self.class.position.x > self.class.window.x - self.class.size.x || self.class.position.x < self.class.size.x do self.class.angle = Math.PI - self.class.angle
        if self.class.position.y > self.class.window.y - self.class.size.y || self.class.position.y < self.class.size.y do self.class.angle = -self.class.angle
    },
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
}