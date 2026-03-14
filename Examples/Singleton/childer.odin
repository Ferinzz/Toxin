package main

import "shared:Toxin"
import "base:runtime"
import "core:fmt"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"

BULLET_COUNT:   int : 10500
SPEED_MIN:      f64 : 20
SPEED_MAX:      f64 : 80
SPEED_RANGE:    f64 : 60
OFFSET:         Toxin.Vector2 = {0,0}

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    shape: Toxin.RID,
    bullet_image: Classes.Texture2D, //cannot preload from Extension. Will need to use load to get the texture.
    space: Toxin.RID,
    area: Toxin.RID,
    window: Toxin.Vector2,
    bullets: [BULLET_COUNT]bullet, //Max bullet count is known, so we can create a fixed array. Otherwise would be dynamic.
}
muhsingleton :: struct {
    a: i32,
}

bullet:: struct {
    position: Toxin.Transform2D,
    speed: Toxin.float,
    body: Toxin.RID,
}


windowSize:Toxin.Vector2i
Window_MethodBind_List: Classes.Window_MethodBind_List
wind_obj:^Toxin.Node
window:Toxin.Vector2 = {1150, 750}
size:Toxin.Vector2={64,64}
texture: Classes.Texture2D


self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, create=THIS_CLASS_NAME_Init, destroy = cast(proc "c" (p_class_userdata: ^Toxin.Class_Deets, p_instance: GDE.ClassInstancePtr))(THIS_destroy))//Toxin.Class_Init) // THIS_CLASS_NAME_Init)
    fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Object,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

self_reggy2:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, create=THIS_CLASS_NAME_Init, destroy = cast(proc "c" (p_class_userdata: ^Toxin.Class_Deets, p_instance: GDE.ClassInstancePtr))(THIS_destroy))//Toxin.Class_Init) // THIS_CLASS_NAME_Init)

        cache_mode:Classes.ResourceLoader_CacheMode=.CACHE_MODE_REUSE
        //texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
        fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets2: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Object,
    class_struct = muhsingleton,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)

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
    },
    _physics_process = proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context()
    },
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context();
    },
    _draw= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)){
        context = runtime.default_context()
    },
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
    Toxin.Export(className, THIS_CLASS_NAME, "window")//, methodType={.STATIC})
    Toxin.bindMethod(&THIS_CLASS_NAME_deets.SN, create_a_method, {.STATIC})
}
create_a_method::proc "c" (self: ^Toxin.Object) {
    context = runtime.default_context()
    fmt.println("look mah I do thing!")
    fmt.println(this_class)
}
THIS_destroy :: proc "c" (p_class_userdata: ^Toxin.Class_Deets, p_instance: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    gdAPI.Memory_Uils.MemFree(p_instance)

}