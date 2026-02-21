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

frame_count::20000
frame_times:[1000]f64
windowSize:Toxin.Vector2i
frame_current:int=0
Window_MethodBind_List: Classes.Window_MethodBind_List
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1150, 750}


self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable), THIS_CLASS_NAME_Init)//Toxin.Class_Init) // THIS_CLASS_NAME_Init)

        cache_mode:Toxin.cache_mode=.CACHE_MODE_REUSE
        texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
        fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Sprite2D,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)

    class.class.angle=rand.float64_range(0, Math.PI*2)
    class.class.speed=rand.int64_range(100, 600)
    //class.class.position = {rand.float32_range(100,1100), rand.float32_range(100,750)}
    class.class.window = {rand.float32_range(window.x-64, window.x), rand.float32_range(window.y-64, window.y)}
    class.class.position = {rand.float32_range(64,class.class.window.x-64), rand.float32_range(64,class.class.window.y-64)}
    //class.class.position = {rand.float32_range(64,window.x-64), rand.float32_range(64,window.y-64)}
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
        set:=[?]rawptr{&texture}
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Texture_Class.set_texture, self.self, raw_data(set[:]), nil)
    },
    //_enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
    //    context = runtime.default_context()
    //    
    //    //wind_obj:^Toxin.Object
    //    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_Class.get_window, self.self, nil, &wind_obj)
    //    //window:Toxin.Vector2
    //    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Window_MethodBind_List.get_size, wind_obj, nil, &window)
    //    //fmt.println(window)
    //},
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        self.class.position.x+=Math.cos_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        self.class.position.y+=Math.sin_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        set:=[?]rawptr{&self.class.position}
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node2D_Class.set_position, self.self, raw_data(set[:]), nil)
        last_delta = p_args.delta^
        if self.position.x > self.window.x - self.size.x || self.position.x < self.size.x do self.angle = Math.PI - self.angle
        if self.position.y > self.window.y - self.size.y || self.position.y < self.size.y do self.angle = -self.angle
    
        //if self.position.x > window.x - size.x || self.position.x < size.x do self.angle = Math.PI - self.angle
        //if self.position.y > window.y - size.y || self.position.y < size.y do self.angle = -self.angle
    },
    //_draw= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)){
    //    //context = runtime.default_context()
    //    //fmt.println("yarrr")
    //},
}
size:Toxin.Vector2={64,64}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
}