package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "core:fmt"
import sics "base:intrinsics"
import "base:runtime"
import str "core:strings"
import s "core:slice"
import "core:math/rand"

BULLET_COUNT:   int : 50
SPEED_MIN:      f64 : 20
SPEED_MAX:      f64 : 80
SPEED_RANGE:    f64 : 60
OFFSET:         GDE.Vector2 = {0,0}
bodySetState: GDE.MethodBindPtr

mySprite :: struct {
    selfPtr: GDE.ObjectPtr,
    shape: GDE.RID,
    bullet_image: GDE.ObjectPtr, //cannot preload from Extension. Will need to use load to get the texture.
    bullets: [dynamic]bullet, //Max bullet count is known, so we can create a fixed array. Otherwise would be dynamic.
    space: GDE.RID,
    area: GDE.RID,

}

bullet:: struct {
    position: GDE.Transform2D,
    speed: f64,
    body: GDE.RID
}

registerSprite:: proc "c" () {
    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "Bullets", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Node2D", false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    class_info: GDE.ClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &stringraw, //For some reason does not work with UTF8 strings??
        set_func = nil,
        get_func = nil,
        get_property_list_func = nil,
        free_property_list_func = nil,
        property_can_revert_func = nil,
        property_get_revert_func = nil,
        validate_property_func = nil,
        notification_func = nil,
        to_string_func = nil,
        reference_func = nil,
        unreference_func = nil,
        create_instance_func = SpriteCreate,
        free_instance_func = SpriteDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithDataSprite,
        call_virtual_with_data_func = callVirtualFunctionWithDataSprite,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //GDW.makePublic(mySprite, "timePassed")
    treeBindMethod()
}

extensionDeinitSprite :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}


treeBindMethodSprite :: proc "c" () {

}

SpriteCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Node2D", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    
    fmt.println("My own Sprite", object)

    //Create extension object.
    //Maybe can replace mem_alloc with new(). This should be safe as we make the free in the destroy callback.
    self: ^mySprite = cast(^mySprite)GDW.gdAPI.mem_alloc(size_of(mySprite))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Bullets", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    self.bullets = make([dynamic]bullet, BULLET_COUNT)

    return object

}


//Not sure what's best to do. Destroy is called after the exit_tree virtual function.
//If you overload the virtual the default functions won't be called? Or Node2D doesn't have one.
SpriteDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    fmt.println("destroy")

    self : ^mySprite = cast(^mySprite)p_instance
    GDW.gdAPI.mem_free(self)

}

class_destructorSprite :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()

    delete(self.bullets)
}


getVirtualWithDataSprite :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)initializeSprite
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)process
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)physics_process
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)draw
    }
    if GDW.stringNameCompare(p_name, "_exit_tree"){
        return cast(rawptr)exit_tree
    }
    return nil
}


callVirtualFunctionWithDataSprite :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)initializeSprite {
        GDW.virtualProcCall(initializeSprite, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)process {
        GDW.virtualProcCall(process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)draw {
        GDW.virtualProcCall(draw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)physics_process {
        GDW.virtualProcCall(physics_process, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)exit_tree {
        GDW.virtualProcCall(exit_tree, p_instance, p_args, r_ret)
    }
}


initializeSprite :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()


    //Godot is able to pre-load the image data. We would need to store it in a global to be able to do this, so just doing it in here for now.
    cache_mode: GDW.cache_mode = .CACHE_MODE_IGNORE
    self.bullet_image = GDW.loadResource("res://bullet.png", "Texture2D", &cache_mode)
    fmt.println(self.bullet_image)
    //1805167009392

    //I'm populating the GDW.PhysServer2dObj value when creating the mainloop class
    //PhysicsServer2D:= GDW.getPhysServer2dObj()
    //PhysicsServer2D = GDW.Methods.getSingleton(&PhysicsServer2D_SN)
    
    GDW.circleShapeCreate(&self.shape)
    //shape = PhysicsServer2D.circle_shape_create()
    fmt.println(self.shape)

    /*
    Can I get the viewport based on the Object itself. This _ready function is being called after it was added to the SceneTree.
    */
    viewport: GDE.TypePtr
    GDW.getViewport(self.selfPtr, &viewport)
    
    world2d: GDE.TypePtr
    GDW.getWorld2D(viewport, &world2d)
    //get_world_2d()


    data:GDE.Int=8
    GDW.shapeSetData(&self.shape, &data)

    space: GDE.TypePtr
    GDW.getSpace(world2d, &space)
    //get_space()

    //Acutal code starts here.
    for &abullet in self.bullets {

        //In the example they had to use .new() to create a bullet variable because they made it as a class.
        //In our case it's just a struct. In both cases the data is stored in the array at the end.
        //NO REASON to make it heap allocated. In fact I will write to the array position immediately since the memory is already allocated.
        //same with body.
        //:tableflip:
        //var bullet := Bullet.new()
        
        GDW.bodyCreate(&abullet.body)
        //bullet.body = PhysicsServer2D.body_create()
        
        GDW.bodySetSpace(&abullet.body, &space)
        //PhysicsServer2D.body_set_space(bullet.body, get_world_2d().get_space())
        
        trans2D: GDE.Transform2D 
        trans2D = GDE.Transform2D {1,0,0,1,0,0}
        
        disabled: GDE.Bool = false
        GDW.bodyAddShape(&abullet.body, &self.shape, trans2D, &disabled)
        //PhysicsServer2D.body_add_shape(bullet.body, shape)

        mask: u32 = 0
        GDW.bodySetCollisionMask(&abullet.body, &mask)
        //PhysicsServer2D.body_set_collision_mask(bullet.body, 0)

        
        abullet.speed = (SPEED_RANGE*rand.float64()) + f64(SPEED_MIN)
        abullet.position = {0, 0, 0, 0, 1000*rand.float32(), 1000*rand.float32()}
        bodyState: GDW.BodyState = .BODY_STATE_TRANSFORM
        //This is for the collision position.
        //trans: GDE.Transform2D = {0,0,0,0,120,120}
        trans_v: GDE.Variant
        GDW.variant_from(&trans_v, &abullet.position)
        
        GDW.bodySetState(&abullet.body, &bodyState, &trans_v)
        //PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)
        GDW.Destructors.variantDestroy(&trans_v)
    
    }
    


    //Acutal code starts here.
    rect: GDE.Rec2
    
    GDW.getViewpRect(self.selfPtr, &rect)
    OFFSET.x = rect.width + 16
    OFFSET.y = rect.height + 16

}

process :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()
    
    GDW.queueRedraw(self.selfPtr)
}

physics_process :: proc "c" (self: ^mySprite, delta: f64) {
    context = runtime.default_context()
    
    
    //Acutal code starts here.
    for &abullet in self.bullets {
        if abullet.position[2,0] < -16 {abullet.position[2,0] = OFFSET.x}
        else {abullet.position[2,0] -= f32(abullet.speed*delta)}

        bodyState: GDW.BodyState = .BODY_STATE_TRANSFORM
        
        
        trans_v: GDE.Variant
        GDW.variant_from(&trans_v, &abullet.position)
        
        GDW.bodySetState(&abullet.body, &bodyState, &trans_v)
        
        GDW.Destructors.variantDestroy(&trans_v)

    }
}

draw :: proc "c" (self: ^mySprite) {

    context = runtime.default_context()
    

    color: GDE.Color = {1,1,1,1}
    args: [3]rawptr
    //Acutal code starts here.
    for &abullet in self.bullets{
        offset: GDE.Vector2
        GDW.getSizeTexture2D(self.bullet_image, &offset)
        
        GDW.drawTexture2D(self.selfPtr, &self.bullet_image, &(GDE.Vector2{abullet.position[2,0] - offset.x/2, abullet.position[2,1] - offset.y/2}), &color)
    }


}

exit_tree :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()
    if (self == nil){
        return
    }
    
    
    //Acutal code starts here.
    dummyReturn:rawptr
    for &abullet in self.bullets {
        if &abullet.body.ptr != nil {
            GDW.freeRID(&abullet.body)
        }
    }
    
    GDW.freeRID(&self.shape)
    
    
    
    //Seeing as we get the resource ObjectPtr (aka refcounted object pointer) of our image we have to go fetch the acutal RID of it to use for the 
    //the eventual freeRID method.
    //For some reason when I was testing it woudl show 2 refs for the texture but removing it from here is enough to clear the errors.
    //BTW!!!! The editor DOES NOT show you these leaks. Run the game in debug mode with verbose to see this.
    GDW.getRenderServer2dObj()
    die:GDE.RID
    GDW.getRid(self.bullet_image, &die)
    GDW.freeRenderRID(&die)
    
    
    class_destructorSprite(self)
    
}


signalCalbackSprite :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}