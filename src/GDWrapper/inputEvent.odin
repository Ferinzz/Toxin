package GDWrapper

import "base:runtime"
import GDE "gdAPI/gdextension"
import "gdAPI"
import "core:fmt"
import sics "base:intrinsics"


DEVICE_ID_EMULATION : Int : -1
InputEvent :: Object
InputEvent_SN : StringName


init_InputEvent :: proc() {
    if InputEvent_SN.ptr == nil {
        InputEvent_SN = StringConstruct("InputEvent")
    }

    get_All_ClassTag_array(&InputEvent_Tags)
};


InputEvent_Types: struct {
    InputEvent: ClassTag,
    InputEventAction: ClassTag,
    InputEventFromWindow: ClassTag,
    InputEventGesture: ClassTag,
    InputEventJoypadButton: ClassTag,
    InputEventJoypadMotion: ClassTag,
    InputEventKey: ClassTag,
    InputEventMIDI: ClassTag,
    InputEventMagnifyGesture: ClassTag,
    InputEventMouse: ClassTag,
    InputEventMouseButton: ClassTag,
    InputEventMouseMotion: ClassTag,
    InputEventPanGesture: ClassTag,
    InputEventScreenDrag: ClassTag,
    InputEventScreenTouch: ClassTag,
    InputEventShortcut: ClassTag,
    InputEventWithModifiers: ClassTag,
};

InputEvent_Tags: [InputEvent_Options]ClassTag

InputEvent_Set: bit_set[InputEvent_Options];
InputEvent_Options :: enum {
    InputEventMouseButton,
    InputEventMouseMotion,
    //InputEventJoypadButton,
    //InputEventJoypadMotion,
    //InputEventGesture,
    //InputEventKey,
    //InputEventMIDI,
    //InputEventMagnifyGesture,
    //InputEventMouse,
    //InputEventPanGesture,
    //InputEventScreenDrag,
    //InputEventScreenTouch,
    //InputEventShortcut,
    //InputEventAction,
    //InputEventWithModifiers,
    //InputEventFromWindow,
    InputEvent,
};
/*
init_Input :: proc (classDB_methods: ^$T) {
    classDB_methods.set_name = cast(sics.type_field_type(T, "set_name"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "set_name", 3304788590)).method
    classDB_methods.get_name = cast(sics.type_field_type(T, "get_name"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "get_name", 2002593661)).method
    classDB_methods.get_child_count = cast(sics.type_field_type(T, "get_child_count"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "get_child_count", 894402480)).method
    
    classDB_methods.set_name2 = cast(sics.type_field_type(T, "set_name2"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "set_name", 3304788590)).method
    classDB_methods.get_name = cast(sics.type_field_type(T, "get_name2"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "get_name", 2002593661)).method
    classDB_methods.get_child_count2 = cast(sics.type_field_type(T, "get_child_count2"))(cast(^MethodBind)classDBGetMethodBind3(.Node, "get_child_count", 894402480)).method
    //classDB_methods.class_get_signal = cast(sics.type_field_type(T, "class_get_signal"))(cast(^MethodBind)classDBGetMethodBind3(.ClassDB, "class_get_signal", 3061114238)).method
}

ClassDB

set_name2:: proc (self: ^InputEvent, name: rawptr) {

}
*/

InputEvent_is_action :: proc(input_event: ^InputEvent, action: ^StringName, exact_match: ^Bool, r_bool: ^Int) {
    @(static)isAction: GDE.MethodBindPtr
    if isAction == nil do isAction = classDBGetMethodBind3(.InputEvent, "is_action", 1558498928)

    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.Object_Utils.MethodBindPtrcall(isAction, input_event, raw_data(args[:]), r_bool)
}

InputEvent_is_action_pressed :: proc(input_event: ^InputEvent, action: ^StringName, allow_echo: ^Bool, exact_match: ^Bool, r_bool: ^Int) {
    @(static)isActionPressed: GDE.MethodBindPtr
    if isActionPressed == nil do isActionPressed = classDBGetMethodBind3(.InputEvent, "is_action_pressed", 1631499404)

    assert(input_event != nil)
    args:= [?]rawptr { action, allow_echo, exact_match }
    gdAPI.Object_Utils.MethodBindPtrcall(isActionPressed, input_event, raw_data(args[:]), r_bool)
}

InputEvent_is_action_released :: proc(input_event: ^InputEvent, action: ^StringName, exact_match: ^Bool, r_bool: ^Int) {
    @(static)isActionReleased: GDE.MethodBindPtr
    if isActionReleased == nil do isActionReleased = classDBGetMethodBind3(.InputEvent, "is_action_released", 1558498928)

    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.Object_Utils.MethodBindPtrcall(isActionReleased, input_event, raw_data(args[:]), r_bool)
}

InputEvent_get_action_strength :: proc(input_event: ^InputEvent, action: ^StringName, exact_match: ^Bool, r_strength: ^float) {
    @(static)getActionStrength: GDE.MethodBindPtr
    if getActionStrength == nil do getActionStrength = classDBGetMethodBind3(.InputEvent, "get_action_strength", 801543509)

    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.Object_Utils.MethodBindPtrcall(getActionStrength, input_event, raw_data(args[:]), r_strength)
}

InputEvent_is_canceled :: proc(input_event: ^InputEvent, r_bool: ^Bool) {
    @(static)isCanceled: GDE.MethodBindPtr
    if isCanceled == nil do isCanceled = classDBGetMethodBind3(.InputEvent, "is_canceled", 36873697)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(isCanceled, input_event, nil, r_bool)
}

InputEvent_is_pressed :: proc(input_event: ^InputEvent, r_bool: ^Bool) {
    @(static)isPressed: GDE.MethodBindPtr
    if isPressed == nil do isPressed = classDBGetMethodBind3(.InputEvent, "is_pressed", 36873697)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(isPressed, input_event, nil, r_bool)
}

InputEvent_is_released :: proc(input_event: ^InputEvent, r_bool: ^Bool) {
    @(static)isReleased: GDE.MethodBindPtr
    if isReleased == nil do isReleased = classDBGetMethodBind3(.InputEvent, "is_released", 36873697)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(isReleased, input_event, nil, r_bool)
}

InputEvent_is_echo :: proc(input_event: ^InputEvent, r_bool: ^Bool) {
    @(static)isEcho: GDE.MethodBindPtr
    if isEcho == nil do isEcho = classDBGetMethodBind3(.InputEvent, "is_echo", 36873697)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(isEcho, input_event, nil, r_bool)
}

InputEvent_as_text :: proc(input_event: ^InputEvent, r_string: ^gdstring) {
    @(static)asText: GDE.MethodBindPtr
    if asText == nil do asText = classDBGetMethodBind3(.InputEvent, "as_text", 201670096)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(asText, input_event, nil, r_string)
}

InputEvent_is_match :: proc(input_event: ^InputEvent, event: ^InputEvent, exact_match: ^Bool, r_string: ^gdstring) {
    @(static)isMatch: GDE.MethodBindPtr
    if isMatch == nil do isMatch = classDBGetMethodBind3(.InputEvent, "is_match", 1754951977)

    assert(input_event != nil)
    args:= [?]rawptr { event, exact_match }
    gdAPI.Object_Utils.MethodBindPtrcall(isMatch, input_event, raw_data(args[:]), r_string)
}

InputEvent_is_action_type :: proc(input_event: ^InputEvent, r_bool: ^Bool) {
    @(static)isActionType: GDE.MethodBindPtr
    if isActionType == nil do isActionType = classDBGetMethodBind3(.InputEvent, "is_action_type", 36873697)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(isActionType, input_event, nil, r_bool)
}

InputEvent_accumulate :: proc(input_event: ^InputEvent, with_event: ^InputEvent, r_bool: ^Bool) {
    @(static)Accumulate: GDE.MethodBindPtr
    if Accumulate == nil do Accumulate = classDBGetMethodBind3(.InputEvent, "accumulate", 1062211774)

    assert(input_event != nil)
    args:= [?]rawptr { with_event }
    gdAPI.Object_Utils.MethodBindPtrcall(Accumulate, input_event, raw_data(args[:]), r_bool)
}    

InputEvent_xformed_by :: proc(input_event: ^InputEvent, xform: ^Transform2D, local_ofs: ^Vector2, r_InputEvent: ^InputEvent) {
    @(static)xformedBy: GDE.MethodBindPtr
    if xformedBy == nil do xformedBy = classDBGetMethodBind3(.InputEvent, "xformed_by", 1282766827)

    assert(input_event != nil)
    args:= [?]rawptr { xformedBy, local_ofs }
    gdAPI.Object_Utils.MethodBindPtrcall(xformedBy, input_event, raw_data(args[:]), r_InputEvent)
}

//Meta of device : int32
InputEvent_set_device :: proc(input_event: ^InputEvent, device: ^Int) {
    @(static)setDevice: GDE.MethodBindPtr
    if setDevice == nil do setDevice = classDBGetMethodBind3(.InputEvent, "set_device", 1286410249)

    assert(input_event != nil)
    args:= [?]rawptr { device }
    gdAPI.Object_Utils.MethodBindPtrcall(setDevice, input_event, raw_data(args[:]), nil)
}

//Meta of device : int32
InputEvent_get_device :: proc(input_event: ^InputEvent, r_device: ^Int) {
    @(static)getDevice: GDE.MethodBindPtr
    if getDevice == nil do getDevice = classDBGetMethodBind3(.InputEvent, "get_device", 3905245786)
    
    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(getDevice, input_event, nil, r_device)
}

InputEventMouseButton:: Object
InputEventMouseButton_SN: StringName

InputEventMouseMotion_SN: StringName
InputEventMouse_SN: StringName

init_InputEventMouse :: proc() {
    if InputEventMouseButton_SN.ptr == nil {
        InputEventMouseButton_SN = StringConstruct("InputEventMouseButton")
    }
    if InputEventMouseMotion_SN.ptr == nil {
        InputEventMouseMotion_SN = StringConstruct("InputEventMouseMotion")
    }
    if InputEventMouse_SN.ptr == nil {
        InputEventMouse_SN = StringConstruct("InputEventMouse")
    }
};


InputEventMouseButton_get_button_index :: proc(input_event: ^InputEvent, r_MouseButton: ^MouseButton) {
    @(static)getbuttonindex: GDE.MethodBindPtr
    if getbuttonindex == nil do getbuttonindex = classDBGetMethodBind3(.InputEventMouseButton, "get_button_index", 1132662608)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(getbuttonindex, input_event, nil, r_MouseButton)
}

InputEventMouseMotion_get_screen_relative :: proc(input_event: ^InputEvent, r_Pos: ^Vector2) {
    @(static)getscreenrelative: GDE.MethodBindPtr
    if getscreenrelative == nil do getscreenrelative = classDBGetMethodBind3(.InputEventMouseMotion, "get_screen_relative", 3341600327)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(getscreenrelative, input_event, nil, r_Pos)
}

InputEventMouse_get_global_position :: proc(input_event: ^InputEvent, r_Pos: ^Vector2) {
    @(static)getglobalposition: GDE.MethodBindPtr
    if getglobalposition == nil do getglobalposition = classDBGetMethodBind3(.InputEventMouse, "get_global_position", 3341600327)

    assert(input_event != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(getglobalposition, input_event, nil, r_Pos)
}

/*
				{
					"name": "set_factor",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 373806689,
					"arguments": [
						{
							"name": "factor",
							"type": "float",
							"meta": "float"
						}
					]
				},
				{
					"name": "get_factor",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1740695150,
					"return_value": {
						"type": "float",
						"meta": "float"
					}
				},
				{
					"name": "set_button_index",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3624991109,
					"arguments": [
						{
							"name": "button_index",
							"type": "enum::MouseButton"
						}
					]
				},
				{
					"name": "get_button_index",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1132662608,
					"return_value": {
						"type": "enum::MouseButton"
					}
				},
				{
					"name": "set_pressed",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "pressed",
							"type": "bool"
						}
					]
				},
				{
					"name": "set_canceled",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "canceled",
							"type": "bool"
						}
					]
				},
				{
					"name": "set_double_click",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "double_click",
							"type": "bool"
						}
					]
				},
				{
					"name": "is_double_click",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				}
*/