package main

import GDW "Toxin/GDWrapper"
//import GDE "Toxin/GDWrapper/gdAPI/gdextension"
import "Toxin"
import "base:runtime"
import "core:fmt"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    someProperty: GDW.Int,
}

munum::enum{
    a1,a2,a3,
    a7=7
}

self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)
    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable))
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Node2D,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: GDW.vNode2D(THIS_CLASS_NAME) = {
    _ready= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
        context = runtime.default_context();
        fmt.println("Hello mom!")
        fmt.println(self^)
        from_position_default :f64= 0
        murray: GDW.Array
        r_ret: GDW.Variant
        fmt.println(Toxin.GetArrayIndex)
        myArray: Toxin.Class_Array
        Toxin.BuiltinMake(&myArray)
        myArray->GetIndex(3, &r_ret)
    },
    _enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {},
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), using p_args: ^struct{delta: ^GDW.float}){},
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^GDW.StringName){
    context = runtime.default_context()
    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    GDW.bindMethod(&THIS_CLASS_NAME_deets.SN, "Some_method_name", somePublicFunction, {.NORMAL}, "arg1")

    //Same with this. It creates 4 extra functions. Getter, Setter, variant callback, and pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    GDW.Export(className, THIS_CLASS_NAME, "someProperty")
    GDW.Export_Enum(className, THIS_CLASS_NAME, munum)
}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
somePublicFunction :: proc "c" (classStruct: ^GDW.Class_Container(THIS_CLASS_NAME), arg1: GDW.Int) {
    //do stuff
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
THIS_CLASS_NAME_signalCallback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDW.Int, r_return: ^GDW.Variant, r_error: ^GDE.CallError){
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