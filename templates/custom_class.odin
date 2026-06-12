package main

import "Toxin"
import "base:runtime"
import "core:fmt"
import Classes "GD_Classes"
import GDE "GDWrapper/gdAPI/gdextension"
import "GD_Classes"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        registerer = THIS_CLASS_NAME_reggy,
        class_struct_size = size_of(THIS_CLASS_NAME),
        name = Toxin.get_name(THIS_CLASS_NAME),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
    },
    create=constructor,
    destroy=destructor,
    notification = GDE.ClassNotification2(THIS_CLASS_NAME_Notifications),
    Exporter = THIS_CLASS_NAME_Export,
    vtable =&THIS_CLASS_NAME_VTable,
}

//Godot will be passing us a pointer to this struct during callbacks.
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    int_as_enum: munum,
}

munum::enum Toxin.Int {
    a1,a2,a3,
    a7=7,
}


THIS_CLASS_NAME_reggy:: proc(self: ^Toxin.required_deets, init_level: Toxin.InitializationLevel) {
    context = runtime.default_context()
    me:=(^Toxin.Class_Deets)(self)
    Toxin._Register(me, init_level)

    //for default values in function binding
    var1= Toxin.variant_r(Toxin.Int(34))
    var2= Toxin.variant_r(Toxin.float(34))
}


//Constructor receive an opaque pointer which is in reality a pointer to this class's container.
constructor :: proc(userdata: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self
    //if you have a dictionary or an array from godot initialize it here before using it.
}

destructor :: proc(userdata: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self

}


//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

//Use this to setup your _process _ready etc instead of the virtuals. Virtuals will prioritize GDScript over your own virtuals.
THIS_CLASS_NAME_Notifications :: proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_what: i32, p_reversed: b8) {
    
    what2:= Classes.Object_Constants(p_what)
    switch what2 {
    case .NOTIFICATION_POSTINITIALIZE:
    case .NOTIFICATION_PREDELETE:
    case .NOTIFICATION_EXTENSION_RELOADED:
    }
    what:= Classes.Node_Constants(p_what)
    #partial switch what {
    case .NOTIFICATION_READY:
        context = runtime.default_context()
    case .NOTIFICATION_ENTER_TREE:
        context = runtime.default_context()
    case .NOTIFICATION_PROCESS:
        context = runtime.default_context()
    case .NOTIFICATION_EXIT_TREE:
    }
    what9:= Classes.CanvasItem_Constants(p_what)
    #partial switch what9 {
    case .NOTIFICATION_DRAW:
    }
}


THIS_CLASS_NAME_VTable: Classes.Sprite2D_vtable(THIS_CLASS_NAME) = {
    _ready= proc "c" (self: ^Classes.Class_Container(THIS_CLASS_NAME), args: rawptr, _: rawptr) {
        context = runtime.default_context()
    },
    _enter_tree= proc "c" (self: ^Classes.Class_Container(THIS_CLASS_NAME), args: rawptr, ret: rawptr) {
        context = runtime.default_context()
    },
    _process= proc "c" (self: ^Classes.Class_Container(THIS_CLASS_NAME), #by_ptr p_args: struct {delta: ^f64}, _: rawptr){
        context = runtime.default_context()
    },
    _draw= proc "c" (self: ^Classes.Class_Container(THIS_CLASS_NAME), args: rawptr, ret: rawptr) {
    },
    _get_focused_accessibility_element= proc "c" (self: ^Classes.Class_Container(THIS_CLASS_NAME), _: rawptr, r_ret: ^Toxin.RID) {

    }
}

//******************************\\
//***********Exports************\\
//******************************\\
//for default values
var1: Toxin.Variant
var2: Toxin.Variant
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()

    Toxin._bind_default(somePublicFunction2, className)
    Toxin._bind_static(static_proc, className)
    user_bind:= Toxin._bind_with_defaults(somePublicFunction, className, &var1, &var2)
    user_bind3:= Toxin._bind_with_defaults(somePublicFunction3, className, &var1)
    user_bind2:= Toxin._bind_static_with_defaults(static_proc_defaults, className, &var1)

    //Same with this. It creates 4 extra functions. Getter, Setter, variant callback, and pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.+ offset_of(THIS_CLASS_NAME{}.nest.nested)
    //Toxin.Export(className, THIS_CLASS_NAME, "someProperty")

    signalName:= Toxin.register_signal2(className, "test_signal", {})

    Toxin.Destroy(&signalName)

    @static
    somproperty:= Toxin.gsetter_userdata{
        gs_type=.INT,
        getter_method= proc "c" (method_userdata: rawptr, Object: rawptr, args: rawptr, r_return: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            r_return:=cast(^Toxin.Int)r_return
            r_return^= Object.speed
        },
        setter_method= proc "c" (method_userdata: rawptr, Object: rawptr, args: rawptr){
            Object:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Object
            args:= cast(^Toxin.Int)args
            Object.speed = args^
        },
        userdata= nil,
    }

    @(rodata, static)
    _enum:= Toxin.gsetter_userdata_t(Toxin.Int, THIS_CLASS_NAME){
        gs_type= .INT,
        getter_method = proc "c" (method_userdata: ^Toxin.Class_Container(THIS_CLASS_NAME)) -> Toxin.Int {
            return Toxin.Int(method_userdata.int_as_enum)
        },
        setter_method = proc "c" (method_userdata: ^Toxin.Class_Container(THIS_CLASS_NAME), arg: ^Toxin.Int) {
            method_userdata.int_as_enum = munum(arg^)
        },
        fieldname = "int_as_enum",
    }

    Toxin.export_enum_as_int(className, &_enum, munum)
}

//***************************\\
//****Exported functions*****\\
//***************************\\

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
somePublicFunction :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), arg1: ^Toxin.Int, arg2: ^Toxin.float) {
    context = runtime.default_context()
    //do stuff
    fmt.println("I am somePublicFunction. I am called by Godot")
    fmt.println("arg1: ", arg1^)
    fmt.println("arg2: ", arg2^)
}
somePublicFunction2 :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), arg1: ^Toxin.Int, arg2: ^Toxin.float) {
    context = runtime.default_context()
    //do stuff
    fmt.println("I am somePublicFunction2. I am called by Godot", arg1^, arg2^)
}
somePublicFunction3 :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), arg1: ^Toxin.Int) {
    context = runtime.default_context()
    //do stuff
    fmt.println("I am somePublicFunction3. I am called by Godot", arg1^)
}

static_proc :: proc "c" () {
    context = runtime.default_context()
    fmt.println("I'm running a static proc")
}
static_proc_defaults :: proc "c" (arg1: ^Toxin.Int) {
    context = runtime.default_context()
    fmt.println("I'm running a static proc.\nMy default is", arg1^)
}

//************************\\
//****Signal Callables****\\
//************************\\

signal_test :: proc "c" (obj: ^Toxin.Object) {
    context = runtime.default_context()
    fmt.println("connected signal")
}

bound_callable_test :: proc "c" (obj: ^Toxin.Object, str: ^Toxin.Int) {
    context = runtime.default_context()
    fmt.println(str^)
}