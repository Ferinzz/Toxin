/*
"name": "Control",
"is_refcounted": false,
"is_instantiable": true,
"inherits": "CanvasItem",
"api_type": "core",*/

constants :: enum i64 { 
    NOTIFICATION_RESIZED = 40,
    NOTIFICATION_MOUSE_ENTER = 41,
    NOTIFICATION_MOUSE_EXIT = 42,
    NOTIFICATION_MOUSE_ENTER_SELF = 60,
    NOTIFICATION_MOUSE_EXIT_SELF = 61,
    NOTIFICATION_FOCUS_ENTER = 43,
    NOTIFICATION_FOCUS_EXIT = 44,
    NOTIFICATION_THEME_CHANGED = 45,
    NOTIFICATION_SCROLL_BEGIN = 47,
    NOTIFICATION_SCROLL_END = 48,
    NOTIFICATION_LAYOUT_DIRECTION_CHANGED = 49
}

FocusMode :: enum i32{
    FOCUS_NONE = 0,
    FOCUS_CLICK = 1,
    FOCUS_ALL = 2
}

CursorShape:: enum i32 {
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
    CURSOR_HELP = 16
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
    PRESET_FULL_RECT = 15
}

LayoutPresetMode :: enum i32 {
    PRESET_MODE_MINSIZE = 0,
    PRESET_MODE_KEEP_WIDTH = 1,
    PRESET_MODE_KEEP_HEIGHT = 2,
    PRESET_MODE_KEEP_SIZE = 3
}

SizeFlags :: enum i32 {
    SIZE_SHRINK_BEGIN = 0,
    SIZE_FILL = 1,
    SIZE_EXPAND = 2,
    SIZE_EXPAND_FILL = 3,
    SIZE_SHRINK_CENTER = 4,
    SIZE_SHRINK_END = 8
}

MouseFilter :: enum i32{
    MOUSE_FILTER_STOP = 0,
    MOUSE_FILTER_PASS = 1,
    MOUSE_FILTER_IGNORE = 2
}

GrowDirection :: enum i32 {
    GROW_DIRECTION_BEGIN = 0,
    GROW_DIRECTION_END = 1,
    GROW_DIRECTION_BOTH = 2
}

Anchor :: enum i32 {
    ANCHOR_BEGIN = 0,
    ANCHOR_END = 1
}

LayoutDirection :: enum i32 {
    LAYOUT_DIRECTION_INHERITED = 0,
    LAYOUT_DIRECTION_APPLICATION_LOCALE = 1,
    LAYOUT_DIRECTION_LTR = 2,
    LAYOUT_DIRECTION_RTL = 3,
    LAYOUT_DIRECTION_SYSTEM_LOCALE = 4,
    LAYOUT_DIRECTION_MAX = 5,
    LAYOUT_DIRECTION_LOCALE = 1
}

TextDirection :: enum i32 {
    TEXT_DIRECTION_INHERITED = 3,
    TEXT_DIRECTION_AUTO = 0,
    TEXT_DIRECTION_LTR = 1,
    TEXT_DIRECTION_RTL = 2
}

"methods": [
	{
		"name": "_has_point",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 556197845,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "point",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "_structured_text_parser",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 1292548940,
					"return_value": {
						"type": "typedarray::Vector3i"
					},
					"arguments": [
						{
							"name": "args",
							"type": "Array"
						},
						{
							"name": "text",
							"type": "String"
						}
					]
				},
				{
					"name": "_get_minimum_size",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "_get_tooltip",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 3674420000,
					"return_value": {
						"type": "String"
					},
					"arguments": [
						{
							"name": "at_position",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "_get_drag_data",
					"is_const": false,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 2233896889,
					"return_value": {
						"type": "Variant"
					},
					"arguments": [
						{
							"name": "at_position",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "_can_drop_data",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 2603004011,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "at_position",
							"type": "Vector2"
						},
						{
							"name": "data",
							"type": "Variant"
						}
					]
				},
				{
					"name": "_drop_data",
					"is_const": false,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 3699746064,
					"arguments": [
						{
							"name": "at_position",
							"type": "Vector2"
						},
						{
							"name": "data",
							"type": "Variant"
						}
					]
				},
				{
					"name": "_make_custom_tooltip",
					"is_const": true,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 1976279298,
					"return_value": {
						"type": "Object"
					},
					"arguments": [
						{
							"name": "for_text",
							"type": "String"
						}
					]
				},
				{
					"name": "_gui_input",
					"is_const": false,
					"is_static": false,
					"is_required": false,
					"is_vararg": false,
					"is_virtual": true,
					"hash": 3754044979,
					"arguments": [
						{
							"name": "event",
							"type": "InputEvent"
						}
					]
				},
				{
					"name": "accept_event",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "get_minimum_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_combined_minimum_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "set_anchors_preset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 509135270,
					"arguments": [
						{
							"name": "preset",
							"type": "enum::Control.LayoutPreset"
						},
						{
							"name": "keep_offsets",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
				{
					"name": "set_offsets_preset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3724524307,
					"hash_compatibility": [
						3651818904
					],
					"arguments": [
						{
							"name": "preset",
							"type": "enum::Control.LayoutPreset"
						},
						{
							"name": "resize_mode",
							"type": "enum::Control.LayoutPresetMode",
							"default_value": "0"
						},
						{
							"name": "margin",
							"type": "int",
							"meta": "int32",
							"default_value": "0"
						}
					]
				},
				{
					"name": "set_anchors_and_offsets_preset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3724524307,
					"hash_compatibility": [
						3651818904
					],
					"arguments": [
						{
							"name": "preset",
							"type": "enum::Control.LayoutPreset"
						},
						{
							"name": "resize_mode",
							"type": "enum::Control.LayoutPresetMode",
							"default_value": "0"
						},
						{
							"name": "margin",
							"type": "int",
							"meta": "int32",
							"default_value": "0"
						}
					]
				},
				{
					"name": "set_anchor",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2302782885,
					"hash_compatibility": [
						2589937826
					],
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						},
						{
							"name": "anchor",
							"type": "float",
							"meta": "float"
						},
						{
							"name": "keep_offset",
							"type": "bool",
							"default_value": "false"
						},
						{
							"name": "push_opposite_anchor",
							"type": "bool",
							"default_value": "true"
						}
					]
				},
				{
					"name": "get_anchor",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2869120046,
					"return_value": {
						"type": "float",
						"meta": "float"
					},
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						}
					]
				},
				{
					"name": "set_offset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4290182280,
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						},
						{
							"name": "offset",
							"type": "float",
							"meta": "float"
						}
					]
				},
				{
					"name": "get_offset",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2869120046,
					"return_value": {
						"type": "float",
						"meta": "float"
					},
					"arguments": [
						{
							"name": "offset",
							"type": "enum::Side"
						}
					]
				},
				{
					"name": "set_anchor_and_offset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4031722181,
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						},
						{
							"name": "anchor",
							"type": "float",
							"meta": "float"
						},
						{
							"name": "offset",
							"type": "float",
							"meta": "float"
						},
						{
							"name": "push_opposite_anchor",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
				{
					"name": "set_begin",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "position",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "set_end",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "position",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "set_position",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2436320129,
					"arguments": [
						{
							"name": "position",
							"type": "Vector2"
						},
						{
							"name": "keep_offsets",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
				{
					"name": "set_size",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2436320129,
					"arguments": [
						{
							"name": "size",
							"type": "Vector2"
						},
						{
							"name": "keep_offsets",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
				{
					"name": "reset_size",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "set_custom_minimum_size",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "size",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "set_global_position",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2436320129,
					"arguments": [
						{
							"name": "position",
							"type": "Vector2"
						},
						{
							"name": "keep_offsets",
							"type": "bool",
							"default_value": "false"
						}
					]
				},
				{
					"name": "set_rotation",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 373806689,
					"arguments": [
						{
							"name": "radians",
							"type": "float",
							"meta": "float"
						}
					]
				},
				{
					"name": "set_rotation_degrees",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 373806689,
					"arguments": [
						{
							"name": "degrees",
							"type": "float",
							"meta": "float"
						}
					]
				},
				{
					"name": "set_scale",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "scale",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "set_pivot_offset",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "pivot_offset",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "get_begin",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_end",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_position",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_rotation",
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
					"name": "get_rotation_degrees",
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
					"name": "get_scale",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_pivot_offset",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_custom_minimum_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_parent_area_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_global_position",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_screen_position",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341600327,
					"return_value": {
						"type": "Vector2"
					}
				},
				{
					"name": "get_rect",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1639390495,
					"return_value": {
						"type": "Rect2"
					}
				},
				{
					"name": "get_global_rect",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1639390495,
					"return_value": {
						"type": "Rect2"
					}
				},
				{
					"name": "set_focus_mode",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3232914922,
					"arguments": [
						{
							"name": "mode",
							"type": "enum::Control.FocusMode"
						}
					]
				},
				{
					"name": "get_focus_mode",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2132829277,
					"return_value": {
						"type": "enum::Control.FocusMode"
					}
				},
				{
					"name": "has_focus",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "grab_focus",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "release_focus",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "find_prev_valid_focus",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2783021301,
					"return_value": {
						"type": "Control"
					}
				},
				{
					"name": "find_next_valid_focus",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2783021301,
					"return_value": {
						"type": "Control"
					}
				},
				{
					"name": "find_valid_focus_neighbor",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1543910170,
					"return_value": {
						"type": "Control"
					},
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						}
					]
				},
				{
					"name": "set_h_size_flags",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 394851643,
					"arguments": [
						{
							"name": "flags",
							"type": "bitfield::Control.SizeFlags"
						}
					]
				},
				{
					"name": "get_h_size_flags",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3781367401,
					"return_value": {
						"type": "bitfield::Control.SizeFlags"
					}
				},
				{
					"name": "set_stretch_ratio",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 373806689,
					"arguments": [
						{
							"name": "ratio",
							"type": "float",
							"meta": "float"
						}
					]
				},
				{
					"name": "get_stretch_ratio",
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
					"name": "set_v_size_flags",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 394851643,
					"arguments": [
						{
							"name": "flags",
							"type": "bitfield::Control.SizeFlags"
						}
					]
				},
				{
					"name": "get_v_size_flags",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3781367401,
					"return_value": {
						"type": "bitfield::Control.SizeFlags"
					}
				},
				{
					"name": "set_theme",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2326690814,
					"arguments": [
						{
							"name": "theme",
							"type": "Theme"
						}
					]
				},
				{
					"name": "get_theme",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3846893731,
					"return_value": {
						"type": "Theme"
					}
				},
				{
					"name": "set_theme_type_variation",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "theme_type",
							"type": "StringName"
						}
					]
				},
				{
					"name": "get_theme_type_variation",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2002593661,
					"return_value": {
						"type": "StringName"
					}
				},
				{
					"name": "begin_bulk_theme_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "end_bulk_theme_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "add_theme_icon_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1373065600,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "texture",
							"type": "Texture2D"
						}
					]
				},
				{
					"name": "add_theme_stylebox_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4188838905,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "stylebox",
							"type": "StyleBox"
						}
					]
				},
				{
					"name": "add_theme_font_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3518018674,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "font",
							"type": "Font"
						}
					]
				},
				{
					"name": "add_theme_font_size_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2415702435,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "font_size",
							"type": "int",
							"meta": "int32"
						}
					]
				},
				{
					"name": "add_theme_color_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4260178595,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "color",
							"type": "Color"
						}
					]
				},
				{
					"name": "add_theme_constant_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2415702435,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "constant",
							"type": "int",
							"meta": "int32"
						}
					]
				},
				{
					"name": "remove_theme_icon_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "remove_theme_stylebox_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "remove_theme_font_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "remove_theme_font_size_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "remove_theme_color_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "remove_theme_constant_override",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3304788590,
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "get_theme_icon",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3163973443,
					"hash_compatibility": [
						2336455395
					],
					"return_value": {
						"type": "Texture2D"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_stylebox",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 604739069,
					"hash_compatibility": [
						2759935355
					],
					"return_value": {
						"type": "StyleBox"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_font",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2826986490,
					"hash_compatibility": [
						387378635
					],
					"return_value": {
						"type": "Font"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_font_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1327056374,
					"hash_compatibility": [
						229578101
					],
					"return_value": {
						"type": "int",
						"meta": "int32"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_color",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2798751242,
					"hash_compatibility": [
						2377051548
					],
					"return_value": {
						"type": "Color"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_constant",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1327056374,
					"hash_compatibility": [
						229578101
					],
					"return_value": {
						"type": "int",
						"meta": "int32"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_icon_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_stylebox_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_font_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_font_size_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_color_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_constant_override",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2619796661,
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						}
					]
				},
				{
					"name": "has_theme_icon",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_stylebox",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_font",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_font_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_color",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "has_theme_constant",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 866386512,
					"hash_compatibility": [
						1187511791
					],
					"return_value": {
						"type": "bool"
					},
					"arguments": [
						{
							"name": "name",
							"type": "StringName"
						},
						{
							"name": "theme_type",
							"type": "StringName",
							"default_value": "&\"\""
						}
					]
				},
				{
					"name": "get_theme_default_base_scale",
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
					"name": "get_theme_default_font",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3229501585,
					"return_value": {
						"type": "Font"
					}
				},
				{
					"name": "get_theme_default_font_size",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3905245786,
					"return_value": {
						"type": "int",
						"meta": "int32"
					}
				},
				{
					"name": "get_parent_control",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2783021301,
					"return_value": {
						"type": "Control"
					}
				},
				{
					"name": "set_h_grow_direction",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2022385301,
					"arguments": [
						{
							"name": "direction",
							"type": "enum::Control.GrowDirection"
						}
					]
				},
				{
					"name": "get_h_grow_direction",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3635610155,
					"return_value": {
						"type": "enum::Control.GrowDirection"
					}
				},
				{
					"name": "set_v_grow_direction",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2022385301,
					"arguments": [
						{
							"name": "direction",
							"type": "enum::Control.GrowDirection"
						}
					]
				},
				{
					"name": "get_v_grow_direction",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3635610155,
					"return_value": {
						"type": "enum::Control.GrowDirection"
					}
				},
				{
					"name": "set_tooltip_auto_translate_mode",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 776149714,
					"arguments": [
						{
							"name": "mode",
							"type": "enum::Node.AutoTranslateMode"
						}
					]
				},
				{
					"name": "get_tooltip_auto_translate_mode",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2498906432,
					"return_value": {
						"type": "enum::Node.AutoTranslateMode"
					}
				},
				{
					"name": "set_tooltip_text",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 83702148,
					"arguments": [
						{
							"name": "hint",
							"type": "String"
						}
					]
				},
				{
					"name": "get_tooltip_text",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 201670096,
					"return_value": {
						"type": "String"
					}
				},
				{
					"name": "get_tooltip",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2895288280,
					"return_value": {
						"type": "String"
					},
					"arguments": [
						{
							"name": "at_position",
							"type": "Vector2",
							"default_value": "Vector2(0, 0)"
						}
					]
				},
				{
					"name": "set_default_cursor_shape",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 217062046,
					"arguments": [
						{
							"name": "shape",
							"type": "enum::Control.CursorShape"
						}
					]
				},
				{
					"name": "get_default_cursor_shape",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2359535750,
					"return_value": {
						"type": "enum::Control.CursorShape"
					}
				},
				{
					"name": "get_cursor_shape",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1395773853,
					"return_value": {
						"type": "enum::Control.CursorShape"
					},
					"arguments": [
						{
							"name": "position",
							"type": "Vector2",
							"default_value": "Vector2(0, 0)"
						}
					]
				},
				{
					"name": "set_focus_neighbor",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2024461774,
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						},
						{
							"name": "neighbor",
							"type": "NodePath"
						}
					]
				},
				{
					"name": "get_focus_neighbor",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2757935761,
					"return_value": {
						"type": "NodePath"
					},
					"arguments": [
						{
							"name": "side",
							"type": "enum::Side"
						}
					]
				},
				{
					"name": "set_focus_next",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1348162250,
					"arguments": [
						{
							"name": "next",
							"type": "NodePath"
						}
					]
				},
				{
					"name": "get_focus_next",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4075236667,
					"return_value": {
						"type": "NodePath"
					}
				},
				{
					"name": "set_focus_previous",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1348162250,
					"arguments": [
						{
							"name": "previous",
							"type": "NodePath"
						}
					]
				},
				{
					"name": "get_focus_previous",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 4075236667,
					"return_value": {
						"type": "NodePath"
					}
				},
				{
					"name": "force_drag",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3191844692,
					"arguments": [
						{
							"name": "data",
							"type": "Variant"
						},
						{
							"name": "preview",
							"type": "Control"
						}
					]
				},
				{
					"name": "set_mouse_filter",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3891156122,
					"arguments": [
						{
							"name": "filter",
							"type": "enum::Control.MouseFilter"
						}
					]
				},
				{
					"name": "get_mouse_filter",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1572545674,
					"return_value": {
						"type": "enum::Control.MouseFilter"
					}
				},
				{
					"name": "set_force_pass_scroll_events",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "force_pass_scroll_events",
							"type": "bool"
						}
					]
				},
				{
					"name": "is_force_pass_scroll_events",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "set_clip_contents",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "enable",
							"type": "bool"
						}
					]
				},
				{
					"name": "is_clipping_contents",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2240911060,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "grab_click_focus",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "set_drag_forwarding",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1076571380,
					"arguments": [
						{
							"name": "drag_func",
							"type": "Callable"
						},
						{
							"name": "can_drop_func",
							"type": "Callable"
						},
						{
							"name": "drop_func",
							"type": "Callable"
						}
					]
				},
				{
					"name": "set_drag_preview",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1496901182,
					"arguments": [
						{
							"name": "control",
							"type": "Control"
						}
					]
				},
				{
					"name": "is_drag_successful",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "warp_mouse",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 743155724,
					"arguments": [
						{
							"name": "position",
							"type": "Vector2"
						}
					]
				},
				{
					"name": "set_shortcut_context",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1078189570,
					"arguments": [
						{
							"name": "node",
							"type": "Node"
						}
					]
				},
				{
					"name": "get_shortcut_context",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3160264692,
					"return_value": {
						"type": "Node"
					}
				},
				{
					"name": "update_minimum_size",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3218959716
				},
				{
					"name": "set_layout_direction",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3310692370,
					"arguments": [
						{
							"name": "direction",
							"type": "enum::Control.LayoutDirection"
						}
					]
				},
				{
					"name": "get_layout_direction",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 1546772008,
					"return_value": {
						"type": "enum::Control.LayoutDirection"
					}
				},
				{
					"name": "is_layout_rtl",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "set_auto_translate",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "enable",
							"type": "bool"
						}
					]
				},
				{
					"name": "is_auto_translating",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				},
				{
					"name": "set_localize_numeral_system",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 2586408642,
					"arguments": [
						{
							"name": "enable",
							"type": "bool"
						}
					]
				},
				{
					"name": "is_localizing_numeral_system",
					"is_const": true,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 36873697,
					"return_value": {
						"type": "bool"
					}
				}
			],
			"signals": [
				{
					"name": "resized"
				},
				{
					"name": "gui_input",
					"arguments": [
						{
							"name": "event",
							"type": "InputEvent"
						}
					]
				},
				{
					"name": "mouse_entered"
				},
				{
					"name": "mouse_exited"
				},
				{
					"name": "focus_entered"
				},
				{
					"name": "focus_exited"
				},
				{
					"name": "size_flags_changed"
				},
				{
					"name": "minimum_size_changed"
				},
				{
					"name": "theme_changed"
				}
			],
			"properties": [
				{
					"type": "bool",
					"name": "clip_contents",
					"setter": "set_clip_contents",
					"getter": "is_clipping_contents"
				},
				{
					"type": "Vector2",
					"name": "custom_minimum_size",
					"setter": "set_custom_minimum_size",
					"getter": "get_custom_minimum_size"
				},
				{
					"type": "int",
					"name": "layout_direction",
					"setter": "set_layout_direction",
					"getter": "get_layout_direction"
				},
				{
					"type": "int",
					"name": "layout_mode",
					"setter": "_set_layout_mode",
					"getter": "_get_layout_mode"
				},
				{
					"type": "int",
					"name": "anchors_preset",
					"setter": "_set_anchors_layout_preset",
					"getter": "_get_anchors_layout_preset"
				},
				{
					"type": "float",
					"name": "anchor_left",
					"setter": "_set_anchor",
					"getter": "get_anchor",
					"index": 0
				},
				{
					"type": "float",
					"name": "anchor_top",
					"setter": "_set_anchor",
					"getter": "get_anchor",
					"index": 1
				},
				{
					"type": "float",
					"name": "anchor_right",
					"setter": "_set_anchor",
					"getter": "get_anchor",
					"index": 2
				},
				{
					"type": "float",
					"name": "anchor_bottom",
					"setter": "_set_anchor",
					"getter": "get_anchor",
					"index": 3
				},
				{
					"type": "float",
					"name": "offset_left",
					"setter": "set_offset",
					"getter": "get_offset",
					"index": 0
				},
				{
					"type": "float",
					"name": "offset_top",
					"setter": "set_offset",
					"getter": "get_offset",
					"index": 1
				},
				{
					"type": "float",
					"name": "offset_right",
					"setter": "set_offset",
					"getter": "get_offset",
					"index": 2
				},
				{
					"type": "float",
					"name": "offset_bottom",
					"setter": "set_offset",
					"getter": "get_offset",
					"index": 3
				},
				{
					"type": "int",
					"name": "grow_horizontal",
					"setter": "set_h_grow_direction",
					"getter": "get_h_grow_direction"
				},
				{
					"type": "int",
					"name": "grow_vertical",
					"setter": "set_v_grow_direction",
					"getter": "get_v_grow_direction"
				},
				{
					"type": "Vector2",
					"name": "size",
					"setter": "_set_size",
					"getter": "get_size"
				},
				{
					"type": "Vector2",
					"name": "position",
					"setter": "_set_position",
					"getter": "get_position"
				},
				{
					"type": "Vector2",
					"name": "global_position",
					"setter": "_set_global_position",
					"getter": "get_global_position"
				},
				{
					"type": "float",
					"name": "rotation",
					"setter": "set_rotation",
					"getter": "get_rotation"
				},
				{
					"type": "float",
					"name": "rotation_degrees",
					"setter": "set_rotation_degrees",
					"getter": "get_rotation_degrees"
				},
				{
					"type": "Vector2",
					"name": "scale",
					"setter": "set_scale",
					"getter": "get_scale"
				},
				{
					"type": "Vector2",
					"name": "pivot_offset",
					"setter": "set_pivot_offset",
					"getter": "get_pivot_offset"
				},
				{
					"type": "int",
					"name": "size_flags_horizontal",
					"setter": "set_h_size_flags",
					"getter": "get_h_size_flags"
				},
				{
					"type": "int",
					"name": "size_flags_vertical",
					"setter": "set_v_size_flags",
					"getter": "get_v_size_flags"
				},
				{
					"type": "float",
					"name": "size_flags_stretch_ratio",
					"setter": "set_stretch_ratio",
					"getter": "get_stretch_ratio"
				},
				{
					"type": "bool",
					"name": "localize_numeral_system",
					"setter": "set_localize_numeral_system",
					"getter": "is_localizing_numeral_system"
				},
				{
					"type": "bool",
					"name": "auto_translate",
					"setter": "set_auto_translate",
					"getter": "is_auto_translating"
				},
				{
					"type": "String",
					"name": "tooltip_text",
					"setter": "set_tooltip_text",
					"getter": "get_tooltip_text"
				},
				{
					"type": "int",
					"name": "tooltip_auto_translate_mode",
					"setter": "set_tooltip_auto_translate_mode",
					"getter": "get_tooltip_auto_translate_mode"
				},
				{
					"type": "NodePath",
					"name": "focus_neighbor_left",
					"setter": "set_focus_neighbor",
					"getter": "get_focus_neighbor",
					"index": 0
				},
				{
					"type": "NodePath",
					"name": "focus_neighbor_top",
					"setter": "set_focus_neighbor",
					"getter": "get_focus_neighbor",
					"index": 1
				},
				{
					"type": "NodePath",
					"name": "focus_neighbor_right",
					"setter": "set_focus_neighbor",
					"getter": "get_focus_neighbor",
					"index": 2
				},
				{
					"type": "NodePath",
					"name": "focus_neighbor_bottom",
					"setter": "set_focus_neighbor",
					"getter": "get_focus_neighbor",
					"index": 3
				},
				{
					"type": "NodePath",
					"name": "focus_next",
					"setter": "set_focus_next",
					"getter": "get_focus_next"
				},
				{
					"type": "NodePath",
					"name": "focus_previous",
					"setter": "set_focus_previous",
					"getter": "get_focus_previous"
				},
				{
					"type": "int",
					"name": "focus_mode",
					"setter": "set_focus_mode",
					"getter": "get_focus_mode"
				},
				{
					"type": "int",
					"name": "mouse_filter",
					"setter": "set_mouse_filter",
					"getter": "get_mouse_filter"
				},
				{
					"type": "bool",
					"name": "mouse_force_pass_scroll_events",
					"setter": "set_force_pass_scroll_events",
					"getter": "is_force_pass_scroll_events"
				},
				{
					"type": "int",
					"name": "mouse_default_cursor_shape",
					"setter": "set_default_cursor_shape",
					"getter": "get_default_cursor_shape"
				},
				{
					"type": "Object",
					"name": "shortcut_context",
					"setter": "set_shortcut_context",
					"getter": "get_shortcut_context"
				},
				{
					"type": "Theme",
					"name": "theme",
					"setter": "set_theme",
					"getter": "get_theme"
				},
				{
					"type": "String",
					"name": "theme_type_variation",
					"setter": "set_theme_type_variation",
					"getter": "get_theme_type_variation"
				}
			]
		},
		{