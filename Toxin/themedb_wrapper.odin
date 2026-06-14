package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"


themedb_get_default_theme :: #force_inline proc() -> (Theme: Classes.Theme){
  ThemeDB_M_List.get_default_theme->m_call(ThemeDB,  r_ret= &Theme)
  return
}

themedb_get_project_theme :: #force_inline proc() -> (Theme: Classes.Theme) {
  ThemeDB_M_List.get_project_theme->m_call(ThemeDB,  r_ret= &Theme)
  return
}
  
themedb_set_fallback_base_scale :: #force_inline proc(base_scale: ^float){
  ThemeDB_M_List.set_fallback_base_scale->m_call(ThemeDB, {base_scale, })
}
  
themedb_get_fallback_base_scale :: #force_inline proc() -> (scale: float){
  ThemeDB_M_List.get_fallback_base_scale->m_call(ThemeDB,  r_ret= &scale)
  return
}
  
themedb_set_fallback_font :: #force_inline proc(Font: ^Classes.Font){
  ThemeDB_M_List.set_fallback_font->m_call(ThemeDB, {Font})
}
  
themedb_get_fallback_font :: #force_inline proc() -> (Font: Classes.Font) {
  ThemeDB_M_List.get_fallback_font->m_call(ThemeDB, r_ret= &Font)
  return
}
  
themedb_set_fallback_font_size :: #force_inline proc(font_size: ^Int){
  ThemeDB_M_List.set_fallback_font_size->m_call(ThemeDB, {font_size, })
}
  
themedb_get_fallback_font_size :: #force_inline proc() -> (font_size: Int){
  ThemeDB_M_List.get_fallback_font_size->m_call(ThemeDB,  r_ret= &font_size)
  return
}
  
themedb_set_fallback_icon :: #force_inline proc(icon: ^Classes.Texture2D) {
  ThemeDB_M_List.set_fallback_icon->m_call(ThemeDB, {icon, })
}
  
themedb_get_fallback_icon :: #force_inline proc() -> (texture2d: Classes.Texture2D){
  ThemeDB_M_List.get_fallback_icon->m_call(ThemeDB, r_ret= &texture2d)
  return
}
  
themedb_set_fallback_stylebox :: #force_inline proc(stylebox: ^Classes.StyleBox){
  ThemeDB_M_List.set_fallback_stylebox->m_call(ThemeDB, {stylebox, })
}
  
themedb_get_fallback_stylebox :: #force_inline proc() -> (stylebox: Classes.StyleBox) {
  ThemeDB_M_List.get_fallback_stylebox->m_call(ThemeDB,  r_ret= &stylebox)
  return
}