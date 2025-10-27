package main

import "core:hash"
import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"
import sics "base:intrinsics"

game :: struct {
    selfPtr: GDE.ObjectPtr,
    exampleInt: GDE.Int,
    publicEnum: myEnum,
    my_range_num: GDE.Int,
    easing_float: GDE.float,
    pos_float: GDE.float,
    exp_float: GDE.float,
    an_array: GDE.PackedInt32Array,
    a_real_array: GDE.Array,
    is_Pointer: rawptr,
    color_no_alpha: GDE.Color,
    //flags: GDE.PropertyUsageFlagsbits
    //flags: GDE.layers_3d_physics,
    flags: bit_set[0..=7; u8],
    layers: GDW.layers_2d_render,
    path: GDW.Path,
    locale: GDW.Locale_ID,
    my_password: GDW.Password,
    string_with_default: GDE.gdstring,
    
}

default_text: GDW.Placeholder_Text = "This is my default text."

controlClass: GDE.ObjectPtr

game_SN : GDE.StringName
game_CString: cstring = "game"
game_GDClass_Index: GDW.ClassName_Index = .Sprite2D
game_GDClass_StringName: ^GDE.StringName

gameInit :: proc "c" ($classStruct: typeid) {
    context = runtime.default_context()

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
        create_instance_func = gameCreate,
        free_instance_func = gameDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }
    
    parent_class_name: GDE.StringName

    //GDW.StringConstruct.stringNameNewLatin(&game_SN, "game", false)
    GDW.StringConstruct.stringNameNewUTF8andLen(&game_SN, raw_data(string("game")), 4)
    game_GDClass_StringName = GDW.ClassName_StringName_get(game_GDClass_Index)

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &game_SN, game_GDClass_StringName, &class_info)
    
    
    //These functions create the callbacks Godot will used to call set and get.
    GDW.bindMethod(&game_SN, "set_testHints", set, GDE.Method_Flags_DEFAULT, "testHints")
    GDW.bindMethod(&game_SN, "get_testHints", get, GDE.Method_Flags_DEFAULT)

    info:= GDW.Make_Property_Full(.INT, "testHints", .RANGE, cstring("0,255"), "game", GDE.PROPERTY_USAGE_DEFAULT)
    info2: GDE.PropertyInfo = GDW.make_property(.INT, "testHints")

    getterName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&getterName, "get_testHints", false)

    setterName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&setterName, "set_testHints", false)
    
    //fmt.println("register property")
    GDW.gdAPI.classDBRegisterExtensionClassProperty(GDW.Library, &game_SN, &info, &setterName, &getterName)
    //GDW.Public_Enum(myEnum, game_CString)
    gameExport()
}

testHints:i8=0

set :: proc "c" (yourclassstruct: ^game, valuePassedInByGodot: GDE.Int) {
    context = runtime.default_context()
    //fmt.println(i8(valuePassedInByGodot))
    //fmt.println(u8(valuePassedInByGodot))
    testHints = i8(valuePassedInByGodot) //someField is of type GDE.Int
}

get :: proc "c" (yourclassstruct: ^game) -> GDE.Int {
    context = runtime.default_context()
    //fmt.println("restHints get: ", testHints)
    return GDE.Int(testHints) //someField is of type GDE.Int
}

gameExport :: proc "c" (){
    context = runtime.default_context()

    /*
    argsInfo: [1]GDE.PropertyInfo
    argsInfo[0] = GDW.Make_Property_Full(.INT, "testvalue", .RANGE, string("0, 455"), "game", GDE.PROPERTY_USAGE_DEFAULT)
    
    args_metadata: [1]GDE.ClassMethodArgumentMetadata
    args_metadata[0]= GDE.ClassMethodArgumentMetadata.INT_IS_UINT8
    
    
    methodStringName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&methodStringName, "testProc", false)
    
    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)testProc,

        call_func = godotVariantCallback,
        ptrcall_func = godotPtrCallback,
        method_flags = u32(GDE.Method_Flags_DEFAULT),
    }

    returnInfo:= GDW.Make_Property_Full(.INT, "return", .RANGE, string("0, 455"), "game", GDE.PROPERTY_USAGE_DEFAULT)
    
    methodInfo.has_return_value = true
    methodInfo.return_value_info = &returnInfo
    methodInfo.return_value_metadata = GDE.ClassMethodArgumentMetadata.INT_IS_UINT8
    
    methodInfo.argument_count = u32(1)
    methodInfo.arguments_info = &argsInfo[0]
    methodInfo.arguments_metadata = &args_metadata[0]
    
    GDW.gdAPI.classdbRegisterExtensionClassMethod(GDW.Library, &game_SN, &methodInfo)
    */

    GDW.Export(game, "my_range_num")
    GDW.Export_Range(game, "exampleInt", GDW.Ranged_Num(GDE.Int){0, 45, 1, {}})
    GDW.Export_Int_As_Enum(game, "publicEnum")
    GDW.Export_Easing(game, "easing_float", .attenuation)
    GDW.Export_Easing(game, "pos_float", .positive_only)
    GDW.Export_Easing(game, "exp_float", .none)
    GDW.Export_Array_Type(game, "a_real_array", {.ARRAY, .NONE, ""}, {.INT, .RANGE, "1,10,1"} )
    GDW.Export(game, "an_array")
    //GDW.Export(game, "a_real_array")
    GDW.Export_Pointer(game, "is_Pointer")
    GDW.Export_Color_No_Alpha(game, "color_no_alpha")
    GDW.Export_Int_As_Flags(game, "flags")
    GDW.Export_Layers(game, "layers", .LAYERS_2D_RENDER)
    GDW.Export_Path(game, "path", .DIR)
    GDW.Export_Locale(game, "locale")
    GDW.Export_Password(game, "my_password", {.STORAGE, .EDITOR, .SECRET})
    GDW.Export_With_Placeholder_Text(game, "string_with_default", default_text)

    GDW.Export_Enum(game, myEnum)
    GDW.Export_Flags(game, GDW.layers_2d_navigation)
    GDW.Export_Flags(game, GDE.PropertyUsageFlagsbits)

}


gameCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(game_GDClass_StringName)

    //Create extension object.
    //Maybe can replace mem_alloc with new(). This should be safe as we make the free in the destroy callback which stays in Odin memory.
    self: ^game = cast(^game)GDW.gdAPI.mem_alloc(size_of(game))
    self.selfPtr = object
    
    self.exampleInt = 0

    self.publicEnum = .one
    self.a_real_array.id = nil
    self.an_array.data = nil

    GDW.ArrayHelp.packedi32create0(&self.an_array, nil)
    GDW.GDArray.create0(&self.a_real_array, nil)

    fmt.println(self.is_Pointer)
    self.is_Pointer = transmute(rawptr)(u64(45))
    //self.is_Pointer = 45
    fmt.println(self.is_Pointer)
    //self.flags = { .EDITOR, .ALWAYS_DUPLICATE }
    self.flags = { 0, 2, 6 }
    self.layers = {1,5}
    self.path.ptr = nil
    self.locale.ptr = nil
    self.my_password.ptr = nil
    self.string_with_default.ptr = nil

    GDW.gdAPI.object_set_instance(object, &game_SN, cast(^GDE.Object)self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    return object
}

testProc :: proc "c" (self: ^game, testvalue: u8) -> GDE.Int {
    //nothing
    context = runtime.default_context()
    fmt.println("testProc: ", testvalue)
    return GDE.Int(testvalue)
}


godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
    context = runtime.default_context()
    testVar:= (cast(^u8)p_args[0])^
    //fmt.printfln("%b", (cast(^i64)p_args[0])^)
    myRet:= testProc(cast(^game)p_instance, testVar)
    //fmt.println(myRet)
    (cast(^GDE.Int)r_ret)^ = myRet
}

godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
    context = runtime.default_context()
    if p_argument_count < 2-1 {
        r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
        r_error.expected = 2
        fmt.println("error small 1 args")
        return
    }
    if p_argument_count > 2-1 {
        r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
        r_error.expected = 2
        fmt.println("error big")
        return
    }
    
    gdTypeList:= [2-1]GDE.VariantType {.INT}
    
    GDW.variantTypeCheck(gdTypeList[:], p_args[:], r_error)

    testProc(cast(^game)p_instance, u8(GDW.fromvariant(cast(^GDE.Variant)p_args[0], GDE.Int)))
}


gameDestroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {

}


getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {
    context = runtime.default_context()
    
    //This is safe because there's only one _ready method in all of the classes.
    if p_hash == 3218959716 {
        return cast(rawptr)ready
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)gameprocess
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)gamephysics
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)gamedraw
    }
    //Only one _input method exists in Godot classes.
    if p_hash == 3754044979 {
        return cast(rawptr)game_Input
    }
    return nil
}


//thinking it's good to keep this in a particular order. The least likely or one-time event should be last.
//unfortunately the more events a class has the more times this thing is called.
callVirtualFunctionWithData :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)gamephysics {
        GDW.virtualProcCall(gamephysics, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)gameprocess {
        GDW.virtualProcCall(gameprocess, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)gamedraw {
        GDW.virtualProcCall(gamedraw, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)game_Input {
        GDW.virtualProcCall(game_Input, p_instance, p_args, r_ret)
    }
    if virtualProcPtr == cast(rawptr)ready {
        GDW.virtualProcCall(ready, p_instance, p_args, r_ret)
    }
    
}

ready :: proc "c" (self: ^game) {
    context = runtime.default_context()
    GDW.getInputSingleton()
    GDW.getPhysServer2dObj()
    GDW.getRenderServer2dObj()
    //className:GDE.StringName
    //GDW.StringConstruct.stringNameNewLatin(&className, "Control", false)
    //defer(GDW.Destructors.stringNameDestructor(&className))
    controlClass = GDW.gdAPI.classDBConstructObj(GDW.ClassName_StringName_get(.Control))

    //create a random controlClass.
    preset: GDW.LayoutPreset = .PRESET_BOTTOM_RIGHT
    resize_mode: GDW.LayoutPresetMode = .PRESET_MODE_KEEP_WIDTH
    //margin: GDE.Int = 9223372036854775807
    //Godot will convert the i64 to i32 automatically as part of the extension's process. wew.
    //If it is out of bounds for the value it will set it to 0 or -1 if the value was at uint max.
    margin: GDE.Int = 2147483
    GDW.set_offsets_preset(controlClass, &preset, &resize_mode, &margin)
}

gamephysics :: proc "c" (self: ^game, delta: f64) {
    context = runtime.default_context()
    
    button: GDE.MouseButton = .MOUSE_BUTTON_LEFT
    isPressed: GDE.Bool
    //GDW.isMouseButtonPressed(&button, &isPressed)
    //fmt.println(isPressed)    
}

gameprocess :: proc "c" (self: ^game, delta: f64) {
    context = runtime.default_context()
    //GDW.queueRedraw(self.selfPtr)


}

gamedraw :: proc "c" (self: ^game) {

}


game_Input :: proc "c" (self: ^game, event: GDE.ObjectPtr) {
    context = runtime.default_context()
    
}

gamesignalCalback :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
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

myEnum :: enum {
    one,
    three,
    two,
}