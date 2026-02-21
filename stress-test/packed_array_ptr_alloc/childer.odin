package main

//import GDW "shared:GDWrapper"
import "shared:Toxin"
import "base:runtime"
import "core:fmt"
//import Classes "shared:Godot_Odin_Binds/GD_Classes"
import Classes "../../GD_Classes"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
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

self_reggy:: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    me:=(^Toxin.Class_Deets)(self)

    Toxin.Register(me, init_level, Toxin.make_get_virtual_func(THIS_CLASS_NAME_VTable), THIS_CLASS_NAME_Init)//Toxin.Class_Init) // THIS_CLASS_NAME_Init)

        cache_mode:Toxin.cache_mode=.CACHE_MODE_REUSE
        texture = Toxin.loadResource("res://icon.svg", "Texture2D", &cache_mode)
        fmt.println("!!special stress test!!")
}

THIS_CLASS_NAME_deets: Toxin.Class_Deets = {
    self_register = self_reggy,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Sprite2D,
    class_struct = THIS_CLASS_NAME,
    binder = THIS_CLASS_NAME_Export,
    vtable = &THIS_CLASS_NAME_VTable,
}

//If there's nothing that is heap allocated, you can use Toxin.Class_Init instead.
//This runs before any virtuals.
THIS_CLASS_NAME_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(THIS_CLASS_NAME))Toxin.Create(p_class_user_data, p_notify_postinitialize)

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
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* virtuals are basically overrides for a procedure. You likely won't be calling these yourself.
* If you want your class to tick on its own you gotta use them.
*/
THIS_CLASS_NAME_VTable: Toxin.vNode2D(THIS_CLASS_NAME) = {
    _ready= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
        context = runtime.default_context();
        set:=[?]rawptr{&texture}
        gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Texture_Class.set_texture._set_texture, self.self, raw_data(set[:]), nil)
    },
    //_enter_tree= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)) {
    //    context = runtime.default_context()
    //    
    //    //wind_obj:^Toxin.Object
    //    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Node_Class.get_window, self.self, nil, &wind_obj)
    //    //window:Toxin.Vector2
    //    //gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)Window_MethodBind_List.get_size, wind_obj, nil, &window)
    //    //fmt.println(window)
    //},
    _process= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME), p_args: ^struct{delta: ^Toxin.float}){

    },
    //_draw= proc "c" (self: ^Toxin.Class_Container(THIS_CLASS_NAME)){
    //    //context = runtime.default_context()
    //    //fmt.println("yarrr")
    //},
}

//******************************\\
//***********Exports************\\
//******************************\\
//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
THIS_CLASS_NAME_Export :: proc(className: ^Toxin.StringName){
    context = runtime.default_context()
    //This function does a lot. I recommend looking at it to understand the steps needed to register a class's function.
    //Toxin.bindMethod(&THIS_CLASS_NAME_deets.SN, "Some_method_name", somePublicFunction, "arg1")

        argsInfo: [1]GDE.PropertyInfo
        argsInfo[0] = Toxin.make_property(.PACKED_VECTOR4_ARRAY, "arg1")
        
        args_metadata: [1]GDE.ClassMethodArgumentMetadata
        args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE
        returnType:= 0
            returnInfo: GDE.PropertyInfo = Toxin.make_property(GDE.VariantType(returnType), "")

    methodStringName: GDE.StringName
    GDW.StringConstruct(&methodStringName, "Some_method_name")

    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)somePublicFunction,

        call_func = cast(GDE.ClassMethodCall)somePublicFunctioncallthrough,
        ptrcall_func = cast(GDE.ClassMethodPtrCall)somePublicFunction,
        method_flags = (GDE.Method_Flags_DEFAULT),
    }

        methodInfo.argument_count = u32(1)
        methodInfo.arguments_info = raw_data(argsInfo[:])
        methodInfo.arguments_metadata = &args_metadata[0]
    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)
    fmt.println("gone.")
}

//Godot only supports one return value per functions. No tuples. Might be able to get by with the Array type as that is not type specific (uses variants).
//(method_userdata: rawptr, p_instance: ClassInstancePtr, p_args: ConstTypePtrargs, r_ret: TypePtr)
@(require)
somePublicFunction :: proc "c" (ethod_userdata: rawptr, classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), call: ^struct{arg1: ^Toxin.packedHolder(Toxin.PackedVector4Array)}, r_ret:rawptr=nil) {
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
    actually:^Toxin.PackedVector4Array=cast(^Toxin.PackedVector4Array)(uintptr(call.arg1))
    //arg1:=arg1
    //fmt.println("murray: ", actually)
    //fmt.println("address holder: ", call.arg1)
    //fmt.println("address packed: ", call.arg1.ptr)
    //fmt.println("address packed: ", call.arg1.ptr.array)
    //fmt.println("address packed: ", call.arg1.array.data[0])
    //GDW.PackedInt64Array_M_List.append(&call.arg1.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedInt64Array_M_List.append(&call.arg1.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //fmt.println("address holder: ", call.arg1)
    //fmt.println("address packed: ", call.arg1.ptr.array)
    //GDW.PackedInt64_Array_M_List.get(actually, raw_data(args[:]), &r_ret, 1)
    //GDW.PackedInt64_Array_M_List.set(actually, raw_data(args[:]),&r_ret, 2)
    //GDW.PackedInt64_Array_M_List.get(actually, raw_data(args[:]),&r_ret, 1)
    GDW.PackedVector4Array_M_List.get(actually, {&indx}, &r_ret2)
    GDW.PackedVector4Array_M_List.set(actually, {&indx, &vec4})
    GDW.PackedVector4Array_M_List.get(actually, {&indx}, &r_ret2)
    //fmt.println("get, got after set: ", r_ret)
    //fmt.println("address holder: ", call.arg1)
    //fmt.println("address packed: ", call.arg1.ptr.array)
    //odinray:=make([dynamic]GDE.Int)
    odinray:=make([dynamic]Toxin.Vector4)
    for i in 0..<1_000_000 {
        append(&odinray, Toxin.Vector4{4,2,7,9})
        //appendcount(actually)
        //_=1+1
    }
    delete(odinray)
    //GDW.PackedInt64Array_M_List.append(&call.arg1.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //GDW.PackedInt64Array_M_List.append(&call.arg1.ptr.array, raw_data(arg[:]),&r_ret, 1)
    //fmt.println("address after appendss: ", actually)
    //fmt.println("get, got: ", r_ret)
    //fmt.println("address holder: ", call.arg1)
    //fmt.println("address packed: ", call.arg1.ptr.array)
    //fmt.println("gone.")
}

somePublicFunctioncallthrough :: proc "c" (classStruct: ^Toxin.Class_Container(THIS_CLASS_NAME), arg1: ^struct{a:^Toxin.Variant}) {
    context = runtime.default_context()
    fmt.println("Through variants.")
    p_args:struct{arg1: ^Toxin.packedHolder(Toxin.PackedVector4Array)}={transmute(^Toxin.packedHolder(Toxin.PackedVector4Array))(arg1.a.data[0])}
    //somePublicFunction(classStruct, &p_args)
}

appendcount::proc(actually: ^Toxin.PackedVector4Array){
    
    r_ret:Toxin.Int

    vec4:Toxin.Vector4 = {0, 4, 6, 7}
    arg:=[?]rawptr{&vec4}

    //GDW.PackedVector4Array_M_List.append(actually, raw_data(arg[:]), &r_ret, 1)
    appendcounter+=1
}

appendcounter:GDE.Int