//#+ignore
package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
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

_has_point :: proc(Control: GDE.ObjectPtr, point: ^GDE.Vector2, r_ret: ^GDE.Bool) {
    @(static)_HAS_POINT: GDE.MethodBindPtr
    if _HAS_POINT == nil do _HAS_POINT = classDBGetMethodBind("Control", "_has_point", 556197845)
    assert(Control != nil)
    args:= [?]rawptr { point }
    gdAPI.Object_Utils.MethodBindPtrcall(_HAS_POINT, Control, raw_data(args[:]), r_ret)
}

_structured_text_parser :: proc(Control: GDE.ObjectPtr, args: ^GDE.Array, text: ^GDE.gdstring, r_ret: ^GDE.ObjectPtr) {
    @(static)_STRUCTURED_TEXT_PARSER: GDE.MethodBindPtr
    if _STRUCTURED_TEXT_PARSER == nil do _STRUCTURED_TEXT_PARSER = classDBGetMethodBind("Control", "_structured_text_parser", 1292548940)
    assert(Control != nil)
    args:= [?]rawptr { args, text }
    gdAPI.Object_Utils.MethodBindPtrcall(_STRUCTURED_TEXT_PARSER, Control, raw_data(args[:]), r_ret)
}

_get_minimum_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)_GET_MINIMUM_SIZE: GDE.MethodBindPtr
    if _GET_MINIMUM_SIZE == nil do _GET_MINIMUM_SIZE = classDBGetMethodBind("Control", "_get_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(_GET_MINIMUM_SIZE, Control, nil, r_ret)
}

_get_tooltip :: proc(Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.gdstring) {
    @(static)_GET_TOOLTIP: GDE.MethodBindPtr
    if _GET_TOOLTIP == nil do _GET_TOOLTIP = classDBGetMethodBind("Control", "_get_tooltip", 3674420000)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.Object_Utils.MethodBindPtrcall(_GET_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

_get_drag_data :: proc(Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.Variant) {
    @(static)_GET_DRAG_DATA: GDE.MethodBindPtr
    if _GET_DRAG_DATA == nil do _GET_DRAG_DATA = classDBGetMethodBind("Control", "_get_drag_data", 2233896889)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.Object_Utils.MethodBindPtrcall(_GET_DRAG_DATA, Control, raw_data(args[:]), r_ret)
}

_can_drop_data :: proc(Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, data: ^GDE.Variant, r_ret: ^GDE.Bool) {
    @(static)_CAN_DROP_DATA: GDE.MethodBindPtr
    if _CAN_DROP_DATA == nil do _CAN_DROP_DATA = classDBGetMethodBind("Control", "_can_drop_data", 2603004011)
    assert(Control != nil)
    args:= [?]rawptr { at_position, data }
    gdAPI.Object_Utils.MethodBindPtrcall(_CAN_DROP_DATA, Control, raw_data(args[:]), r_ret)
}

_drop_data :: proc(Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, data: ^GDE.Variant) {
    @(static)_DROP_DATA: GDE.MethodBindPtr
    if _DROP_DATA == nil do _DROP_DATA = classDBGetMethodBind("Control", "_drop_data", 3699746064)
    assert(Control != nil)
    args:= [?]rawptr { at_position, data }
    gdAPI.Object_Utils.MethodBindPtrcall(_DROP_DATA, Control, raw_data(args[:]), nil)
}

_make_custom_tooltip :: proc(Control: GDE.ObjectPtr, for_text: ^GDE.gdstring, r_ret: ^GDE.Object) {
    @(static)_MAKE_CUSTOM_TOOLTIP: GDE.MethodBindPtr
    if _MAKE_CUSTOM_TOOLTIP == nil do _MAKE_CUSTOM_TOOLTIP = classDBGetMethodBind("Control", "_make_custom_tooltip", 1976279298)
    assert(Control != nil)
    args:= [?]rawptr { for_text }
    gdAPI.Object_Utils.MethodBindPtrcall(_MAKE_CUSTOM_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

_gui_input :: proc(Control: GDE.ObjectPtr, event: ^GDE.ObjectPtr) {
    @(static)_GUI_INPUT: GDE.MethodBindPtr
    if _GUI_INPUT == nil do _GUI_INPUT = classDBGetMethodBind("Control", "_gui_input", 3754044979)
    assert(Control != nil)
    args:= [?]rawptr { event }
    gdAPI.Object_Utils.MethodBindPtrcall(_GUI_INPUT, Control, raw_data(args[:]), nil)
}

accept_event :: proc(Control: GDE.ObjectPtr) {
    @(static)ACCEPT_EVENT: GDE.MethodBindPtr
    if ACCEPT_EVENT == nil do ACCEPT_EVENT = classDBGetMethodBind("Control", "accept_event", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(ACCEPT_EVENT, Control, nil, nil)
}

get_minimum_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_MINIMUM_SIZE == nil do GET_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_MINIMUM_SIZE, Control, nil, r_ret)
}

get_combined_minimum_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_COMBINED_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_COMBINED_MINIMUM_SIZE == nil do GET_COMBINED_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_combined_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_COMBINED_MINIMUM_SIZE, Control, nil, r_ret)
}


//default of keep_offsets : false
set_anchors_preset :: proc(Control: GDE.ObjectPtr, preset: ^LayoutPreset, keep_offsets: ^GDE.Bool) {
    @(static)SET_ANCHORS_PRESET: GDE.MethodBindPtr
    if SET_ANCHORS_PRESET == nil do SET_ANCHORS_PRESET = classDBGetMethodBind("Control", "set_anchors_preset", 509135270)
    assert(Control != nil)
    args:= [?]rawptr { preset, keep_offsets }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ANCHORS_PRESET, Control, raw_data(args[:]), nil)
}


//default of resize_mode : 0
//Meta of margin : int32
//default of margin : 0
set_offsets_preset :: proc(Control: GDE.ObjectPtr, preset: ^LayoutPreset, resize_mode: ^LayoutPresetMode, margin: ^GDE.Int) {
    @(static)SET_OFFSETS_PRESET: GDE.MethodBindPtr
    if SET_OFFSETS_PRESET == nil do SET_OFFSETS_PRESET = classDBGetMethodBind("Control", "set_offsets_preset", 3724524307)
    assert(Control != nil)
    args:= [?]rawptr { preset, resize_mode, margin }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_OFFSETS_PRESET, Control, raw_data(args[:]), nil)
}


//default of resize_mode : 0
//Meta of margin : int32
//default of margin : 0
set_anchors_and_offsets_preset :: proc(Control: GDE.ObjectPtr, preset: ^LayoutPreset, resize_mode: ^LayoutPresetMode, margin: ^GDE.Int) {
    @(static)SET_ANCHORS_AND_OFFSETS_PRESET: GDE.MethodBindPtr
    if SET_ANCHORS_AND_OFFSETS_PRESET == nil do SET_ANCHORS_AND_OFFSETS_PRESET = classDBGetMethodBind("Control", "set_anchors_and_offsets_preset", 3724524307)
    assert(Control != nil)
    args:= [?]rawptr { preset, resize_mode, margin }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ANCHORS_AND_OFFSETS_PRESET, Control, raw_data(args[:]), nil)
}


//Meta of anchor : float
//default of keep_offset : false
//default of push_opposite_anchor : true
set_anchor :: proc(Control: GDE.ObjectPtr, side: ^Side, anchor: ^GDE.float, keep_offset: ^GDE.Bool, push_opposite_anchor: ^GDE.Bool) {
    @(static)SET_ANCHOR: GDE.MethodBindPtr
    if SET_ANCHOR == nil do SET_ANCHOR = classDBGetMethodBind("Control", "set_anchor", 2302782885)
    assert(Control != nil)
    args:= [?]rawptr { side, anchor, keep_offset, push_opposite_anchor }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ANCHOR, Control, raw_data(args[:]), nil)
}

get_anchor :: proc(Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.float) {
    @(static)GET_ANCHOR: GDE.MethodBindPtr
    if GET_ANCHOR == nil do GET_ANCHOR = classDBGetMethodBind("Control", "get_anchor", 2869120046)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_ANCHOR, Control, raw_data(args[:]), r_ret)
}


//Meta of offset : float
set_offset :: proc(Control: GDE.ObjectPtr, side: ^Side, offset: ^GDE.float) {
    @(static)SET_OFFSET: GDE.MethodBindPtr
    if SET_OFFSET == nil do SET_OFFSET = classDBGetMethodBind("Control", "set_offset", 4290182280)
    assert(Control != nil)
    args:= [?]rawptr { side, offset }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_OFFSET, Control, raw_data(args[:]), nil)
}

get_offset :: proc(Control: GDE.ObjectPtr, offset: ^Side, r_ret: ^GDE.float) {
    @(static)GET_OFFSET: GDE.MethodBindPtr
    if GET_OFFSET == nil do GET_OFFSET = classDBGetMethodBind("Control", "get_offset", 2869120046)
    assert(Control != nil)
    args:= [?]rawptr { offset }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_OFFSET, Control, raw_data(args[:]), r_ret)
}


//Meta of anchor : float
//Meta of offset : float
//default of push_opposite_anchor : false
set_anchor_and_offset :: proc(Control: GDE.ObjectPtr, side: ^Side, anchor: ^GDE.float, offset: ^GDE.float, push_opposite_anchor: ^GDE.Bool) {
    @(static)SET_ANCHOR_AND_OFFSET: GDE.MethodBindPtr
    if SET_ANCHOR_AND_OFFSET == nil do SET_ANCHOR_AND_OFFSET = classDBGetMethodBind("Control", "set_anchor_and_offset", 4031722181)
    assert(Control != nil)
    args:= [?]rawptr { side, anchor, offset, push_opposite_anchor }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ANCHOR_AND_OFFSET, Control, raw_data(args[:]), nil)
}

set_begin :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    @(static)SET_BEGIN: GDE.MethodBindPtr
    if SET_BEGIN == nil do SET_BEGIN = classDBGetMethodBind("Control", "set_begin", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_BEGIN, Control, raw_data(args[:]), nil)
}

set_end :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    @(static)SET_END: GDE.MethodBindPtr
    if SET_END == nil do SET_END = classDBGetMethodBind("Control", "set_end", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_END, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_position :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    @(static)SET_POSITION: GDE.MethodBindPtr
    if SET_POSITION == nil do SET_POSITION = classDBGetMethodBind("Control", "set_position", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { position, keep_offsets }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_POSITION, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_size :: proc(Control: GDE.ObjectPtr, size: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    @(static)SET_SIZE: GDE.MethodBindPtr
    if SET_SIZE == nil do SET_SIZE = classDBGetMethodBind("Control", "set_size", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { size, keep_offsets }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_SIZE, Control, raw_data(args[:]), nil)
}

reset_size :: proc(Control: GDE.ObjectPtr) {
    @(static)RESET_SIZE: GDE.MethodBindPtr
    if RESET_SIZE == nil do RESET_SIZE = classDBGetMethodBind("Control", "reset_size", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(RESET_SIZE, Control, nil, nil)
}

set_custom_minimum_size :: proc(Control: GDE.ObjectPtr, size: ^GDE.Vector2) {
    @(static)SET_CUSTOM_MINIMUM_SIZE: GDE.MethodBindPtr
    if SET_CUSTOM_MINIMUM_SIZE == nil do SET_CUSTOM_MINIMUM_SIZE = classDBGetMethodBind("Control", "set_custom_minimum_size", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { size }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_CUSTOM_MINIMUM_SIZE, Control, raw_data(args[:]), nil)
}


//default of keep_offsets : false
set_global_position :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2, keep_offsets: ^GDE.Bool) {
    @(static)SET_GLOBAL_POSITION: GDE.MethodBindPtr
    if SET_GLOBAL_POSITION == nil do SET_GLOBAL_POSITION = classDBGetMethodBind("Control", "set_global_position", 2436320129)
    assert(Control != nil)
    args:= [?]rawptr { position, keep_offsets }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_GLOBAL_POSITION, Control, raw_data(args[:]), nil)
}


//Meta of radians : float
set_rotation :: proc(Control: GDE.ObjectPtr, radians: ^GDE.float) {
    @(static)SET_ROTATION: GDE.MethodBindPtr
    if SET_ROTATION == nil do SET_ROTATION = classDBGetMethodBind("Control", "set_rotation", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { radians }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ROTATION, Control, raw_data(args[:]), nil)
}


//Meta of degrees : float
set_rotation_degrees :: proc(Control: GDE.ObjectPtr, degrees: ^GDE.float) {
    @(static)SET_ROTATION_DEGREES: GDE.MethodBindPtr
    if SET_ROTATION_DEGREES == nil do SET_ROTATION_DEGREES = classDBGetMethodBind("Control", "set_rotation_degrees", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { degrees }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_ROTATION_DEGREES, Control, raw_data(args[:]), nil)
}

set_scale :: proc(Control: GDE.ObjectPtr, scale: ^GDE.Vector2) {
    @(static)SET_SCALE: GDE.MethodBindPtr
    if SET_SCALE == nil do SET_SCALE = classDBGetMethodBind("Control", "set_scale", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { scale }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_SCALE, Control, raw_data(args[:]), nil)
}

set_pivot_offset :: proc(Control: GDE.ObjectPtr, pivot_offset: ^GDE.Vector2) {
    @(static)SET_PIVOT_OFFSET: GDE.MethodBindPtr
    if SET_PIVOT_OFFSET == nil do SET_PIVOT_OFFSET = classDBGetMethodBind("Control", "set_pivot_offset", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { pivot_offset }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_PIVOT_OFFSET, Control, raw_data(args[:]), nil)
}

get_begin :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_BEGIN: GDE.MethodBindPtr
    if GET_BEGIN == nil do GET_BEGIN = classDBGetMethodBind("Control", "get_begin", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_BEGIN, Control, nil, r_ret)
}

get_end :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_END: GDE.MethodBindPtr
    if GET_END == nil do GET_END = classDBGetMethodBind("Control", "get_end", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_END, Control, nil, r_ret)
}

get_position :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_POSITION: GDE.MethodBindPtr
    if GET_POSITION == nil do GET_POSITION = classDBGetMethodBind("Control", "get_position", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_POSITION, Control, nil, r_ret)
}

get_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_SIZE: GDE.MethodBindPtr
    if GET_SIZE == nil do GET_SIZE = classDBGetMethodBind("Control", "get_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_SIZE, Control, nil, r_ret)
}

get_rotation :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    @(static)GET_ROTATION: GDE.MethodBindPtr
    if GET_ROTATION == nil do GET_ROTATION = classDBGetMethodBind("Control", "get_rotation", 1740695150)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_ROTATION, Control, nil, r_ret)
}

get_rotation_degrees :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    @(static)GET_ROTATION_DEGREES: GDE.MethodBindPtr
    if GET_ROTATION_DEGREES == nil do GET_ROTATION_DEGREES = classDBGetMethodBind("Control", "get_rotation_degrees", 1740695150)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_ROTATION_DEGREES, Control, nil, r_ret)
}

get_scale :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_SCALE: GDE.MethodBindPtr
    if GET_SCALE == nil do GET_SCALE = classDBGetMethodBind("Control", "get_scale", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_SCALE, Control, nil, r_ret)
}

get_pivot_offset :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_PIVOT_OFFSET: GDE.MethodBindPtr
    if GET_PIVOT_OFFSET == nil do GET_PIVOT_OFFSET = classDBGetMethodBind("Control", "get_pivot_offset", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_PIVOT_OFFSET, Control, nil, r_ret)
}

get_custom_minimum_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_CUSTOM_MINIMUM_SIZE: GDE.MethodBindPtr
    if GET_CUSTOM_MINIMUM_SIZE == nil do GET_CUSTOM_MINIMUM_SIZE = classDBGetMethodBind("Control", "get_custom_minimum_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_CUSTOM_MINIMUM_SIZE, Control, nil, r_ret)
}

get_parent_area_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_PARENT_AREA_SIZE: GDE.MethodBindPtr
    if GET_PARENT_AREA_SIZE == nil do GET_PARENT_AREA_SIZE = classDBGetMethodBind("Control", "get_parent_area_size", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_PARENT_AREA_SIZE, Control, nil, r_ret)
}

get_global_position :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_GLOBAL_POSITION: GDE.MethodBindPtr
    if GET_GLOBAL_POSITION == nil do GET_GLOBAL_POSITION = classDBGetMethodBind("Control", "get_global_position", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_GLOBAL_POSITION, Control, nil, r_ret)
}

get_screen_position :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Vector2) {
    @(static)GET_SCREEN_POSITION: GDE.MethodBindPtr
    if GET_SCREEN_POSITION == nil do GET_SCREEN_POSITION = classDBGetMethodBind("Control", "get_screen_position", 3341600327)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_SCREEN_POSITION, Control, nil, r_ret)
}

get_rect :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Rec2) {
    @(static)GET_RECT: GDE.MethodBindPtr
    if GET_RECT == nil do GET_RECT = classDBGetMethodBind("Control", "get_rect", 1639390495)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_RECT, Control, nil, r_ret)
}

get_global_rect :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Rec2) {
    @(static)GET_GLOBAL_RECT: GDE.MethodBindPtr
    if GET_GLOBAL_RECT == nil do GET_GLOBAL_RECT = classDBGetMethodBind("Control", "get_global_rect", 1639390495)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_GLOBAL_RECT, Control, nil, r_ret)
}

set_focus_mode :: proc(Control: GDE.ObjectPtr, mode: ^FocusMode) {
    @(static)SET_FOCUS_MODE: GDE.MethodBindPtr
    if SET_FOCUS_MODE == nil do SET_FOCUS_MODE = classDBGetMethodBind("Control", "set_focus_mode", 3232914922)
    assert(Control != nil)
    args:= [?]rawptr { mode }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_FOCUS_MODE, Control, raw_data(args[:]), nil)
}

get_focus_mode :: proc(Control: GDE.ObjectPtr, r_ret: ^FocusMode) {
    @(static)GET_FOCUS_MODE: GDE.MethodBindPtr
    if GET_FOCUS_MODE == nil do GET_FOCUS_MODE = classDBGetMethodBind("Control", "get_focus_mode", 2132829277)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_FOCUS_MODE, Control, nil, r_ret)
}

has_focus :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)HAS_FOCUS: GDE.MethodBindPtr
    if HAS_FOCUS == nil do HAS_FOCUS = classDBGetMethodBind("Control", "has_focus", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_FOCUS, Control, nil, r_ret)
}

grab_focus :: proc(Control: GDE.ObjectPtr) {
    @(static)GRAB_FOCUS: GDE.MethodBindPtr
    if GRAB_FOCUS == nil do GRAB_FOCUS = classDBGetMethodBind("Control", "grab_focus", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GRAB_FOCUS, Control, nil, nil)
}

release_focus :: proc(Control: GDE.ObjectPtr) {
    @(static)RELEASE_FOCUS: GDE.MethodBindPtr
    if RELEASE_FOCUS == nil do RELEASE_FOCUS = classDBGetMethodBind("Control", "release_focus", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(RELEASE_FOCUS, Control, nil, nil)
}

find_prev_valid_focus :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)FIND_PREV_VALID_FOCUS: GDE.MethodBindPtr
    if FIND_PREV_VALID_FOCUS == nil do FIND_PREV_VALID_FOCUS = classDBGetMethodBind("Control", "find_prev_valid_focus", 2783021301)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(FIND_PREV_VALID_FOCUS, Control, nil, r_ret)
}

find_next_valid_focus :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)FIND_NEXT_VALID_FOCUS: GDE.MethodBindPtr
    if FIND_NEXT_VALID_FOCUS == nil do FIND_NEXT_VALID_FOCUS = classDBGetMethodBind("Control", "find_next_valid_focus", 2783021301)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(FIND_NEXT_VALID_FOCUS, Control, nil, r_ret)
}

find_valid_focus_neighbor :: proc(Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.ObjectPtr) {
    @(static)FIND_VALID_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if FIND_VALID_FOCUS_NEIGHBOR == nil do FIND_VALID_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "find_valid_focus_neighbor", 1543910170)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.Object_Utils.MethodBindPtrcall(FIND_VALID_FOCUS_NEIGHBOR, Control, raw_data(args[:]), r_ret)
}

set_h_size_flags :: proc(Control: GDE.ObjectPtr, flags: ^SizeFlags) {
    @(static)SET_H_SIZE_FLAGS: GDE.MethodBindPtr
    if SET_H_SIZE_FLAGS == nil do SET_H_SIZE_FLAGS = classDBGetMethodBind("Control", "set_h_size_flags", 394851643)
    assert(Control != nil)
    args:= [?]rawptr { flags }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_H_SIZE_FLAGS, Control, raw_data(args[:]), nil)
}

get_h_size_flags :: proc(Control: GDE.ObjectPtr, r_ret: ^SizeFlags) {
    @(static)GET_H_SIZE_FLAGS: GDE.MethodBindPtr
    if GET_H_SIZE_FLAGS == nil do GET_H_SIZE_FLAGS = classDBGetMethodBind("Control", "get_h_size_flags", 3781367401)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_H_SIZE_FLAGS, Control, nil, r_ret)
}


//Meta of ratio : float
set_stretch_ratio :: proc(Control: GDE.ObjectPtr, ratio: ^GDE.float) {
    @(static)SET_STRETCH_RATIO: GDE.MethodBindPtr
    if SET_STRETCH_RATIO == nil do SET_STRETCH_RATIO = classDBGetMethodBind("Control", "set_stretch_ratio", 373806689)
    assert(Control != nil)
    args:= [?]rawptr { ratio }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_STRETCH_RATIO, Control, raw_data(args[:]), nil)
}

get_stretch_ratio :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    @(static)GET_STRETCH_RATIO: GDE.MethodBindPtr
    if GET_STRETCH_RATIO == nil do GET_STRETCH_RATIO = classDBGetMethodBind("Control", "get_stretch_ratio", 1740695150)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_STRETCH_RATIO, Control, nil, r_ret)
}

set_v_size_flags :: proc(Control: GDE.ObjectPtr, flags: ^SizeFlags) {
    @(static)SET_V_SIZE_FLAGS: GDE.MethodBindPtr
    if SET_V_SIZE_FLAGS == nil do SET_V_SIZE_FLAGS = classDBGetMethodBind("Control", "set_v_size_flags", 394851643)
    assert(Control != nil)
    args:= [?]rawptr { flags }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_V_SIZE_FLAGS, Control, raw_data(args[:]), nil)
}

get_v_size_flags :: proc(Control: GDE.ObjectPtr, r_ret: ^SizeFlags) {
    @(static)GET_V_SIZE_FLAGS: GDE.MethodBindPtr
    if GET_V_SIZE_FLAGS == nil do GET_V_SIZE_FLAGS = classDBGetMethodBind("Control", "get_v_size_flags", 3781367401)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_V_SIZE_FLAGS, Control, nil, r_ret)
}

set_theme :: proc(Control: GDE.ObjectPtr, theme: ^GDE.ObjectPtr) {
    @(static)SET_THEME: GDE.MethodBindPtr
    if SET_THEME == nil do SET_THEME = classDBGetMethodBind("Control", "set_theme", 2326690814)
    assert(Control != nil)
    args:= [?]rawptr { theme }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_THEME, Control, raw_data(args[:]), nil)
}

get_theme :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_THEME: GDE.MethodBindPtr
    if GET_THEME == nil do GET_THEME = classDBGetMethodBind("Control", "get_theme", 3846893731)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME, Control, nil, r_ret)
}

set_theme_type_variation :: proc(Control: GDE.ObjectPtr, theme_type: ^GDE.StringName) {
    @(static)SET_THEME_TYPE_VARIATION: GDE.MethodBindPtr
    if SET_THEME_TYPE_VARIATION == nil do SET_THEME_TYPE_VARIATION = classDBGetMethodBind("Control", "set_theme_type_variation", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_THEME_TYPE_VARIATION, Control, raw_data(args[:]), nil)
}

get_theme_type_variation :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.StringName) {
    @(static)GET_THEME_TYPE_VARIATION: GDE.MethodBindPtr
    if GET_THEME_TYPE_VARIATION == nil do GET_THEME_TYPE_VARIATION = classDBGetMethodBind("Control", "get_theme_type_variation", 2002593661)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_TYPE_VARIATION, Control, nil, r_ret)
}

begin_bulk_theme_override :: proc(Control: GDE.ObjectPtr) {
    @(static)BEGIN_BULK_THEME_OVERRIDE: GDE.MethodBindPtr
    if BEGIN_BULK_THEME_OVERRIDE == nil do BEGIN_BULK_THEME_OVERRIDE = classDBGetMethodBind("Control", "begin_bulk_theme_override", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(BEGIN_BULK_THEME_OVERRIDE, Control, nil, nil)
}

end_bulk_theme_override :: proc(Control: GDE.ObjectPtr) {
    @(static)END_BULK_THEME_OVERRIDE: GDE.MethodBindPtr
    if END_BULK_THEME_OVERRIDE == nil do END_BULK_THEME_OVERRIDE = classDBGetMethodBind("Control", "end_bulk_theme_override", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(END_BULK_THEME_OVERRIDE, Control, nil, nil)
}

add_theme_icon_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, texture: ^GDE.ObjectPtr) {
    @(static)ADD_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_ICON_OVERRIDE == nil do ADD_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "add_theme_icon_override", 1373065600)
    assert(Control != nil)
    args:= [?]rawptr { name, texture }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_stylebox_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, stylebox: ^GDE.ObjectPtr) {
    @(static)ADD_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_STYLEBOX_OVERRIDE == nil do ADD_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "add_theme_stylebox_override", 4188838905)
    assert(Control != nil)
    args:= [?]rawptr { name, stylebox }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_font_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, font: ^GDE.ObjectPtr) {
    @(static)ADD_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_FONT_OVERRIDE == nil do ADD_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "add_theme_font_override", 3518018674)
    assert(Control != nil)
    args:= [?]rawptr { name, font }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), nil)
}


//Meta of font_size : int32
add_theme_font_size_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, font_size: ^GDE.Int) {
    @(static)ADD_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_FONT_SIZE_OVERRIDE == nil do ADD_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "add_theme_font_size_override", 2415702435)
    assert(Control != nil)
    args:= [?]rawptr { name, font_size }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), nil)
}

add_theme_color_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, color: ^GDE.Color) {
    @(static)ADD_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_COLOR_OVERRIDE == nil do ADD_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "add_theme_color_override", 4260178595)
    assert(Control != nil)
    args:= [?]rawptr { name, color }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), nil)
}


//Meta of constant : int32
add_theme_constant_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, constant: ^GDE.Int) {
    @(static)ADD_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if ADD_THEME_CONSTANT_OVERRIDE == nil do ADD_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "add_theme_constant_override", 2415702435)
    assert(Control != nil)
    args:= [?]rawptr { name, constant }
    gdAPI.Object_Utils.MethodBindPtrcall(ADD_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_icon_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_ICON_OVERRIDE == nil do REMOVE_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_icon_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_stylebox_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_STYLEBOX_OVERRIDE == nil do REMOVE_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_stylebox_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_font_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_FONT_OVERRIDE == nil do REMOVE_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_font_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_font_size_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_FONT_SIZE_OVERRIDE == nil do REMOVE_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_font_size_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_color_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_COLOR_OVERRIDE == nil do REMOVE_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_color_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), nil)
}

remove_theme_constant_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName) {
    @(static)REMOVE_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if REMOVE_THEME_CONSTANT_OVERRIDE == nil do REMOVE_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "remove_theme_constant_override", 3304788590)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(REMOVE_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), nil)
}


//default of theme_type : &\"\"
get_theme_icon :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_THEME_ICON: GDE.MethodBindPtr
    if GET_THEME_ICON == nil do GET_THEME_ICON = classDBGetMethodBind("Control", "get_theme_icon", 3163973443)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_ICON, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_stylebox :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_THEME_STYLEBOX: GDE.MethodBindPtr
    if GET_THEME_STYLEBOX == nil do GET_THEME_STYLEBOX = classDBGetMethodBind("Control", "get_theme_stylebox", 604739069)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_STYLEBOX, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_font :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_THEME_FONT: GDE.MethodBindPtr
    if GET_THEME_FONT == nil do GET_THEME_FONT = classDBGetMethodBind("Control", "get_theme_font", 2826986490)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_FONT, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_font_size :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Int) {
    @(static)GET_THEME_FONT_SIZE: GDE.MethodBindPtr
    if GET_THEME_FONT_SIZE == nil do GET_THEME_FONT_SIZE = classDBGetMethodBind("Control", "get_theme_font_size", 1327056374)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_FONT_SIZE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_color :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Color) {
    @(static)GET_THEME_COLOR: GDE.MethodBindPtr
    if GET_THEME_COLOR == nil do GET_THEME_COLOR = classDBGetMethodBind("Control", "get_theme_color", 2798751242)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_COLOR, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
get_theme_constant :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Int) {
    @(static)GET_THEME_CONSTANT: GDE.MethodBindPtr
    if GET_THEME_CONSTANT == nil do GET_THEME_CONSTANT = classDBGetMethodBind("Control", "get_theme_constant", 1327056374)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_CONSTANT, Control, raw_data(args[:]), r_ret)
}

has_theme_icon_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_ICON_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_ICON_OVERRIDE == nil do HAS_THEME_ICON_OVERRIDE = classDBGetMethodBind("Control", "has_theme_icon_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_ICON_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_stylebox_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_STYLEBOX_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_STYLEBOX_OVERRIDE == nil do HAS_THEME_STYLEBOX_OVERRIDE = classDBGetMethodBind("Control", "has_theme_stylebox_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_STYLEBOX_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_font_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_FONT_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_FONT_OVERRIDE == nil do HAS_THEME_FONT_OVERRIDE = classDBGetMethodBind("Control", "has_theme_font_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_FONT_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_font_size_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_FONT_SIZE_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_FONT_SIZE_OVERRIDE == nil do HAS_THEME_FONT_SIZE_OVERRIDE = classDBGetMethodBind("Control", "has_theme_font_size_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_FONT_SIZE_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_color_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_COLOR_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_COLOR_OVERRIDE == nil do HAS_THEME_COLOR_OVERRIDE = classDBGetMethodBind("Control", "has_theme_color_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_COLOR_OVERRIDE, Control, raw_data(args[:]), r_ret)
}

has_theme_constant_override :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_CONSTANT_OVERRIDE: GDE.MethodBindPtr
    if HAS_THEME_CONSTANT_OVERRIDE == nil do HAS_THEME_CONSTANT_OVERRIDE = classDBGetMethodBind("Control", "has_theme_constant_override", 2619796661)
    assert(Control != nil)
    args:= [?]rawptr { name }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_CONSTANT_OVERRIDE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_icon :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_ICON: GDE.MethodBindPtr
    if HAS_THEME_ICON == nil do HAS_THEME_ICON = classDBGetMethodBind("Control", "has_theme_icon", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_ICON, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_stylebox :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_STYLEBOX: GDE.MethodBindPtr
    if HAS_THEME_STYLEBOX == nil do HAS_THEME_STYLEBOX = classDBGetMethodBind("Control", "has_theme_stylebox", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_STYLEBOX, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_font :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_FONT: GDE.MethodBindPtr
    if HAS_THEME_FONT == nil do HAS_THEME_FONT = classDBGetMethodBind("Control", "has_theme_font", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_FONT, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_font_size :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_FONT_SIZE: GDE.MethodBindPtr
    if HAS_THEME_FONT_SIZE == nil do HAS_THEME_FONT_SIZE = classDBGetMethodBind("Control", "has_theme_font_size", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_FONT_SIZE, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_color :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_COLOR: GDE.MethodBindPtr
    if HAS_THEME_COLOR == nil do HAS_THEME_COLOR = classDBGetMethodBind("Control", "has_theme_color", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_COLOR, Control, raw_data(args[:]), r_ret)
}


//default of theme_type : &\"\"
has_theme_constant :: proc(Control: GDE.ObjectPtr, name: ^GDE.StringName, theme_type: ^GDE.StringName, r_ret: ^GDE.Bool) {
    @(static)HAS_THEME_CONSTANT: GDE.MethodBindPtr
    if HAS_THEME_CONSTANT == nil do HAS_THEME_CONSTANT = classDBGetMethodBind("Control", "has_theme_constant", 866386512)
    assert(Control != nil)
    args:= [?]rawptr { name, theme_type }
    gdAPI.Object_Utils.MethodBindPtrcall(HAS_THEME_CONSTANT, Control, raw_data(args[:]), r_ret)
}

get_theme_default_base_scale :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.float) {
    @(static)GET_THEME_DEFAULT_BASE_SCALE: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_BASE_SCALE == nil do GET_THEME_DEFAULT_BASE_SCALE = classDBGetMethodBind("Control", "get_theme_default_base_scale", 1740695150)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_DEFAULT_BASE_SCALE, Control, nil, r_ret)
}

get_theme_default_font :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_THEME_DEFAULT_FONT: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_FONT == nil do GET_THEME_DEFAULT_FONT = classDBGetMethodBind("Control", "get_theme_default_font", 3229501585)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_DEFAULT_FONT, Control, nil, r_ret)
}

get_theme_default_font_size :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Int) {
    @(static)GET_THEME_DEFAULT_FONT_SIZE: GDE.MethodBindPtr
    if GET_THEME_DEFAULT_FONT_SIZE == nil do GET_THEME_DEFAULT_FONT_SIZE = classDBGetMethodBind("Control", "get_theme_default_font_size", 3905245786)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_THEME_DEFAULT_FONT_SIZE, Control, nil, r_ret)
}

get_parent_control :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_PARENT_CONTROL: GDE.MethodBindPtr
    if GET_PARENT_CONTROL == nil do GET_PARENT_CONTROL = classDBGetMethodBind("Control", "get_parent_control", 2783021301)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_PARENT_CONTROL, Control, nil, r_ret)
}

set_h_grow_direction :: proc(Control: GDE.ObjectPtr, direction: ^GrowDirection) {
    @(static)SET_H_GROW_DIRECTION: GDE.MethodBindPtr
    if SET_H_GROW_DIRECTION == nil do SET_H_GROW_DIRECTION = classDBGetMethodBind("Control", "set_h_grow_direction", 2022385301)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_H_GROW_DIRECTION, Control, raw_data(args[:]), nil)
}

get_h_grow_direction :: proc(Control: GDE.ObjectPtr, r_ret: ^GrowDirection) {
    @(static)GET_H_GROW_DIRECTION: GDE.MethodBindPtr
    if GET_H_GROW_DIRECTION == nil do GET_H_GROW_DIRECTION = classDBGetMethodBind("Control", "get_h_grow_direction", 3635610155)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_H_GROW_DIRECTION, Control, nil, r_ret)
}

set_v_grow_direction :: proc(Control: GDE.ObjectPtr, direction: ^GrowDirection) {
    @(static)SET_V_GROW_DIRECTION: GDE.MethodBindPtr
    if SET_V_GROW_DIRECTION == nil do SET_V_GROW_DIRECTION = classDBGetMethodBind("Control", "set_v_grow_direction", 2022385301)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_V_GROW_DIRECTION, Control, raw_data(args[:]), nil)
}

get_v_grow_direction :: proc(Control: GDE.ObjectPtr, r_ret: ^GrowDirection) {
    @(static)GET_V_GROW_DIRECTION: GDE.MethodBindPtr
    if GET_V_GROW_DIRECTION == nil do GET_V_GROW_DIRECTION = classDBGetMethodBind("Control", "get_v_grow_direction", 3635610155)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_V_GROW_DIRECTION, Control, nil, r_ret)
}

set_tooltip_auto_translate_mode :: proc(Control: GDE.ObjectPtr, mode: ^AutoTranslateMode) {
    @(static)SET_TOOLTIP_AUTO_TRANSLATE_MODE: GDE.MethodBindPtr
    if SET_TOOLTIP_AUTO_TRANSLATE_MODE == nil do SET_TOOLTIP_AUTO_TRANSLATE_MODE = classDBGetMethodBind("Control", "set_tooltip_auto_translate_mode", 776149714)
    assert(Control != nil)
    args:= [?]rawptr { mode }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_TOOLTIP_AUTO_TRANSLATE_MODE, Control, raw_data(args[:]), nil)
}

get_tooltip_auto_translate_mode :: proc(Control: GDE.ObjectPtr, r_ret: ^AutoTranslateMode) {
    @(static)GET_TOOLTIP_AUTO_TRANSLATE_MODE: GDE.MethodBindPtr
    if GET_TOOLTIP_AUTO_TRANSLATE_MODE == nil do GET_TOOLTIP_AUTO_TRANSLATE_MODE = classDBGetMethodBind("Control", "get_tooltip_auto_translate_mode", 2498906432)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_TOOLTIP_AUTO_TRANSLATE_MODE, Control, nil, r_ret)
}

set_tooltip_text :: proc(Control: GDE.ObjectPtr, hint: ^GDE.gdstring) {
    @(static)SET_TOOLTIP_TEXT: GDE.MethodBindPtr
    if SET_TOOLTIP_TEXT == nil do SET_TOOLTIP_TEXT = classDBGetMethodBind("Control", "set_tooltip_text", 83702148)
    assert(Control != nil)
    args:= [?]rawptr { hint }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_TOOLTIP_TEXT, Control, raw_data(args[:]), nil)
}

get_tooltip_text :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.gdstring) {
    @(static)GET_TOOLTIP_TEXT: GDE.MethodBindPtr
    if GET_TOOLTIP_TEXT == nil do GET_TOOLTIP_TEXT = classDBGetMethodBind("Control", "get_tooltip_text", 201670096)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_TOOLTIP_TEXT, Control, nil, r_ret)
}


//default of at_position : Vector2(0, 0)
get_tooltip :: proc(Control: GDE.ObjectPtr, at_position: ^GDE.Vector2, r_ret: ^GDE.gdstring) {
    @(static)GET_TOOLTIP: GDE.MethodBindPtr
    if GET_TOOLTIP == nil do GET_TOOLTIP = classDBGetMethodBind("Control", "get_tooltip", 2895288280)
    assert(Control != nil)
    args:= [?]rawptr { at_position }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_TOOLTIP, Control, raw_data(args[:]), r_ret)
}

set_default_cursor_shape :: proc(Control: GDE.ObjectPtr, shape: ^CursorShape) {
    @(static)SET_DEFAULT_CURSOR_SHAPE: GDE.MethodBindPtr
    if SET_DEFAULT_CURSOR_SHAPE == nil do SET_DEFAULT_CURSOR_SHAPE = classDBGetMethodBind("Control", "set_default_cursor_shape", 217062046)
    assert(Control != nil)
    args:= [?]rawptr { shape }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_DEFAULT_CURSOR_SHAPE, Control, raw_data(args[:]), nil)
}

get_default_cursor_shape :: proc(Control: GDE.ObjectPtr, r_ret: ^CursorShape) {
    @(static)GET_DEFAULT_CURSOR_SHAPE: GDE.MethodBindPtr
    if GET_DEFAULT_CURSOR_SHAPE == nil do GET_DEFAULT_CURSOR_SHAPE = classDBGetMethodBind("Control", "get_default_cursor_shape", 2359535750)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_DEFAULT_CURSOR_SHAPE, Control, nil, r_ret)
}


//default of position : Vector2(0, 0)
get_cursor_shape :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2, r_ret: ^CursorShape) {
    @(static)GET_CURSOR_SHAPE: GDE.MethodBindPtr
    if GET_CURSOR_SHAPE == nil do GET_CURSOR_SHAPE = classDBGetMethodBind("Control", "get_cursor_shape", 1395773853)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_CURSOR_SHAPE, Control, raw_data(args[:]), r_ret)
}

set_focus_neighbor :: proc(Control: GDE.ObjectPtr, side: ^Side, neighbor: ^GDE.NodePath) {
    @(static)SET_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if SET_FOCUS_NEIGHBOR == nil do SET_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "set_focus_neighbor", 2024461774)
    assert(Control != nil)
    args:= [?]rawptr { side, neighbor }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_FOCUS_NEIGHBOR, Control, raw_data(args[:]), nil)
}

get_focus_neighbor :: proc(Control: GDE.ObjectPtr, side: ^Side, r_ret: ^GDE.NodePath) {
    @(static)GET_FOCUS_NEIGHBOR: GDE.MethodBindPtr
    if GET_FOCUS_NEIGHBOR == nil do GET_FOCUS_NEIGHBOR = classDBGetMethodBind("Control", "get_focus_neighbor", 2757935761)
    assert(Control != nil)
    args:= [?]rawptr { side }
    gdAPI.Object_Utils.MethodBindPtrcall(GET_FOCUS_NEIGHBOR, Control, raw_data(args[:]), r_ret)
}

set_focus_next :: proc(Control: GDE.ObjectPtr, next: ^GDE.NodePath) {
    @(static)SET_FOCUS_NEXT: GDE.MethodBindPtr
    if SET_FOCUS_NEXT == nil do SET_FOCUS_NEXT = classDBGetMethodBind("Control", "set_focus_next", 1348162250)
    assert(Control != nil)
    args:= [?]rawptr { next }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_FOCUS_NEXT, Control, raw_data(args[:]), nil)
}

get_focus_next :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.NodePath) {
    @(static)GET_FOCUS_NEXT: GDE.MethodBindPtr
    if GET_FOCUS_NEXT == nil do GET_FOCUS_NEXT = classDBGetMethodBind("Control", "get_focus_next", 4075236667)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_FOCUS_NEXT, Control, nil, r_ret)
}

set_focus_previous :: proc(Control: GDE.ObjectPtr, previous: ^GDE.NodePath) {
    @(static)SET_FOCUS_PREVIOUS: GDE.MethodBindPtr
    if SET_FOCUS_PREVIOUS == nil do SET_FOCUS_PREVIOUS = classDBGetMethodBind("Control", "set_focus_previous", 1348162250)
    assert(Control != nil)
    args:= [?]rawptr { previous }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_FOCUS_PREVIOUS, Control, raw_data(args[:]), nil)
}

get_focus_previous :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.NodePath) {
    @(static)GET_FOCUS_PREVIOUS: GDE.MethodBindPtr
    if GET_FOCUS_PREVIOUS == nil do GET_FOCUS_PREVIOUS = classDBGetMethodBind("Control", "get_focus_previous", 4075236667)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_FOCUS_PREVIOUS, Control, nil, r_ret)
}

force_drag :: proc(Control: GDE.ObjectPtr, data: ^GDE.Variant, preview: ^GDE.ObjectPtr) {
    @(static)FORCE_DRAG: GDE.MethodBindPtr
    if FORCE_DRAG == nil do FORCE_DRAG = classDBGetMethodBind("Control", "force_drag", 3191844692)
    assert(Control != nil)
    args:= [?]rawptr { data, preview }
    gdAPI.Object_Utils.MethodBindPtrcall(FORCE_DRAG, Control, raw_data(args[:]), nil)
}

set_mouse_filter :: proc(Control: GDE.ObjectPtr, filter: ^MouseFilter) {
    @(static)SET_MOUSE_FILTER: GDE.MethodBindPtr
    if SET_MOUSE_FILTER == nil do SET_MOUSE_FILTER = classDBGetMethodBind("Control", "set_mouse_filter", 3891156122)
    assert(Control != nil)
    args:= [?]rawptr { filter }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_MOUSE_FILTER, Control, raw_data(args[:]), nil)
}

get_mouse_filter :: proc(Control: GDE.ObjectPtr, r_ret: ^MouseFilter) {
    @(static)GET_MOUSE_FILTER: GDE.MethodBindPtr
    if GET_MOUSE_FILTER == nil do GET_MOUSE_FILTER = classDBGetMethodBind("Control", "get_mouse_filter", 1572545674)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_MOUSE_FILTER, Control, nil, r_ret)
}

set_force_pass_scroll_events :: proc(Control: GDE.ObjectPtr, force_pass_scroll_events: ^GDE.Bool) {
    @(static)SET_FORCE_PASS_SCROLL_EVENTS: GDE.MethodBindPtr
    if SET_FORCE_PASS_SCROLL_EVENTS == nil do SET_FORCE_PASS_SCROLL_EVENTS = classDBGetMethodBind("Control", "set_force_pass_scroll_events", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { force_pass_scroll_events }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_FORCE_PASS_SCROLL_EVENTS, Control, raw_data(args[:]), nil)
}

is_force_pass_scroll_events :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_FORCE_PASS_SCROLL_EVENTS: GDE.MethodBindPtr
    if IS_FORCE_PASS_SCROLL_EVENTS == nil do IS_FORCE_PASS_SCROLL_EVENTS = classDBGetMethodBind("Control", "is_force_pass_scroll_events", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_FORCE_PASS_SCROLL_EVENTS, Control, nil, r_ret)
}

set_clip_contents :: proc(Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    @(static)SET_CLIP_CONTENTS: GDE.MethodBindPtr
    if SET_CLIP_CONTENTS == nil do SET_CLIP_CONTENTS = classDBGetMethodBind("Control", "set_clip_contents", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_CLIP_CONTENTS, Control, raw_data(args[:]), nil)
}

is_clipping_contents :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_CLIPPING_CONTENTS: GDE.MethodBindPtr
    if IS_CLIPPING_CONTENTS == nil do IS_CLIPPING_CONTENTS = classDBGetMethodBind("Control", "is_clipping_contents", 2240911060)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_CLIPPING_CONTENTS, Control, nil, r_ret)
}

grab_click_focus :: proc(Control: GDE.ObjectPtr) {
    @(static)GRAB_CLICK_FOCUS: GDE.MethodBindPtr
    if GRAB_CLICK_FOCUS == nil do GRAB_CLICK_FOCUS = classDBGetMethodBind("Control", "grab_click_focus", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GRAB_CLICK_FOCUS, Control, nil, nil)
}

set_drag_forwarding :: proc(Control: GDE.ObjectPtr, drag_func: ^GDE.Callable, can_drop_func: ^GDE.Callable, drop_func: ^GDE.Callable) {
    @(static)SET_DRAG_FORWARDING: GDE.MethodBindPtr
    if SET_DRAG_FORWARDING == nil do SET_DRAG_FORWARDING = classDBGetMethodBind("Control", "set_drag_forwarding", 1076571380)
    assert(Control != nil)
    args:= [?]rawptr { drag_func, can_drop_func, drop_func }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_DRAG_FORWARDING, Control, raw_data(args[:]), nil)
}

set_drag_preview :: proc(Control: GDE.ObjectPtr, control: ^GDE.ObjectPtr) {
    @(static)SET_DRAG_PREVIEW: GDE.MethodBindPtr
    if SET_DRAG_PREVIEW == nil do SET_DRAG_PREVIEW = classDBGetMethodBind("Control", "set_drag_preview", 1496901182)
    assert(Control != nil)
    args:= [?]rawptr { control }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_DRAG_PREVIEW, Control, raw_data(args[:]), nil)
}

is_drag_successful :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_DRAG_SUCCESSFUL: GDE.MethodBindPtr
    if IS_DRAG_SUCCESSFUL == nil do IS_DRAG_SUCCESSFUL = classDBGetMethodBind("Control", "is_drag_successful", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_DRAG_SUCCESSFUL, Control, nil, r_ret)
}

warp_mouse :: proc(Control: GDE.ObjectPtr, position: ^GDE.Vector2) {
    @(static)WARP_MOUSE: GDE.MethodBindPtr
    if WARP_MOUSE == nil do WARP_MOUSE = classDBGetMethodBind("Control", "warp_mouse", 743155724)
    assert(Control != nil)
    args:= [?]rawptr { position }
    gdAPI.Object_Utils.MethodBindPtrcall(WARP_MOUSE, Control, raw_data(args[:]), nil)
}

set_shortcut_context :: proc(Control: GDE.ObjectPtr, node: ^GDE.ObjectPtr) {
    @(static)SET_SHORTCUT_CONTEXT: GDE.MethodBindPtr
    if SET_SHORTCUT_CONTEXT == nil do SET_SHORTCUT_CONTEXT = classDBGetMethodBind("Control", "set_shortcut_context", 1078189570)
    assert(Control != nil)
    args:= [?]rawptr { node }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_SHORTCUT_CONTEXT, Control, raw_data(args[:]), nil)
}

get_shortcut_context :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.ObjectPtr) {
    @(static)GET_SHORTCUT_CONTEXT: GDE.MethodBindPtr
    if GET_SHORTCUT_CONTEXT == nil do GET_SHORTCUT_CONTEXT = classDBGetMethodBind("Control", "get_shortcut_context", 3160264692)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_SHORTCUT_CONTEXT, Control, nil, r_ret)
}

update_minimum_size :: proc(Control: GDE.ObjectPtr) {
    @(static)UPDATE_MINIMUM_SIZE: GDE.MethodBindPtr
    if UPDATE_MINIMUM_SIZE == nil do UPDATE_MINIMUM_SIZE = classDBGetMethodBind("Control", "update_minimum_size", 321895971)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(UPDATE_MINIMUM_SIZE, Control, nil, nil)
}

set_layout_direction :: proc(Control: GDE.ObjectPtr, direction: ^LayoutDirection) {
    @(static)SET_LAYOUT_DIRECTION: GDE.MethodBindPtr
    if SET_LAYOUT_DIRECTION == nil do SET_LAYOUT_DIRECTION = classDBGetMethodBind("Control", "set_layout_direction", 3310692370)
    assert(Control != nil)
    args:= [?]rawptr { direction }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_LAYOUT_DIRECTION, Control, raw_data(args[:]), nil)
}

get_layout_direction :: proc(Control: GDE.ObjectPtr, r_ret: ^LayoutDirection) {
    @(static)GET_LAYOUT_DIRECTION: GDE.MethodBindPtr
    if GET_LAYOUT_DIRECTION == nil do GET_LAYOUT_DIRECTION = classDBGetMethodBind("Control", "get_layout_direction", 1546772008)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_LAYOUT_DIRECTION, Control, nil, r_ret)
}

is_layout_rtl :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_LAYOUT_RTL: GDE.MethodBindPtr
    if IS_LAYOUT_RTL == nil do IS_LAYOUT_RTL = classDBGetMethodBind("Control", "is_layout_rtl", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_LAYOUT_RTL, Control, nil, r_ret)
}

set_auto_translate :: proc(Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    @(static)SET_AUTO_TRANSLATE: GDE.MethodBindPtr
    if SET_AUTO_TRANSLATE == nil do SET_AUTO_TRANSLATE = classDBGetMethodBind("Control", "set_auto_translate", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_AUTO_TRANSLATE, Control, raw_data(args[:]), nil)
}

is_auto_translating :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_AUTO_TRANSLATING: GDE.MethodBindPtr
    if IS_AUTO_TRANSLATING == nil do IS_AUTO_TRANSLATING = classDBGetMethodBind("Control", "is_auto_translating", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_AUTO_TRANSLATING, Control, nil, r_ret)
}

set_localize_numeral_system :: proc(Control: GDE.ObjectPtr, enable: ^GDE.Bool) {
    @(static)SET_LOCALIZE_NUMERAL_SYSTEM: GDE.MethodBindPtr
    if SET_LOCALIZE_NUMERAL_SYSTEM == nil do SET_LOCALIZE_NUMERAL_SYSTEM = classDBGetMethodBind("Control", "set_localize_numeral_system", 2586408642)
    assert(Control != nil)
    args:= [?]rawptr { enable }
    gdAPI.Object_Utils.MethodBindPtrcall(SET_LOCALIZE_NUMERAL_SYSTEM, Control, raw_data(args[:]), nil)
}

is_localizing_numeral_system :: proc(Control: GDE.ObjectPtr, r_ret: ^GDE.Bool) {
    @(static)IS_LOCALIZING_NUMERAL_SYSTEM: GDE.MethodBindPtr
    if IS_LOCALIZING_NUMERAL_SYSTEM == nil do IS_LOCALIZING_NUMERAL_SYSTEM = classDBGetMethodBind("Control", "is_localizing_numeral_system", 36873697)
    assert(Control != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(IS_LOCALIZING_NUMERAL_SYSTEM, Control, nil, r_ret)
}


//***********************\\
//********Signals********\\
//***********************\\

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

@(rodata)
ControlSignals_String : [ControlSignals]string = {
    .resized = "resized",
    .gui_input = "gui_input",//Args //name: GDE.ObjectPtr
    .mouse_entered = "mouse_entered",//Args //name: GDE.ObjectPtr
    .mouse_exited = "mouse_exited",
    .focus_entered = "focus_entered",
    .focus_exited = "focus_exited",
    .size_flags_changed = "size_flags_changed",
    .minimum_size_changed = "minimum_size_changed",
    .theme_changed = "theme_changed",
}

Controlgui_input:= [?]typeid {GDE.ObjectPtr}
Controlmouse_entered:= [?]typeid {GDE.ObjectPtr}
