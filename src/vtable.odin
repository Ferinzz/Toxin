package main

import GDW "shared:GDWrapper"
import "Toxin"
import "base:runtime"
import "core:fmt"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    someProperty: GDW.Int,
    receive: GDW.AABB,
    rarray: GDW.Array,
    stringname: Toxin.StringName,
    godotstring: Toxin.gdstring,
}

munum::enum{
    a1,a2,a3,
    a7=7
}

self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)
    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable), THIS_CLASS_NAME_Init)//Toxin.Class_Init) // THIS_CLASS_NAME_Init)
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Node2D,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, can yse Toxin.Class_Init instead.
//This class has a Array type and this must initialize it at object creation (RAII)
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^GDW.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)
    
    Toxin.GDArray_Methods.Create0(&class.class.rarray, nil)
    return class.self
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
        murray: Toxin.Array
        r_ret: Toxin.Variant
        fmt.println(Toxin.GetArrayIndex)
        myArray: Toxin.Class_Array
        Toxin.BuiltinMake(&myArray)
        myArray->GetIndex(3, &r_ret)
        receive:Toxin.Variant
        aabber: Toxin.AABB = {
            4,5,0,0,12,18
        }
        vecker: Toxin.Vector2 = { 6, 92 }
        
        GDW.new_variant_from_methods(&receive, &vecker)
        GDW.new_type_from_methods(&vecker, &receive)
        Toxin.variant_Destroy(&receive)
        GDW.new_variant_from_methods(&receive, &vecker)
        GDW.new_type_from_methods(&vecker, &receive)
        Toxin.variant_Destroy(&receive)

        GDW.new_variant_from_methods(&receive, &myArray.self)
        GDW.new_type_from_methods(&myArray.self, &receive)
        Toxin.copy_from_variant(&myArray.self, &receive)
        Toxin.variant_Destroy(&receive)
        GDW.new_variant_from_methods(&receive, &myArray.self)
        GDW.new_type_from_methods(&myArray.self, &receive)
        Toxin.variant_Destroy(&receive)

        GDW.new_variant_from_methods(&receive, &myArray.self)
        GDW.new_type_from_methods(&myArray.self, &receive)
        Toxin.variant_Destroy(&receive)
        GDW.new_variant_from_methods(&receive, &aabber)
        Toxin.copy_from_variant(&aabber, &receive)
        GDW.new_type_from_methods(&aabber, &receive)
        GDW.new_variant_from_methods(&receive, &aabber)
        GDW.new_type_from_methods(&aabber, &receive)
        GDW.new_variant_from_methods(&receive, &aabber)
        GDW.new_type_from_methods(&aabber, &receive)
        fmt.println((transmute(^Toxin.AABB)receive.data[0])^)
        fmt.println(size_of(Toxin.Vector4))
        fmt.println((cast(^Toxin.variant_union)(&receive.data[0])).AABB^)
        myNode: Toxin.Node_C
        Toxin.Maker(&myNode)
        mbewl: i64
        Toxin.GDArray_Methods.Create0(cast(rawptr)(&self.rarray),nil)
        //myNode->call_deferred({nil}, &mbewl)
    },
    _enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {},
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), using p_args: ^struct{delta: ^GDW.float}){},
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    Toxin.bindMethod(&THIS_CLASS_NAME_deets.SN, "Some_method_name", somePublicFunction, "arg1")

    //Same with this. It creates 4 extra functions. Getter, Setter, variant callback, and pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    Toxin.Export(className, THIS_CLASS_NAME, "someProperty")
    Toxin.Export_Enum(className, THIS_CLASS_NAME, munum)
    Toxin.Export(className, THIS_CLASS_NAME, "receive")
    Toxin.Export(className, THIS_CLASS_NAME, "rarray")
    Toxin.Export(className, THIS_CLASS_NAME, "stringname")
    Toxin.Export(className, THIS_CLASS_NAME, "godotstring")

}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
somePublicFunction :: proc "c" (classStruct: ^GDW.Class_Container(THIS_CLASS_NAME), arg1: Toxin.Int) {
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