package Toxin

import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import "base:runtime"
import sics "base:intrinsics"

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
            call(cast(^Object)(callable_self.callable.call_p.stringName.ptr), nil)
    }
    r_error^= {
        error= .CALL_OK,
        argument = i32(p_argument_count),
        expected = 0,
    }
}

/*
* I already have a Variant -> type proc generator for normal exports.
* I can make changes to the bindnoreturn2 proc in order to generate the variant->type system.
* All signal procs should therefore use pointers as parameters.
*/
some_Signal :: proc(val1: ^Array, val2: ^float, val3: ^Basis) -> Vector2 {
    return {0,3}
}

some_callback :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context=runtime.default_context()
    p_args:=p_args[:p_argument_count]
    r_arg::sics.type_proc_return_type(type_of(some_Signal), 0)
    newproc:=cast(proc(rawptr,rawptr,rawptr) -> (r_arg))some_Signal
    ret:= newproc(&p_args[0].data, &p_args[1].data, &p_args[2].data)
}

muh_callback :: proc(self: ^Object, p_args: [3]GDE.ConstVariantPtr, r_return: ^Variant) {

}

dataneeded:: struct ($T: typeid) {
    callproc: rawptr, //of type proc
    calldeets: Callable,
    object: ^Class_Container(T),
}

Connection_Error :: enum {
    DOES_NOT_HAVE_SIGNAL,

}

/*
* Subscriber does not need to know about the state of the object, only the data sent to it.
* signal does not need to know the Object it is going to or the method details, but it does need to 
* Subscriber Object is identified by the Objectid
*/
Connect_to :: proc(target_signal: string, subscription: ^Object, subscriber: ^Object, callback: proc "c" (self: ^Object)) {

}

subscription:: struct {
    target_signal: ^string,
    subscription: ^Object,
}
