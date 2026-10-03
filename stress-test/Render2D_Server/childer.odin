package main

import "../../Toxin"
import "../../Toxin/classes"
import "base:runtime"
import "core:fmt"
import Classes "../../GD_Classes"
import Math "core:math"
import rand "core:math/rand"

BULLET_COUNT :   int : 100500
SPEED_MIN :      f64 : 20
SPEED_MAX :      f64 : 80
SPEED_RANGE :    f64 : 60
OFFSET :         Toxin.Vector2 = {0,0}

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    shape :Toxin.RID,
    bullet_image :Classes.Texture2D, //cannot preload from Extension. Will need to use load to get the texture.
    bullets :[BULLET_COUNT]bullet, //Max bullet count is known, so we can create a fixed array. Otherwise would be dynamic.
    space :Toxin.RID,
    area :Toxin.RID,
    window :Toxin.Vector2,
}

bullet:: struct {
    position :Toxin.Transform2D,
    speed :Toxin.float,
    body :Toxin.RID,
}


windowSize :Toxin.Vector2i
wind_obj :^Toxin.Object
window :Toxin.Vector2 = {1150, 750}
size :Toxin.Vector2= {64,64}
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
    registerer = self_reggy,
    Exporter = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc(p_class_user_data: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self

    cache_mode: Classes.ResourceLoader_CacheMode = .CACHE_MODE_REUSE
    self.class.bullet_image = Toxin.loadResource( "res://icon.svg", "Texture2D", &cache_mode )

    //self.bullets = make( [dynamic]bullet, BULLET_COUNT )

    //fmt.println( "ïnit" )
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: Classes.Node2D_vtable( THIS_CLASS_NAME ) = {
    _ready= proc "c" ( self: ^Toxin.Class_Container( THIS_CLASS_NAME ), _: rawptr, _: rawptr) {
        context = runtime.default_context();
        classes.CanvasItem_queue_redraw( self.self )
        self.class.shape = classes.PhysicsServer2D_circle_shape_create( Toxin.PhysicsServer2D )
        //shape = PhysicsServer2D.circle_shape_create()

        /*
        Can I get the viewport based on the Object itself. This _ready function is being called after it was added to the SceneTree.
        */
        viewport: Classes.Viewport = classes.Node_get_viewport(self.self)

        //Acutal code starts here.
        for &abullet in self.class.bullets {

            //In the example they had to use .new() to create a bullet variable because they made it as a class.
            //In our case it's just a struct. In both cases the data is stored in the array at the end.
            //NO REASON to make it heap allocated.
            //var bullet := Bullet.new()

            abullet.speed = (SPEED_RANGE*rand.float64()) + f64(SPEED_MIN)
            abullet.position = {0, 0, 0, 0, 1000*rand.float32(), 1000*rand.float32()}
        }

        //Acutal code starts here.
        rect: Toxin.Rect2 = classes.CanvasItem_get_viewport_rect( self.self )
        OFFSET.x = rect.x + 64
        OFFSET.y = rect.y + 64
    },
    //_enter_tree= proc "c" ( self: ^Toxin.Class_Container( THIS_CLASS_NAME ), _: rawptr, _: rawptr ) {
    //    context = runtime.default_context( )
    //    //fmt.println( window )
    //},
    _physics_process = proc "c" ( self: ^Toxin.Class_Container( THIS_CLASS_NAME ), #by_ptr p_args: struct{delta: ^Toxin.float}, _: rawptr ){
        context = runtime.default_context( )
        //Acutal code starts here.
        
        for &abullet in self.class.bullets {
            if abullet.position[2,0] < -16 { abullet.position[2,0] = OFFSET.x }
            else { abullet.position[2,0] -= f32( abullet.speed*p_args.delta^ ) }
        }
    },
    _process= proc "c" ( self: ^Toxin.Class_Container(THIS_CLASS_NAME), #by_ptr p_args: struct{delta: ^Toxin.float}, _: rawptr ){
        context = runtime.default_context( );
        classes.CanvasItem_queue_redraw( self.self )
    },
    _draw= proc "c" ( self: ^Toxin.Class_Container( THIS_CLASS_NAME ), _: rawptr, _: rawptr ){
        context = runtime.default_context( )
        color: Toxin.Color = { 1,1,1,1 }
        
        for &abullet in self.class.bullets{
            offset: Toxin.Vector2 = classes.Texture2D_get_size( self.class.bullet_image )
            classes.CanvasItem_draw_texture( self.self, &self.class.bullet_image, &( Toxin.Vector2{ abullet.position[2,0] - offset.x/2, abullet.position[2,1] - offset.y/2 } ), &color )
        }
    },
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
}