package main

import "shared:Toxin/Toxin"
import "base:runtime"
import "core:fmt"
import Classes "shared:Toxin/GD_Classes"


//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        class_struct_size = size_of(THIS_CLASS_NAME),
        name = Toxin.get_name(THIS_CLASS_NAME),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
    },
    registerer = THIS_CLASS_NAME_reggy, // this is optional
    create=constructor, // this is optional
    destroy=destructor, // this is optional
    notification = Toxin.ClassNotification2(THIS_CLASS_NAME_Notifications), // this is optional
    Exporter = THIS_CLASS_NAME_Export, // this is optional
    vtable =&THIS_CLASS_NAME_VTable, // this is optional. Prefer notifications to vtable as the vtable will be overridden by script virtuals.
}

// This is your class's data. This struct will be heap allocated whenever this custom class is created.
// Godot will be passing us a pointer to a Toxin.Class_Container struct containing this struct during callbacks.
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    int_as_enum: munum,
}

// example enum for export_enum_as_int
munum::enum Toxin.Int {
    a1,a2,a3,
    a7=7,
}

// This is not normally necessary. Only declare this if you :
// a. want to specify different Toxin.class_info details
// b. need to allocate/set a global variable at time of registration
THIS_CLASS_NAME_reggy:: proc(self: ^Toxin.Class_Deets, init_level: Toxin.InitializationLevel) {
    context = runtime.default_context()
    Toxin._Register(self, init_level)

    //for default values in function binding
    var1= Toxin.variant_r(Toxin.Int(34))
    var2= Toxin.variant_r(Toxin.float(34))
}


// Only necessary if you need to initialize some variables.
// Required if your class includes :
// a. Toxin.Array
// b. Toxin.Dictionary
// c. Toxin.gdstring - need to set the pointer to nil. Godot's allocator does not zero init memory.
// Godot's methods will panic if these are not initialized.
constructor :: proc(userdata: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self
    //if you have a dictionary or an array from godot initialize it here before using it.
}

// Only necessary if you have memory cleanup to do.
// Required if your class includes a type which needs to be destroyed.
// See Toxin.Destroy for the list of types with a destructor.
// Don't forget to cleanup textures, objects created, resources.
destructor :: proc(userdata: ^Toxin.Class_Deets, self: rawptr) {
    self:=cast(^Toxin.Class_Container(THIS_CLASS_NAME))self
    // destroy your heap allocated memory.
}


//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

// Prefer this to setup your _process _ready etc instead of the virtuals.
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

// These will be overridden by GDscript's virtuals.
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
// For export with default values
var1: Toxin.Variant
var2: Toxin.Variant

// Makes some function public to Godot's GDscripts and inspector.
// There are many different ways to export a function or variable.
// default, static, with or without default parameters.
// Many different flavors of custom property info.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()

    Toxin._bind_default(somePublicFunction2, className, false)
    Toxin._bind_static(static_proc, className, false)
    user_bind:= Toxin._bind_with_defaults(somePublicFunction, className, false, &var1, &var2)
    user_bind3:= Toxin._bind_with_defaults(somePublicFunction3, className, false, &var1)
    user_bind2:= Toxin._bind_static_with_defaults(static_proc_defaults, className, false, &var1)

    //Same with this. It creates 4 extra functions. Getter, Setter, variant callback, and pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.+ offset_of(THIS_CLASS_NAME{}.nest.nested)
    //Toxin.Export(className, THIS_CLASS_NAME, "someProperty")

    signalName:= Toxin.register_signal2(className, "test_signal", {})

    Toxin.Destroy(&signalName)

    @static
    somproperty:= Toxin.gsetter_userdata_t(Toxin.Int, THIS_CLASS_NAME) {
        gs_type=.INT,
        getter_method= proc "c" (Object: (^Toxin.Class_Container(THIS_CLASS_NAME))) -> Toxin.Int{
            return Object.speed
        },
        setter_method= proc "c" (Object: (^Toxin.Class_Container(THIS_CLASS_NAME)), args: ^Toxin.Int){
            Object.speed = args^
        },
        fieldname = "someproperty"
    }
    Toxin.Export_Default2(className, &somproperty, false)

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

// A static proc does not receive any object to work on. Basically acts as a global proc but only this class can see it in GDscript.
static_proc :: proc "c" () {
    context = runtime.default_context()
    fmt.println("I'm running a static proc")
}

// Of course all procs can include default values.
// Defaults need to be variants.
// Defaults need to exist at the time the proc is called. Which is why the variants are declared as globals in the Export section.
// You need to own the lifetime of the default values and the slice containing them.
// Procs with defaults will always be slower to call.
static_proc_defaults :: proc "c" (arg1: ^Toxin.Int) {
    context = runtime.default_context()
    fmt.println("I'm running a static proc.\nMy default is", arg1^)
}

//************************\\
//****Signal Callables****\\
//************************\\

// Signal callbacks use the callable system. Each signal connection creates a callable variable which contains the proc pointer and the default values.
// Signals have more overhead than virtuals and other export systems as they must use variants.

// You can attach a callback to a signal. Uses the callable system.
// Process is a bit long, but Toxin takes care of that.
signal_test :: proc "c" (obj: ^Toxin.Object) {
    context = runtime.default_context()
    fmt.println("connected signal")
}

// You can define a callable. A callback outside of the signal system which can be passed to other objects to use.
// All callables can have default values.
// Default values can be unique per callable creates.
// A procedure can be turned into any number of callables, as a callable is just a class of data.
bound_callable_test :: proc "c" (obj: ^Toxin.Object, str: ^Toxin.Int) {
    context = runtime.default_context()
    fmt.println(str^)
}