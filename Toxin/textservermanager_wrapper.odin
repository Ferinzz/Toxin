package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"

TextServerManager_get_primary_interface :: #force_inline proc() -> (text_interface: Classes.TextServer) {
    TextServerManager_M_List.get_primary_interface->m_call(TextServerManager, r_ret = &text_interface)
    return
}