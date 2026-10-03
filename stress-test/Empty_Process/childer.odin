package main

//import GDW "../../GDWrapper"
import "../../Toxin"
import "base:runtime"
import "core:fmt"
import Classes "../../GD_Classes"
import "../../GDWrapper/gdAPI"
import GDE "../../GDWrapper/gdAPI/gdextension"
import Math "core:math"
import rand "core:math/rand"

//Find and Replace THIS_CLASS_NAME with the name that you will be giving to the GDE class.
//Find and Replace Godot_Class_Name with the name of the class from Godot.

//Godot will be passing us a pointer to this struct during callbacks.
//Name of the strict MUST match what is used in the init function used to name our class. THIS_CLASS_NAME_SN
THIS_CLASS_NAME :: struct {
    speed: Toxin.Int,
    angle: Toxin.float,
    position: Toxin.Vector2,
    window: Toxin.Vector2,
    size: Toxin.Vector2,
}


windowSize:Toxin.Vector2i
wind_obj:^Toxin.Object
window:Toxin.Vector2 = {1150, 750}
size:Toxin.Vector2={64,64}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    required = {
        class_struct_size = size_of(THIS_CLASS_NAME),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
        name = Toxin.get_name(THIS_CLASS_NAME),
    },
    Exporter = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.bltn_Create(p_class_user_data, p_notify_postinitialize)
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
@(require)
THIS_CLASS_NAME_VTable: Classes.Node2D_vtable(THIS_CLASS_NAME) = {
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), #by_ptr p_args: struct{delta: ^Toxin.float}, _: rawptr){
        context = runtime.default_context();
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