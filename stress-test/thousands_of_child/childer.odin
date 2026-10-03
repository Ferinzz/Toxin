package main

//import GDW "../../GDWrapper"
import "../../Toxin"
import "../../Toxin/classes"
import "base:runtime"
import "core:fmt"
import Classes "../../GD_Classes"
import "../../GDWrapper/gdAPI"
import GDE "../../GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    angle: Toxin.float,
    position: Toxin.Vector2,
    window: Toxin.Vector2,
    size: Toxin.Vector2,
}

windowSize:Toxin.Vector2i
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1150, 750}
size:Toxin.Vector2={64,64}
texture: Classes.Texture2D


self_reggy:: proc(self: ^Toxin.Class_Deets, init_level: Toxin.InitializationLevel) {
    context = runtime.default_context()
    Toxin._Register(self, init_level)

    cache_mode : Classes.ResourceLoader_CacheMode = .CACHE_MODE_REUSE
    texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
    fmt.println("!!special stress test!!")
        
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        name = Toxin.get_name( THIS_CLASS_NAME ),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
        class_struct_size = size_of( THIS_CLASS_NAME ),
    },
    vtable = &THIS_CLASS_NAME_VTable,
    create = THIS_CLASS_NAME_Init,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc(p_class_user_data: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self

    self.class.angle=rand.float64_range(0, Math.PI*2)
    self.class.speed=rand.int64_range(100, 600)
    self.class.window = {rand.float32_range(window.x-64, window.x), rand.float32_range(window.y-64, window.y)}
    self.class.position = { rand.float32_range( 64, self.class.window.x-64 ), rand.float32_range( 64, self.class.window.y-64 ) }
    self.class.size = {rand.float32_range(0,32), rand.float32_range(0,32)}
    append_elem(&class_list, self)
    //fmt.println("ïnit")
}

class_list:[dynamic]^Toxin.Class_Container(THIS_CLASS_NAME)

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: Classes.Node2D_vtable(THIS_CLASS_NAME) = {
    _ready = proc "c" ( self: ^Toxin.Class_Container(THIS_CLASS_NAME), _: rawptr, _: rawptr ) {
        context = runtime.default_context();
        //classes.Texture_set_texture(self.self, &texture)
        classes.Node2D_set_position(self.self, &self.position)
    },
    //_enter_tree = proc "c" ( self: ^Toxin.Class_Container(THIS_CLASS_NAME), _: rawptr, _: rawptr ) {
    //    context = runtime.default_context()
    //},
    _process = proc "c" ( self: ^Toxin.Class_Container(THIS_CLASS_NAME), #by_ptr p_args: struct{delta: ^Toxin.float}, _: rawptr ){
        context = runtime.default_context()
        self.class.position.x+=Math.cos_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        self.class.position.y+=Math.sin_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)

        classes.Node2D_set_position(self.self, &self.position)
        //is_centered: Toxin.Bool = classes.Texture_is_centered(self.self, 0)
        if self.class.position.x > self.class.window.x - self.class.size.x || self.class.position.x < self.class.size.x do self.class.angle = Math.PI - self.class.angle
        if self.position.y > self.window.y - self.size.y || self.position.y < self.size.y do self.angle = -self.angle
    },
    //_draw = proc "c" ( self: ^Toxin.Class_Container(THIS_CLASS_NAME), _: rawptr, _: rawptr ){
    //    //context = runtime.default_context()
    //    //fmt.println("yarrr")
    //},
}
