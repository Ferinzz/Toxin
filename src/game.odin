package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"

game :: struct {
    selfPtr: GDE.ObjectPtr,
    exampleInt: GDE.Int,
}


gameInit :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {

    context = runtime.default_context()
    if initLevel != .INITIALIZATION_SCENE{
        return
    }

    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "game", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, GDW.ClassNameStrings[.Node2D], false)
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
        create_instance_func = gameCreate,
        free_instance_func = gameDestroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    
    //GDW.makePublic(treeHook, "timePassed")
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    className_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&className_SN, "game", false)
    defer(GDW.Destructors.stringNameDestructor(&className_SN))
    
    GDW.makePublic(game, "exampleInt")

    //These functions create the callbacks Godot will used to call set and get.
    GDW.bindMethod(&className_SN, "set_testHints", set, GDE.ClassMethodFlags.NORMAL, "testHints")
    GDW.bindMethod(&className_SN, "get_testHints", get, GDE.ClassMethodFlags.NORMAL)

    info:= GDW.makePropertyFull(.INT, "testHints", .PROPERTY_HINT_RANGE, "0,255", "game", .PROPERTY_USAGE_DEFAULT)
    info2: GDE.PropertyInfo = GDW.make_property(.INT, "testHints")

    getterName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&getterName, "get_testHints", false)

    setterName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&setterName, "set_testHints", false)
    
    //fmt.println("register property")
    GDW.gdAPI.classDBRegisterExtensionClassProperty(GDW.Library, &className_SN, &info, &setterName, &getterName)
    gameBindMethod()
}

testHints:i8=0

set :: proc "c" (yourclassstruct: ^game, valuePassedInByGodot: GDE.Int) {
    context = runtime.default_context()
    fmt.println(i8(valuePassedInByGodot))
    //fmt.println(u8(valuePassedInByGodot))
    testHints = i8(valuePassedInByGodot) //someField is of type GDE.Int
}

get :: proc "c" (yourclassstruct: ^game) -> GDE.Int {
    context = runtime.default_context()
    fmt.println("restHints get: ", testHints)
    return GDE.Int(testHints) //someField is of type GDE.Int
}

gameBindMethod :: proc "c" (){
    argsInfo: [1]GDE.PropertyInfo
    argsInfo[0] = GDW.makePropertyFull(.INT, "testvalue", .PROPERTY_HINT_RANGE, "0, 455", "game", .PROPERTY_USAGE_DEFAULT)
    
    args_metadata: [1]GDE.ClassMethodArgumentMetadata
    args_metadata[0]= GDE.ClassMethodArgumentMetadata.INT_IS_UINT8
    
    
    methodStringName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&methodStringName, "testProc", false)
    
    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)testProc,

        call_func = godotVariantCallback,
        ptrcall_func = godotPtrCallback,
        method_flags = u32(GDE.ClassMethodFlags.NORMAL),
    }

    returnInfo:= GDW.makePropertyFull(.INT, "return", .PROPERTY_HINT_RANGE, "0, 455", "game", .PROPERTY_USAGE_DEFAULT)
    
    methodInfo.has_return_value = true
    methodInfo.return_value_info = &returnInfo
    methodInfo.return_value_metadata = GDE.ClassMethodArgumentMetadata.INT_IS_UINT8
    
    methodInfo.argument_count = u32(1)
    methodInfo.arguments_info = &argsInfo[0]
    methodInfo.arguments_metadata = &args_metadata[0]
    
    className_SN: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&className_SN, "game", false)
    defer(GDW.Destructors.stringNameDestructor(&className_SN))
    
    GDW.gdAPI.classdbRegisterExtensionClassMethod(GDW.Library, &className_SN, &methodInfo)

}


gameCreate :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Node2D", false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)

    
    //fmt.println("My own tree", object)

    //Create extension object.
    //Maybe can replace mem_alloc with new(). This should be safe as we make the free in the destroy callback.
    self: ^game = cast(^game)GDW.gdAPI.mem_alloc(size_of(game))
    self.selfPtr = object
    
    self.exampleInt = 0

    GDW.StringConstruct.stringNameNewLatin(&class_name, "game", false)
    GDW.gdAPI.object_set_instance(object, &class_name, cast(^GDE.Object)self)
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

    if GDW.stringNameCompare(p_name, "_ready"){
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
    if GDW.stringNameCompare(p_name, "_input"){
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
    className:GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&className, "Control", false)
    defer(GDW.Destructors.stringNameDestructor(&className))
    controlClass = GDW.gdAPI.classDBConstructObj(&className)

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
    GDW.queueRedraw(self.selfPtr)


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
