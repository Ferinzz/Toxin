package Input

import GDW "../../GDWrapper"

DEVICE_ID_EMULATION : GDW.Int : -1
InputEvent :: GDW.Object
InputEvent_SN : GDW.StringName


init_InputEvent :: proc() {
    if InputEvent_SN.ptr == nil {
        InputEvent_SN = GDW.StringConstruct("InputEvent")
    }

    GDW.get_All_ClassTag_array(&InputEvent_Tags)
};


InputEvent_Types: struct {
    InputEvent: GDW.ClassTag,
    InputEventAction: GDW.ClassTag,
    InputEventFromWindow: GDW.ClassTag,
    InputEventGesture: GDW.ClassTag,
    InputEventJoypadButton: GDW.ClassTag,
    InputEventJoypadMotion: GDW.ClassTag,
    InputEventKey: GDW.ClassTag,
    InputEventMIDI: GDW.ClassTag,
    InputEventMagnifyGesture: GDW.ClassTag,
    InputEventMouse: GDW.ClassTag,
    InputEventMouseButton: GDW.ClassTag,
    InputEventMouseMotion: GDW.ClassTag,
    InputEventPanGesture: GDW.ClassTag,
    InputEventScreenDrag: GDW.ClassTag,
    InputEventScreenTouch: GDW.ClassTag,
    InputEventShortcut: GDW.ClassTag,
    InputEventWithModifiers: GDW.ClassTag,
};

InputEvent_Tags: [InputEvent_Options]GDW.ClassTag

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
*/