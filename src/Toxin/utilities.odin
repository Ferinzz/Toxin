package Toxin

import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import sics "base:intrinsics"
import "core:reflect"


//a pointer uniquely identifying the given built-in class in the ClassDB.

ClassTag :: GDW.ClassTag

InputEvent :: GDW.InputEvent

/*
* Goes through the list of ClassTags to determine what Input_Event was used.
* Does not check inheritance. A InputEventMouseButton is also a InputEventMouse.
* event: Pointer to an InputEvent, usually received from an _input virtual method.
* return: The enum value which the InputEvent corresponds with.
*/
InputEvent_get_ClassTag :: proc(event: ^InputEvent) -> GDW.InputEvent_Options {
    for &eventClassTag, index in GDW.InputEvent_Tags {
        if gdAPI.Object_Utils.CastTo(event, eventClassTag) != nil {
            return index
        }
    }
    return nil
}