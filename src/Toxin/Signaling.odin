package Toxin

import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import "base:runtime"

callable_container:: struct {
    function: rawptr,
    callable: Callable,
}

Signal_Callback :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    p_args:[]^Variant=p_args[:p_argument_count]
    switch p_argument_count {
        case 1:
            call:= cast(proc(object: ^Object, arg1: rawptr))(callable_self.function)
            //TODO: Make a Variant helper which returns a value based on the variant's enum value. Current version sucks.
            call(cast(^Object)(callable_self.callable.stringName.ptr), nil)
    }
    r_error^= {
        error= .CALL_OK,
        argument = i32(p_argument_count),
        expected = 0,
    }
}
