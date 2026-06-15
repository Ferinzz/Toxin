package main

proc_sig:= `%s_%s :: #force_inline proc(`
object:=`%s: Classes.%[0]s, `
arg:= `%s: ^%s, `
class_arg:= `%s: ^Classes.%s, `
ret:= `) -> (a_ret: %s`
class_ret:= `) -> (a_ret: Classes.%s`
open:= `{{`
close:= `}`
method_call:= `    Classes.%s_%s->m_call(%s, `
default:= ` = %s,`
call_args:= `%s,`
ret_arg:= `r_ret = &a_ret`
call_close:= `    return
}`

header:= `package class_wrap

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import GDE "../GDWrapper/gdAPI/gdextension"`