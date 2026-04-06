#+feature using-stmt
package Toxin

import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import "base:runtime"
import sics "base:intrinsics"
import Classes "../GD_Classes"
import "Input"

/*
* A bit of a hack, but since the data passed in from Godot is known based on the method being called
* and the fact that the data is passed in as a [^]rawptr means that a virutal method can access
* data via ^struct{arg1: ^type, arg2: ^type ...}
* returns are returned via a ^type which is known based on the virtual being called.
* Can leave it to the user to handle the pointers appropriately.
* Calling with using allows for the proc to access the arguments more easily, reducing the need for p_args.arg0 ...
*/

Method_Callback_Compare_Info :: struct {
    name: StringName,
    p_hash: u32,
};

//Use this if you're just doing a Node, as it's the type for VTable directly.
//This is the base of everything else, don't need to pass it through its own special vtable group.
Node_v_table:: struct ($T: typeid) {
    _physics_process: proc "c" (self: ^Class_Container(T), p_args: ^struct{delta: ^float}),
    _process: proc "c" (self: ^Class_Container(T), p_args: ^struct{delta: ^float}),
    _input: proc "c" (self: ^Class_Container(T), input: ^struct{inp: ^^Input.InputEvent}),
    _ready: proc "c" (self: ^Class_Container(T)),
    _enter_tree: proc "c" (self: ^Class_Container(T)),
    _exit_tree: proc "c" (self: ^Class_Container(T)),
    _get_accessibility_configuration_warnings: proc "c" (self: ^Class_Container(T)) -> PackedStringArray,
    _get_configuration_warnings: proc "c" (self: ^Class_Container(T)),
    _get_focused_accessibility_element: proc "c" (self: ^Class_Container(T)),
    _shortcut_input: proc "c" (self: ^Class_Container(T), p_args: ^struct{input: ^^Input.InputEvent}),
    _unhandled_input: proc "c" (self: ^Class_Container(T), p_args: ^struct{input: ^^Input.InputEvent}),
    _unhandled_key_input: proc "c" (self: ^Class_Container(T), p_args: ^struct{input: ^^Input.InputEvent}),
}

vCanvasItem:: struct($T: typeid){
    using vNode: Node_v_table(T),
    using vCanvasItem: CanvasItem_v_table(T),
}

vNode2D:: struct($T: typeid) {
    using vNode: Node_v_table(T),
    using vCanvasItem: CanvasItem_v_table(T),
}

vCollisionObject2D:: struct ($T: typeid) {
    using vNode: Node_v_table(T),
    using vCanvasItem: CanvasItem_v_table(T),
    using vCollisionObject2D: CollisionObject2D_v_table(T),
}

vTexture2D:: struct ($T: typeid) {
    using vTexture: Texture2D_v_table(T),
    using vNode: Node_v_table(T),
    using vCanvasItem: CanvasItem_v_table(T),
}

vControl:: struct($T: typeid) {
    using vControl: Control_v_table(T),
    using vNode: Node_v_table(T),
    using vCanvasItem: CanvasItem_v_table(T),
}

//"inherits": "Node2D",
Texture2D_v_table:: struct ($T: typeid){
    _is_pixel_opaque: proc "c" (self: ^Class_Container(T), using args: ^struct {x: ^Int, y: ^Int}),
    _get_height: proc "c" (self: ^Class_Container(T), p_args: rawptr = nil, r_ret: ^Int),
    _get_width: proc "c" (self: ^Class_Container(T), p_args: rawptr = nil, r_ret: ^Int),
    _draw_txt2D: proc "c" (self: ^Class_Container(T), p_args: ^struct { to_canvas_item: ^RID, rect: ^Rect2, src_rect: ^Rect2, modulate: ^Color, transpose: ^Bool, clip_uv: ^Bool }),
}

CanvasItem_v_table:: struct($T: typeid){
    _draw: proc "c" (self: ^Class_Container(T)),
}

//"inherits": "CanvasItem",
Control_v_table:: struct($T: typeid) {
    _has_point: proc "c" (self: ^Class_Container(T), p_args: ^struct{point: ^Vector2}),
    _structured_text_parser: proc "c" (self: ^Class_Container(T), p_args: ^struct{args: ^Array, text: ^gdstring}),
    _get_minimum_size: proc "c" (self: ^Class_Container(T)),
    _get_tooltip: proc "c" (self: ^Class_Container(T), p_args: ^struct{at_position: ^Vector2}),
    _get_drag_data: proc "c" (self: ^Class_Container(T), p_args: ^struct{at_position: ^Vector2}),
    _can_drop_data: proc "c" (self: ^Class_Container(T), p_args: ^struct{at_position: ^Vector2, data: ^GDE.Variant}),
    _drop_data: proc "c" (self: ^Class_Container(T), p_args: ^struct{at_position: ^Vector2, data: ^GDE.Variant}),
    _make_custom_tooltip: proc "c" (self: ^Class_Container(T), p_args: ^struct{for_text: ^gdstring}),
    _accessibility_get_contextual_info: proc "c" (self: ^Class_Container(T)),
    _get_accessibility_container_name: proc "c" (self: ^Class_Container(T),  p_args: ^struct{node: ^GDE.Node}),
    _gui_input: proc "c" (self: ^Class_Container(T), p_args: ^struct{event: ^^Input.InputEvent}),
};

//"inherits": "Node",
CanvasItem_Virtuals_Info: struct {
    _draw: Method_Callback_Compare_Info,
}

Texture2D_Virtuals_Info: struct {
    _is_pixel_opaque: Method_Callback_Compare_Info,
    _get_height: Method_Callback_Compare_Info,
    _get_width: Method_Callback_Compare_Info,
    _draw_txt2D: Method_Callback_Compare_Info,
}

//"inherits": "Object",
Node_Virtuals_Info: struct {
    _physics_process: Method_Callback_Compare_Info,
    _process: Method_Callback_Compare_Info,
    _input: Method_Callback_Compare_Info,
    _ready: Method_Callback_Compare_Info,
    _enter_tree: Method_Callback_Compare_Info,
    _exit_tree: Method_Callback_Compare_Info,
    _get_accessibility_configuration_warnings: Method_Callback_Compare_Info,
    _get_configuration_warnings: Method_Callback_Compare_Info,
    _get_focused_accessibility_element: Method_Callback_Compare_Info,
    _shortcut_input: Method_Callback_Compare_Info,
    _unhandled_input: Method_Callback_Compare_Info,
    _unhandled_key_input: Method_Callback_Compare_Info,
}

//"inherits": "CanvasItem",
Control_Virtual_Info: struct {
    _has_point: Method_Callback_Compare_Info,
    _structured_text_parser: Method_Callback_Compare_Info,
    _get_minimum_size: Method_Callback_Compare_Info,
    _get_tooltip: Method_Callback_Compare_Info,
    _get_drag_data: Method_Callback_Compare_Info,
    _can_drop_data: Method_Callback_Compare_Info,
    _drop_data: Method_Callback_Compare_Info,
    _make_custom_tooltip: Method_Callback_Compare_Info,
    _accessibility_get_contextual_info: Method_Callback_Compare_Info,
    _get_accessibility_container_name: Method_Callback_Compare_Info,
    _gui_input: Method_Callback_Compare_Info,
};

//"inherits": "RefCounted",
Logger_Virtual: struct {
    _log_error: Method_Callback_Compare_Info,
    _log_message: Method_Callback_Compare_Info,
}

//"inherits": "Object",
MainLoop_Virtual: struct {
    _initialize: Method_Callback_Compare_Info,
    _physics_process: Method_Callback_Compare_Info,
    _process: Method_Callback_Compare_Info,
    _finalize: Method_Callback_Compare_Info,
}

//"inherits": "RefCounted",
Resource_Virtual: struct {
    _setup_local_to_scene: Method_Callback_Compare_Info,
    _get_rid: Method_Callback_Compare_Info,
    _reset_state: Method_Callback_Compare_Info,
    _set_path_cache: Method_Callback_Compare_Info,
}

//"inherits": "RenderData",
RenderDataExtension_Virtual_Info: struct {
    _get_render_scene_buffers: Method_Callback_Compare_Info,
    _get_render_scene_data: Method_Callback_Compare_Info,
    _get_environment: Method_Callback_Compare_Info,
    _get_camera_attributes: Method_Callback_Compare_Info,
}

//This resource defines a custom rendering effect that can be applied to Viewports through the viewports' Environment. 
//This particular method receives the RenderData from the RenderServer.
//"inherits": "Resource",
CompositorEffect_Virtual_Info: struct {
    _render_callback: Method_Callback_Compare_Info,
}

//"inherits": "Resource"
AudioStreamPlayback_Virtual_Info: struct {
    _start: Method_Callback_Compare_Info,
    _stop: Method_Callback_Compare_Info,
    _is_playing: Method_Callback_Compare_Info,
    _get_loop_count: Method_Callback_Compare_Info,
    _get_playback_position: Method_Callback_Compare_Info,
    _seek: Method_Callback_Compare_Info,
    _mix: Method_Callback_Compare_Info,
    _tag_used_streams: Method_Callback_Compare_Info,
    _set_parameter: Method_Callback_Compare_Info,
    _get_parameter: Method_Callback_Compare_Info,
}

//"inherits": "Resource",
AudioStream_Virtual_Info: Classes.AudioStream_Virtual_Info

//"inherits": "Resource",
AudioStream_Virtual_Info2: struct {
    _instantiate_playback: Method_Callback_Compare_Info,
    _get_stream_name: Method_Callback_Compare_Info,
    _get_length: Method_Callback_Compare_Info,
    _is_monophonic: Method_Callback_Compare_Info,
    _get_bpm: Method_Callback_Compare_Info,
    _get_beat_count: Method_Callback_Compare_Info,
    _get_tags: Method_Callback_Compare_Info,
    _get_parameter_list: Method_Callback_Compare_Info,
    _has_loop: Method_Callback_Compare_Info,
    _get_bar_beats: Method_Callback_Compare_Info,
}

//"inherits": "Node2D",
CollisionObject2D_Virtual_Info: struct {
    _input_event: Method_Callback_Compare_Info,
    _mouse_enter: Method_Callback_Compare_Info,
    _mouse_exit: Method_Callback_Compare_Info,
    _mouse_shape_enter: Method_Callback_Compare_Info,
    _mouse_shape_exit: Method_Callback_Compare_Info,
}

//"inherits": "Node2D",
CollisionObject2D_v_table:: struct (T: typeid){
    _input_event: proc "c" (self: ^Class_Container(T), using args: ^struct {viewport: ^^Object, event: ^^Input.InputEvent, shape_idx: ^Int}),
}

//"inherits": "Node3D",
CollisionObject3D_Virtual_Info: struct {
    _input_event: Method_Callback_Compare_Info,
    _mouse_enter: Method_Callback_Compare_Info,
    _mouse_exit: Method_Callback_Compare_Info,
}


Return_Node_Virtuals :: proc (class_v_table: $T, p_class_userdata: rawptr, p_name: ^StringName, p_hash: u32) -> (rawptr, bool) {

        using Node_Virtuals_Info
        
        if (GDW.stringNameCompare(p_name, &_ready.name) && p_hash == _ready.p_hash) {
            return cast(rawptr)class_v_table._ready, true
        }
        if (GDW.stringNameCompare(p_name, &_process.name) && p_hash == _process.p_hash) {
            return cast(rawptr)class_v_table._process, true
        }
        if (GDW.stringNameCompare(p_name, &_physics_process.name) && p_hash == _physics_process.p_hash) {
            return cast(rawptr)class_v_table._physics_process, true
        }
        if (GDW.stringNameCompare(p_name, &_input.name) && p_hash == _input.p_hash) {
            return cast(rawptr)class_v_table._input, true
        }
        if (GDW.stringNameCompare(p_name, &_enter_tree.name) && p_hash == _enter_tree.p_hash) {
            return cast(rawptr)class_v_table._enter_tree, true
        }
        if (GDW.stringNameCompare(p_name, &_exit_tree.name) && p_hash == _exit_tree.p_hash) {
            return cast(rawptr)class_v_table._exit_tree, true
        }
        if (GDW.stringNameCompare(p_name, &_get_accessibility_configuration_warnings.name) && p_hash == _get_accessibility_configuration_warnings.p_hash) {
            return cast(rawptr)class_v_table._get_accessibility_configuration_warnings, true
        }
        if (GDW.stringNameCompare(p_name, &_get_configuration_warnings.name) && p_hash == _get_configuration_warnings.p_hash) {
            return cast(rawptr)class_v_table._get_configuration_warnings, true
        }
        if (GDW.stringNameCompare(p_name, &_get_focused_accessibility_element.name) && p_hash == _get_focused_accessibility_element.p_hash) {
            return cast(rawptr)class_v_table._get_focused_accessibility_element, true
        }
        if (GDW.stringNameCompare(p_name, &_shortcut_input.name) && p_hash == _shortcut_input.p_hash) {
            return cast(rawptr)class_v_table._shortcut_input, true
        }
        if (GDW.stringNameCompare(p_name, &_unhandled_input.name) && p_hash == _unhandled_input.p_hash) {
            return cast(rawptr)class_v_table._unhandled_input, true
        }
        if (GDW.stringNameCompare(p_name, &_unhandled_key_input.name) && p_hash == _unhandled_key_input.p_hash) {
            return cast(rawptr)class_v_table._unhandled_key_input, true
        }

    return nil, false
}

Match_Draw_Virtuals :: proc (class_v_table: $T, p_class_userdata: rawptr, p_name: ^StringName, p_hash: u32) -> (rawptr, bool) {
        using CanvasItem_Virtuals_Info
        if (GDW.stringNameCompare(p_name, &_draw.name) && p_hash == _draw.p_hash) {
            return cast(rawptr)class_v_table._draw, true
        }
    return nil, false
}


Return_CanvasItem_Virtuals :: proc (class_v_table: $T, p_class_userdata: rawptr, p_name: ^StringName, p_hash: u32) -> (rawptr, bool) {
        using CanvasItem_Virtuals_Info
        if (GDW.stringNameCompare(p_name, &_draw.name) && p_hash == _draw.p_hash) {
            return cast(rawptr)class_v_table._draw, true
        }
    return nil, false
}

Return_Collision2D_Virtuals :: proc (class_v_table: $T, p_class_userdata: rawptr, p_name: ^StringName, p_hash: u32) -> (rawptr, bool) {
        using CollisionObject2D_Virtual_Info
        if (GDW.stringNameCompare(p_name, &_input_event.name) && p_hash == _input_event.p_hash) {
            if class_v_table._input_event == nil do return nil, false
            return cast(rawptr)class_v_table._input_event, true
        }
    return nil, false
}

Return_texture_Virtuals :: proc (class_v_table: $T, p_class_userdata: rawptr, p_name: ^StringName, p_hash: u32) -> (rawptr, bool) {
        using Texture2D_Virtuals_Info
        if (p_hash == _is_pixel_opaque.p_hash && GDW.stringNameCompare(p_name, &_is_pixel_opaque.name)) {
            return cast(rawptr)class_v_table._is_pixel_opaque, true
        }
        if (p_hash == _get_height.p_hash && GDW.stringNameCompare(p_name, &_get_height.name)) {
            return cast(rawptr)class_v_table._get_height, true
        }
        if (p_hash == _get_width.p_hash && GDW.stringNameCompare(p_name, &_get_width.name)) {
            return cast(rawptr)class_v_table._get_width, true
        }
        if (p_hash == _draw_txt2D.p_hash && GDW.stringNameCompare(p_name, &_draw_txt2D.name)) {
            return cast(rawptr)class_v_table._draw_txt2D, true
        }
        if (p_hash == _draw_txt2D.p_hash && GDW.stringNameCompare(p_name, &_draw_txt2D.name)) {
            return cast(rawptr)class_v_table._draw_txt2D, true
        }
    return nil, false
}

init_Node_Virtuals_Info :: proc () {
    
    Node_Virtuals_Info._physics_process.p_hash = 373806689
    Node_Virtuals_Info._process.p_hash = 373806689
    Node_Virtuals_Info._input.p_hash = 3754044979
    Node_Virtuals_Info._ready.p_hash = 3218959716
    Node_Virtuals_Info._enter_tree.p_hash = 3218959716
    Node_Virtuals_Info._exit_tree.p_hash = 3218959716
    Node_Virtuals_Info._get_accessibility_configuration_warnings.p_hash = 3218959716
    Node_Virtuals_Info._get_configuration_warnings.p_hash = 1139954409
    Node_Virtuals_Info._get_focused_accessibility_element.p_hash = 3218959716
    Node_Virtuals_Info._shortcut_input.p_hash = 3754044979
    Node_Virtuals_Info._unhandled_input.p_hash = 3754044979
    Node_Virtuals_Info._unhandled_key_input.p_hash = 3754044979

    Node_Virtuals_Info._physics_process.name = GDW.StringConstruct("_physics_process")
    Node_Virtuals_Info._process.name = GDW.StringConstruct("_process")
    Node_Virtuals_Info._input.name = GDW.StringConstruct("_input")
    Node_Virtuals_Info._ready.name = GDW.StringConstruct("_ready")
    Node_Virtuals_Info._enter_tree.name = GDW.StringConstruct("_enter_tree")
    Node_Virtuals_Info._exit_tree.name = GDW.StringConstruct("_exit_tree")
    Node_Virtuals_Info._get_accessibility_configuration_warnings.name = GDW.StringConstruct("_get_accessibility_configuration_warnings")
    Node_Virtuals_Info._get_configuration_warnings.name = GDW.StringConstruct("_get_configuration_warnings")
    Node_Virtuals_Info._get_focused_accessibility_element.name = GDW.StringConstruct("_get_focused_accessibility_element")
    Node_Virtuals_Info._shortcut_input.name = GDW.StringConstruct("_shortcut_input")
    Node_Virtuals_Info._unhandled_input.name = GDW.StringConstruct("_unhandled_input")
    Node_Virtuals_Info._unhandled_key_input.name = GDW.StringConstruct("_unhandled_key_input")
}

init_CanvasItem_Virtuals_Info :: proc () {
    using CanvasItem_Virtuals_Info
    _draw.p_hash = 3218959716
    _draw.name = GDW.StringConstruct("_draw")
}

init_Texture2D_Virtuals_Info :: proc () {
    using Texture2D_Virtuals_Info
    _is_pixel_opaque.p_hash = 2522259332
    _is_pixel_opaque.name = GDW.StringConstruct("_is_pixel_opaque")
    
    _get_height.p_hash = 3905245786
    _get_height.name = GDW.StringConstruct("_get_height")
    
    _get_width.p_hash = 3905245786
    _draw_txt2D.p_hash = 4094143664

    _get_width.name = GDW.StringConstruct("_get_width")
    _draw_txt2D.name = GDW.StringConstruct("_draw_rect_region")
}

init_Control_Virtual_Info :: proc () {
    using Control_Virtual_Info
    _has_point.name = GDW.StringConstruct("_has_point")
    _has_point.p_hash = 556197845
    _structured_text_parser.name = GDW.StringConstruct("_structured_text_parser")
    _structured_text_parser.p_hash = 1292548940
    _get_minimum_size.name = GDW.StringConstruct("_get_minimum_size")
    _get_minimum_size.p_hash = 3341600327
    _get_tooltip.name = GDW.StringConstruct("_get_tooltip")
    _get_tooltip.p_hash = 3674420000
    _get_drag_data.name = GDW.StringConstruct("_get_drag_data")
    _get_drag_data.p_hash = 2233896889
    _can_drop_data.name = GDW.StringConstruct("_can_drop_data")
    _can_drop_data.p_hash = 2603004011
    _drop_data.name = GDW.StringConstruct("_drop_data")
    _drop_data.p_hash = 3699746064
    _make_custom_tooltip.name = GDW.StringConstruct("_make_custom_tooltip")
    _make_custom_tooltip.p_hash = 1976279298
    _accessibility_get_contextual_info.name = GDW.StringConstruct("_accessibility_get_contextual_info")
    _accessibility_get_contextual_info.p_hash = 201670096
    _get_accessibility_container_name.name = GDW.StringConstruct("_get_accessibility_container_name")
    _get_accessibility_container_name.p_hash = 2174079723
    _gui_input.name = GDW.StringConstruct("_gui_input")
    _gui_input.p_hash = 3754044979
}

init_Logger_Virtuals_Info :: proc () {
    using Logger_Virtual
    _log_error.p_hash = 27079556
    _log_error.name = GDW.StringConstruct("_log_error")
    _log_message.p_hash = 2678287736
    _log_message.name = GDW.StringConstruct("_log_message")
}

init_MainLoop_Virtual_Info :: proc () {
    using MainLoop_Virtual
    _initialize.p_hash = 3218959716
    _initialize.name = GDW.StringConstruct("_initialize")
    _physics_process.p_hash = 330693286
    _physics_process.name = GDW.StringConstruct("_physics_process")
    _process.p_hash = 330693286
    _process.name = GDW.StringConstruct("_process")
    _finalize.p_hash = 3218959716
    _finalize.name = GDW.StringConstruct("_finalize")
}

init_Resource_Virtual_Info :: proc () {
    using Resource_Virtual
    _setup_local_to_scene.p_hash = 3218959716
    _setup_local_to_scene.name = GDW.StringConstruct("_setup_local_to_scene")

    _get_rid.p_hash = 2944877500
    _get_rid.name = GDW.StringConstruct("_get_rid")

    _reset_state.p_hash = 3218959716
    _reset_state.name = GDW.StringConstruct("_reset_state")
    
    _set_path_cache.p_hash = 3218959716
    _set_path_cache.name = GDW.StringConstruct("_set_path_cache")
}

init_RenderDataExtension_Virtual_Info :: proc () {
    using RenderDataExtension_Virtual_Info
    _get_render_scene_buffers.p_hash = 2793216201
    _get_render_scene_buffers.name = GDW.StringConstruct("_get_render_scene_buffers")
    
    _get_render_scene_data.p_hash = 1288715698
    _get_render_scene_data.name = GDW.StringConstruct("_get_render_scene_data")
    
    _get_environment.p_hash = 2944877500
    _get_environment.name = GDW.StringConstruct("_get_environment")

    _get_camera_attributes.p_hash = 2944877500
    _get_camera_attributes.name = GDW.StringConstruct("_get_camera_attributes")
}

init_CompositorEffect_Virtual_Info :: proc () {
    using CompositorEffect_Virtual_Info
    _render_callback.p_hash = 2153422729
    _render_callback.name = GDW.StringConstruct("_render_callback")
}


init_AudioStreamPlayback_Virtual_Info :: proc () {
    using AudioStreamPlayback_Virtual_Info
    _start.p_hash = 373806689
    _stop.p_hash = 3218959716
    _is_playing.p_hash = 36873697
    _get_loop_count.p_hash = 3905245786
    _get_playback_position.p_hash = 1740695150
    _seek.p_hash = 373806689
    _mix.p_hash = 925936155
    _tag_used_streams.p_hash = 3218959716
    _set_parameter.p_hash = 3776071444
    _get_parameter.p_hash = 2760726917
    

    _start.name = GDW.StringConstruct("_start")
    _stop.name = GDW.StringConstruct("_stop")
    _is_playing.name = GDW.StringConstruct("_is_playing")
    _get_loop_count.name = GDW.StringConstruct("_get_loop_count")
    _get_playback_position.name = GDW.StringConstruct("_get_playback_position")
    _seek.name = GDW.StringConstruct("_seek")
    _mix.name = GDW.StringConstruct("_mix")
    _tag_used_streams.name = GDW.StringConstruct("_tag_used_streams")
    _set_parameter.name = GDW.StringConstruct("_set_parameter")
    _get_parameter.name = GDW.StringConstruct("_get_parameter")
}

init_AudioStream_Virtual_Info :: proc () {
    using AudioStream_Virtual_Info
    _instantiate_playback.p_hash = 3093715447
    _get_stream_name.p_hash = 201670096
    _get_length.p_hash = 1740695150
    _is_monophonic.p_hash = 36873697
    _get_bpm.p_hash = 1740695150
    _get_beat_count.p_hash = 3905245786
    _get_tags.p_hash = 3102165223
    _get_parameter_list.p_hash = 3995934104
    _has_loop.p_hash = 36873697
    _get_bar_beats.p_hash = 3905245786


    _instantiate_playback.name = GDW.StringConstruct("_instantiate_playback")
    _get_stream_name.name = GDW.StringConstruct("_get_stream_name")
    _get_length.name = GDW.StringConstruct("_get_length")
    _is_monophonic.name = GDW.StringConstruct("_is_monophonic")
    _get_bpm.name = GDW.StringConstruct("_get_bpm")
    _get_beat_count.name = GDW.StringConstruct("_get_beat_count")
    _get_tags.name = GDW.StringConstruct("_get_tags")
    _get_parameter_list.name = GDW.StringConstruct("_get_parameter_list")
    _has_loop.name = GDW.StringConstruct("_has_loop")
    _get_bar_beats.name = GDW.StringConstruct("_get_bar_beats")
}

init_CollisionObject2D_Virtual_Info :: proc () {
    using CollisionObject2D_Virtual_Info
    _input_event.p_hash = 1847696837
    _mouse_enter.p_hash = 3218959716
    _mouse_exit.p_hash = 3218959716
    _mouse_shape_enter.p_hash = 1286410249
    _mouse_shape_exit.p_hash = 1286410249

    _input_event.name = GDW.StringConstruct("_input_event")
    _mouse_enter.name = GDW.StringConstruct("_mouse_enter")
    _mouse_exit.name = GDW.StringConstruct("_mouse_exit")
    _mouse_shape_enter.name = GDW.StringConstruct("_mouse_shape_enter")
    _mouse_shape_exit.name = GDW.StringConstruct("_mouse_shape_exit")
}

init_CollisionObject3D_Virtual_Info :: proc () {
    using CollisionObject3D_Virtual_Info
    _input_event.p_hash = 2310605070
    _mouse_enter.p_hash = 3218959716
    _mouse_exit.p_hash = 3218959716

    _input_event.name = GDW.StringConstruct("_input_event")
    _mouse_enter.name = GDW.StringConstruct("_mouse_enter")
    _mouse_exit.name = GDW.StringConstruct("_mouse_exit")
}

//EditorResourceTooltipPlugin might be interesting in order to add tooltips based on resourceType.
//EditorScript extend this class's _run() in order for it to be executed from the Script Editor's File > Run menu option
//PhysicsServer3DExtension if you want to create your own custom PhysicsServer.
//PhysicsDirectBodyState3DExtension If you want to implement your own version of PhysicsDirectBodyState3D. Specifically here for GDExtension!
//AudioEffectInstance to implement your own custom AudioEffects for use on the Audio bus.
//VisualShaderNodeCustom If you want to have your own custom Node in the VisualShader tool.
//GLTFDocumentExtension The code that converts to/from a Godot scene can be intercepted at arbitrary points by GLTFDocumentExtension classes. This allows for custom data to be stored in the glTF file or for custom data to be converted to/from Godot nodes.