package Input

import GDW "../../GDWrapper"
import GDW "../../GDWrapper"
import GDE "../../GDWrapper/gdAPI/gdextension"
import sics "base:intrinsics"
import reflect "core:reflect"

DEVICE_ID_EMULATION : GDW.Int : -1
InputEvent :: GDW.Object
InputEvent_SN : GDW.StringName


/*
* Populate an array with the ClassTag(s).
* See Input.odin for an example InputEvent_get_ClassTag of its usage.
* classtypes: a pointer to an enumerated array of ClassTags.
*/
get_All_ClassTag_array :: proc(classtypes: ^$T/[$E]GDE.ClassTag) where sics.type_is_enum(E){
    for name, i in reflect.enum_field_names(E) {
        classtypes[E(i)] = GDW.get_ClassTagName(name)
    }
};

init_InputEvent :: proc() {
    if InputEvent_SN.ptr == nil {
        InputEvent_SN = GDW.StringConstruct("InputEvent")
    }

    get_All_ClassTag_array(&InputEvent_Tags)
};


InputEvent_Types: struct {
    InputEvent: GDE.ClassTag,
    InputEventAction: GDE.ClassTag,
    InputEventFromWindow: GDE.ClassTag,
    InputEventGesture: GDE.ClassTag,
    InputEventJoypadButton: GDE.ClassTag,
    InputEventJoypadMotion: GDE.ClassTag,
    InputEventKey: GDE.ClassTag,
    InputEventMIDI: GDE.ClassTag,
    InputEventMagnifyGesture: GDE.ClassTag,
    InputEventMouse: GDE.ClassTag,
    InputEventMouseButton: GDE.ClassTag,
    InputEventMouseMotion: GDE.ClassTag,
    InputEventPanGesture: GDE.ClassTag,
    InputEventScreenDrag: GDE.ClassTag,
    InputEventScreenTouch: GDE.ClassTag,
    InputEventShortcut: GDE.ClassTag,
    InputEventWithModifiers: GDE.ClassTag,
};

InputEvent_Tags: [InputEvent_Options]GDE.ClassTag

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