package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"

textserver_init :: proc() {
    Classes.TextServer_Init_(&textserver_class)
}
textserver_class: Classes.TextServer_MethodBind_List

textserver_create_shaped_text :: #force_inline proc(text_interface: Classes.TextServer, Direction: Classes.TextServer_Direction = .DIRECTION_LTR, Orientation: Classes.TextServer_Orientation = .ORIENTATION_HORIZONTAL) -> (shaped_text: GDW.RID) {
    direction:=Direction
    orientation:=Orientation
    textserver_class.create_shaped_text->m_call(text_interface, {&direction, &orientation}, r_ret = &shaped_text)
    return
}

textserver_shaped_text_add_string :: proc {
    textserver_shaped_text_add_string_s,
    textserver_shaped_text_add_string_ex,
    textserver_shaped_text_add_string_ex_gd,
}

textserver_shaped_text_add_string_s :: #force_inline proc(text_interface: Classes.TextServer,
    shaped_text: RID,
    message: string,
    fonts: Array,
    font_size: Int,) -> (shaped_bool: Bool){

    shaped_text:= shaped_text
    fonts:= fonts
    font_size:= font_size
    dumb_dic:Dictionary
    GDW.Dictionary_M_List.Create0(&dumb_dic)
    shaped_bool = textserver_shaped_text_add_string_ex(text_interface, shaped_text, message, fonts, font_size, dumb_dic)
    Destroy(&dumb_dic)
    return
}

textserver_shaped_text_add_string_ex :: #force_inline proc(text_interface: Classes.TextServer,
    shaped_text: RID,
    message: string,
    fonts: Array,
    font_size: Int,
    dumb_dic: Dictionary,
    lang: string = "",
    meta: Variant = {}) -> (shaped_bool: Bool) {

    shaped_text:= shaped_text
    fonts:= fonts
    font_size:= font_size
    dumb_dic:= dumb_dic
    meta:= meta
    message_s: gdstring = gdstring_new(message)
    lang_s: gdstring= gdstring_new(lang)
    textserver_class.shaped_text_add_string->m_call(text_interface, {&shaped_text, &message_s, &fonts, &font_size, &dumb_dic, &lang_s, &meta}, &shaped_bool)
    Destroy(&message_s)
    Destroy(&lang_s)
    return
}

textserver_shaped_text_add_string_ex_gd :: #force_inline proc(text_interface: Classes.TextServer,
    shaped_text: RID,
    message: gdstring,
    fonts: Array,
    font_size: Int,
    dumb_dic: Dictionary,
    lang: gdstring,
    meta: Variant = {}) -> (shaped_bool: Bool){

    shaped_text:= shaped_text
    fonts:= fonts
    font_size:= font_size
    dumb_dic:= dumb_dic
    meta:= meta
    message:=message
    lang:=lang
    textserver_class.shaped_text_add_string->m_call(text_interface, {&shaped_text, &message, &fonts, &font_size, &dumb_dic, &lang, &meta}, &shaped_bool)
    return
}

textserver_class_shaped_text_shape :: #force_inline proc(text_interface: Classes.TextServer, shaped_text: ^RID) -> (shaped_bool: Bool) {
    textserver_class.shaped_text_shape->m_call(text_interface, {shaped_text}, &shaped_bool)
    return
}