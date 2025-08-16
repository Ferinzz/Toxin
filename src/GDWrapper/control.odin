//#+ignore
package GDWrapper

import GDE "gdextension"
import "base:runtime"

/*
{
			"name": "Control",
			"is_refcounted": false,
			"is_instantiable": true,
			"inherits": "CanvasItem",
			"api_type": "core",
			
*/
ControlConstants :: enum i64 {

   ControlNOTIFICATION_RESIZED = 40,
   ControlNOTIFICATION_MOUSE_ENTER = 41,
   ControlNOTIFICATION_MOUSE_EXIT = 42,
   ControlNOTIFICATION_MOUSE_ENTER_SELF = 60,
   ControlNOTIFICATION_MOUSE_EXIT_SELF = 61,
   ControlNOTIFICATION_FOCUS_ENTER = 43,
   ControlNOTIFICATION_FOCUS_EXIT = 44,
   ControlNOTIFICATION_THEME_CHANGED = 45,
   ControlNOTIFICATION_SCROLL_BEGIN = 47,
   ControlNOTIFICATION_SCROLL_END = 48,
   ControlNOTIFICATION_LAYOUT_DIRECTION_CHANGED = 49,
}



FocusMode :: enum i32 {
 FOCUS_NONE = 0,
 FOCUS_CLICK = 1,
 FOCUS_ALL = 2,
}

CursorShape :: enum i32 {
 CURSOR_ARROW = 0,
 CURSOR_IBEAM = 1,
 CURSOR_POINTING_HAND = 2,
 CURSOR_CROSS = 3,
 CURSOR_WAIT = 4,
 CURSOR_BUSY = 5,
 CURSOR_DRAG = 6,
 CURSOR_CAN_DROP = 7,
 CURSOR_FORBIDDEN = 8,
 CURSOR_VSIZE = 9,
 CURSOR_HSIZE = 10,
 CURSOR_BDIAGSIZE = 11,
 CURSOR_FDIAGSIZE = 12,
 CURSOR_MOVE = 13,
 CURSOR_VSPLIT = 14,
 CURSOR_HSPLIT = 15,
 CURSOR_HELP = 16,
}

LayoutPreset :: enum i32 {
 PRESET_TOP_LEFT = 0,
 PRESET_TOP_RIGHT = 1,
 PRESET_BOTTOM_LEFT = 2,
 PRESET_BOTTOM_RIGHT = 3,
 PRESET_CENTER_LEFT = 4,
 PRESET_CENTER_TOP = 5,
 PRESET_CENTER_RIGHT = 6,
 PRESET_CENTER_BOTTOM = 7,
 PRESET_CENTER = 8,
 PRESET_LEFT_WIDE = 9,
 PRESET_TOP_WIDE = 10,
 PRESET_RIGHT_WIDE = 11,
 PRESET_BOTTOM_WIDE = 12,
 PRESET_VCENTER_WIDE = 13,
 PRESET_HCENTER_WIDE = 14,
 PRESET_FULL_RECT = 15,
}

LayoutPresetMode :: enum i32 {
 PRESET_MODE_MINSIZE = 0,
 PRESET_MODE_KEEP_WIDTH = 1,
 PRESET_MODE_KEEP_HEIGHT = 2,
 PRESET_MODE_KEEP_SIZE = 3,
}

SizeFlags :: enum i32 {
 SIZE_SHRINK_BEGIN = 0,
 SIZE_FILL = 1,
 SIZE_EXPAND = 2,
 SIZE_EXPAND_FILL = 3,
 SIZE_SHRINK_CENTER = 4,
 SIZE_SHRINK_END = 8,
}

MouseFilter :: enum i32 {
 MOUSE_FILTER_STOP = 0,
 MOUSE_FILTER_PASS = 1,
 MOUSE_FILTER_IGNORE = 2,
}

GrowDirection :: enum i32 {
 GROW_DIRECTION_BEGIN = 0,
 GROW_DIRECTION_END = 1,
 GROW_DIRECTION_BOTH = 2,
}

Anchor :: enum i32 {
 ANCHOR_BEGIN = 0,
 ANCHOR_END = 1,
}

LayoutDirection :: enum i32 {
 LAYOUT_DIRECTION_INHERITED = 0,
 LAYOUT_DIRECTION_APPLICATION_LOCALE = 1,
 LAYOUT_DIRECTION_LTR = 2,
 LAYOUT_DIRECTION_RTL = 3,
 LAYOUT_DIRECTION_SYSTEM_LOCALE = 4,
 LAYOUT_DIRECTION_MAX = 5,
 LAYOUT_DIRECTION_LOCALE = 1,
}

TextDirection :: enum i32 {
 TEXT_DIRECTION_INHERITED = 3,
 TEXT_DIRECTION_AUTO = 0,
 TEXT_DIRECTION_LTR = 1,
 TEXT_DIRECTION_RTL = 2,
}



    //*****************\\
    //*****Methods*****\\
    //*****************\\

_has_point :: proc "c" (Control: GDE.ObjectPtr, point: ^GDE.Vector2, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)_HAS_POINT: GDE.MethodBindPtr
    if _HAS_POINT == nil do _HAS_POINT = classDBGetMethodBind("Control", "_has_point", 556197845)
    assert(Control != nil)
    args:= [?]rawptr { point }
    gdAPI.objectMethodBindPtrCall(_HAS_POINT, Control, raw_data(args[:]), r_ret)
}

_structured_text_parser :: proc "c" (Control: GDE.ObjectPtr, args: ^GDE.Array, text: ^GDE.gdstring, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)_STRUCTURED_TEXT_PARSER: GDE.MethodBindPtr
    if _STRUCTURED_TEXT_PARSER == nil do _STRUCTURED_TEXT_PARSER = classDBGetMethodBind("Control", "_structured_text_parser", 1292548940)
    assert(Control != nil)
    args:= [?]rawptr { args, text }
    gdAPI.objectMethodBindPtrCall(_STRUCTURED_TEXT_PARSER, Control, raw_data(args[:]), r_ret)
}

_get_minimum_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)_GET_MINIMUM_SIZE: GDE.MethodBindPtr
    if _GET_MINIMUM_SIZE == nil do _GET_MINIMUM_SIZE = classDBGetMethodBind("Control", "_get_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(_GET_MINIMUM_SIZE, Control, nil, r_ret)
}

_get_tooltip :: proc "c" (Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)_GET_TOOLTIP: GDE.MethodBindPtr
    if _GET_TOOLTIP == nil do _GET_TOOLTIP = classDBGetMethodBind("Control", "_get_tooltip", 3674420000)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.objectMethodBindPtrCall(_GET_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

_get_drag_data :: proc "c" (Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.Variant) {
    context = runtime.default_context()
    @(static)_GET_DRAG_DATA: GDE.MethodBindPtr
    if _GET_DRAG_DATA == nil do _GET_DRAG_DATA = classDBGetMethodBind("Control", "_get_drag_data", 2233896889)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.objectMethodBindPtrCall(_GET_DRAG_DATA, Control, raw_data(args[:]), r_ret)
}

_can_drop_data :: proc "c" (Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, data: ^GDE.Variant, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)_CAN_DROP_DATA: GDE.MethodBindPtr
    if _CAN_DROP_DATA == nil do _CAN_DROP_DATA = classDBGetMethodBind("Control", "_can_drop_data", 2603004011)
    assert(Control != nil)
    args:= [?]rawptr { at_position, data }
    gdAPI.objectMethodBindPtrCall(_CAN_DROP_DATA, Control, raw_data(args[:]), r_ret)
}

_drop_data :: proc "c" (Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, data: ^GDE.Variant) {
    context = runtime.default_context()
    @(static)_DROP_DATA: GDE.MethodBindPtr
    if _DROP_DATA == nil do _DROP_DATA = classDBGetMethodBind("Control", "_drop_data", 3699746064)
    assert(Control != nil)
    args:= [?]rawptr { at_position, data }
    gdAPI.objectMethodBindPtrCall(_DROP_DATA, Control, raw_data(args[:]), nil)
}

_make_custom_tooltip :: proc "c" (Control: GDE.ObjectPtr, for_text: ^GDE.gdstring, r_ret: ^GDE.Object) {
    context = runtime.default_context()
    @(static)_MAKE_CUSTOM_TOOLTIP: GDE.MethodBindPtr
    if _MAKE_CUSTOM_TOOLTIP == nil do _MAKE_CUSTOM_TOOLTIP = classDBGetMethodBind("Control", "_make_custom_tooltip", 1976279298)
    assert(Control != nil)
    args:= [?]rawptr { for_text }
    gdAPI.objectMethodBindPtrCall(_MAKE_CUSTOM_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

_gui_input :: proc "c" (Control: GDE.ObjectPtr, event: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)_GUI_INPUT: GDE.MethodBindPtr
    if _GUI_INPUT == nil do _GUI_INPUT = classDBGetMethodBind("Control", "_gui_input", 3754044979)
    assert(Control != nil)
    args:= [?]rawptr { event }
    gdAPI.objectMethodBindPtrCall(_GUI_INPUT, Control, raw_data(args[:]), nil)
}

accept_event :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)ACCEPT_EVENT: GDE.MethodBindPtr
    if ACCEPT_EVENT == nil do ACCEPT_EVENT = classDBGetMethodBind("Control", "accept_event", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(ACCEPT_EVENT, Control, nil, nil)
}

get_minimum_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_MINIMUM_SIZE == nil do GET_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_MINIMUM_SIZE, Control, nil, r_ret)
}

get_combined_minimum_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_COMBINED_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_COMBINED_MINIMUM_SIZE == nil do GET_COMBINED_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_combined_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_COMBINED_MINIMUM_SIZE, Control, nil, r_ret)
}


//default of keep_offsets : false
set_anchors_preset :: proc "c" (Control: GDE.ObjectPtr, preset: ^LayoutPreset, keep_offsets: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_ANCHORS_PRESET: GDE.MethodBindPtr
    if SET_ANCHORS_PRESET == nil do SET_ANCHORS_PRESET = classDBGetMethodBind("Control", "set_anchors_preset", 509135270)
    assert(Control != nil)
    args:= [?]rawptr { preset, keep_offsets }
    gdAPI.objectMethodBindPtrCall(SET_ANCHORS_PRESET, Control, raw_data(args[:]), nil)
}


//default of resize_mode : 0
//Meta of margin : int32
//default of margin : 0
set_offsets_preset :: proc "c" (Control: GDE.ObjectPtr, preset: ^LayoutPreset, resize_mode: ^LayoutPresetMode, margin: ^GDE.Int) {
    context = runtime.default_context()
    @(static)SET_OFFSETS_PRESET: GDE.MethodBindPtr
    if SET_OFFSETS_PRESET == nil do SET_OFFSETS_PRESET = classDBGetMethodBind("Control", "set_offsets_preset", 3724524307)
    assert(Control != nil)
    args:= [?]rawptr { preset, resize_mode, margin }
    gdAPI.objectMethodBindPtrCall(SET_OFFSETS_PRESET, Control, raw_data(args[:]), nil)
}


//default of resize_mode : 0
//Meta of margin : int32
//default of margin : 0
set_anchors_and_offsets_preset :: proc "c" (Control: GDE.ObjectPtr, preset: ^LayoutPreset, resize_mode: ^LayoutPresetMode, margin: ^GDE.Int) {
    context = runtime.default_context()
    @(static)SET_ANCHORS_AND_OFFSETS_PRESET: GDE.MethodBindPtr
    if SET_ANCHORS_AND_OFFSETS_PRESET == nil do SET_ANCHORS_AND_OFFSETS_PRESET = classDBGetMethodBind("Control", "set_anchors_and_offsets_preset", 3724524307)
    assert(Control != nil)
    args:= [?]rawptr { preset, resize_mode, margin }
    gdAPI.objectMethodBindPtrCall(SET_ANCHORS_AND_OFFSETS_PRESET, Control, raw_data(args[:]), nil)
}


//Meta of anchor : float
//default of keep_offset : false
//default of push_opposite_anchor : true
set_anchor :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, anchor: ^GDE.float, keep_offset: ^GDE.Bool, push_opposite_anchor: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_ANCHOR: GDE.MethodBindPtr
    if SET_ANCHOR == nil do SET_ANCHOR = classDBGetMethodBind("Control", "set_anchor", 2302782885)
    assert(Control != nil)
    args:= [?]rawptr { side, anchor, keep_offset, push_opposite_anchor }
    gdAPI.objectMethodBindPtrCall(SET_ANCHOR, Control, raw_data(args[:]), nil)
}

get_anchor :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_ANCHOR: GDE.MethodBindPtr
    if GET_ANCHOR == nil do GET_ANCHOR = classDBGetMethodBind("Control", "get_anchor", 2869120046)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.objectMethodBindPtrCall(GET_ANCHOR, Control, raw_data(args[:]), r_ret)
}


//Meta of offset : float
set_offset :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, offset: ^GDE.float) {
    context = runtime.default_context()
    @(static)SET_OFFSET: GDE.MethodBindPtr
    if SET_OFFSET == nil do SET_OFFSET = classDBGetMethodBind("Control", "set_offset", 4290182280)
    assert(Control != nil)
    args:= [?]rawptr { side, offset }
    gdAPI.objectMethodBindPtrCall(SET_OFFSET, Control, raw_data(args[:]), nil)
}

get_offset :: proc "c" (Control: GDE.ObjectPtr, offset: ^Side, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_OFFSET: GDE.MethodBindPtr
    if GET_OFFSET == nil do GET_OFFSET = classDBGetMethodBind("Control", "get_offset", 2869120046)
    assert(Control != nil)
    args:= [?]rawptr { offset }
    gdAPI.objectMethodBindPtrCall(GET_OFFSET, Control, raw_data(args[:]), r_ret)
}


//Meta of anchor : float
//Meta of offset : float
//default of push_opposite_anchor : false
set_anchor_and_offset :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, anchor: ^GDE.float, offset: ^GDE.float, push_opposite_anchor: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_ANCHOR_AND_OFFSET: GDE.MethodBindPtr
    if SET_ANCHOR_AND_OFFSET == nil do SET_ANCHOR_AND_OFFSET = classDBGetMethodBind("Control", "set_anchor_and_offset", 4031722181)
    assert(Control != nil)
    args:= [?]rawptr { side, anchor, offset, push_opposite_anchor }
    gdAPI.objectMethodBindPtrCall(SET_ANCHOR_AND_OFFSET, Control, raw_data(args[:]), nil)
}

set_begin :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)SET_BEGIN: GDE.MethodBindPtr
    if SET_BEGIN == nil do SET_BEGIN = classDBGetMethodBind("Control", "set_begin", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.objectMethodBindPtrCall(SET_BEGIN, Control, raw_data(args[:]), nil)
}

set_end :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)SET_END: GDE.MethodBindPtr
    if SET_END == nil do SET_END = classDBGetMethodBind("Control", "set_end", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.objectMethodBindPtrCall(SET_END, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_position :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_POSITION: GDE.MethodBindPtr
    if SET_POSITION == nil do SET_POSITION = classDBGetMethodBind("Control", "set_position", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { position, keep_offsets }
    gdAPI.objectMethodBindPtrCall(SET_POSITION, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_size :: proc "c" (Control: GDE.ObjectPtr, size: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_SIZE: GDE.MethodBindPtr
    if SET_SIZE == nil do SET_SIZE = classDBGetMethodBind("Control", "set_size", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { size, keep_offsets }
    gdAPI.objectMethodBindPtrCall(SET_SIZE, Control, raw_data(args[:]), nil)
}

reset_size :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)RESET_SIZE: GDE.MethodBindPtr
    if RESET_SIZE == nil do RESET_SIZE = classDBGetMethodBind("Control", "reset_size", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(RESET_SIZE, Control, nil, nil)
}

set_custom_minimum_size :: proc "c" (Control: GDE.ObjectPtr, size: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)SET_CUSTOM_MINIMUM_SIZE: GDE.MethodBindPtr
    if SET_CUSTOM_MINIMUM_SIZE == nil do SET_CUSTOM_MINIMUM_SIZE = classDBGetMethodBind("Control", "set_custom_minimum_size", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { size }
    gdAPI.objectMethodBindPtrCall(SET_CUSTOM_MINIMUM_SIZE, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_global_position :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_GLOBAL_POSITION: GDE.MethodBindPtr
    if SET_GLOBAL_POSITION == nil do SET_GLOBAL_POSITION = classDBGetMethodBind("Control", "set_global_position", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { position, keep_offsets }
    gdAPI.objectMethodBindPtrCall(SET_GLOBAL_POSITION, Control, raw_data(args[:]), nil)
}


//Meta of radians : float
set_rotation :: proc "c" (Control: GDE.ObjectPtr, radians: ^GDE.float) {
    context = runtime.default_context()
    @(static)SET_ROTATION: GDE.MethodBindPtr
    if SET_ROTATION == nil do SET_ROTATION = classDBGetMethodBind("Control", "set_rotation", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { radians }
    gdAPI.objectMethodBindPtrCall(SET_ROTATION, Control, raw_data(args[:]), nil)
}


//Meta of degrees : float
set_rotation_degrees :: proc "c" (Control: GDE.ObjectPtr, degrees: ^GDE.float) {
    context = runtime.default_context()
    @(static)SET_ROTATION_DEGREES: GDE.MethodBindPtr
    if SET_ROTATION_DEGREES == nil do SET_ROTATION_DEGREES = classDBGetMethodBind("Control", "set_rotation_degrees", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { degrees }
    gdAPI.objectMethodBindPtrCall(SET_ROTATION_DEGREES, Control, raw_data(args[:]), nil)
}

set_scale :: proc "c" (Control: GDE.ObjectPtr, scale: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)SET_SCALE: GDE.MethodBindPtr
    if SET_SCALE == nil do SET_SCALE = classDBGetMethodBind("Control", "set_scale", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { scale }
    gdAPI.objectMethodBindPtrCall(SET_SCALE, Control, raw_data(args[:]), nil)
}

set_pivot_offset :: proc "c" (Control: GDE.ObjectPtr, pivot_offset: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)SET_PIVOT_OFFSET: GDE.MethodBindPtr
    if SET_PIVOT_OFFSET == nil do SET_PIVOT_OFFSET = classDBGetMethodBind("Control", "set_pivot_offset", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { pivot_offset }
    gdAPI.objectMethodBindPtrCall(SET_PIVOT_OFFSET, Control, raw_data(args[:]), nil)
}

get_begin :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_BEGIN: GDE.MethodBindPtr
    if GET_BEGIN == nil do GET_BEGIN = classDBGetMethodBind("Control", "get_begin", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_BEGIN, Control, nil, r_ret)
}

get_end :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_END: GDE.MethodBindPtr
    if GET_END == nil do GET_END = classDBGetMethodBind("Control", "get_end", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_END, Control, nil, r_ret)
}

get_position :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_POSITION: GDE.MethodBindPtr
    if GET_POSITION == nil do GET_POSITION = classDBGetMethodBind("Control", "get_position", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_POSITION, Control, nil, r_ret)
}

get_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_SIZE: GDE.MethodBindPtr
    if GET_SIZE == nil do GET_SIZE = classDBGetMethodBind("Control", "get_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_SIZE, Control, nil, r_ret)
}

get_rotation :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_ROTATION: GDE.MethodBindPtr
    if GET_ROTATION == nil do GET_ROTATION = classDBGetMethodBind("Control", "get_rotation", 1740695150)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_ROTATION, Control, nil, r_ret)
}

get_rotation_degrees :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_ROTATION_DEGREES: GDE.MethodBindPtr
    if GET_ROTATION_DEGREES == nil do GET_ROTATION_DEGREES = classDBGetMethodBind("Control", "get_rotation_degrees", 1740695150)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_ROTATION_DEGREES, Control, nil, r_ret)
}

get_scale :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_SCALE: GDE.MethodBindPtr
    if GET_SCALE == nil do GET_SCALE = classDBGetMethodBind("Control", "get_scale", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_SCALE, Control, nil, r_ret)
}

get_pivot_offset :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_PIVOT_OFFSET: GDE.MethodBindPtr
    if GET_PIVOT_OFFSET == nil do GET_PIVOT_OFFSET = classDBGetMethodBind("Control", "get_pivot_offset", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_PIVOT_OFFSET, Control, nil, r_ret)
}

get_custom_minimum_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_CUSTOM_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_CUSTOM_MINIMUM_SIZE == nil do GET_CUSTOM_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_custom_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_CUSTOM_MINIMUM_SIZE, Control, nil, r_ret)
}

get_parent_area_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_PARENT_AREA_SIZE: GDE.MethodBindPtr
    if GET_PARENT_AREA_SIZE == nil do GET_PARENT_AREA_SIZE = classDBGetMethodBind("Control", "get_parent_area_size", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_PARENT_AREA_SIZE, Control, nil, r_ret)
}

get_global_position :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_GLOBAL_POSITION: GDE.MethodBindPtr
    if GET_GLOBAL_POSITION == nil do GET_GLOBAL_POSITION = classDBGetMethodBind("Control", "get_global_position", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_GLOBAL_POSITION, Control, nil, r_ret)
}

get_screen_position :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GET_SCREEN_POSITION: GDE.MethodBindPtr
    if GET_SCREEN_POSITION == nil do GET_SCREEN_POSITION = classDBGetMethodBind("Control", "get_screen_position", 3341600327)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_SCREEN_POSITION, Control, nil, r_ret)
}

get_rect :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Rec2) {
    context = runtime.default_context()
    @(static)GET_RECT: GDE.MethodBindPtr
    if GET_RECT == nil do GET_RECT = classDBGetMethodBind("Control", "get_rect", 1639390495)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_RECT, Control, nil, r_ret)
}

get_global_rect :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Rec2) {
    context = runtime.default_context()
    @(static)GET_GLOBAL_RECT: GDE.MethodBindPtr
    if GET_GLOBAL_RECT == nil do GET_GLOBAL_RECT = classDBGetMethodBind("Control", "get_global_rect", 1639390495)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_GLOBAL_RECT, Control, nil, r_ret)
}

set_focus_mode :: proc "c" (Control: GDE.ObjectPtr, mode: ^FocusMode) {
    context = runtime.default_context()
    @(static)SET_FOCUS_MODE: GDE.MethodBindPtr
    if SET_FOCUS_MODE == nil do SET_FOCUS_MODE = classDBGetMethodBind("Control", "set_focus_mode", 3232914922)
    assert(Control != nil)
    args:= [?]rawptr { mode }
    gdAPI.objectMethodBindPtrCall(SET_FOCUS_MODE, Control, raw_data(args[:]), nil)
}

get_focus_mode :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^FocusMode) {
    context = runtime.default_context()
    @(static)GET_FOCUS_MODE: GDE.MethodBindPtr
    if GET_FOCUS_MODE == nil do GET_FOCUS_MODE = classDBGetMethodBind("Control", "get_focus_mode", 2132829277)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_FOCUS_MODE, Control, nil, r_ret)
}

has_focus :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_FOCUS: GDE.MethodBindPtr
    if HAS_FOCUS == nil do HAS_FOCUS = classDBGetMethodBind("Control", "has_focus", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(HAS_FOCUS, Control, nil, r_ret)
}

grab_focus :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GRAB_FOCUS: GDE.MethodBindPtr
    if GRAB_FOCUS == nil do GRAB_FOCUS = classDBGetMethodBind("Control", "grab_focus", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GRAB_FOCUS, Control, nil, nil)
}

release_focus :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)RELEASE_FOCUS: GDE.MethodBindPtr
    if RELEASE_FOCUS == nil do RELEASE_FOCUS = classDBGetMethodBind("Control", "release_focus", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(RELEASE_FOCUS, Control, nil, nil)
}

find_prev_valid_focus :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)FIND_PREV_VALID_FOCUS: GDE.MethodBindPtr
    if FIND_PREV_VALID_FOCUS == nil do FIND_PREV_VALID_FOCUS = classDBGetMethodBind("Control", "find_prev_valid_focus", 2783021301)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(FIND_PREV_VALID_FOCUS, Control, nil, r_ret)
}

find_next_valid_focus :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)FIND_NEXT_VALID_FOCUS: GDE.MethodBindPtr
    if FIND_NEXT_VALID_FOCUS == nil do FIND_NEXT_VALID_FOCUS = classDBGetMethodBind("Control", "find_next_valid_focus", 2783021301)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(FIND_NEXT_VALID_FOCUS, Control, nil, r_ret)
}

find_valid_focus_neighbor :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)FIND_VALID_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if FIND_VALID_FOCUS_NEIGHBOR == nil do FIND_VALID_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "find_valid_focus_neighbor", 1543910170)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.objectMethodBindPtrCall(FIND_VALID_FOCUS_NEIGHBOR, Control, raw_data(args[:]), r_ret)
}

set_h_size_flags :: proc "c" (Control: GDE.ObjectPtr, flags: ^SizeFlags) {
    context = runtime.default_context()
    @(static)SET_H_SIZE_FLAGS: GDE.MethodBindPtr
    if SET_H_SIZE_FLAGS == nil do SET_H_SIZE_FLAGS = classDBGetMethodBind("Control", "set_h_size_flags", 394851643)
    assert(Control != nil)
    args:= [?]rawptr { flags }
    gdAPI.objectMethodBindPtrCall(SET_H_SIZE_FLAGS, Control, raw_data(args[:]), nil)
}

get_h_size_flags :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^SizeFlags) {
    context = runtime.default_context()
    @(static)GET_H_SIZE_FLAGS: GDE.MethodBindPtr
    if GET_H_SIZE_FLAGS == nil do GET_H_SIZE_FLAGS = classDBGetMethodBind("Control", "get_h_size_flags", 3781367401)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_H_SIZE_FLAGS, Control, nil, r_ret)
}


//Meta of ratio : float
set_stretch_ratio :: proc "c" (Control: GDE.ObjectPtr, ratio: ^GDE.float) {
    context = runtime.default_context()
    @(static)SET_STRETCH_RATIO: GDE.MethodBindPtr
    if SET_STRETCH_RATIO == nil do SET_STRETCH_RATIO = classDBGetMethodBind("Control", "set_stretch_ratio", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { ratio }
    gdAPI.objectMethodBindPtrCall(SET_STRETCH_RATIO, Control, raw_data(args[:]), nil)
}

get_stretch_ratio :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_STRETCH_RATIO: GDE.MethodBindPtr
    if GET_STRETCH_RATIO == nil do GET_STRETCH_RATIO = classDBGetMethodBind("Control", "get_stretch_ratio", 1740695150)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_STRETCH_RATIO, Control, nil, r_ret)
}

set_v_size_flags :: proc "c" (Control: GDE.ObjectPtr, flags: ^SizeFlags) {
    context = runtime.default_context()
    @(static)SET_V_SIZE_FLAGS: GDE.MethodBindPtr
    if SET_V_SIZE_FLAGS == nil do SET_V_SIZE_FLAGS = classDBGetMethodBind("Control", "set_v_size_flags", 394851643)
    assert(Control != nil)
    args:= [?]rawptr { flags }
    gdAPI.objectMethodBindPtrCall(SET_V_SIZE_FLAGS, Control, raw_data(args[:]), nil)
}

get_v_size_flags :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^SizeFlags) {
    context = runtime.default_context()
    @(static)GET_V_SIZE_FLAGS: GDE.MethodBindPtr
    if GET_V_SIZE_FLAGS == nil do GET_V_SIZE_FLAGS = classDBGetMethodBind("Control", "get_v_size_flags", 3781367401)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_V_SIZE_FLAGS, Control, nil, r_ret)
}

set_theme :: proc "c" (Control: GDE.ObjectPtr, theme: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)SET_THEME: GDE.MethodBindPtr
    if SET_THEME == nil do SET_THEME = classDBGetMethodBind("Control", "set_theme", 2326690814)
    assert(Control != nil)
    args:= [?]rawptr { theme }
    gdAPI.objectMethodBindPtrCall(SET_THEME, Control, raw_data(args[:]), nil)
}

get_theme :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_THEME: GDE.MethodBindPtr
    if GET_THEME == nil do GET_THEME = classDBGetMethodBind("Control", "get_theme", 3846893731)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_THEME, Control, nil, r_ret)
}

set_theme_type_variation :: proc "c" (Control: GDE.ObjectPtr, theme_type: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)SET_THEME_TYPE_VARIATION: GDE.MethodBindPtr
    if SET_THEME_TYPE_VARIATION == nil do SET_THEME_TYPE_VARIATION = classDBGetMethodBind("Control", "set_theme_type_variation", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { theme_type }
    gdAPI.objectMethodBindPtrCall(SET_THEME_TYPE_VARIATION, Control, raw_data(args[:]), nil)
}

get_theme_type_variation :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)GET_THEME_TYPE_VARIATION: GDE.MethodBindPtr
    if GET_THEME_TYPE_VARIATION == nil do GET_THEME_TYPE_VARIATION = classDBGetMethodBind("Control", "get_theme_type_variation", 2002593661)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_THEME_TYPE_VARIATION, Control, nil, r_ret)
}

begin_bulk_theme_override :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)BEGIN_BULK_THEME_OVERRIDE: GDE.MethodBindPtr
    if BEGIN_BULK_THEME_OVERRIDE == nil do BEGIN_BULK_THEME_OVERRIDE = classDBGetMethodBind("Control", "begin_bulk_theme_override", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(BEGIN_BULK_THEME_OVERRIDE, Control, nil, nil)
}

end_bulk_theme_override :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)END_BULK_THEME_OVERRIDE: GDE.MethodBindPtr
    if END_BULK_THEME_OVERRIDE == nil do END_BULK_THEME_OVERRIDE = classDBGetMethodBind("Control", "end_bulk_theme_override", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(END_BULK_THEME_OVERRIDE, Control, nil, nil)
}

add_theme_icon_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, texture: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)ADD_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_ICON_OVERRIDE == nil do ADD_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "add_theme_icon_override", 1373065600)
    assert(Control != nil)
    args:= [?]rawptr { name, texture }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_stylebox_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, stylebox: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)ADD_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_STYLEBOX_OVERRIDE == nil do ADD_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "add_theme_stylebox_override", 4188838905)
    assert(Control != nil)
    args:= [?]rawptr { name, stylebox }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_font_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, font: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)ADD_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_FONT_OVERRIDE == nil do ADD_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "add_theme_font_override", 3518018674)
    assert(Control != nil)
    args:= [?]rawptr { name, font }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), nil)
}


//Meta of font_size : int32
add_theme_font_size_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, font_size: ^GDE.Int) {
    context = runtime.default_context()
    @(static)ADD_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_FONT_SIZE_OVERRIDE == nil do ADD_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "add_theme_font_size_override", 2415702435)
    assert(Control != nil)
    args:= [?]rawptr { name, font_size }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_color_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, color: ^GDE.Color) {
    context = runtime.default_context()
    @(static)ADD_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_COLOR_OVERRIDE == nil do ADD_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "add_theme_color_override", 4260178595)
    assert(Control != nil)
    args:= [?]rawptr { name, color }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), nil)
}


//Meta of constant : int32
add_theme_constant_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, constant: ^GDE.Int) {
    context = runtime.default_context()
    @(static)ADD_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_CONSTANT_OVERRIDE == nil do ADD_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "add_theme_constant_override", 2415702435)
    assert(Control != nil)
    args:= [?]rawptr { name, constant }
    gdAPI.objectMethodBindPtrCall(ADD_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_icon_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_ICON_OVERRIDE == nil do REMOVE_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_icon_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_stylebox_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_STYLEBOX_OVERRIDE == nil do REMOVE_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_stylebox_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_font_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_FONT_OVERRIDE == nil do REMOVE_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_font_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_font_size_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_FONT_SIZE_OVERRIDE == nil do REMOVE_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_font_size_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_color_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_COLOR_OVERRIDE == nil do REMOVE_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_color_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_constant_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    context = runtime.default_context()
    @(static)REMOVE_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_CONSTANT_OVERRIDE == nil do REMOVE_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_constant_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(REMOVE_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), nil)
}


//default of theme_type : &\"\"
get_theme_icon :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_THEME_ICON: GDE.MethodBindPtr
    if GET_THEME_ICON == nil do GET_THEME_ICON = classDBGetMethodBind("Control", "get_theme_icon", 3163973443)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_ICON, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_stylebox :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_THEME_STYLEBOX: GDE.MethodBindPtr
    if GET_THEME_STYLEBOX == nil do GET_THEME_STYLEBOX = classDBGetMethodBind("Control", "get_theme_stylebox", 604739069)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_STYLEBOX, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_font :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_THEME_FONT: GDE.MethodBindPtr
    if GET_THEME_FONT == nil do GET_THEME_FONT = classDBGetMethodBind("Control", "get_theme_font", 2826986490)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_FONT, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_font_size :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Int) {
    context = runtime.default_context()
    @(static)GET_THEME_FONT_SIZE: GDE.MethodBindPtr
    if GET_THEME_FONT_SIZE == nil do GET_THEME_FONT_SIZE = classDBGetMethodBind("Control", "get_theme_font_size", 1327056374)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_FONT_SIZE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_color :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Color) {
    context = runtime.default_context()
    @(static)GET_THEME_COLOR: GDE.MethodBindPtr
    if GET_THEME_COLOR == nil do GET_THEME_COLOR = classDBGetMethodBind("Control", "get_theme_color", 2798751242)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_COLOR, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_constant :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Int) {
    context = runtime.default_context()
    @(static)GET_THEME_CONSTANT: GDE.MethodBindPtr
    if GET_THEME_CONSTANT == nil do GET_THEME_CONSTANT = classDBGetMethodBind("Control", "get_theme_constant", 1327056374)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(GET_THEME_CONSTANT, Control, raw_data(args[:]), r_ret)
}

has_theme_icon_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_ICON_OVERRIDE == nil do HAS_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "has_theme_icon_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_stylebox_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_STYLEBOX_OVERRIDE == nil do HAS_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "has_theme_stylebox_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_font_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_FONT_OVERRIDE == nil do HAS_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "has_theme_font_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_font_size_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_FONT_SIZE_OVERRIDE == nil do HAS_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "has_theme_font_size_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_color_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_COLOR_OVERRIDE == nil do HAS_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "has_theme_color_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_constant_override :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_CONSTANT_OVERRIDE == nil do HAS_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "has_theme_constant_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_icon :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_ICON: GDE.MethodBindPtr
    if HAS_THEME_ICON == nil do HAS_THEME_ICON = classDBGetMethodBind("Control", "has_theme_icon", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_ICON, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_stylebox :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_STYLEBOX: GDE.MethodBindPtr
    if HAS_THEME_STYLEBOX == nil do HAS_THEME_STYLEBOX = classDBGetMethodBind("Control", "has_theme_stylebox", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_STYLEBOX, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_font :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_FONT: GDE.MethodBindPtr
    if HAS_THEME_FONT == nil do HAS_THEME_FONT = classDBGetMethodBind("Control", "has_theme_font", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_FONT, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_font_size :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_FONT_SIZE: GDE.MethodBindPtr
    if HAS_THEME_FONT_SIZE == nil do HAS_THEME_FONT_SIZE = classDBGetMethodBind("Control", "has_theme_font_size", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_FONT_SIZE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_color :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_COLOR: GDE.MethodBindPtr
    if HAS_THEME_COLOR == nil do HAS_THEME_COLOR = classDBGetMethodBind("Control", "has_theme_color", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_COLOR, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_constant :: proc "c" (Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)HAS_THEME_CONSTANT: GDE.MethodBindPtr
    if HAS_THEME_CONSTANT == nil do HAS_THEME_CONSTANT = classDBGetMethodBind("Control", "has_theme_constant", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.objectMethodBindPtrCall(HAS_THEME_CONSTANT, Control, raw_data(args[:]), r_ret)
}

get_theme_default_base_scale :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    context = runtime.default_context()
    @(static)GET_THEME_DEFAULT_BASE_SCALE: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_BASE_SCALE == nil do GET_THEME_DEFAULT_BASE_SCALE = classDBGetMethodBind("Control", "get_theme_default_base_scale", 1740695150)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_THEME_DEFAULT_BASE_SCALE, Control, nil, r_ret)
}

get_theme_default_font :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_THEME_DEFAULT_FONT: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_FONT == nil do GET_THEME_DEFAULT_FONT = classDBGetMethodBind("Control", "get_theme_default_font", 3229501585)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_THEME_DEFAULT_FONT, Control, nil, r_ret)
}

get_theme_default_font_size :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Int) {
    context = runtime.default_context()
    @(static)GET_THEME_DEFAULT_FONT_SIZE: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_FONT_SIZE == nil do GET_THEME_DEFAULT_FONT_SIZE = classDBGetMethodBind("Control", "get_theme_default_font_size", 3905245786)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_THEME_DEFAULT_FONT_SIZE, Control, nil, r_ret)
}

get_parent_control :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_PARENT_CONTROL: GDE.MethodBindPtr
    if GET_PARENT_CONTROL == nil do GET_PARENT_CONTROL = classDBGetMethodBind("Control", "get_parent_control", 2783021301)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_PARENT_CONTROL, Control, nil, r_ret)
}

set_h_grow_direction :: proc "c" (Control: GDE.ObjectPtr, direction: ^GrowDirection) {
    context = runtime.default_context()
    @(static)SET_H_GROW_DIRECTION: GDE.MethodBindPtr
    if SET_H_GROW_DIRECTION == nil do SET_H_GROW_DIRECTION = classDBGetMethodBind("Control", "set_h_grow_direction", 2022385301)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.objectMethodBindPtrCall(SET_H_GROW_DIRECTION, Control, raw_data(args[:]), nil)
}

get_h_grow_direction :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GrowDirection) {
    context = runtime.default_context()
    @(static)GET_H_GROW_DIRECTION: GDE.MethodBindPtr
    if GET_H_GROW_DIRECTION == nil do GET_H_GROW_DIRECTION = classDBGetMethodBind("Control", "get_h_grow_direction", 3635610155)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_H_GROW_DIRECTION, Control, nil, r_ret)
}

set_v_grow_direction :: proc "c" (Control: GDE.ObjectPtr, direction: ^GrowDirection) {
    context = runtime.default_context()
    @(static)SET_V_GROW_DIRECTION: GDE.MethodBindPtr
    if SET_V_GROW_DIRECTION == nil do SET_V_GROW_DIRECTION = classDBGetMethodBind("Control", "set_v_grow_direction", 2022385301)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.objectMethodBindPtrCall(SET_V_GROW_DIRECTION, Control, raw_data(args[:]), nil)
}

get_v_grow_direction :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GrowDirection) {
    context = runtime.default_context()
    @(static)GET_V_GROW_DIRECTION: GDE.MethodBindPtr
    if GET_V_GROW_DIRECTION == nil do GET_V_GROW_DIRECTION = classDBGetMethodBind("Control", "get_v_grow_direction", 3635610155)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_V_GROW_DIRECTION, Control, nil, r_ret)
}

set_tooltip_auto_translate_mode :: proc "c" (Control: GDE.ObjectPtr, mode: ^AutoTranslateMode) {
    context = runtime.default_context()
    @(static)SET_TOOLTIP_AUTO_TRANSLATE_MODE: GDE.MethodBindPtr
    if SET_TOOLTIP_AUTO_TRANSLATE_MODE == nil do SET_TOOLTIP_AUTO_TRANSLATE_MODE = classDBGetMethodBind("Control", "set_tooltip_auto_translate_mode", 776149714)
    assert(Control != nil)
    args:= [?]rawptr { mode }
    gdAPI.objectMethodBindPtrCall(SET_TOOLTIP_AUTO_TRANSLATE_MODE, Control, raw_data(args[:]), nil)
}

get_tooltip_auto_translate_mode :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^AutoTranslateMode) {
    context = runtime.default_context()
    @(static)GET_TOOLTIP_AUTO_TRANSLATE_MODE: GDE.MethodBindPtr
    if GET_TOOLTIP_AUTO_TRANSLATE_MODE == nil do GET_TOOLTIP_AUTO_TRANSLATE_MODE = classDBGetMethodBind("Control", "get_tooltip_auto_translate_mode", 2498906432)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_TOOLTIP_AUTO_TRANSLATE_MODE, Control, nil, r_ret)
}

set_tooltip_text :: proc "c" (Control: GDE.ObjectPtr, hint: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)SET_TOOLTIP_TEXT: GDE.MethodBindPtr
    if SET_TOOLTIP_TEXT == nil do SET_TOOLTIP_TEXT = classDBGetMethodBind("Control", "set_tooltip_text", 83702148)
    assert(Control != nil)
    args:= [?]rawptr { hint }
    gdAPI.objectMethodBindPtrCall(SET_TOOLTIP_TEXT, Control, raw_data(args[:]), nil)
}

get_tooltip_text :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)GET_TOOLTIP_TEXT: GDE.MethodBindPtr
    if GET_TOOLTIP_TEXT == nil do GET_TOOLTIP_TEXT = classDBGetMethodBind("Control", "get_tooltip_text", 201670096)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_TOOLTIP_TEXT, Control, nil, r_ret)
}


//default of at_position : Vector2(0, 0)
get_tooltip :: proc "c" (Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.gdstring) {
    context = runtime.default_context()
    @(static)GET_TOOLTIP: GDE.MethodBindPtr
    if GET_TOOLTIP == nil do GET_TOOLTIP = classDBGetMethodBind("Control", "get_tooltip", 2895288280)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.objectMethodBindPtrCall(GET_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

set_default_cursor_shape :: proc "c" (Control: GDE.ObjectPtr, shape: ^CursorShape) {
    context = runtime.default_context()
    @(static)SET_DEFAULT_CURSOR_SHAPE: GDE.MethodBindPtr
    if SET_DEFAULT_CURSOR_SHAPE == nil do SET_DEFAULT_CURSOR_SHAPE = classDBGetMethodBind("Control", "set_default_cursor_shape", 217062046)
    assert(Control != nil)
    args:= [?]rawptr { shape }
    gdAPI.objectMethodBindPtrCall(SET_DEFAULT_CURSOR_SHAPE, Control, raw_data(args[:]), nil)
}

get_default_cursor_shape :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^CursorShape) {
    context = runtime.default_context()
    @(static)GET_DEFAULT_CURSOR_SHAPE: GDE.MethodBindPtr
    if GET_DEFAULT_CURSOR_SHAPE == nil do GET_DEFAULT_CURSOR_SHAPE = classDBGetMethodBind("Control", "get_default_cursor_shape", 2359535750)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_DEFAULT_CURSOR_SHAPE, Control, nil, r_ret)
}


//default of position : Vector2(0, 0)
get_cursor_shape :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2, r_ret: ^CursorShape) {
    context = runtime.default_context()
    @(static)GET_CURSOR_SHAPE: GDE.MethodBindPtr
    if GET_CURSOR_SHAPE == nil do GET_CURSOR_SHAPE = classDBGetMethodBind("Control", "get_cursor_shape", 1395773853)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.objectMethodBindPtrCall(GET_CURSOR_SHAPE, Control, raw_data(args[:]), r_ret)
}

set_focus_neighbor :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, neighbor: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)SET_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if SET_FOCUS_NEIGHBOR == nil do SET_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "set_focus_neighbor", 2024461774)
    assert(Control != nil)
    args:= [?]rawptr { side, neighbor }
    gdAPI.objectMethodBindPtrCall(SET_FOCUS_NEIGHBOR, Control, raw_data(args[:]), nil)
}

get_focus_neighbor :: proc "c" (Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)GET_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if GET_FOCUS_NEIGHBOR == nil do GET_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "get_focus_neighbor", 2757935761)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.objectMethodBindPtrCall(GET_FOCUS_NEIGHBOR, Control, raw_data(args[:]), r_ret)
}

set_focus_next :: proc "c" (Control: GDE.ObjectPtr, next: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)SET_FOCUS_NEXT: GDE.MethodBindPtr
    if SET_FOCUS_NEXT == nil do SET_FOCUS_NEXT = classDBGetMethodBind("Control", "set_focus_next", 1348162250)
    assert(Control != nil)
    args:= [?]rawptr { next }
    gdAPI.objectMethodBindPtrCall(SET_FOCUS_NEXT, Control, raw_data(args[:]), nil)
}

get_focus_next :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)GET_FOCUS_NEXT: GDE.MethodBindPtr
    if GET_FOCUS_NEXT == nil do GET_FOCUS_NEXT = classDBGetMethodBind("Control", "get_focus_next", 4075236667)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_FOCUS_NEXT, Control, nil, r_ret)
}

set_focus_previous :: proc "c" (Control: GDE.ObjectPtr, previous: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)SET_FOCUS_PREVIOUS: GDE.MethodBindPtr
    if SET_FOCUS_PREVIOUS == nil do SET_FOCUS_PREVIOUS = classDBGetMethodBind("Control", "set_focus_previous", 1348162250)
    assert(Control != nil)
    args:= [?]rawptr { previous }
    gdAPI.objectMethodBindPtrCall(SET_FOCUS_PREVIOUS, Control, raw_data(args[:]), nil)
}

get_focus_previous :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.NodePath) {
    context = runtime.default_context()
    @(static)GET_FOCUS_PREVIOUS: GDE.MethodBindPtr
    if GET_FOCUS_PREVIOUS == nil do GET_FOCUS_PREVIOUS = classDBGetMethodBind("Control", "get_focus_previous", 4075236667)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_FOCUS_PREVIOUS, Control, nil, r_ret)
}

force_drag :: proc "c" (Control: GDE.ObjectPtr, data: ^GDE.Variant, preview: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)FORCE_DRAG: GDE.MethodBindPtr
    if FORCE_DRAG == nil do FORCE_DRAG = classDBGetMethodBind("Control", "force_drag", 3191844692)
    assert(Control != nil)
    args:= [?]rawptr { data, preview }
    gdAPI.objectMethodBindPtrCall(FORCE_DRAG, Control, raw_data(args[:]), nil)
}

set_mouse_filter :: proc "c" (Control: GDE.ObjectPtr, filter: ^MouseFilter) {
    context = runtime.default_context()
    @(static)SET_MOUSE_FILTER: GDE.MethodBindPtr
    if SET_MOUSE_FILTER == nil do SET_MOUSE_FILTER = classDBGetMethodBind("Control", "set_mouse_filter", 3891156122)
    assert(Control != nil)
    args:= [?]rawptr { filter }
    gdAPI.objectMethodBindPtrCall(SET_MOUSE_FILTER, Control, raw_data(args[:]), nil)
}

get_mouse_filter :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^MouseFilter) {
    context = runtime.default_context()
    @(static)GET_MOUSE_FILTER: GDE.MethodBindPtr
    if GET_MOUSE_FILTER == nil do GET_MOUSE_FILTER = classDBGetMethodBind("Control", "get_mouse_filter", 1572545674)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_MOUSE_FILTER, Control, nil, r_ret)
}

set_force_pass_scroll_events :: proc "c" (Control: GDE.ObjectPtr, force_pass_scroll_events: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_FORCE_PASS_SCROLL_EVENTS: GDE.MethodBindPtr
    if SET_FORCE_PASS_SCROLL_EVENTS == nil do SET_FORCE_PASS_SCROLL_EVENTS = classDBGetMethodBind("Control", "set_force_pass_scroll_events", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { force_pass_scroll_events }
    gdAPI.objectMethodBindPtrCall(SET_FORCE_PASS_SCROLL_EVENTS, Control, raw_data(args[:]), nil)
}

is_force_pass_scroll_events :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_FORCE_PASS_SCROLL_EVENTS: GDE.MethodBindPtr
    if IS_FORCE_PASS_SCROLL_EVENTS == nil do IS_FORCE_PASS_SCROLL_EVENTS = classDBGetMethodBind("Control", "is_force_pass_scroll_events", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_FORCE_PASS_SCROLL_EVENTS, Control, nil, r_ret)
}

set_clip_contents :: proc "c" (Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_CLIP_CONTENTS: GDE.MethodBindPtr
    if SET_CLIP_CONTENTS == nil do SET_CLIP_CONTENTS = classDBGetMethodBind("Control", "set_clip_contents", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.objectMethodBindPtrCall(SET_CLIP_CONTENTS, Control, raw_data(args[:]), nil)
}

is_clipping_contents :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_CLIPPING_CONTENTS: GDE.MethodBindPtr
    if IS_CLIPPING_CONTENTS == nil do IS_CLIPPING_CONTENTS = classDBGetMethodBind("Control", "is_clipping_contents", 2240911060)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_CLIPPING_CONTENTS, Control, nil, r_ret)
}

grab_click_focus :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GRAB_CLICK_FOCUS: GDE.MethodBindPtr
    if GRAB_CLICK_FOCUS == nil do GRAB_CLICK_FOCUS = classDBGetMethodBind("Control", "grab_click_focus", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GRAB_CLICK_FOCUS, Control, nil, nil)
}

set_drag_forwarding :: proc "c" (Control: GDE.ObjectPtr, drag_func: ^GDE.Callable, can_drop_func: ^GDE.Callable, drop_func: ^GDE.Callable) {
    context = runtime.default_context()
    @(static)SET_DRAG_FORWARDING: GDE.MethodBindPtr
    if SET_DRAG_FORWARDING == nil do SET_DRAG_FORWARDING = classDBGetMethodBind("Control", "set_drag_forwarding", 1076571380)
    assert(Control != nil)
    args:= [?]rawptr { drag_func, can_drop_func, drop_func }
    gdAPI.objectMethodBindPtrCall(SET_DRAG_FORWARDING, Control, raw_data(args[:]), nil)
}

set_drag_preview :: proc "c" (Control: GDE.ObjectPtr, control: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)SET_DRAG_PREVIEW: GDE.MethodBindPtr
    if SET_DRAG_PREVIEW == nil do SET_DRAG_PREVIEW = classDBGetMethodBind("Control", "set_drag_preview", 1496901182)
    assert(Control != nil)
    args:= [?]rawptr { control }
    gdAPI.objectMethodBindPtrCall(SET_DRAG_PREVIEW, Control, raw_data(args[:]), nil)
}

is_drag_successful :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_DRAG_SUCCESSFUL: GDE.MethodBindPtr
    if IS_DRAG_SUCCESSFUL == nil do IS_DRAG_SUCCESSFUL = classDBGetMethodBind("Control", "is_drag_successful", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_DRAG_SUCCESSFUL, Control, nil, r_ret)
}

warp_mouse :: proc "c" (Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)WARP_MOUSE: GDE.MethodBindPtr
    if WARP_MOUSE == nil do WARP_MOUSE = classDBGetMethodBind("Control", "warp_mouse", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.objectMethodBindPtrCall(WARP_MOUSE, Control, raw_data(args[:]), nil)
}

set_shortcut_context :: proc "c" (Control: GDE.ObjectPtr, node: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)SET_SHORTCUT_CONTEXT: GDE.MethodBindPtr
    if SET_SHORTCUT_CONTEXT == nil do SET_SHORTCUT_CONTEXT = classDBGetMethodBind("Control", "set_shortcut_context", 1078189570)
    assert(Control != nil)
    args:= [?]rawptr { node }
    gdAPI.objectMethodBindPtrCall(SET_SHORTCUT_CONTEXT, Control, raw_data(args[:]), nil)
}

get_shortcut_context :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)GET_SHORTCUT_CONTEXT: GDE.MethodBindPtr
    if GET_SHORTCUT_CONTEXT == nil do GET_SHORTCUT_CONTEXT = classDBGetMethodBind("Control", "get_shortcut_context", 3160264692)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_SHORTCUT_CONTEXT, Control, nil, r_ret)
}

update_minimum_size :: proc "c" (Control: GDE.ObjectPtr) {
    context = runtime.default_context()
    @(static)UPDATE_MINIMUM_SIZE: GDE.MethodBindPtr
    if UPDATE_MINIMUM_SIZE == nil do UPDATE_MINIMUM_SIZE = classDBGetMethodBind("Control", "update_minimum_size", 321895971)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(UPDATE_MINIMUM_SIZE, Control, nil, nil)
}

set_layout_direction :: proc "c" (Control: GDE.ObjectPtr, direction: ^LayoutDirection) {
    context = runtime.default_context()
    @(static)SET_LAYOUT_DIRECTION: GDE.MethodBindPtr
    if SET_LAYOUT_DIRECTION == nil do SET_LAYOUT_DIRECTION = classDBGetMethodBind("Control", "set_layout_direction", 3310692370)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.objectMethodBindPtrCall(SET_LAYOUT_DIRECTION, Control, raw_data(args[:]), nil)
}

get_layout_direction :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^LayoutDirection) {
    context = runtime.default_context()
    @(static)GET_LAYOUT_DIRECTION: GDE.MethodBindPtr
    if GET_LAYOUT_DIRECTION == nil do GET_LAYOUT_DIRECTION = classDBGetMethodBind("Control", "get_layout_direction", 1546772008)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(GET_LAYOUT_DIRECTION, Control, nil, r_ret)
}

is_layout_rtl :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_LAYOUT_RTL: GDE.MethodBindPtr
    if IS_LAYOUT_RTL == nil do IS_LAYOUT_RTL = classDBGetMethodBind("Control", "is_layout_rtl", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_LAYOUT_RTL, Control, nil, r_ret)
}

set_auto_translate :: proc "c" (Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_AUTO_TRANSLATE: GDE.MethodBindPtr
    if SET_AUTO_TRANSLATE == nil do SET_AUTO_TRANSLATE = classDBGetMethodBind("Control", "set_auto_translate", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.objectMethodBindPtrCall(SET_AUTO_TRANSLATE, Control, raw_data(args[:]), nil)
}

is_auto_translating :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_AUTO_TRANSLATING: GDE.MethodBindPtr
    if IS_AUTO_TRANSLATING == nil do IS_AUTO_TRANSLATING = classDBGetMethodBind("Control", "is_auto_translating", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_AUTO_TRANSLATING, Control, nil, r_ret)
}

set_localize_numeral_system :: proc "c" (Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)SET_LOCALIZE_NUMERAL_SYSTEM: GDE.MethodBindPtr
    if SET_LOCALIZE_NUMERAL_SYSTEM == nil do SET_LOCALIZE_NUMERAL_SYSTEM = classDBGetMethodBind("Control", "set_localize_numeral_system", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.objectMethodBindPtrCall(SET_LOCALIZE_NUMERAL_SYSTEM, Control, raw_data(args[:]), nil)
}

is_localizing_numeral_system :: proc "c" (Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    context = runtime.default_context()
    @(static)IS_LOCALIZING_NUMERAL_SYSTEM: GDE.MethodBindPtr
    if IS_LOCALIZING_NUMERAL_SYSTEM == nil do IS_LOCALIZING_NUMERAL_SYSTEM = classDBGetMethodBind("Control", "is_localizing_numeral_system", 36873697)
    assert(Control != nil)
    gdAPI.objectMethodBindPtrCall(IS_LOCALIZING_NUMERAL_SYSTEM, Control, nil, r_ret)
}

ControlSignals :: enum {
    resized, // = "resized",
    gui_input, // = "gui_input",//Args //name: GDE.ObjectPtr
    mouse_entered, // = "mouse_entered",//Args //name: GDE.ObjectPtr //name: GDE.ObjectPtr
    mouse_exited, // = "mouse_exited",
    focus_entered, // = "focus_entered",
    focus_exited, // = "focus_exited",
    size_flags_changed, // = "size_flags_changed",
    minimum_size_changed, // = "minimum_size_changed",
    theme_changed, // = "theme_changed",
}