package GDWrapper

import "base:runtime"
import GDE "gdAPI/gdextension"
import "gdAPI"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"

Library : GDE.ClassDB = nil

//a pointer uniquely identifying the given built-in class in the ClassDB.
ClassTag:: rawptr

Init_Wrapper :: proc(p_get_proc_address : GDE.InterfaceGetProcAddress) {

    gdAPI.loadAPI(p_get_proc_address)
    init_StringName_Methods()
    init_String_Methods()

    StringConstruct.stringNameNewString = proc(StringName_r: ^StringName, name: string) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(StringName_r, raw_data(name[:]), i64(len(name)))
    }
    
    StringConstruct.stringNameNewString_r = proc(name: string) -> (r_ret: StringName) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(&r_ret, raw_data(name[:]), i64(len(name)))
        return
    }
    init_Node_Virtuals_Info()
    init_CanvasItem_Virtuals_Info()
    init_Texture2D_Virtuals_Info()
    init_Logger_Virtuals_Info()
    init_Resource_Virtual_Info()
    init_AudioStreamPlayback_Virtual_Info()
    init_AudioStream_Virtual_Info()
    //init_classDB()
    StringConstruct.stringNameNewString(&PhysicsServer2D_SN, "PhysicsServer2D")
    StringConstruct.stringNameNewString(&RenderServer_SN, "RenderingServer")

    objectEmitSignal = classDBGetMethodBind3(.Object, "emit_signal", 4047867050)
}

//Use these to build a C++ String or StringName that Godot can use.
StringConstruct : struct {
    stringNameNewString: stringNameNewString,
    stringNameNewString_r: stringNameNewString_r,
}

stringNameNewString :: #type proc(StringName_r: ^StringName, name: string)
stringNameNewString_r :: #type proc(name: string) -> (r_ret: StringName)


/*
* Use to check the type that Godot provides from its side.
* Returns early with ok or an error.
*/
variantTypeCheck :: proc(typeList: []GDE.VariantType, argList: GDE.ConstVariantPtrargs, r_error: ^GDE.CallError) {
    
    for type, index in typeList {
        if type != gdAPI.Variant_Utils.GetType(argList[index]) {
            r_error.error = .CALL_ERROR_INVALID_ARGUMENT
            r_error.argument = i32(gdAPI.Variant_Utils.GetType(argList[index]))
            r_error.expected = i32(type)
            return
        }
    }
    
}

stringNameCompare :: proc {
    stringNameCompare_string,
    stringNameCompare_StringName,
}

//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
@(deprecated="use stringNameCompare_string")
stringNameCompare_cstring :: proc(l_value: ^StringName, r_value: cstring) -> (ret: bool) {
    r_name: StringName
    gdAPI.StringName_Utils.Latin1Chars(&r_name, r_value, false)
    defer(StringName_Methods.Destroy(&r_name))

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_Methods.Compare(cast([^]rawptr)l_value, cast([^]rawptr)(&r_name), &ret)
    return ret
}

//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_string :: proc(l_value: ^StringName, r_value: string) -> (ret: bool) {
    r_name: StringName
    StringConstruct.stringNameNewString(&r_name, r_value)
    defer(StringName_Methods.Destroy(&r_name))

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_Methods.Compare(cast([^]rawptr)l_value, cast([^]rawptr)(&r_name), &ret)
    return ret
}
//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_StringName :: proc(l_value: ^StringName, r_value: ^StringName) -> (ret: bool) {

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_Methods.Compare(cast([^]rawptr)l_value, cast([^]rawptr)r_value, &ret)
    return ret
}

StringNameGetBasename :: proc(StringNamePtr: ^StringName, r_String: ^gdstring) {
    @(static)stringNameGetBasename: GDE.PtrBuiltInMethod
    if stringNameGetBasename == nil {
        ClassDB:StringName
        gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "get_basename", false)
        defer(StringName_Methods.Destroy(&ClassDB))
        stringNameGetBasename = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.STRING_NAME, &ClassDB, 3942272618)
    }
    stringNameGetBasename(StringNamePtr, nil, r_String, 0)

}

GDStringJoin :: proc(packedString: ^PackedStringArray, r_String: ^gdstring) {
    @(static)gdStringJoin: GDE.PtrBuiltInMethod
    if gdStringJoin == nil {
        ClassDB:StringName
        gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "join", false)
        defer(StringName_Methods.Destroy(&ClassDB))
        gdStringJoin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.STRING, &ClassDB, 3595973238)
    }

    args:= [1]rawptr {packedString}
    gdStringJoin(packedString, raw_data(args[:]), r_String, 1)
}

/*Returns the unique tag of the Class.
* Use with checkCast in order to verify if a GDObject received can be cast to the specific class.
* classTagName: string representing the name of the class. ie InputEvent
*/
get_ClassTagName :: proc(classTagName: string) -> ClassTag {
    
    classTagName_SN: StringName
    StringConstruct.stringNameNewString(&classTagName_SN, classTagName)
    defer(StringName_Methods.Destroy(&classTagName_SN))
    return gdAPI.ClassDB.GetClassTag(&classTagName_SN)
}

get_All_ClassTag :: proc {
    get_All_ClassTag_struct,
    get_All_ClassTag_array,
}

get_All_ClassTag_struct :: proc(classtypes: ^$T) where sics.type_is_struct(T){
    pos:^T = classtypes
    for field, i in reflect.struct_fields_zipped(T) {
        field_pos:^ClassTag=cast(^ClassTag)(uintptr(pos) + field.offset)
        field_pos^ = get_ClassTagName(field.name)
    }
};

/*
* Populate an array with the ClassTag(s).
* See Input.odin for an example InputEvent_get_ClassTag of its usage.
* classtypes: a pointer to an enumerated array of ClassTags.
*/
get_All_ClassTag_array :: proc(classtypes: ^$T/[$E]ClassTag) where sics.type_is_enum(E){
    for name, i in reflect.enum_field_names(E) {
        classtypes[E(i)] = get_ClassTagName(name)
    }
};

//**********************\\
//********globals*******\\
//**********************\\

ProcessThreadMessages :: enum i64 {
    FLAG_PROCESS_THREAD_MESSAGES = 1,
    //Allows this node to process threaded messages created with call_deferred_thread_group() right before _process() is called.
    FLAG_PROCESS_THREAD_MESSAGES_PHYSICS = 2,
    //Allows this node to process threaded messages created with call_deferred_thread_group() right before _physics_process() is called.
    FLAG_PROCESS_THREAD_MESSAGES_ALL = 3,
    //Allows this node to process threaded messages created with call_deferred_thread_group() right before either _process() or _physics_process() are called.
}

AutoTranslateMode :: enum i64 {
    AUTO_TRANSLATE_MODE_INHERIT = 0,
//Inherits auto_translate_mode from the nodes parent. This is the default for any newly created node.
    AUTO_TRANSLATE_MODE_ALWAYS = 1,
//Always automatically translate. This is the inverse of AUTO_TRANSLATE_MODE_DISABLED, and the default for the root node.
    AUTO_TRANSLATE_MODE_DISABLED = 2,
//Never automatically translate. This is the inverse of AUTO_TRANSLATE_MODE_ALWAYS.
//String parsing for POT generation will be skipped for this node and children that are set to AUTO_TRANSLATE_MODE_INHERIT.
}

/*
* MainLoop is a class that Godot uses to tick through the program logic.
* This function returns a pointer to the object. If SceneTree is your mainLoop (or your own version of it) call
* this to get the object instead of Node's get_tree which would provide a ref to SceneTree instead.
*/
getMainLoop :: proc() -> (gdLoop: ^Object) {
    @(static)getMainLoop:GDE.MethodBindPtr

    ClassDB:StringName
    gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "Engine", false)
    defer(StringName_Methods.Destroy(&ClassDB))
    myEngine:= gdAPI.GlobalGetSingleton(&ClassDB)

    if getMainLoop == nil {
        getMainLoop = classDBGetMethodBind3(.Engine, "get_main_loop", 1016888095)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(getMainLoop, myEngine, nil, &gdLoop)
    return
}

getRoot :: proc() -> ^Object {
    @(static)getRoot: GDE.MethodBindPtr
    if getRoot == nil {
        getRoot = classDBGetMethodBind3(.SceneTree, "get_root", 1757182445)
    }
    mySceneTree:= getMainLoop()
    r_ret:^Object
    gdAPI.Object_Utils.MethodBindPtrcall(getRoot, mySceneTree, nil, &r_ret)
    return r_ret
}

get_current_scene :: proc() -> ^Object {
    @(static)getCurrentScene: GDE.MethodBindPtr
    if getCurrentScene == nil {
        getCurrentScene = classDBGetMethodBind3(.SceneTree, "get_current_scene", 3160264692)
    }
    mySceneTree:= getMainLoop()
    r_ret:^Object
    gdAPI.Object_Utils.MethodBindPtrcall(getCurrentScene, mySceneTree, nil, &r_ret)
    return r_ret
}

//********************\\
//*******Object*******\\
//********************\\

callDeferred :: proc(Object: ^Object, method: ^StringName, r_Variant: ^GDE.Variant) {
    @(static)CallDeferred: GDE.MethodBindPtr
    if CallDeferred == nil {
        CallDeferred = classDBGetMethodBind3(.Object, "call_deferred", 3400424181)
    }

    assert(method.ptr != nil)
    method_arg := tovariant(method, StringName)
    args:= [?]^GDE.Variant {&method_arg}
    r_error: GDE.CallError
    gdAPI.Object_Utils.MethodBindCall(CallDeferred, Object, raw_data(args[:]), 1, r_Variant, &r_error)
}


ObjectToString :: proc(Object: ^Object, r_String: ^gdstring) {
    @(static)objectToString: GDE.MethodBindPtr
    if objectToString == nil {
        objectToString = classDBGetMethodBind3(.Object, "to_string", 2841200299)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(objectToString, Object, nil, r_String)
}


//******************\\
//******Input*******\\
//******************\\

InputSingleton : ^Object
Input_SN:StringName

getInputSingleton :: proc() {
    gdAPI.StringName_Utils.Latin1Chars(&Input_SN, "Input", false)
    InputSingleton = gdAPI.GlobalGetSingleton(&Input_SN)
}

isAnythingPressed :: proc(r_bool: ^Bool) {
    @(static)IsAnythingPressed: GDE.MethodBindPtr
    if IsAnythingPressed == nil do IsAnythingPressed = classDBGetMethodBind3(.Input, "is_anything_pressed", 36873697)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IsAnythingPressed, InputSingleton, nil, r_bool)
}
isKeyPressed :: proc(keycode: ^Key, r_bool: ^Bool) {
    @(static)IsKeyPressed: GDE.MethodBindPtr
    if IsKeyPressed == nil do IsKeyPressed = classDBGetMethodBind3(.Input, "is_anything_pressed", 36873697)

    assert(InputSingleton != nil)
    args:= [1]rawptr { keycode }
    gdAPI.Object_Utils.MethodBindPtrcall(IsKeyPressed, InputSingleton, raw_data(args[:]), r_bool)
}
isPhysicalKeyPressed :: proc(keycode: ^Key, r_bool: ^Bool) {
    @(static)IsPhysicalKeyPressed: GDE.MethodBindPtr
    if IsPhysicalKeyPressed == nil do IsPhysicalKeyPressed = classDBGetMethodBind3(.Input, "is_physical_key_pressed", 1938909964)

    assert(InputSingleton != nil)
    args:= [1]rawptr { keycode }
    gdAPI.Object_Utils.MethodBindPtrcall(IsPhysicalKeyPressed, InputSingleton, raw_data(args[:]), r_bool)
}
isLabelKeyPressed :: proc(keycode: ^Key, r_bool: ^Bool) {
    @(static)IsLabelKeyPressed: GDE.MethodBindPtr
    if IsLabelKeyPressed == nil do IsLabelKeyPressed = classDBGetMethodBind3(.Input, "is_key_label_pressed", 1938909964)

    assert(InputSingleton != nil)
    args:= [1]rawptr { keycode }
    gdAPI.Object_Utils.MethodBindPtrcall(IsLabelKeyPressed, InputSingleton, raw_data(args[:]), r_bool)
}
isMouseButtonPressed :: proc(button: ^MouseButton, r_bool: ^Bool) {
    @(static)IsMouseButtonPressed: GDE.MethodBindPtr
    if IsMouseButtonPressed == nil do IsMouseButtonPressed = classDBGetMethodBind3(.Input, "is_mouse_button_pressed", 1821097125)

    assert(InputSingleton != nil)
    args:= [1]rawptr {button}
    gdAPI.Object_Utils.MethodBindPtrcall(IsMouseButtonPressed, InputSingleton, raw_data(args[:]), r_bool)
}
getLastMouseVelocity :: proc(r_v2Pos: ^Vector2) {
    @(static)GetLastMouseVelocity: GDE.MethodBindPtr
    if GetLastMouseVelocity == nil do GetLastMouseVelocity = classDBGetMethodBind3(.Input, "get_last_mouse_velocity", 1497962370)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetLastMouseVelocity, InputSingleton, nil, r_v2Pos)
}
getLastMouseScreenVelocity :: proc(r_v2Pos: ^Vector2) {
    @(static)GetLastMouseScreenVelocity: GDE.MethodBindPtr
    if GetLastMouseScreenVelocity == nil do GetLastMouseScreenVelocity = classDBGetMethodBind3(.Input, "get_last_mouse_screen_velocity", 1497962370)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetLastMouseScreenVelocity, InputSingleton, nil, r_v2Pos)
}
getMouseButtonMask :: proc(r_mouseMask: ^MouseButtonMask) {
    @(static)GetLastMouseScreenVelocity: GDE.MethodBindPtr
    if GetLastMouseScreenVelocity == nil do GetLastMouseScreenVelocity = classDBGetMethodBind3(.Input, "get_mouse_button_mask", 2512161324)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetLastMouseScreenVelocity, InputSingleton, nil, r_mouseMask)
}
setMouseMode :: proc(mouseMode: ^MouseMode) {
    @(static)SetMouseMode: GDE.MethodBindPtr
    if SetMouseMode == nil do SetMouseMode = classDBGetMethodBind3(.Input, "set_mouse_mode", 2228490894)

    assert(InputSingleton != nil)
    args:= [1]rawptr {mouseMode}
    gdAPI.Object_Utils.MethodBindPtrcall(SetMouseMode, InputSingleton, raw_data(args[:]), nil)
}
getMouseMode :: proc(r_mouseMode: ^MouseMode) {
    @(static)GetMouseMode: GDE.MethodBindPtr
    if GetMouseMode == nil do GetMouseMode = classDBGetMethodBind3(.Input, "get_mouse_mode", 965286182)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetMouseMode, InputSingleton, nil, r_mouseMode)
}
//Default of exact_match should be false
isActionPressed :: proc(action: ^StringName, exact_match: ^Bool, r_bool: ^Bool) {
    @(static)IsActionPressed: GDE.MethodBindPtr
    if IsActionPressed == nil do IsActionPressed = classDBGetMethodBind3(.Input, "is_action_pressed", 1558498928)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, exact_match}
    gdAPI.Object_Utils.MethodBindPtrcall(IsActionPressed, InputSingleton, raw_data(args[:]), r_bool)
}
isActionJustPressed :: proc(action: ^StringName, exact_match: ^Bool, r_bool: ^Bool) {
    @(static)IsActionJustPressed: GDE.MethodBindPtr
    if IsActionJustPressed == nil do IsActionJustPressed = classDBGetMethodBind3(.Input, "is_action_just_pressed", 1558498928)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, exact_match}
    gdAPI.Object_Utils.MethodBindPtrcall(IsActionJustPressed, InputSingleton, raw_data(args[:]), r_bool)
}
isActionJustReleased :: proc(action: ^StringName, exact_match: ^Bool, r_bool: ^Bool) {
    @(static)IsActionJustReleased: GDE.MethodBindPtr
    if IsActionJustReleased == nil do IsActionJustReleased = classDBGetMethodBind3(.Input, "is_action_just_released", 1558498928)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, exact_match}
    gdAPI.Object_Utils.MethodBindPtrcall(IsActionJustReleased, InputSingleton, raw_data(args[:]), r_bool)
}
getActionStrength :: proc(action: ^StringName, exact_match: ^Bool, r_bool: ^float) {
    @(static)GetActionStrength: GDE.MethodBindPtr
    if GetActionStrength == nil do GetActionStrength = classDBGetMethodBind3(.Input, "get_action_strength", 801543509)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, exact_match}
    gdAPI.Object_Utils.MethodBindPtrcall(GetActionStrength, InputSingleton, raw_data(args[:]), r_bool)
}
getActionRawStrength :: proc(action: ^StringName, exact_match: ^Bool, r_bool: ^float) {
    @(static)GetActionRawStrength: GDE.MethodBindPtr
    if GetActionRawStrength == nil do GetActionRawStrength = classDBGetMethodBind3(.Input, "get_action_raw_strength", 801543509)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, exact_match}
    gdAPI.Object_Utils.MethodBindPtrcall(GetActionRawStrength, InputSingleton, raw_data(args[:]), r_bool)
}
//Strength default 1
actionPress :: proc(action: ^StringName, strength: ^float) {
    @(static)ActionPress: GDE.MethodBindPtr
    if ActionPress == nil do ActionPress = classDBGetMethodBind3(.Input, "action_press", 743155724)

    assert(InputSingleton != nil)
    args:= [2]rawptr {action, strength}
    gdAPI.Object_Utils.MethodBindPtrcall(ActionPress, InputSingleton, raw_data(args[:]), nil)
}
actionRelease :: proc(action: ^StringName) {
    @(static)ActionRelease: GDE.MethodBindPtr
    if ActionRelease == nil do ActionRelease = classDBGetMethodBind3(.Input, "action_release", 3304788590)

    assert(InputSingleton != nil)
    args:= [1]rawptr {action}
    gdAPI.Object_Utils.MethodBindPtrcall(ActionRelease, InputSingleton, raw_data(args[:]), nil)
}
warpMouse :: proc(position: ^Vector2) {
    @(static)WarpMouse: GDE.MethodBindPtr
    if WarpMouse == nil do WarpMouse = classDBGetMethodBind3(.Input, "warp_mouse", 743155724)

    assert(InputSingleton != nil)
    args:= [1]rawptr {position}
    gdAPI.Object_Utils.MethodBindPtrcall(WarpMouse, InputSingleton, raw_data(args[:]), nil)
}
setDefaultCursorShape :: proc(cursorShape: ^CursorShape) {
    @(static)SetDefaultCursorShape: GDE.MethodBindPtr
    if SetDefaultCursorShape == nil do SetDefaultCursorShape = classDBGetMethodBind3(.Input, "set_default_cursor_shape", 2124816902)

    assert(InputSingleton != nil)
    args:= [1]rawptr {cursorShape}
    gdAPI.Object_Utils.MethodBindPtrcall(SetDefaultCursorShape, InputSingleton, raw_data(args[:]), nil)
}
getCurrentCursorShape :: proc(r_cursorShape: ^CursorShape) {
    @(static)GetCurrentCursorShape: GDE.MethodBindPtr
    if GetCurrentCursorShape == nil do GetCurrentCursorShape = classDBGetMethodBind3(.Input, "get_current_cursor_shape", 3455658929)

    assert(InputSingleton != nil)
    //args:= [1]rawptr {cursorShape}
    gdAPI.Object_Utils.MethodBindPtrcall(GetCurrentCursorShape, InputSingleton, nil, r_cursorShape)
}

//image should be a resource object
//hotspot default is {0, 0}
setCustomMouseCursor :: proc(image: ^^Object, shape: ^CursorShape, hotspot: ^Vector2) {
    @(static)SetCustomMouseCursor: GDE.MethodBindPtr
    if SetCustomMouseCursor == nil do SetCustomMouseCursor = classDBGetMethodBind3(.Input, "set_custom_mouse_cursor", 703945977)

    assert(InputSingleton != nil)
    args:= [3]rawptr {image, shape, hotspot}
    gdAPI.Object_Utils.MethodBindPtrcall(SetCustomMouseCursor, InputSingleton, raw_data(args[:]), nil)
}

//TODO: figure out what this does. The name isn't very clear considering there's no return value.
parseInputEvent :: proc(event: ^^Object) {
    @(static)ParseInputEvent: GDE.MethodBindPtr
    if ParseInputEvent == nil do ParseInputEvent = classDBGetMethodBind3(.Input, "parse_input_event", 3754044979)

    assert(InputSingleton != nil)
    args:= [1]rawptr {event}
    gdAPI.Object_Utils.MethodBindPtrcall(ParseInputEvent, InputSingleton, raw_data(args[:]), nil)
}
setUseAccumulatedInput :: proc(enable: ^Bool) {
    @(static)SetUseAccumulatedInput: GDE.MethodBindPtr
    if SetUseAccumulatedInput == nil do SetUseAccumulatedInput = classDBGetMethodBind3(.Input, "set_use_accumulated_input", 2586408642)

    assert(InputSingleton != nil)
    args:= [1]rawptr {enable}
    gdAPI.Object_Utils.MethodBindPtrcall(SetUseAccumulatedInput, InputSingleton, raw_data(args[:]), nil)
}
isUsingAccumulatedInput :: proc(r_enable: ^Bool) {
    @(static)IsUsingAccumulatedInput: GDE.MethodBindPtr
    if IsUsingAccumulatedInput == nil do IsUsingAccumulatedInput = classDBGetMethodBind3(.Input, "is_using_accumulated_input", 2240911060)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IsUsingAccumulatedInput, InputSingleton, nil, r_enable)
}
FlushBufferedEvents :: proc() {
    @(static)FlushBufferedEvents: GDE.MethodBindPtr
    if FlushBufferedEvents == nil do FlushBufferedEvents = classDBGetMethodBind3(.Input, "flush_buffered_events", 3218959716)

    assert(InputSingleton != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(FlushBufferedEvents, InputSingleton, nil, nil)
}



//*************************\\
//*****PhysicsServer2D*****\\
//*************************\\


queueRedraw :: proc(object: ^Object) {
    @(static)QueueRedraw: GDE.MethodBindPtr
    if QueueRedraw == nil do QueueRedraw = classDBGetMethodBind3(.CanvasItem, "queue_redraw", 3218959716)
    
    //dummyReturn: GDE.TypePtr

    //Acutal code starts here.
    gdAPI.Object_Utils.MethodBindPtrcall(QueueRedraw, object, nil, nil)
}

//**************************\\
//******Canvas Item******\\
//**************************\\

drawTexture2D :: proc(object: ^Object, image: ^^Object, position: ^Vector2, color: ^Color) {
    @(static)DrawTexture: GDE.MethodBindPtr
    if DrawTexture == nil do DrawTexture = classDBGetMethodBind3(.CanvasItem, "draw_texture", 520200117)

    args :=  [3]rawptr{image, position, color}
    gdAPI.Object_Utils.MethodBindPtrcall(DrawTexture, object, raw_data(args[:]), nil)
}


//**************************\\
//*********Viewport*********\\
//**************************\\

getWorld2D :: proc(viewport: GDE.TypePtr, r_world: ^GDE.TypePtr) {
    @(static)GetWorld2D: GDE.MethodBindPtr
    if GetWorld2D == nil do GetWorld2D = classDBGetMethodBind3(.Viewport, "get_world_2d", 2339128592)
    
    
    gdAPI.Object_Utils.MethodBindPtrcall(GetWorld2D, cast(^Object)viewport, nil, r_world)
}

//**************************\\
//*******Canvas Group*******\\
//**************************\\

getViewpRect :: proc(object: ^Object, r_rect: ^Rec2) {
    @(static)GetViewpRect: GDE.MethodBindPtr
    if GetViewpRect == nil do GetViewpRect = classDBGetMethodBind3(.CanvasGroup, "get_viewport_rect", 1639390495)

    gdAPI.Object_Utils.MethodBindPtrcall(GetViewpRect, object, nil, r_rect)
}


//**************************\\
//******Sprite Methods******\\
//**************************\\
//Use Resource->loadResource to get the texture in the correct format. Remember to specify Texture as a hint when fetching.
setTexture :: proc(dest: ^Object, texture: ^^Object) {    
    @(static)set_texture: GDE.MethodBindPtr
    if set_texture == nil do set_texture = classDBGetMethodBind3(.Sprite2D, "set_texture", 4051416890)

    args_spr:= [?]rawptr {texture}
    dummyReturn:rawptr
    gdAPI.Object_Utils.MethodBindPtrcall(set_texture, dest, raw_data(args_spr[:]), &dummyReturn)
}


//*************************\\
//********Texture2D********\\
//*************************\\


getSizeTexture2D :: proc(object: ^Object, r_size: ^Vector2) {
    @(static)GetSize: GDE.MethodBindPtr
    if GetSize == nil do GetSize = classDBGetMethodBind3(.Texture2D, "get_size", 3341600327)

    gdAPI.Object_Utils.MethodBindPtrcall(GetSize, object, nil, r_size)
}

//**************************\\
//*******Tree Methods*******\\
//**************************\\


InternalMode :: enum Int {
    INTERNAL_MODE_DISABLED,
    INTERNAL_MODE_FRONT,
    INTERNAL_MODE_BACK,
}

//**************************\\
//***********Node***********\\
//**************************\\

Side :: enum i64 {
    SIDE_LEFT = 0,
    SIDE_TOP = 1,
    SIDE_RIGHT = 2,
    SIDE_BOTTOM = 3,
}


getViewport :: proc(object: ^Object, r_viewport: ^^Object) {
    @(static)GetViewport: GDE.MethodBindPtr
    if GetViewport == nil do GetViewport = classDBGetMethodBind3(.Node, "get_viewport", 3596683776)

    viewport: GDE.TypePtr
    gdAPI.Object_Utils.MethodBindPtrcall(GetViewport, object, nil, r_viewport)
}

/*
* https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-add-child
* Force_readable_name default should be false if you care about performance. True if you really want a name to be visible to the user.
* Use internalMode to hide children from the user. But make sure to set include_internal to true when calling get_children.
*/
addChild :: proc(parent: ^Object, child: ^^Object, force_readable_name: Bool = false, internalMode: InternalMode = .INTERNAL_MODE_DISABLED) {

    force_readable_name:= force_readable_name
    internalMode:= internalMode

    @(static)addChild: GDE.MethodBindPtr
    if addChild == nil {
        addChild = classDBGetMethodBind3(.Node, "add_child", 3863233950)
    }
    

    internal: InternalMode = internalMode
    args:= [?]rawptr {child, &force_readable_name, &internalMode}
    
    dummyReturn:rawptr
    gdAPI.Object_Utils.MethodBindPtrcall(addChild, parent, raw_data(args[:]), dummyReturn)
}


//*************************\\
//****Rendering Server*****\\
//*************************\\

RenderServerObj: ^Object //Warning: not populated by default. Call getPhysServer2dObj to get its singleton.
RenderServer_SN: StringName


//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getRenderServer2dObj :: proc() -> ^Object {
    if RenderServerObj == nil do RenderServerObj = gdAPI.GlobalGetSingleton(&RenderServer_SN)
    return RenderServerObj
}

/*If RenerServerObj is nil Godot will throw a memory access issue.
* Make sure that you have called/set getRenderServer2dObj at
* least once before using this function.
*/
freeRenderRID :: proc(resourceId: ^RID, renderServer: ^Object = RenderServerObj) {
    @(static)FreeRenderRID: GDE.MethodBindPtr
    if FreeRenderRID ==nil do FreeRenderRID = classDBGetMethodBind3(.RenderingServer, "free_rid", 2722037293)

    assert(resourceId.id != 0)
    args :=[?]rawptr {resourceId}
    gdAPI.Object_Utils.MethodBindPtrcall(FreeRenderRID, renderServer, raw_data(args[:]), nil)
}

//*************************\\
//*****Container(gui)******\\
//*************************\\


//Virtual. Can use as a class callback function if you want to extend the class.
getAlloweredSizeFlagsHorizontal :: proc(container: ^Object, r_sizeFlags: ^PackedInt32Array) {
    @(static)GetAlloweredSizeFlagsHorizontal: GDE.MethodBindPtr
    if GetAlloweredSizeFlagsHorizontal ==nil do GetAlloweredSizeFlagsHorizontal = classDBGetMethodBind3(.Container, "_get_allowed_size_flags_horizontal", 1930428628)

    assert(container != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetAlloweredSizeFlagsHorizontal, container, nil, r_sizeFlags)
}

getAlloweredSizeFlagsVertical :: proc(container: ^Object, r_sizeFlags: ^PackedInt32Array) {
    @(static)GetAlloweredSizeFlagsVertical: GDE.MethodBindPtr
    if GetAlloweredSizeFlagsVertical ==nil do GetAlloweredSizeFlagsVertical = classDBGetMethodBind3(.Container, "_get_allowed_size_flags_vertical", 1930428628)

    assert(container != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GetAlloweredSizeFlagsVertical, container, nil, r_sizeFlags)
}
queueSort :: proc(container: ^Object) {
    @(static)QueueSort: GDE.MethodBindPtr
    if QueueSort ==nil do QueueSort = classDBGetMethodBind3(.Container, "queue_sort", 3218959716)

    assert(container != nil)
    //args :=[?]rawptr {resourceId}
    gdAPI.Object_Utils.MethodBindPtrcall(QueueSort, container, nil, nil)
}
fitChildInRect :: proc(container: ^Object, child: ^^Object, rect: ^Rec2) {
    @(static)FitChildInRect: GDE.MethodBindPtr
    if FitChildInRect ==nil do FitChildInRect = classDBGetMethodBind3(.Container, "fit_child_in_rect", 1993438598)

    assert(container != nil)
    args :=[?]rawptr {child, rect}
    gdAPI.Object_Utils.MethodBindPtrcall(FitChildInRect, container, raw_data(args[:]), nil)
}


/*
*/

//*************************\\
//*****PhysicsServer2D*****\\
//*************************\\

PhysServer2dObj: ^Object //Warning: not populated by default. Call getPhysServer2dObj to get its singleton.
PhysicsServer2D_SN: StringName

BodyState :: enum u32 {
    BODY_STATE_TRANSFORM,
    BODY_STATE_LINEAR_VELOCITY,
    BODY_STATE_ANGULAR_VELOCITY,
    BODY_STATE_SLEEPING,
    BODY_STATE_CAN_SLEEP,
}

//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getPhysServer2dObj :: proc() -> ^Object {
    if PhysServer2dObj == nil do PhysServer2dObj = gdAPI.GlobalGetSingleton(&PhysicsServer2D_SN)
    return PhysServer2dObj
}

circleShapeCreate :: proc(r_shape: ^RID, physServer := PhysServer2dObj) {
    @(static)CircleShapeCreate: GDE.MethodBindPtr
    assert(PhysServer2dObj != nil)
    if CircleShapeCreate == nil do CircleShapeCreate = classDBGetMethodBind3(.PhysicsServer2D, "circle_shape_create", 529393457)

    gdAPI.Object_Utils.MethodBindPtrcall(CircleShapeCreate, PhysServer2dObj, nil, r_shape)
}
 
getSpace :: proc(world2d: GDE.TypePtr, r_space: ^GDE.TypePtr) {
    @(static)GetSpace: GDE.MethodBindPtr
    if GetSpace == nil do GetSpace = classDBGetMethodBind3(.World2D, "get_space", 2944877500)

    gdAPI.Object_Utils.MethodBindPtrcall(GetSpace, cast(^Object)world2d, nil, r_space)
}

bodySetSpace :: proc(body: ^RID, space: ^GDE.TypePtr, physServer := PhysServer2dObj) {
    @(static)SetSpace:GDE.MethodBindPtr
    if SetSpace == nil do SetSpace = classDBGetMethodBind3(.PhysicsServer2D, "body_set_space", 395945892)

    assert(physServer != nil )
    assert(body.id != 0)
    assert(space != nil)

    args:= [2]rawptr {body, space}

    gdAPI.Object_Utils.MethodBindPtrcall(SetSpace, physServer, raw_data(args[:]), nil)
}

bodyAddShape :: proc(body: ^RID, shape: ^RID, trans2d: Transform2D = {1,0,0,1,0,0}, disabled: ^Bool, physServer := PhysServer2dObj){
    @(static)BodyAddShape: GDE.MethodBindPtr
    if BodyAddShape == nil do BodyAddShape = classDBGetMethodBind3(.PhysicsServer2D, "body_add_shape", 339056240)
    assert(physServer != nil && body.id != 0 && shape.id != 0)

    trans2d:=trans2d
    args:= [?]rawptr {body, shape, &trans2d, disabled}

    gdAPI.Object_Utils.MethodBindPtrcall(BodyAddShape, physServer, raw_data(args[:]), nil)
}

shapeSetData :: proc(shape: ^RID, data: ^Int, physServer := PhysServer2dObj){
    @(static)ShapeSetData: GDE.MethodBindPtr
    if ShapeSetData == nil do ShapeSetData = classDBGetMethodBind3(.PhysicsServer2D, "shape_set_data", 3175752987)

    shapedata: GDE.Variant
    variant_from(&shapedata, data)
    shape_data:= [?]rawptr {shape, &shapedata}
    
    gdAPI.Object_Utils.MethodBindPtrcall(ShapeSetData, physServer, raw_data(shape_data[:]), nil)
}

bodyCreate :: proc(r_body: ^RID, physServer := PhysServer2dObj) {
    @(static)BodyCreate: GDE.MethodBindPtr
    if BodyCreate == nil do BodyCreate = classDBGetMethodBind3(.PhysicsServer2D, "body_create", 529393457)

    assert(physServer != nil)

    gdAPI.Object_Utils.MethodBindPtrcall(BodyCreate, physServer, nil, r_body)

}

/*Mask sets which layers this body checks against for collisions received.
* Default is 1.
* Set to 0 to ignore collision from other entities.
* mask is a bitfield. 1, 2, 4, 8, 16 etc for each layer.
* Use layer to specify where this body collides into.
*/
bodySetCollisionMask :: proc(body: ^RID, mask: ^u32, physServer:= PhysServer2dObj) {
    @(static)BodySetCollisionMask: GDE.MethodBindPtr
    if BodySetCollisionMask == nil do BodySetCollisionMask = classDBGetMethodBind3(.PhysicsServer2D, "body_set_collision_mask", 3411492887)

    assert(physServer != nil && body.id != 0 && mask^ >= 0)

    args:= [2]rawptr {body, mask}

    gdAPI.Object_Utils.MethodBindPtrcall(BodySetCollisionMask, physServer, raw_data(args[:]), nil)
}

bodySetState :: proc(body: ^RID, bodyState: ^BodyState, trans_v: ^GDE.Variant, physServer:= PhysServer2dObj) {
    @(static)BodySetState: GDE.MethodBindPtr
    if BodySetState == nil do BodySetState = classDBGetMethodBind3(.PhysicsServer2D, "body_set_state", 1706355209)

    assert(physServer != nil && body.id != 0 && trans_v.VType == .TRANSFORM2D)

    args:= [?]rawptr {body, bodyState, trans_v}

    gdAPI.Object_Utils.MethodBindPtrcall(BodySetState, physServer, raw_data(args[:]), nil)
}


/*
* Use this function to generate a ptr call for your virutal functions.
* Can have up to 10 variables + the classInstancePointer.
* First variable of your procPointer should always be a pointer to your class struct. p_instance will be used there.
*
* procPointer : The proc to your variable. Passed from your callVirtualFunctionWithData
* p_instance : The instance pointer that Godot included in callVirtualFunctionWithData
* p_args : An array of args sent by Godot in callVirtualFunctionWithData
* r_ret : A pointer to hold the return value of your function
*/
virtualProcCall :: #force_inline proc (procPointer: $T, p_instance: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr)
                            where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 11){

    classStructPtr::sics.type_proc_parameter_type(T, 0)
    
    argcount :: sics.type_proc_parameter_count(T)

    when argcount == 1 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance)
        } else {
        procPointer(cast(classStructPtr)p_instance)}
    }
    else do when argcount > 1 do argT0::sics.type_proc_parameter_type(T, 1)

    else do when argcount > 2 do argT1 :: sics.type_proc_parameter_type(T, 2)
    
    else do when argcount > 3 do argT2 :: sics.type_proc_parameter_type(T, 3)
    
    else do when argcount > 4 do argT3 :: sics.type_proc_parameter_type(T, 4)
    
    else do when argcount > 5 do argT4 :: sics.type_proc_parameter_type(T, 5)
    
    else do when argcount > 6 do argT5 :: sics.type_proc_parameter_type(T, 6)
    
    else do when argcount > 7 do argT6 :: sics.type_proc_parameter_type(T, 7)
    
    else do when argcount > 8 do argT7 :: sics.type_proc_parameter_type(T, 8)
    
    else do when argcount > 9 do argT8 :: sics.type_proc_parameter_type(T, 9)
    
    else do when argcount > 10 do argT9 :: sics.type_proc_parameter_type(T, 10)
    
    when argcount == 2 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^)
        }
    }
    when argcount == 3 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^)
        }
    }
    when argcount == 4 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^)
        }
    }
    when argcount == 5 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^)
        }
    }
    when argcount == 6 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, ))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^)
        }
    }
    when argcount == 7 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^)
        }
    }
    when argcount == 8 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^)
        }
    }
    when argcount == 9 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^)
        }
    }
    when argcount == 10 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^)
        }
    }
    when argcount == 11 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^, (cast(^argT9)p_args[9])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^, (cast(^argT9)p_args[9])^)
        }
    }
}