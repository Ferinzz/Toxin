package main

import "shared:Toxin"
import "base:runtime"
import "core:fmt"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
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

bullet:: struct {
    position: Toxin.Transform2D,
    speed: Toxin.float,
    body: Toxin.RID,
}


windowSize:Toxin.Vector2i
Window_MethodBind_List: Classes.Window_MethodBind_List
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1150, 750}
size:Toxin.Vector2={64,64}
texture: Classes.Texture2D


self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable), THIS_CLASS_NAME_Init)//Toxin.Class_Init) // THIS_CLASS_NAME_Init)

        cache_mode:Classes.ResourceLoader_CacheMode=.CACHE_MODE_REUSE
        //texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
        fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Node2D,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)

    cache_mode:Classes.ResourceLoader_CacheMode=.CACHE_MODE_REUSE
    class.class.bullet_image = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)

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
        CanvasItem_Class.queue_redraw->m_call(self.self)
        Phys2D_Server.circle_shape_create->m_call(Toxin.PhysServer2dObj, r_ret = &self.class.shape)
        //shape = PhysicsServer2D.circle_shape_create()

        /*
        Can I get the viewport based on the Object itself. This _ready function is being called after it was added to the SceneTree.
        */
        viewport: Classes.Viewport
        Node_Class.get_viewport->m_call(self.self, r_ret = &viewport)
        
        world2d: Classes.World2D
        Viewport_Class.get_world_2d->m_call(viewport, r_ret = &world2d)

        data:Toxin.Int=8
        
        var_int:Toxin.Variant
        Toxin.copy_to_variant(&var_int, &data)
        Phys2D_Server.shape_set_data->m_call(Toxin.PhysServer2dObj, {&self.class.shape, &var_int})

        space: Toxin.RID
        World2D_Class.get_space->m_call(world2d, r_ret = &space)
        //get_space()

        //Acutal code starts here.
        for &abullet in self.class.bullets {

            //In the example they had to use .new() to create a bullet variable because they made it as a class.
            //In our case it's just a struct. In both cases the data is stored in the array at the end.
            //NO REASON to make it heap allocated.
            //same with body.
            //:tableflip:
            //var bullet := Bullet.new()
            
            Phys2D_Server.body_create->m_call(Toxin.PhysServer2dObj, r_ret = &abullet.body)
            //bullet.body = PhysicsServer2D.body_create()

            Phys2D_Server.body_set_space->m_call(Toxin.PhysServer2dObj, {&abullet.body, &space})
            //PhysicsServer2D.body_set_space(bullet.body, get_world_2d().get_space())

            trans2D:= Toxin.Transform2D{1,0,0,1,0,0}

            disabled: Toxin.Bool = false
            Phys2D_Server.body_add_shape->m_call(Toxin.PhysServer2dObj, {&abullet.body, &self.class.shape, &trans2D, &disabled})
            //PhysicsServer2D.body_add_shape(bullet.body, shape)

            mask: i64 = 0
            Phys2D_Server.body_set_collision_mask->m_call(Toxin.PhysServer2dObj, {&abullet.body, &mask})
            //PhysicsServer2D.body_set_collision_mask(bullet.body, 0)
            
            abullet.speed = (SPEED_RANGE*rand.float64()) + f64(SPEED_MIN)
            abullet.position = {0, 0, 0, 0, 1000*rand.float32(), 1000*rand.float32()}
            bodyState: Classes.PhysicsServer2D_BodyState = .BODY_STATE_TRANSFORM
            //This is for the collision position.
            //trans: Toxin.Transform2D = {0,0,0,0,120,120}
            trans_v: Toxin.Variant
            Toxin.copy_to_variant(&trans_v, &abullet.position)

            Phys2D_Server.body_set_state->m_call(Toxin.PhysServer2dObj, {&abullet.body, &bodyState, &trans_v})
            //PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)

        }

        //Acutal code starts here.
        rect: Toxin.Rect2
        
        CanvasItem_Class.get_viewport_rect->m_call(self.self, r_ret = &rect)
        OFFSET.x = rect.width + 16
        OFFSET.y = rect.height + 16
    },
    //_enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
    //    context = runtime.default_context()
    //    //fmt.println(window)
    //},
    _physics_process = proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context()
        for &abullet in self.class.bullets {
            if abullet.position[2,0] < -16 {abullet.position[2,0] = OFFSET.x}
            else {abullet.position[2,0] -= f32(abullet.speed*p_args.delta^)}

            bodyState: Classes.PhysicsServer2D_BodyState = .BODY_STATE_TRANSFORM
            trans_v: Toxin.Variant
            Toxin.copy_to_variant(&trans_v, &abullet.position)
            Phys2D_Server.body_set_state->m_call(Toxin.PhysServer2dObj, {&abullet.body, &bodyState, &trans_v})
        }
    },
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context();
        CanvasItem_Class.queue_redraw->m_call(self.self)
    },
    _draw= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)){
        context = runtime.default_context()
        color:= Toxin.Color{1,1,1,1}
        for &abullet in self.class.bullets{
            offset: Toxin.Vector2
            Texture2D_Class.get_size->m_call(self.class.bullet_image, r_ret = &offset)
            CanvasItem_Class.draw_texture->m_call(self.self, {&self.class.bullet_image, &(Toxin.Vector2{abullet.position[2,0] - offset.x/2,
                                                                                                  abullet.position[2,1] - offset.y/2}), &color})
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