package GDWrapper

import GDE "gdextension"



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

//"inherits": "Node",
CanvasItem_Virtuals_Info: struct {
    _draw: Method_Callback_Compare_Info,
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
}

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
AudioStream_Virtual_Info: struct {
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

//"inherits": "Node3D",
CollisionObject3D_Virtual_Info: struct {
    _input_event: Method_Callback_Compare_Info,
    _mouse_enter: Method_Callback_Compare_Info,
    _mouse_exit: Method_Callback_Compare_Info,
}

Method_Callback_Compare_Info :: struct {
    name: GDE.StringName,
    p_hash: u32,
}

init_Node_Virtuals_Info :: proc () {
    using Node_Virtuals_Info
    _physics_process.p_hash = 3218959716
    _process.p_hash = 3218959716
    _input.p_hash = 3218959716
    _ready.p_hash = 3218959716
    _enter_tree.p_hash = 3218959716
    _exit_tree.p_hash = 3218959716
    _get_accessibility_configuration_warnings.p_hash = 3218959716
    _get_configuration_warnings.p_hash = 3218959716
    _get_focused_accessibility_element.p_hash = 3218959716
    _shortcut_input.p_hash = 3218959716
    _unhandled_input.p_hash = 3218959716
    _unhandled_key_input.p_hash = 3218959716

    _physics_process.name = StringConstruct.stringNameNewString_r("_physics_process")
    _process.name = StringConstruct.stringNameNewString_r("_process")
    _input.name = StringConstruct.stringNameNewString_r("_input")
    _ready.name = StringConstruct.stringNameNewString_r("_ready")
    _enter_tree.name = StringConstruct.stringNameNewString_r("_enter_tree")
    _exit_tree.name = StringConstruct.stringNameNewString_r("_exit_tree")
    _get_accessibility_configuration_warnings.name = StringConstruct.stringNameNewString_r("_get_accessibility_configuration_warnings")
    _get_configuration_warnings.name = StringConstruct.stringNameNewString_r("_get_configuration_warnings")
    _get_focused_accessibility_element.name = StringConstruct.stringNameNewString_r("_get_focused_accessibility_element")
    _shortcut_input.name = StringConstruct.stringNameNewString_r("_shortcut_input")
    _unhandled_input.name = StringConstruct.stringNameNewString_r("_unhandled_input")
    _unhandled_key_input.name = StringConstruct.stringNameNewString_r("_unhandled_key_input")
}

init_CanvasItem_Virtuals_Info :: proc () {
    using CanvasItem_Virtuals_Info
    _draw.p_hash = 3218959716
    _draw.name = StringConstruct.stringNameNewString_r("_draw")
}

init_Control_Virtual_Info :: proc () {
    using Control_Virtual_Info
    _has_point.name = StringConstruct.stringNameNewString_r("_has_point")
    _has_point.p_hash = 556197845
    _structured_text_parser.name = StringConstruct.stringNameNewString_r("_structured_text_parser")
    _structured_text_parser.p_hash = 1292548940
    _get_minimum_size.name = StringConstruct.stringNameNewString_r("_get_minimum_size")
    _get_minimum_size.p_hash = 3341600327
    _get_tooltip.name = StringConstruct.stringNameNewString_r("_get_tooltip")
    _get_tooltip.p_hash = 3674420000
    _get_drag_data.name = StringConstruct.stringNameNewString_r("_get_drag_data")
    _get_drag_data.p_hash = 2233896889
    _can_drop_data.name = StringConstruct.stringNameNewString_r("_can_drop_data")
    _can_drop_data.p_hash = 2603004011
    _drop_data.name = StringConstruct.stringNameNewString_r("_drop_data")
    _drop_data.p_hash = 3699746064
    _make_custom_tooltip.name = StringConstruct.stringNameNewString_r("_make_custom_tooltip")
    _make_custom_tooltip.p_hash = 1976279298
    _accessibility_get_contextual_info.name = StringConstruct.stringNameNewString_r("_accessibility_get_contextual_info")
    _accessibility_get_contextual_info.p_hash = 201670096
    _get_accessibility_container_name.name = StringConstruct.stringNameNewString_r("_get_accessibility_container_name")
    _get_accessibility_container_name.p_hash = 2174079723
    _gui_input.name = StringConstruct.stringNameNewString_r("_gui_input")
    _gui_input.p_hash = 3754044979
}

init_Logger_Virtuals_Info :: proc () {
    using Logger_Virtual
    _log_error.p_hash = 27079556
    _log_error.name = StringConstruct.stringNameNewString_r("_log_error")
    _log_message.p_hash = 2678287736
    _log_message.name = StringConstruct.stringNameNewString_r("_log_message")
}

init_MainLoop_Virtual_Info :: proc () {
    using MainLoop_Virtual
    _initialize.p_hash = 3218959716
    _initialize.name = StringConstruct.stringNameNewString_r("_initialize")
    _physics_process.p_hash = 330693286
    _physics_process.name = StringConstruct.stringNameNewString_r("_physics_process")
    _process.p_hash = 330693286
    _process.name = StringConstruct.stringNameNewString_r("_process")
    _finalize.p_hash = 3218959716
    _finalize.name = StringConstruct.stringNameNewString_r("_finalize")
}

init_Resource_Virtual_Info :: proc () {
    using Resource_Virtual
    _setup_local_to_scene.p_hash = 3218959716
    _setup_local_to_scene.name = StringConstruct.stringNameNewString_r("_setup_local_to_scene")

    _get_rid.p_hash = 2944877500
    _get_rid.name = StringConstruct.stringNameNewString_r("_get_rid")

    _reset_state.p_hash = 3218959716
    _reset_state.name = StringConstruct.stringNameNewString_r("_reset_state")
    
    _set_path_cache.p_hash = 3218959716
    _set_path_cache.name = StringConstruct.stringNameNewString_r("_set_path_cache")
}

init_RenderDataExtension_Virtual_Info :: proc () {
    using RenderDataExtension_Virtual_Info
    _get_render_scene_buffers.p_hash = 2793216201
    _get_render_scene_buffers.name = StringConstruct.stringNameNewString_r("_get_render_scene_buffers")
    
    _get_render_scene_data.p_hash = 1288715698
    _get_render_scene_data.name = StringConstruct.stringNameNewString_r("_get_render_scene_data")
    
    _get_environment.p_hash = 2944877500
    _get_environment.name = StringConstruct.stringNameNewString_r("_get_environment")

    _get_camera_attributes.p_hash = 2944877500
    _get_camera_attributes.name = StringConstruct.stringNameNewString_r("_get_camera_attributes")
}

init_CompositorEffect_Virtual_Info :: proc () {
    using CompositorEffect_Virtual_Info
    _render_callback.p_hash = 2153422729
    _render_callback.name = StringConstruct.stringNameNewString_r("_render_callback")
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
    

    _start.name = StringConstruct.stringNameNewString_r("_start")
    _stop.name = StringConstruct.stringNameNewString_r("_stop")
    _is_playing.name = StringConstruct.stringNameNewString_r("_is_playing")
    _get_loop_count.name = StringConstruct.stringNameNewString_r("_get_loop_count")
    _get_playback_position.name = StringConstruct.stringNameNewString_r("_get_playback_position")
    _seek.name = StringConstruct.stringNameNewString_r("_seek")
    _mix.name = StringConstruct.stringNameNewString_r("_mix")
    _tag_used_streams.name = StringConstruct.stringNameNewString_r("_tag_used_streams")
    _set_parameter.name = StringConstruct.stringNameNewString_r("_set_parameter")
    _get_parameter.name = StringConstruct.stringNameNewString_r("_get_parameter")
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
    

    _instantiate_playback.name = StringConstruct.stringNameNewString_r("_instantiate_playback")
    _get_stream_name.name = StringConstruct.stringNameNewString_r("_get_stream_name")
    _get_length.name = StringConstruct.stringNameNewString_r("_get_length")
    _is_monophonic.name = StringConstruct.stringNameNewString_r("_is_monophonic")
    _get_bpm.name = StringConstruct.stringNameNewString_r("_get_bpm")
    _get_beat_count.name = StringConstruct.stringNameNewString_r("_get_beat_count")
    _get_tags.name = StringConstruct.stringNameNewString_r("_get_tags")
    _get_parameter_list.name = StringConstruct.stringNameNewString_r("_get_parameter_list")
    _has_loop.name = StringConstruct.stringNameNewString_r("_has_loop")
    _get_bar_beats.name = StringConstruct.stringNameNewString_r("_get_bar_beats")
}

init_CollisionObject2D_Virtual_Info :: proc () {
    using CollisionObject2D_Virtual_Info
    _input_event.p_hash = 1847696837
    _mouse_enter.p_hash = 3218959716
    _mouse_exit.p_hash = 3218959716
    _mouse_shape_enter.p_hash = 1286410249
    _mouse_shape_exit.p_hash = 1286410249

    _input_event.name = StringConstruct.stringNameNewString_r("_input_event")
    _mouse_enter.name = StringConstruct.stringNameNewString_r("_mouse_enter")
    _mouse_exit.name = StringConstruct.stringNameNewString_r("_mouse_exit")
    _mouse_shape_enter.name = StringConstruct.stringNameNewString_r("_mouse_shape_enter")
    _mouse_shape_exit.name = StringConstruct.stringNameNewString_r("_mouse_shape_exit")
}

init_CollisionObject3D_Virtual_Info :: proc () {
    using CollisionObject3D_Virtual_Info
    _input_event.p_hash = 2310605070
    _mouse_enter.p_hash = 3218959716
    _mouse_exit.p_hash = 3218959716

    _input_event.name = StringConstruct.stringNameNewString_r("_input_event")
    _mouse_enter.name = StringConstruct.stringNameNewString_r("_mouse_enter")
    _mouse_exit.name = StringConstruct.stringNameNewString_r("_mouse_exit")
}

//EditorResourceTooltipPlugin might be interesting in order to add tooltips based on resourceType.
//EditorScript extend this class's _run() in order for it to be executed from the Script Editor's File > Run menu option
//PhysicsServer3DExtension if you want to create your own custom PhysicsServer.
//PhysicsDirectBodyState3DExtension If you want to implement your own version of PhysicsDirectBodyState3D. Specifically here for GDExtension!
//AudioEffectInstance to implement your own custom AudioEffects for use on the Audio bus.
//VisualShaderNodeCustom If you want to have your own custom Node in the VisualShader tool.
//GLTFDocumentExtension The code that converts to/from a Godot scene can be intercepted at arbitrary points by GLTFDocumentExtension classes. This allows for custom data to be stored in the glTF file or for custom data to be converted to/from Godot nodes.