package Toxin


import GDE "../GDWrapper/gdAPI/gdextension"
import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"

is_key_pressed :: #force_inline proc(key: GDW.Key) -> (is_pressed: Bool) {
    key:=key
    Input_M_List.is_key_pressed->m_call(Input, {&key}, r_ret = &is_pressed)
    return
}