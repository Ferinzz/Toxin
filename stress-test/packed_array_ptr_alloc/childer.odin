package main

//import GDW "../../GDWrapper"
import "../../Toxin"
import "base:runtime"
import "core:fmt"
import Classes "../../GD_Classes"
//import Classes "../../GD_Classes"
import "../../GDWrapper/gdAPI"
import GDW "../../GDWrapper"
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
        name = Toxin.get_name( THIS_CLASS_NAME ),
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Sprite2D,
        class_struct_size = size_of( THIS_CLASS_NAME ),
    },
    Exporter = THIS_CLASS_NAME_Export,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
//This runs before any virtuals.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.bltn_Create(p_class_user_data, p_notify_postinitialize)

    class.class.angle=rand.float64_range(0, Math.PI*2)
    class.class.speed=rand.int64_range(100, 600)
    //class.class.position = {rand.float32_range(100,1100), rand.float32_range(100,750)}
    class.class.window = {rand.float32_range(window.x-64, window.x), rand.float32_range(window.y-64, window.y)}
    class.class.position = {rand.float32_range(64,class.class.window.x-64), rand.float32_range(64,class.class.window.y-64)}
    //class.class.position = {rand.float32_range(64,window.x-64), rand.float32_range(64,window.y-64)}
    class.class.size = {rand.float32_range(0,32), rand.float32_range(0,32)}
    fmt.println("ïnit")
    
    return class.self
}


//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
    Toxin._bind_default(somePublicFunction, className, false)
    fmt.println("gone.")
}

// Need to revisit. There was an issue where I wasn't handling Godot passing a basic array in place of a packed array. Because fuck you I guess.
@(require)
somePublicFunction :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), call: ^Toxin.PackedVector4Array) {
    //do stuff
    context = runtime.default_context()

    
    r_ret:Toxin.Int
    r_ret2:Toxin.Vector4
    //vec2:Toxin.Vector2 = {32, 73}
    vec2:Toxin.Int = 32
    vec4:Toxin.Vector4 = {0, 4, 6, 7}
    indx:Toxin.Int=0
    set:Toxin.Int=32
    args:=[?]rawptr{&indx, &set}
    vec4_args:=[?]rawptr{&indx, &vec4}
    ref:Toxin.Object
    barl: Toxin.Bool
    varintttt:Toxin.Variant
    arg:=[?]rawptr{&indx}
    actually:^Toxin.PackedVector4Array=cast(^Toxin.PackedVector4Array)(uintptr(call))
    //arg1:=arg1
    //fmt.println("murray: ", actually)
    //fmt.println("address holder: ", call)
    //fmt.println("address packed: ", call.ptr)
    //fmt.println("address packed: ", call.ptr.array)
    //fmt.println("address packed: ", call.array.data[0])
    //GDW.PackedInt64Array_M_List.append(&call.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedInt64Array_M_List.append(&call.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //fmt.println("address holder: ", call)
    //fmt.println("address packed: ", call.ptr.array)
    //GDW.PackedInt64_Array_M_List.get(actually, raw_data(args[:]), &r_ret, 1)
    //GDW.PackedInt64_Array_M_List.set(actually, raw_data(args[:]),&r_ret, 2)
    //GDW.PackedInt64_Array_M_List.get(actually, raw_data(args[:]),&r_ret, 1)
    GDW.PackedVector4Array_M_List.get(actually, {&indx}, &r_ret2)
    GDW.PackedVector4Array_M_List.set(actually, {&indx, &vec4})
    GDW.PackedVector4Array_M_List.get(actually, {&indx}, &r_ret2)
    //fmt.println("get, got after set: ", r_ret)
    //fmt.println("address holder: ", call)
    //fmt.println("address packed: ", call.ptr.array)
    //odinray:=make([dynamic]GDE.Int)
    odinray:=make([dynamic]Toxin.Vector4)
    for i in 0..<1_000_000 {
        append(&odinray, Toxin.Vector4{4,2,7,9})
        //appendcount(actually)
        //_=1+1
    }
    delete(odinray)
    //GDW.PackedInt64Array_M_List.append(&call.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedInt64Array_M_List.append(&call.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //fmt.println("address after appendss: ", actually)
    //fmt.println("get, got: ", r_ret)
    //fmt.println("address holder: ", call.arg1)
    //fmt.println("address packed: ", call.arg1.ptr.array)
    //fmt.println("gone.")
}

appendcount::proc(actually: ^Toxin.PackedVector4Array){
    
    r_ret:Toxin.Int

    vec4:Toxin.Vector4 = {0, 4, 6, 7}
    arg:=[?]rawptr{&vec4}

    //GDW.PackedVector4Array_M_List.append(actually, raw_data(arg[:]), &r_ret, 1)
    appendcounter+=1
}

appendcounter:GDE.Int