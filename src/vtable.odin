package main

import "core:flags"
import "core:reflect"
//import GDW "GDWrapper"
import "Toxin"
import "base:runtime"
import "core:fmt"
import GDW "GDWrapper"
import sics "base:intrinsics"
//import "../GD_Classes"
import Classes "GD_Classes"
import "GDWrapper/gdAPI"
import GDE "GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"
import "GD_Classes"
import "base:builtin"
//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    angle: Toxin.float,
    receive: Toxin.AABB,
    rarray: Toxin.Array,
    stringname: Toxin.StringName,
    godotstring: Toxin.gdstring,
    someProperty: Toxin.Int,
    exampleInt: Toxin.Int,
    nest: struct {
        nested: Toxin.Int,
        nested2: Toxin.Int,
    },
    my_range_num: Toxin.Int,
    easing_float: Toxin.float,
    pos_float: Toxin.float,
    position: Toxin.Vector2,
    exp_float: Toxin.float,
    an_array: Toxin.PackedInt32Array,
    a_real_array: Toxin.Array,
    is_Pointer: rawptr,
    color_no_alpha: Toxin.Color,
    //flags: GDE.PropertyUsageFlagsbits,
    flags3d: Toxin.layers_3d_physics,
    flags: bit_set[0..=7; u8],
    layers: Toxin.layers_2d_render,
    path: Toxin.Path,
    Plane: Toxin.Plane,
    locale: Toxin.Locale_ID,
    my_password: Toxin.Password,
    string_with_default: Toxin.gdstring,
    string_enum: Toxin.StringName,
    string_enum2: Toxin.gdstring,
    input: Toxin.gdstring,
    multiline: Toxin.gdstring,
    valid_nodes: Toxin.gdstring,
    valid_objects: Toxin.Object,
    dictionary_type: Toxin.Dictionary,
    a_dictionary: Toxin.Dictionary,
    locale_dictionary: Toxin.Dictionary,
    int_as_enum: munum,
}

munum::enum{
    a1,a2,a3,
    a7=7,
}
nest :: struct {
        nested: Toxin.Int,
        nested2: Toxin.Int,
    }

frame_count::4000
frame_times:[1000]f64
windowSize:Toxin.Vector2i
frame_current:int=0
Window_MethodBind_List: Classes.Window_MethodBind_List

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        registerer = {self_reggy},
        class_struct_size = size_of(THIS_CLASS_NAME),
        name = Toxin.get_name(THIS_CLASS_NAME),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
    },
    create=constructor,
    destroy=destructor,
    Exporter = THIS_CLASS_NAME_Export,
    vtable ={.Node, &THIS_CLASS_NAME_VTable},
}


self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    context = runtime.default_context()
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, {is_exposed = true})

    Toxin.myMainLoopCallbacks.startup_func = MainLoopStartupCallback
    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)
    cache_mode:Classes.ResourceLoader_CacheMode=.CACHE_MODE_REUSE
    //texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
}

root:^Toxin.Object
texture: Classes.Texture2D
Texture_Class: Classes.Sprite2D_MethodBind_List
Node2D_Class: Classes.Node2D_MethodBind_List
Node_Class: Classes.Node_MethodBind_List
Viewport_Class: Classes.Viewport_MethodBind_List
CanvasItem_Class: Classes.CanvasItem_MethodBind_List
CanvasGroup_Class: Classes.CanvasGroup_MethodBind_List
SceneTree_Class: Classes.SceneTree_MethodBind_List

Phys2D_Server: Classes.PhysicsServer2D_MethodBind_List
World2D_Class: Classes.World2D_MethodBind_List
Texture2D_Class: Classes.Texture2D_MethodBind_List
Engine: Classes.Engine_MethodBind_List

singletons: Toxin.Singletons

//Constructor receive an opaque pointer which is in reality a pointer to this class's container.
constructor :: proc(self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self

    GDW.Array_M_List.Create0(&self.class.rarray, nil)
    GDW.Array_M_List.Create0(&self.class.a_real_array, nil)
    GDW.PackedInt32Array_M_List.Create0(&self.class.an_array, nil)
    size:Toxin.Int=0
    args:=[1]rawptr{&size}
    npath:= GDW.stringNameNewString_r("Node")
    tag:=gdAPI.ClassDB.GetClassTag(&npath)
    GDW.Dictionary_M_List.Create0(&self.class.a_dictionary, nil)
    GDW.Dictionary_M_List.Create0(&self.class.dictionary_type, nil)
    GDW.Dictionary_M_List.Create0(&self.class.locale_dictionary, nil)

    self.class.angle=rand.float64_range(0, Math.PI*2)
    self.class.speed=rand.int64_range(100, 600)
    window:Toxin.Vector2
}

destructor :: proc(self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self
    GDW.Array_M_List.Destroy(&self.class.rarray)
    GDW.Array_M_List.Destroy(&self.class.a_real_array)
    GDW.PackedInt32Array_M_List.Destroy(&self.class.an_array)

    GDW.Dictionary_M_List.Destroy(&self.class.a_dictionary)
    GDW.Dictionary_M_List.Destroy(&self.class.dictionary_type)
    GDW.Dictionary_M_List.Destroy(&self.class.locale_dictionary)

}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object

last_delta:Toxin.float
printonce:bool=true
MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()
    if frame_current < 1000 {
        frame_times[frame_current] = last_delta
        frame_current+=1
    } else if printonce {
        printonce = false
        fmt.println(frame_times[:])
    }
}

MainLoopStartupCallback :: proc "c" () {
    context = runtime.default_context()
    /////////////////////////////////////////////////
    //DO NOT USE THIS WITH OPTIMIZED CODE!!!!!
    /////////////////////////////////////////////////
    //Classes.INIT_ALL_OF_THEM()
    Toxin._Init_Singletons(&singletons)

    Classes.Sprite2D_Init_(&Texture_Class)
    Classes.Node2D_Init_(&Node2D_Class)
    Classes.Node_Init_(&Node_Class)
    Classes.Window_Init_(&Window_MethodBind_List)
    Classes.SceneTree_Init_(&SceneTree_Class)

    //myEngine:= gdAPI.GlobalGetSingleton(&ClassDB)
    //Engine.get_main_loop->m_call(Toxin.EngineObj(), nil, &scene_tree_obj)
    scene_tree_obj= Toxin._getMainLoop(singletons)
    //SceneTree_Class.get_root->m_call(scene_tree_obj, nil, &root)
    Toxin._getRoot(singletons, SceneTree_Class)
    scene: ^Toxin.Object
    SceneTree_Class.get_current_scene->m_call(scene_tree_obj, nil, &scene)
    Classes.Window_Init_(&Window_MethodBind_List)

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //warning_player is a global object, not a multi-instance object. As such, there will be issues adding it to multiple sewage instances.

    //Create a class. Your extension registerations should all be done and all classes available at this point.

    //A scene is not added when running editor mode. Check for the scene before trying to add the child to it.
    if scene != nil {
        //You can add a node directly to the root.
        //Add the class to the root of the sceneTree
        for i in 0..<frame_count {
            //root_node_instance = gdAPI.ClassDB.ConstructObject(&THIS_CLASS_NAME_deets.SN)
            //GDW.addChild(root, &root_node_instance)
        }
    }
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
        context = runtime.default_context()

        set:=[?]rawptr{&texture}
        Texture_Class.set_texture->m_call(self.self, {&texture}, nil)
    },
    _enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
        context = runtime.default_context()

        Node_Class.get_window->m_call(self.self, nil, &wind_obj)
        window:Toxin.Vector2i
        Window_MethodBind_List.get_size->m_call(wind_obj, nil, &window)
    },
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){
        context = runtime.default_context()
        speed:=Toxin.Vector2{f32(self.class.speed),f32(self.class.speed)}
        //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Window_MethodBind_List.get_size, wind_obj, nil, &window)
        delta:=Toxin.Vector2{f32(p_args.delta^),f32(p_args.delta^)}
        //self.class.position={Math.cos_f32(f32(self.class.angle)), Math.sin_f32(f32(self.class.angle))}
        //self.class.position.x+=Math.cos_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        //self.class.position.y+=Math.sin_f32(f32(self.class.angle))*f32(p_args.delta^)*f32(self.class.speed)
        //set:=[?]rawptr{&self.class.position}
        //Node2D_Class.set_position->m_call(self.self, {&self.class.position}, nil)
        //last_delta = p_args.delta^
        //if self.position.x > window.x do self.angle = Math.PI - self.angle
        //if self.position.y > window.y do self.angle = -self.angle
    },
    //_draw= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)){
    //    //context = runtime.default_context()
    //    //fmt.println("yarrr")
    //},
}
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1100, 750}

field_vals:: proc(field: $T) -> (uintptr, typeid) {
    offset:: offset_of(field)
    field_type:: T
    return offset, field_type
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
    //field_vals(THIS_CLASS_NAME{}.someProperty)
    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    //Toxin.bindMethod(&THIS_CLASS_NAME_deets.SN, somePublicFunction)

    //Same with this. It creates 4 extra functions. Getter, Setter, variant callback, and pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.+ offset_of(THIS_CLASS_NAME{}.nest.nested)
    //Toxin.Export(className, THIS_CLASS_NAME, "someProperty")
    
    @(rodata, static)
    somproperty:= Toxin.gsetter_userdata{
        rs_type=.INT,
        getter_method= proc "c" (method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            r_return:=cast(^Toxin.Int)r_return
            r_return^= Object.someProperty
        },
        setter_method= proc "c" (method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            args:= cast([^]^Toxin.Int)args
            Object.someProperty = args[0]^
        },
        userdata= nil,
    }
    Toxin.Export_Default(className, &somproperty, "someProperty")
    @(rodata, static)
    rarray:= Toxin.gsetter_userdata{
        rs_type=.ARRAY,
        getter_method= proc"c"(method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            r_return:=cast(^Toxin.Array)r_return
            r_return^= Object.rarray
        },
        setter_method= proc"c"(method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            args:= cast([^]^Toxin.Array)args
            Toxin.Ref_Count(args[0], &Object.rarray)
        },
        userdata= nil,
    }
    Toxin.Export_Default(className, &rarray, "rarray")
    
    anarray:= Toxin.gsetter_userdata{
        rs_type=.PACKED_INT32_ARRAY,
        getter_method= proc"c"(method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            r_return:=cast(^Toxin.PackedInt32Array)r_return
            r_return^= Object.an_array
        },
        setter_method= proc"c"(method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            args:= cast([^]^Toxin.PackedInt32Array)args
            Toxin.Ref_Count(args[0], &Object.an_array)
        },
        userdata= nil,
    }
    Toxin.Export(className, THIS_CLASS_NAME, "an_array")
    //Toxin.Export(className, THIS_CLASS_NAME, "receive")
    //Toxin.Export_Enum(className, THIS_CLASS_NAME, munum)
    //Toxin.Export(className, THIS_CLASS_NAME, "stringname")
    //Toxin.Export(className, THIS_CLASS_NAME, "godotstring")
    
    //Toxin.Export(className, THIS_CLASS_NAME, "my_range_num")
    //Toxin.Export_Range(className, THIS_CLASS_NAME, "exampleInt", Toxin.Ranged_Num(Toxin.Int){0, 45, 1, {}})
    //TODO: still kinda weird
    //Toxin.Export_Easing(className, THIS_CLASS_NAME, "easing_float", .attenuation)
    //Toxin.Export_Easing(className, THIS_CLASS_NAME, "pos_float", .positive_only)
    //Toxin.Export_Easing(className, THIS_CLASS_NAME, "exp_float", .none)
    //Toxin.Export_Array_Type(className, THIS_CLASS_NAME, "a_real_array", {.ARRAY, .NONE, ""}, {.INT, .RANGE, "1,10,1"} )
    //Toxin.Export(className, THIS_CLASS_NAME, "a_real_array")
    //Toxin.Export_Pointer(className, THIS_CLASS_NAME, "is_Pointer")
    //Toxin.Export_Color_No_Alpha(className, THIS_CLASS_NAME, "color_no_alpha")
    //Toxin.Export_Int_As_Flags(className, THIS_CLASS_NAME, "flags")
    //Toxin.Export_Int_As_Flags(className, THIS_CLASS_NAME, "flags3d")
    //Toxin.Export_Int_As_Enum(className, THIS_CLASS_NAME, "int_as_enum")
    //Toxin.Export(className, THIS_CLASS_NAME, "Plane")
    //Toxin.Export_Layers(className, THIS_CLASS_NAME, "layers", .LAYERS_2D_RENDER)
    //Toxin.Export_Path(className, THIS_CLASS_NAME, "path", .DIR)
    //Toxin.Export_Locale(className, THIS_CLASS_NAME, "locale")
    //Toxin.Export_Password(className, THIS_CLASS_NAME, "my_password", {.STORAGE, .EDITOR, .SECRET})
    //default_text: Toxin.Placeholder_Text = "This is my default text."
    //Toxin.Export_With_Placeholder_Text(className, THIS_CLASS_NAME, "string_with_default", default_text)
//
    //Toxin.Export_Flags(className, THIS_CLASS_NAME, Toxin.layers_2d_navigation)
    //Toxin.Export_Flags(className, THIS_CLASS_NAME, Toxin.PropertyUsageFlagsbits)
    //Toxin.Export_String_As_Enum(className, THIS_CLASS_NAME, "string_enum", {"one", "two", "fdkasljw"})
    //Toxin.Export_String_As_Enum(className, THIS_CLASS_NAME, "string_enum2", {"one", "two", "fdkasljw"})
    //Toxin.Export_Input_Name(className, THIS_CLASS_NAME, "input", {.show_builtin})
    //Toxin.Export_Multiline(className, THIS_CLASS_NAME, "multiline")
    //Toxin.Export_Node_Path_Types(className, THIS_CLASS_NAME,"valid_nodes", "Sprite2D")
    //Toxin.Export_Object_ID(className, THIS_CLASS_NAME, "valid_objects", "")//, string(GDW.ClassName_Strings[.ButtonGroup]))
    //Toxin.Export_Dictionary_type(className, THIS_CLASS_NAME, "dictionary_type", {.INT, .STRING})
    //Toxin.Export(className, THIS_CLASS_NAME, "a_dictionary")
    //Toxin.Export_Dictionary_Localizable_String(className, THIS_CLASS_NAME, "locale_dictionary")

}


//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
somePublicFunction :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), arg1: Toxin.Int, arg2: Toxin.float) {
    context = runtime.default_context()
    //do stuff
    fmt.println("I am called by Godot")
    fmt.println("arg1: ", arg1)
    fmt.println("arg2: ", arg2)
}

/*
* Proc called by Godot when a signal this class is connected to emits.
* Check EmitSignal.odin to understand how to connect to signals.
* Check the json export or Godot docs for signals available from each class.
* callable_userdata: Proc specified in CallableCustomInfo2 during connection.
* p_args: Argument pointers passed in by the class connected to.
* p_argument_count: Number of arguments sent by the connected class. Use to validate info is in line.
* r_return: Return value sent to the connected class.
* r_error: Error to report to the connected class, or .CALL_OK
*/
/*
THIS_CLASS_NAME_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: Toxin.Int, r_return: ^Toxin.Variant, r_error: ^GDE.CallError){
    context = runtime.default_context()

    /*
    if callable_userdata == cast(rawptr)mainPhysTick {
        mainPhysTick()
        r_error.error=.CALL_OK
        return
    }*/

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}
*/

create_a_method::proc "c" (self: ^Toxin.Object) {
    context = runtime.default_context()
    fmt.println("look mah I do thing!")
}

