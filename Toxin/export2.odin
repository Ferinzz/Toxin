
package Toxin

import "base:builtin"
import "base:runtime"
import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import sics "base:intrinsics"
import "core:fmt"
import "core:reflect"
import "core:strings"


//CS is Class_Struct
gsetter_userdata_t:: struct($T:typeid, $CS: typeid) {
    gs_type: GDE.VariantType,
    getter_method: proc "c" (Object: ^Class_Container(CS)) -> T,
    setter_method: proc "c" (Object: ^Class_Container(CS), args: ^T),
    fieldname: string,
}

gsetter_userdata_static:: struct($T:typeid) {
    gs_type: GDE.VariantType,
    getter_method: proc "c" () -> T,
    setter_method: proc "c" (args: ^T),
    fieldname: string,
}

getbuf:[100]u8
setbuf:[100]u8

//Does not support pass by copy.
Export_Default2 :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t) {
    info:= make_property(getter_setter.gs_type, getter_setter.fieldname)
    Export5(className_SN, getter_setter, &info)
    destructProperty(&info)
}

//Does not support pass by copy.
Export_default_static :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_static) {
    if getter_setter.getter_method == nil && getter_setter.setter_method == nil {
        return .missing_getset_ptr
    }
    info:= make_property(getter_setter.gs_type, getter_setter.fieldname)
    Export_static(className_SN, getter_setter, &info)
    destructProperty(&info)
}

export_enum_as_int :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t($V, $C), $E: typeid) where sics.type_is_enum(E) && V == Int{
    prop_info:= enum_info(E, getter_setter.fieldname)
    Export5(className_SN, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

export_enum_as_int_static :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_static($V), $E: typeid) where sics.type_is_enum(E) && V == Int {
    prop_info:= enum_info(E, getter_setter.fieldname)
    Export_static(className_SN, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

export_enum_as_type :: proc(className_SN: ^StringName, $E: typeid) where sics.type_is_enum(E) {
    enumName:= type_info_of(out_enum).variant.(runtime.Type_Info_Named).name
    info:=type_info_of(out_enum).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)
    for field, idx in info.names {
        export_const(className_SN, enumName, field, info.values[idx], false, Library)
    }
}

export_const :: proc(className_SN: ^StringName, enum_name: string, name: string, value: Int, bitfield: Bool, Library: GDE.ClassDB) {
    name_SN:= GDW.StringConstruct(name)
    enum_name_SN:= GDW.StringConstruct(enum_name)
    gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(Library, className_SN, &name_SN, &enum_name_SN, value, bitfield)
}

export_range :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t, range_info: $R/Ranged_Num) {
    build:= strings.builder_make()
    fmt.sbprintf(&build, "%d,%d,", range_info.min, range_info.max)
    if range_info.step > 0 {
        fmt.sbprintf(&build, "%d", range_info.step)
    }
    for flag in range_info.flags {
        if flag != .none {
            strings.write_byte(&build, ',')
            fmt.sbprint(&build, flag, sep="")
        }
    }
    info:= Make_Property_Full(getter_setter.gs_type, getter_setter.fieldname, .RANGE, strings.to_string(build), "", PROPERTY_USAGE_DEFAULT)
    Export5(className_SN, getter_setter, &info)
    strings.builder_destroy(&build)
    destructProperty(&info)
}


/*Struct to pass data for a ranged variable.
* Supports: float, int
* min: lowest value allowed by the editor.
* max: largest value allowed by the editor.
* step: by how much it should increment. 0 will be ignored.
* flags: additional usage information.
* validate: Not implemented. if Odin's callback should verify the range.
*/
Ranged_Num :: struct ($T: typeid) #all_or_none {
  min: T,
  max: T,
  step: T,
  flags: Range_Flags,
}

Range_Flags :: bit_set [Range; Int]

Range :: enum {
  none,
  or_greater, //Can exceed the max limit
  or_less, //Can go lower than the min limit
  exp, //
  hide_slider, //Slider will not appear in editor
  radians_as_degrees, //will represent radian values as degrees
  degrees, //limit the range to degrees (-360 to 360)
}

enum_info :: proc($E: typeid, fieldname: string, prop_usage: PropertyUsageFlagsbits = PROPERTY_USAGE_DEFAULT) -> (prop_info: GDE.PropertyInfo) where sics.type_is_enum(E) && sics.type_core_type(E) == Int {
    info:= type_info_of(E).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)

    build, b_err:= strings.builder_make()
    if b_err != nil {
        return
    }
    for name, idx in info.names {
        if idx > 0 {
            strings.write_byte(&build, ',')
        }
        fmt.sbprintf(&build, "%s:%d", name, i64(info.values[idx]))
    }

    prop_info=makePropertyFull_string(.INT, fieldname, .ENUM, strings.to_string(build), string(""), prop_usage)
    strings.builder_destroy(&build)
    return
}

/*
* used for Export_Tool_Button to specify the details of the button.
* text: will be displayed in the button itself.
* icon: the icon type to be displayed alongside the button. ex. ColorRect will show the color selector icon.
*/
tool_Button_Info :: struct {
    text: string,
    icon: string,
}
/*
* Tells Godot to create a button which will call the Callable returned by the getter function.
* Callable needs to exist at the time the button is pressed.
* Callable needs to be returned to Godot via a getter. The getter is called at button press.
* Set the callback of the callable to one which will only need to exist when the editor is running (unless this will be used in scripting or signals as well.)
*/
export_tool_button :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t($T, $CS), button_props: tool_Button_Info) where T == Callable {
    hint_string:= strings.builder_make()
    strings.write_string(&hint_string, button_props.text)
    if len(button_props.text) > 0 && len(button_props.icon) > 0 {
        fmt.sbprint(&hint_string, ',', button_props.icon, sep="")
    }
    prop_info:= Make_Property_Full(.CALLABLE, getter_setter.fieldname, .TOOL_BUTTON, strings.to_string(hint_string), "", {.EDITOR, .READ_ONLY})
    Export5(className, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

export_tool_button_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static($T), button_props: tool_Button_Info) where T == Callable {
    hint_string:= strings.builder_make()
    strings.write_string(&hint_string, button_props.text)
    if len(button_props.text) > 0 && len(button_props.icon) > 0 {
        fmt.sbprint(&hint_string, ',', button_props.icon, sep="")
    }
    prop_info:= Make_Property_Full(.CALLABLE, getter_setter.fieldname, .TOOL_BUTTON, strings.to_string(hint_string), "", {.EDITOR, .READ_ONLY})
    Export_static(className, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

export_dictionary_localizable_string :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    prop_info:= Make_Property_Full(.DICTIONARY, getter_setter.fieldname, .LOCALIZABLE_STRING, "", "", prop_usage)
    Export5(className, getter_setter, &prop_info)
    destructProperty(&prop_info)
}


Easing_Type: [Easing_Options]string = {
  .none = "",
  .attenuation= "attenuation",
  .positive_only = "positive_only",
}

Easing_Options :: enum {
  none,
  attenuation,
  positive_only,
}

export_easing :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t($T, $CS), easing: Easing_Options) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    info: GDE.PropertyInfo = Make_Property_Full(.FLOAT, fieldName, .EXP_EASING, Easing_Type[easing], "", prop_usage)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

export_easing_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static($T), easing: Easing_Options) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    info: GDE.PropertyInfo = Make_Property_Full(.FLOAT, fieldName, .EXP_EASING, Easing_Type[easing], "", prop_usage)
    Export_static(className, getter_setter, &info)
    destructProperty(&info)
}

export_int_as_pointer :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t($T, $CS)) where sics.type_is_pointer(T) {
    prop_usage:= {PROPERTY_USAGE_DEFAULT, .READ_ONLY}
    info: GDE.PropertyInfo = Make_Property_Full(.INT, fieldName, .INT_AS_POINTER, "", prop_usage)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}
export_int_as_pointer_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static($T)) where sics.type_is_pointer(T) {
    prop_usage:= {PROPERTY_USAGE_DEFAULT, .READ_ONLY}
    info: GDE.PropertyInfo = Make_Property_Full(.INT, fieldName, .INT_AS_POINTER, "", prop_usage)
    Export_static(className, getter_setter, &info)
    destructProperty(&info)
}

export_color_noalpha :: proc(clasName: ^StringName, getter_setter: ^gsetter_userdata_t) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    info: GDE.PropertyInfo = Make_Property_Full(.COLOR, fieldName, .COLOR_NO_ALPHA, "", prop_usage)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

export_color_noalpha_static :: proc(clasName: ^StringName, getter_setter: ^gsetter_userdata_static) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    info: GDE.PropertyInfo = Make_Property_Full(.COLOR, fieldName, .COLOR_NO_ALPHA, "", prop_usage)
    export_static(className, getter_setter, &info)
    destructProperty(&info)
}

export_int_as_flag :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t($T, $CS), $F: typeid) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    hint_string:= strings.builder_make()
    when sics.type_is_enum(sics.type_bit_set_elem_type($F)) {
        flag_enum:= type_info_of(F).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)
        for name, idx in flag_enum.names {
            if idx > 0 {
                strings.write_byte(&build, ',')
            }
            fmt.sbprintf(&build, "%s:%d", name, i64(info.values[idx]))
        }
    } else {
        fmt.sbprint(&hint_string, type_info_of(F).variant.(runtime.Type_Info_Bit_Set).lower)
        for i:= type_info_of(F).variant.(runtime.Type_Info_Bit_Set).lower+1; i< type_info_of(F).variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            fmt.sbprintf(&hint_string, ",%v", i)
        }
    }
    prop_info:= Make_Property_Full(.INT, getter_setter.fieldname, .FLAGS, strings.to_string(hint_string), "", prop_usage)
    Export5(className, getter_setter, &prop_info)
    strings.builder_destroy(&hint_string)
    destructProperty(&prop_info)
}

export_int_as_flag_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static($T), $F: typeid) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    hint_string:= strings.builder_make()
    when sics.type_is_enum(sics.type_bit_set_elem_type(F)) {
        flag_enum:= type_info_of(sics.type_bit_set_elem_type(F)).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)
        for name, idx in flag_enum.names {
            if idx > 0 {
                strings.write_byte(&build, ',')
            }
            fmt.sbprintf(&build, "%s:%d", name, i64(info.values[idx]))
        }
    } else {
        fmt.sbprint(&hint_string, type_info_of(F).variant.(runtime.Type_Info_Bit_Set).lower)
        for i:= type_info_of(F).variant.(runtime.Type_Info_Bit_Set).lower+1; i< type_info_of(F).variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            fmt.sbprintf(&hint_string, ",%v", i)
        }
    }
    prop_info:= Make_Property_Full(.INT, getter_setter.fieldname, .FLAGS, strings.to_string(hint_string), "", prop_usage)
    Export_static(className, getter_setter, &prop_info)
    strings.builder_destroy(&hint_string)
    destructProperty(&prop_info)
}

export_flags :: proc(className: ^StringName, $F: typeid) where sics.type_is_bit_set(outbit_set) && sics.type_is_named(outbit_set) {
    bsname:= type_info_of(F).variant.(runtime.Type_Info_Named).name
    bsname_SN:= GDW.StringConstruct(bsname)
    when sics.type_is_enum(sics.type_bit_set_elem_type((F))) {
        flag_fields:= (type_info_of(sics.type_bit_set_elem_type(F)).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum))
        for name, idx in flag_fields.names {
            name_SN:= GDW.StringConstruct(name)
            gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(Library, className, &bsname_SN, &name_SN, Int(1<<flag_fields.values[idx]), true)
            destroy(&name_SN)
        }
    } else {
        for i:= type_info_of(F).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).lower; i< type_info_of(F).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            field:= fmt.aprintf("%s_%v", bsname, i)
            field_SN:= GDW.StringConstruct(field)
            gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(Library, className, &bsname_SN, &field_SN, Int(i), true)
            delete(field)
            destroy(&field_SN)
        }
    }
    destroy(&bsname_SN)
}


//bit flag field for layers.
//The widget in the Inspector dock will use the layer names defined in ProjectSettings.layer_names
layers_2d_render:: bit_set[1..=20; u32]
layers_3d_render:: bit_set[1..=20; u32]

layers_2d_physics:: bit_set[1..=32; u32]
layers_3d_physics:: bit_set[1..=32; u32]

layers_2d_navigation:: distinct bit_set[1..=32; u32]
layers_3d_navigation:: bit_set[1..=32; u32]

layers_avoidance:: bit_set[1..=32; u32]

Layer_Type :: enum {
    LAYERS_2D_RENDER,
    LAYERS_3D_RENDER,
    LAYERS_2D_PHYSICS,
    LAYERS_3D_PHYSICS,
    LAYERS_2D_NAVIGATION,
    LAYERS_3D_NAVIGATION,
    LAYERS_AVOIDANCE,
}
export_int_as_layers :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t, $layer: typeid) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    hint:GDE.PropertyHint
    switch layer {
        case layers_2d_navigation: hint = .LAYERS_2D_NAVIGATION
        case layers_2d_physics: hint = .LAYERS_2D_PHYSICS
        case layers_2d_render: hint = .LAYERS_2D_RENDER
        case layers_3d_navigation: hint =.LAYERS_3D_NAVIGATION
        case layers_3d_physics: hint = .LAYERS_3D_PHYSICS
        case layers_3d_render: hint = .LAYERS_3D_RENDER
        case layers_avoidance: hint = .LAYERS_AVOIDANCE
    }
    prop_info:= Make_Property_Full(.INT, getter_setter.fieldname, hint, "" , "", prop_usage)
    Export5(className, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

export_int_as_layers_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static, $layer: typeid) {
    prop_usage:= PROPERTY_USAGE_DEFAULT
    if getter_setter.setter_method == nil {
        prop_usage+=.READ_ONLY
    }
    hint:GDE.PropertyHint
    switch layer {
        case layers_2d_navigation: hint = .LAYERS_2D_NAVIGATION
        case layers_2d_physics: hint = .LAYERS_2D_PHYSICS
        case layers_2d_render: hint = .LAYERS_2D_RENDER
        case layers_3d_navigation: hint =.LAYERS_3D_NAVIGATION
        case layers_3d_physics: hint = .LAYERS_3D_PHYSICS
        case layers_3d_render: hint = .LAYERS_3D_RENDER
        case layers_avoidance: hint = .LAYERS_AVOIDANCE
    }
    prop_info:= Make_Property_Full(.INT, getter_setter.fieldname, hint, "" , "", prop_usage)
    Export_static(className, getter_setter, &prop_info)
    destructProperty(&prop_info)
}

PATH_TYPES :: enum {
  DIR, //path to a directory
  FILE, //path to a file filters with wildcards like "*.png,*.jpg"
  FILE_PATH, //stored as raw path instead of UID
  GLOBAL_DIR, //absolute path to directory
  GLOBAL_FILE, //absolute path to file
  SAVE_FILE, //file path. can have wildcards like "*.png,*.jpg".
  GLOBAL_SAVE_FILE, //absoulte file path. can have wildcards like "*.png,*.jpg".
}
export_path :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t, type: PATH_TYPES) {
    hint: GDE.PropertyHint
    switch  type {
        case .DIR: hint = .DIR
        case .FILE: hint = .FILE
        case .FILE_PATH: hint = .FILE_PATH
        case .GLOBAL_DIR: hint = .GLOBAL_DIR
        case .GLOBAL_FILE: hint = .GLOBAL_FILE
        case .GLOBAL_SAVE_FILE: hint = .GLOBAL_SAVE_FILE
        case .SAVE_FILE: hint = .SAVE_FILE
    }
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, hint, filters, className, property_usage)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}
export_path_static :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static, type: PATH_TYPES) {
    hint: GDE.PropertyHint
    switch  type {
        case .DIR: hint = .DIR
        case .FILE: hint = .FILE
        case .FILE_PATH: hint = .FILE_PATH
        case .GLOBAL_DIR: hint = .GLOBAL_DIR
        case .GLOBAL_FILE: hint = .GLOBAL_FILE
        case .GLOBAL_SAVE_FILE: hint = .GLOBAL_SAVE_FILE
        case .SAVE_FILE: hint = .SAVE_FILE
    }
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, hint, filters, className, property_usage)
    export_static(className, getter_setter, &info)
    destructProperty(&info)
}

export_locale :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static) {
    info:= Make_Property_Full(.STRING, getter_setter.fieldname, .LOCALE_ID, "", "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

export_password :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static) {
    info:= Make_Property_Full(.STRING, getter_setter.fieldname, .PASSWORD, "", "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

export_with_placeholder_text :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static, placeholder_text: string) {
    info:= Make_Property_Full(.STRING, getter_setter.fieldname, .PLACEHOLDER_TEXT, placeholder_text, "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

export_input_name :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_static, options: Input_Options) {
    hints:= strings.builder_make()
    if .loose_mode in options {
        strings.write_string(&hints, Input_Option_Strings[.loose_mode])
    }
    if .show_builtin in options {
        fmt.sbprint(&hints, ',', Input_Option_Strings[.show_builtin])
    }
    info:= Make_Property_Full(getter_setter.gs_type, getter_setter.fieldname, .INPUT_NAME, strings.to_string(hints), "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
    delete(hints)
}

Input_Options :: bit_set [Input_Options_enum; u8]

Input_Options_enum :: enum u8 {
    show_builtin,
    loose_mode,
}

Input_Option_Strings:[Input_Options_enum]string=  {
    .show_builtin = "show_builtin",
    .loose_mode = "loose_mode",
}

export_multiline :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t) {
    info:= Make_Property_Full(.STRING, getter_setter.fieldname, .MULTILINE_TEXT, "", "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}


export_nodepath_type :: proc(className: ^StringName, getter_setter: ^gsetter_userdata_t, node_type: string) {
    info:= Make_Property_Full(.NODE_PATH, getter_setter.fieldname, .NODE_PATH_VALID_TYPES, node_type, "", PROPERTY_USAGE_DEFAULT,)
    Export5(className, getter_setter, &info)
    destructProperty(&info)
}

make_gs_name :: #force_no_inline proc(fieldname: string, getbuf:^[100]u8, setbuf:^[100]u8) -> (getName, setName: string){
    getName= fmt.bprint(getbuf[:], "get", fieldname, sep="_")
    setName= fmt.bprint(setbuf[:], "set", fieldname, sep="_")
    return
}
 
Export5 :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t, info: ^GDE.PropertyInfo, loc:= #caller_location) -> export_error {

    if getter_setter.getter_method == nil && getter_setter.setter_method == nil {
        return .missing_getset_ptr
    }
    getName, setName:= make_gs_name(getter_setter.fieldname, &getbuf, &setbuf)
    if getter_setter.setter_method != nil {
        _bind_default(getter_setter.setter_method, className_SN, setName)
    }
    if getter_setter.getter_method != nil {
        _bind_default(getter_setter.getter_method, className_SN, getName)
    }
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, getter_setter.fieldname, getter_setter.gs_type, info, getName, setName if getter_setter.setter_method != nil else "")
    return nil
}

//Does not support pass by copy.
Export_static :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_static, info: ^GDE.PropertyInfo) {
    if getter_setter.getter_method == nil && getter_setter.setter_method == nil {
        return .missing_getset_ptr
    }

    getName, setName:= make_gs_name(getter_setter.fieldname, &getbuf, &setbuf)
    _bind_static(getter_setter.setter_method, className_SN, setName)
    _bind_static(getter_setter.getter_method, className_SN, getName)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, getter_setter.fieldname, getter_setter.gs_type, info^, getName, setName)
}

Bind_Set3 :: #force_inline proc(className: ^StringName, \
                methodName: string, function: ^gsetter_userdata, argNames: string, \
                methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location)
{
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    argsInfo: [1]GDE.PropertyInfo

    index:int = int(function.gs_type)
    argsInfo[0] = make_property(GDE.VariantType(index), argNames)
    args_metadata: [1]GDE.ClassMethodArgumentMetadata
    args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE


    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)(function),
        ptrcall_func = set_passthrough,
        method_flags = (methodType),
    }
    #partial switch function.gs_type {
        case .ARRAY:
            methodInfo.call_func = Variant_Setter_Array
        case .PACKED_BYTE_ARRAY, .PACKED_INT32_ARRAY, .PACKED_INT64_ARRAY,
          .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT64_ARRAY, .PACKED_STRING_ARRAY,
          .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR3_ARRAY, .PACKED_COLOR_ARRAY,
          .PACKED_VECTOR4_ARRAY :
            methodInfo.call_func = Variant_Setter_Packed
        case:
            methodInfo.call_func = godotVariantSetterCallback
    }
    
        methodInfo.argument_count = 1
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]


    gdAPI.ClassDB.RegisterExtensionClassMethod(Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&argsInfo[0])
}
