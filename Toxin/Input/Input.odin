package Input

import GDW "shared:GDWrapper"

DEVICE_ID_EMULATION : GDW.Int : -1
InputEvent :: GDW.Object
InputEvent_SN : GDW.StringName

get_All_ClassTag :: proc {
    get_All_ClassTag_struct,
    get_All_ClassTag_array,
}

get_All_ClassTag_struct :: proc "c" (classtypes: ^$T) where sics.type_is_struct(T){
    pos:^T = classtypes
    for field, i in reflect.struct_fields_zipped(T) {
        field_pos:^ClassTag=cast(^ClassTag)(uintptr(pos) + field.offset)
        field_pos^ = get_ClassTagName(field.name)
    }
};

init_InputEvent :: proc() {
    if InputEvent_SN.ptr == nil {
        InputEvent_SN = GDW.StringConstruct("InputEvent")
    }

    GDW.get_All_ClassTag_array(&InputEvent_Tags)
};

classDBGetMethodBind3 :: proc "c" (className: ClassName_Index, methodName: cstring, hash: i64, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {
    native_class_name: ^StringName;
    method_name: StringName;

    native_class_name = GDClass_StringName_get(className)
    gdAPI.StringName_Utils.Latin1Chars(&method_name, methodName, false)

    methodBind = gdAPI.ClassDB.GetMethodBind(native_class_name, &method_name, hash)
    //assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)

    StringName_M_List.Destroy(&method_name)

    return methodBind
}


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