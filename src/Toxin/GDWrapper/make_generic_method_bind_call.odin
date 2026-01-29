package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import sics "base:intrinsics"
import "base:runtime"

@(require_results)
make_generic_methodbind_call :: proc($procsig: typeid, mbb: ^MethodBind, loc := #caller_location) -> rawptr \
    where ((sics.type_has_field(sics.type_proc_parameter_type(procsig, 0), "self") && sics.type_field_type(sics.type_proc_parameter_type(procsig, 0), "self") == ^Object)\
    && sics.type_proc_parameter_count(procsig) < 5) {
    @(static) mb:^MethodBind
    mb= mbb

    //Not sure why this is receiving the Node struct as if it's a pointer despite passing it as itself.
    //Maybe implicitly converting it to a pointer due to size.
    when (sics.type_proc_parameter_count(procsig) == 4 && sics.type_is_struct(sics.type_proc_parameter_type(procsig, 1))){
        when (sics.type_is_pointer(sics.type_proc_parameter_type(procsig, 2)) && sics.type_proc_parameter_type(procsig, 3) == runtime.Source_Code_Location) {
            //#type proc(self: ^Object, args: struct {_: rawptr}, r_ret: rawptr, loc:= #caller_location)
            generic:: proc(self: ^Class_Container(CC_Dummy), args: sics.type_proc_parameter_type(procsig, 1), r_ret: rawptr, loc := #caller_location) {
                args:=args
                gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)mb, self.self, cast([^]rawptr)&args, r_ret)
            }
            return cast(rawptr)generic} else {
                panic("incorrect MethodBind callback format for args+return", loc)
            }
    } else  when (sics.type_proc_parameter_count(procsig) == 3 && (sics.type_proc_parameter_type(procsig, 2) == runtime.Source_Code_Location)) {
        when sics.type_is_struct(sics.type_proc_parameter_type(procsig, 1)) {
            //#type proc(self: ^Object, args: struct {_: rawptr}, loc:= #caller_location)
            generic:: proc(self: ^Class_Container(CC_Dummy), args: sics.type_proc_parameter_type(procsig, 1), loc := #caller_location){
                args:=args
                gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)mb, self.self, cast([^]rawptr)&args, nil)
            }
            return cast(rawptr)generic
        } else when sics.type_is_pointer(sics.type_proc_parameter_type(procsig, 1)) {
            //#type proc(self: ^Object, r_ret: rawptr, loc:= #caller_location)
            generic:: proc(self: ^Class_Container(CC_Dummy), args: sics.type_proc_parameter_type(procsig, 1), loc := #caller_location){
                gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)mb, self.self, nil, args)
            }
            return cast(rawptr)generic
        } else {
            panic("incorrect MethodBind callback format for only args or return", loc)
        }
    } else  {
        panic("incorrect MethodBind callback format", loc)
    }
    return nil
}
