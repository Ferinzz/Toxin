package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:fmt"
import "core:reflect"


DEVICE_ID_EMULATION : GDE.Int : -1
InputEvent :: GDE.Object
InputEvent_SN : GDE.StringName

init_InputEvent :: proc() {
    if InputEvent_SN.ptr == nil {
        InputEvent_SN = StringConstruct.stringNameNewString_r("InputEvent")
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
    nil,
    InputEventMouseButton,
    InputEventMouseMotion,
    InputEventJoypadButton,
    InputEventJoypadMotion,
    InputEventGesture,
    InputEventKey,
    InputEventMIDI,
    InputEventMagnifyGesture,
    InputEventMouse,
    InputEventPanGesture,
    InputEventScreenDrag,
    InputEventScreenTouch,
    InputEventShortcut,
    InputEventAction,
    InputEventWithModifiers,
    InputEventFromWindow,
    InputEvent,
};

InputEvent_get_ClassTag :: proc(event: ^InputEvent) -> InputEvent_Options {
    for &eventClassTag, index in InputEvent_Tags {
        if Methods.checkCast(event, eventClassTag) != nil {
            return index
        }
    }
    return nil
}


//Meta of device : int32
InputEvent_set_device :: proc "c" (input_event: ^InputEvent, device: ^GDE.Int) {
    context = runtime.default_context()
    @(static)setDevice: GDE.MethodBindPtr
    if setDevice == nil do setDevice = classDBGetMethodBind2(&InputEvent_SN, "set_device", 1286410249)
    
    assert(input_event != nil)
    args:= [?]rawptr { device }
    gdAPI.objectMethodBindPtrCall(setDevice, input_event, raw_data(args[:]), nil)
}

//Meta of device : int32
InputEvent_get_device :: proc "c" (input_event: ^InputEvent, r_device: ^GDE.Int) {
    context = runtime.default_context()
    @(static)getDevice: GDE.MethodBindPtr
    if getDevice == nil do getDevice = classDBGetMethodBind2(&InputEvent_SN, "get_device", 3905245786)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(getDevice, input_event, nil, r_device)
}

InputEvent_is_action :: proc "c" (input_event: ^InputEvent, action: GDE.StringNamePtr, exact_match: ^GDE.Bool, r_bool: ^GDE.Int) {
    context = runtime.default_context()
    @(static)isAction: GDE.MethodBindPtr
    if isAction == nil do isAction = classDBGetMethodBind2(&InputEvent_SN, "is_action", 1558498928)
    
    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.objectMethodBindPtrCall(isAction, input_event, raw_data(args[:]), r_bool)
}

InputEvent_is_action_pressed :: proc "c" (input_event: ^InputEvent, action: GDE.StringNamePtr, allow_echo: ^GDE.Bool, exact_match: ^GDE.Bool, r_bool: ^GDE.Int) {
    context = runtime.default_context()
    @(static)isActionPressed: GDE.MethodBindPtr
    if isActionPressed == nil do isActionPressed = classDBGetMethodBind2(&InputEvent_SN, "is_action_pressed", 1631499404)
    
    assert(input_event != nil)
    args:= [?]rawptr { action, allow_echo, exact_match }
    gdAPI.objectMethodBindPtrCall(isActionPressed, input_event, raw_data(args[:]), r_bool)
}

InputEvent_is_action_released :: proc "c" (input_event: ^InputEvent, action: GDE.StringNamePtr, exact_match: ^GDE.Bool, r_bool: ^GDE.Int) {
    context = runtime.default_context()
    @(static)isActionReleased: GDE.MethodBindPtr
    if isActionReleased == nil do isActionReleased = classDBGetMethodBind2(&InputEvent_SN, "is_action_released", 1558498928)
    
    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.objectMethodBindPtrCall(isActionReleased, input_event, raw_data(args[:]), r_bool)
}

InputEvent_get_action_strength :: proc "c" (input_event: ^InputEvent, action: GDE.StringNamePtr, exact_match: ^GDE.Bool, r_strength: ^GDE.float) {
    context = runtime.default_context()
    @(static)getActionStrength: GDE.MethodBindPtr
    if getActionStrength == nil do getActionStrength = classDBGetMethodBind2(&InputEvent_SN, "get_action_strength", 801543509)
    
    assert(input_event != nil)
    args:= [?]rawptr { action, exact_match }
    gdAPI.objectMethodBindPtrCall(getActionStrength, input_event, raw_data(args[:]), r_strength)
}

InputEvent_is_canceled :: proc "c" (input_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)isCanceled: GDE.MethodBindPtr
    if isCanceled == nil do isCanceled = classDBGetMethodBind2(&InputEvent_SN, "is_canceled", 36873697)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(isCanceled, input_event, nil, r_bool)
}

InputEvent_is_pressed :: proc "c" (input_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)isPressed: GDE.MethodBindPtr
    if isPressed == nil do isPressed = classDBGetMethodBind2(&InputEvent_SN, "is_pressed", 36873697)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(isPressed, input_event, nil, r_bool)
}

InputEvent_is_released :: proc "c" (input_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)isReleased: GDE.MethodBindPtr
    if isReleased == nil do isReleased = classDBGetMethodBind2(&InputEvent_SN, "is_released", 36873697)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(isReleased, input_event, nil, r_bool)
}

InputEvent_is_echo :: proc "c" (input_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)isEcho: GDE.MethodBindPtr
    if isEcho == nil do isEcho = classDBGetMethodBind2(&InputEvent_SN, "is_echo", 36873697)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(isEcho, input_event, nil, r_bool)
}

InputEvent_as_text :: proc "c" (input_event: ^InputEvent, r_string: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)asText: GDE.MethodBindPtr
    if asText == nil do asText = classDBGetMethodBind2(&InputEvent_SN, "as_text", 201670096)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(asText, input_event, nil, r_string)
}

InputEvent_is_match :: proc "c" (input_event: ^InputEvent, event: ^InputEvent, exact_match: ^GDE.Bool, r_string: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)isMatch: GDE.MethodBindPtr
    if isMatch == nil do isMatch = classDBGetMethodBind2(&InputEvent_SN, "is_match", 1754951977)
    
    assert(input_event != nil)
    args:= [?]rawptr { event, exact_match }
    gdAPI.objectMethodBindPtrCall(isMatch, input_event, raw_data(args[:]), r_string)
}

InputEvent_is_action_type :: proc "c" (input_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)isActionType: GDE.MethodBindPtr
    if isActionType == nil do isActionType = classDBGetMethodBind2(&InputEvent_SN, "is_action_type", 36873697)
    
    assert(input_event != nil)
    gdAPI.objectMethodBindPtrCall(isActionType, input_event, nil, r_bool)
}

InputEvent_accumulate :: proc "c" (input_event: ^InputEvent, with_event: ^InputEvent, r_bool: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)Accumulate: GDE.MethodBindPtr
    if Accumulate == nil do Accumulate = classDBGetMethodBind2(&InputEvent_SN, "accumulate", 1062211774)
    
    assert(input_event != nil)
    args:= [?]rawptr { with_event }
    gdAPI.objectMethodBindPtrCall(Accumulate, input_event, raw_data(args[:]), r_bool)
}    

InputEvent_xformed_by :: proc "c" (input_event: ^InputEvent, xform: ^GDE.Transform2D, local_ofs: ^GDE.Vector2, r_InputEvent: ^InputEvent) {
    context = runtime.default_context()
    @(static)xformedBy: GDE.MethodBindPtr
    if xformedBy == nil do xformedBy = classDBGetMethodBind2(&InputEvent_SN, "xformed_by", 1282766827)
    
    assert(input_event != nil)
    args:= [?]rawptr { xformedBy, local_ofs }
    gdAPI.objectMethodBindPtrCall(xformedBy, input_event, raw_data(args[:]), r_InputEvent)
}