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
    position: GDE.Vector2,
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
    //Can replace mem_alloc with new(). Just need to create the struct and pass a pointer.
    self: ^mySprite = cast(^mySprite)GDW.gdAPI.mem_alloc(size_of(mySprite))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Bullets", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    self.bullets = make([dynamic]bullet, BULLET_COUNT)

    return object

}


SpriteDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    //
    //freeRID:= GDW.classDBGetMethodBind("PhysicsServer2D", "free_rid", 2722037293)
//
    //PhysicsServer2D_SN: GDE.StringName
    //GDW.StringConstruct.stringNameNewLatin(&PhysicsServer2D_SN, "PhysicsServer2D", false)
    //defer(GDW.Destructors.stringNameDestructor(&PhysicsServer2D_SN))
    //PhysicsServer2D:= GDW.Methods.getSingleton(&PhysicsServer2D_SN)
    //
//
    //self : ^mySprite = cast(^mySprite)p_instance
    ////Acutal code starts here.
    //dummyReturn:rawptr
    //for &abullet in self.bullets {
    //    if &abullet.body[0] != nil {
    //        args:= [1]rawptr {&abullet.body}    
    //        GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
    //    }
    //}
    //
    //args:= [1]rawptr {&self.shape[0]}
    //GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
    //args= {raw_data(self.bullet_image[:])}
    //GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
    //args=  {&self.bullets[0]}
    //GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
    
    //class_destructorSprite(self)
    //GDW.gdAPI.mem_free(self)

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
    //Connect to mainLoop's phys tick signal.
    //Can do at create or _ready.
    mainLoop := GDW.getMainLoop()
    rec_signal: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)mainPhysTickSprite,
	    token= GDW.Library,
	    
	    call_func= signalCalbackSprite,
    }
    
    signalName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&signalName, "physics_frame", false)
    defer(GDW.Destructors.stringNameDestructor(&signalName))

    connectErr:= GDW.connectToSignal(&rec_signal, &signalName, mainLoop)
    fmt.println("was there a connection error: ", connectErr)
    /*
    * "name": "PhysicsServer2D",,
				{
					"name": "body_create",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 529393457,
					"return_value": {
						"type": "RID"
					}
				},,
    */
    
    

    //Get PhysicsServer2D Singleton.
    PhysicsServer2D_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&PhysicsServer2D_SN, "PhysicsServer2D", false)
    defer(GDW.Destructors.stringNameDestructor(&PhysicsServer2D_SN))
    PhysicsServer2D:= GDW.Methods.getSingleton(&PhysicsServer2D_SN)
    
    /*
    "PhysicsServer2D"
    ,
				{
					"name": "shape_set_data",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3175752987,
					"arguments": [
						{
							"name": "shape",
							"type": "RID"
						},
						{//WHY IS THIS A VARIANT?!
							"name": "data",
							"type": "Variant"
						}
					]
				},*/
    /*
    ,
				{
					"name": "circle_shape_create",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 529393457,
					"return_value": {
						"type": "RID"
					}
				},
    */
    
    circleShapeCreate:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "circle_shape_create", 529393457)
    
    dummyReturn: GDE.TypePtr
    GDW.gdAPI.objectMethodBindPtrCall(circleShapeCreate, PhysicsServer2D, nil, &self.shape)
    //shape = PhysicsServer2D.circle_shape_create()
    fmt.println(self.shape)

    shapeSetData:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "shape_set_data", 3175752987)
    
    bodyCreate:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_create", 529393457)

    

    /*
    Can I get the viewport based on the Object itself. This _ready function is being called after it was added to the SceneTree.
    "name": "Node",,
				{
					"name": "get_viewport",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3596683776,
					"return_value": {
						"type": "Viewport"
					}
				},
    "name": "Viewport",,
				{
					"name": "get_world_2d",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2339128592,
					"return_value": {
						"type": "World2D"
					}
				},*/
    
    getViewport:= GDW.classDBGetMethodBind("Node", "get_viewport", 3596683776)
    
    viewport: GDE.TypePtr
    GDW.gdAPI.objectMethodBindPtrCall(getViewport, self.selfPtr, nil, &viewport)
    
    getWorld2D:= GDW.classDBGetMethodBind("Viewport", "get_world_2d", 2339128592)
    
    world2d: GDE.TypePtr
    GDW.gdAPI.objectMethodBindPtrCall(getWorld2D, cast(GDE.ObjectPtr)viewport, nil, &world2d)
    //get_world_2d()

    /*
    "name": "World2D",
                ,
				{
					"name": "get_space",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2944877500,
					"return_value": {
						"type": "RID"
					}
				},
    */
    
    
    getSpace:= GDW.classDBGetMethodBind("World2D", "get_space", 2944877500)
    

    /*
    "name": "PhysicsServer2D",,
				{
					"name": "body_set_space",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 395945892,
					"arguments": [
						{
							"name": "body",
							"type": "RID"
						},
						{
							"name": "space",
							"type": "RID"
						}
					]
				},
    */
    
    bodySetSpace:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_space", 395945892)
    

    /*
				{
					"name": "body_add_shape",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 339056240,
					"hash_compatibility": [
						754862190
					],
					"arguments": [
						{
							"name": "body",
							"type": "RID"
						},
						{
							"name": "shape",
							"type": "RID"
						},
                        //We will use the default values.
						{
							"name": "transform",
							"type": "Transform2D",
							"default_value": "Transform2D(1, 0, 0, 1, 0, 0)"
						},
						{
							"name": "disabled",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
                */
    
    bodyAddSpace:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_add_shape", 339056240)
    

                /*
				{
					"name": "body_set_collision_mask",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3411492887,
					"arguments": [
						{
							"name": "body",
							"type": "RID"
						},
						{
							"name": "mask",
							"type": "int",
							"meta": "uint32"
						}
					]
				},
                */
    
    bodySetCollision:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_collision_mask", 3411492887)
    
                
                /*
                "name": "Transform2D",
                Transform2D is a fixed size variable and thus does not need a create function.
				{
					"name": "body_set_state",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1706355209,
					"arguments": [
						{
							"name": "body",
							"type": "RID"
						},
						{
							"name": "state",
							"type": "enum::PhysicsServer2D.BodyState"
						},
						{//OH GOD THIS IS A VARIANT?
							"name": "value",
							"type": "Variant"
						}
					]
				},
    */

    bodySetState:= GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_state", 1706355209)
    


    //Acutal code starts here.
    for &abullet in self.bullets {
        shapedata: GDE.Variant
        data:GDE.Int=8
        GDW.variant_from(&shapedata, &data)
        shape_data:= [?]rawptr {&self.shape, &shapedata}
        GDW.gdAPI.objectMethodBindPtrCall(shapeSetData, PhysicsServer2D, raw_data(shape_data[:]), &dummyReturn)
        //In the example they had to use .new() to create a bullet variable because they made it as a class.
        //In our case it's just a struct. In both cases the data is stored in the array at the end.
        //NO REASON to make it heap allocated. In fact I will write to the array position immediately since the memory is already allocated.
        //same with body.
        //:tableflip:
        //var bullet := Bullet.new()
        
        GDW.gdAPI.objectMethodBindPtrCall(bodyCreate, PhysicsServer2D, nil, &abullet.body)
        //bullet.body = PhysicsServer2D.body_create()
        space: GDE.TypePtr
        GDW.gdAPI.objectMethodBindPtrCall(getSpace, cast(GDE.ObjectPtr)world2d, nil, &space)
        //get_space()
        args:= [?]rawptr {&abullet.body, &space}
        
        GDW.gdAPI.objectMethodBindPtrCall(bodySetSpace, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
        //PhysicsServer2D.body_set_space(bullet.body, get_world_2d().get_space())
        trans2D:= [6]f32 {1,0,0,1,0,0}
        disabled: GDE.Bool = false
        args2:= [?]rawptr {&abullet.body, &self.shape, raw_data(trans2D[:]), &disabled}
        GDW.gdAPI.objectMethodBindPtrCall(bodyAddSpace, PhysicsServer2D, raw_data(args2[:]), &dummyReturn)
        //PhysicsServer2D.body_add_shape(bullet.body, shape)
        mask: u32 = 0
        args= {&abullet.body, &mask}
        GDW.gdAPI.objectMethodBindPtrCall(bodySetCollision, PhysicsServer2D, raw_data(args2[:]), &dummyReturn)
        //PhysicsServer2D.body_set_collision_mask(bullet.body, 0)

        
        abullet.speed = (SPEED_RANGE*rand.float64()) + f64(SPEED_MIN)
        abullet.position = {1000*rand.float32(),1000*rand.float32()}
        bodyState: GDW.BodyState = .BODY_STATE_TRANSFORM
        //This is for the collision position.
        trans: GDE.Transform2d = {0,0,0,0,120,120}
        trans_v: GDE.Variant
        GDW.variant_from(&trans_v, &trans)
        args3:= [?]rawptr {&abullet.body, &bodyState, &trans_v}
        GDW.gdAPI.objectMethodBindPtrCall(bodySetState, PhysicsServer2D, raw_data(args3[:]), &dummyReturn)
        //PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)
        GDW.Destructors.variantDestroy(&trans_v)
    
    }
    
    getViewpRect:= GDW.classDBGetMethodBind("CanvasGroup", "get_viewport_rect", 1639390495)


    //Acutal code starts here.
    rect: GDE.Rec2
    rectptr:= &OFFSET
    GDW.gdAPI.objectMethodBindPtrCall(getViewpRect, self.selfPtr, nil, raw_data(rect[:]))
    OFFSET.x = rect.z + 16
    OFFSET.y = rect.w + 16

    freeRID:= GDW.classDBGetMethodBind("PhysicsServer2D", "free_rid", 2722037293)

    args:= [1]rawptr {&self.shape}
    GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)

}

process :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()

    /*
    "CanvasItem" // but can use our own object since Node2D inherits from CanvasItem
				{
					"name": "queue_redraw",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},*/
    
    
    queueRedraw:= GDW.classDBGetMethodBind("CanvasItem", "queue_redraw", 3218959716)
    
    dummyReturn: GDE.TypePtr

    //Acutal code starts here.
    GDW.gdAPI.objectMethodBindPtrCall(queueRedraw, self.selfPtr, nil, &dummyReturn)
}

physics_process :: proc "c" (self: ^mySprite, delta: f64) {
    context = runtime.default_context()

    PhysicsServer2D_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&PhysicsServer2D_SN, "PhysicsServer2D", false)
    defer(GDW.Destructors.stringNameDestructor(&PhysicsServer2D_SN))

    PhysicsServer2D:= GDW.Methods.getSingleton(&PhysicsServer2D_SN)

    if bodySetState == nil {
        bodySetState = GDW.classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_state", 1706355209)
    }

    //Acutal code starts here.
    for &abullet in self.bullets {
        if abullet.position.x < -16 do abullet.position.x = OFFSET.x
        abullet.position.x -= f32(abullet.speed*delta)

        bodyState: GDW.BodyState = .BODY_STATE_TRANSFORM
        trans: GDE.Transform2d = {1,2,3,4,abullet.position.x,abullet.position.y}
        
        trans_v: GDE.Variant
        //trans_v.VType = .TRANSFORM2D
        //trans_v.data[0] = transmute(u64)(&(trans[0]))
        GDW.variant_from(&trans_v, &trans)
        args3:= [?]rawptr {&abullet.body, &bodyState, &trans_v}
        dummyReturn:rawptr
        GDW.gdAPI.objectMethodBindPtrCall(bodySetState, PhysicsServer2D, raw_data(args3[:]), &dummyReturn)
        GDW.Destructors.variantDestroy(&trans_v)

    }
}

draw :: proc "c" (self: ^mySprite) {

    context = runtime.default_context()
    /*
    ,
				{
					"name": "draw_texture",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 520200117,
					"hash_compatibility": [
						1695860435
					],
					"arguments": [
						{
							"name": "texture",
							"type": "Texture2D"
						},
						{
							"name": "position",
							"type": "Vector2"
						},
						{
							"name": "modulate",
							"type": "Color",
							"default_value": "Color(1, 1, 1, 1)"
						}
					]
				},*/
    
    drawTexture:= GDW.classDBGetMethodBind("CanvasItem", "draw_texture", 520200117)
        printTree:= GDW.classDBGetMethodBind("Node", "get_tree", 2958820483)
        sceneTree: GDE.ObjectPtr
        //GDW.gdAPI.objectMethodBindPtrCall(printTree, GDW.getMainLoop(), nil, &sceneTree)

    color: GDE.Color = {1,1,1,1}
    args: [3]rawptr
    //Acutal code starts here.
    for &abullet in self.bullets{
        args =  {&self.bullet_image, &abullet.position, &color}
        dummyReturn: GDE.TypePtr
        GDW.gdAPI.objectMethodBindPtrCall(drawTexture, self.selfPtr, raw_data(args[:]), dummyReturn)
    }


}

/*
,
				{
					"name": "free_rid",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2722037293,
					"arguments": [
						{
							"name": "rid",
							"type": "RID"
						}
					]
				},
                */
exit_tree :: proc "c" (self: ^mySprite) {
    context = runtime.default_context()
    if (self == nil){
        return
    }
    
    freeRID:= GDW.classDBGetMethodBind("PhysicsServer2D", "free_rid", 2722037293)
    freeRenderRID:= GDW.classDBGetMethodBind("RenderingServer", "free_rid", 2722037293)

    PhysicsServer2D_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&PhysicsServer2D_SN, "PhysicsServer2D", false)
    defer(GDW.Destructors.stringNameDestructor(&PhysicsServer2D_SN))
    PhysicsServer2D:= GDW.Methods.getSingleton(&PhysicsServer2D_SN)

    
    RenderingServer_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&RenderingServer_SN, "RenderingServer", false)
    defer(GDW.Destructors.stringNameDestructor(&RenderingServer_SN))
    RenderingServer:= GDW.Methods.getSingleton(&RenderingServer_SN)
    
    //Acutal code starts here.
    dummyReturn:rawptr
    for &abullet in self.bullets {
        if &abullet.body.ptr != nil {
            args:= [1]rawptr {&abullet.body}    
            GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
        }
    }
    
    args:= [1]rawptr {&self.shape}
    GDW.gdAPI.objectMethodBindPtrCall(freeRID, PhysicsServer2D, raw_data(args[:]), &dummyReturn)
    
    
    getRid:= GDW.classDBGetMethodBind("Resource", "get_rid", 2944877500)

    //Seeing as we get the resource ObjectPtr (aka refcounted object pointer) of our image we have to go fetch the acutal RID of it to use for the 
    //the eventual freeRID method.
    //For some reason when I was testing it woudl show 2 refs for the texture but removing it from here is enough to clear the errors.
    //BTW!!!! The editor DOES NOT show you these errors.
    die:GDE.RID
    argse: [^]rawptr
    GDW.gdAPI.objectMethodBindPtrCall(getRid, self.bullet_image, argse, &die)
    args = {&die}
    GDW.gdAPI.objectMethodBindPtrCall(freeRenderRID, RenderingServer, raw_data(args[:]), &die)
    
    q_free:= GDW.classDBGetMethodBind("Node", "queue_free", 3218959716)
    GDW.gdAPI.objectMethodBindPtrCall(q_free, self.selfPtr, nil, nil)

    getCanvas:= GDW.classDBGetMethodBind("CanvasItem", "get_canvas", 2944877500)

    GDW.gdAPI.objectMethodBindPtrCall(getCanvas, self.selfPtr, nil, &die)
    args = {&die}
    GDW.gdAPI.objectMethodBindPtrCall(freeRenderRID, RenderingServer, raw_data(args[:]), &die)
    
    
    class_destructorSprite(self)
    GDW.gdAPI.mem_free(self)
}

mainPhysTickSprite :: proc "c" () {
    context = runtime.default_context()

    //fmt.println("My Sprite tick.")
}

signalCalbackSprite :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    if callable_userdata == cast(rawptr)mainPhysTickSprite {
        mainPhysTickSprite()
        r_error.error=.CALL_OK
        return
    }

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}