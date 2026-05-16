package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import "base:runtime"
import sics "base:intrinsics"
import Classes "../GD_Classes"

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

arg_deets :: struct {
    name: string,
    variant_type: GDE.VariantType,
}

@(require_results)
register_signal2 :: proc (className: StringName, signalName: string, args: []arg_deets) -> (signalSName: StringName) {
    gdAPI.StringName_Utils.Utf8CharsAndLen(&signalSName, raw_data(signalName), i64(len(signalName)))

    signalProp:[32]GDE.PropertyInfo
    for arg, i in args {
        signalProp[i] = make_property(arg.variant_type, arg.name)
    }

    className:=className
    gdAPI.ClassDB.RegisterExtensionClassSignal(GDW.Library, &className, &signalSName, raw_data(signalProp[:]), i64(len(args)))
    for &prop in signalProp {
        destructProperty(&prop)
    }
    return
}

/*
* Subscriber does not need to know about the state of the object, only the data sent to it.
* signal does not need to know the Object it is going to or the method details, but it does need to 
* Subscriber Object is identified by the Objectid
*/
@(require_results)
connect_to :: proc(object: ^Object, callback: ^Callable, signal_name: ^StringName, flags: ConnectFlags = nil) -> (ret_err: GDW.Error) {
    flags:i64=i64(transmute(u32)flags)
    Object_M_methods.connect->m_call(object, {signal_name, callback, &flags}, &ret_err)
    return
}


/*
* Callable is a 'heap' allocated value. You are responsible for deleting it when you are done with it.
* Godot implements a Callable as an ENTIRE class. In reality it has several more values than those described in the type definition of GDE.
* r_callable: An uninitialized pointer which will hold the Callable as a return value.
* callable_userdata: some information which you'd want to receive in the CallableCustomCall callback.
* object_id: object to be stored with the callable class. Can be retrieved via Callable's get_object.
* call_func: a callback which you'd like thid Callable to call.
* is_valid_func: proc which returns true if the call_func is valid.
* free_func: called when Callable is freed. Cleanup proc.
* hash_func: function which provides a hash with which to identify this particular Callable.
* equal_func: proc to compare two callable_userdata against each other to determine if they are the same Callable.
* less_than_func: same but asks if it's a less than. If you're storing by index?
* to_string_func: stringify the Callable info.
* get_argument_count_func: Helper to get the count of arguments for this Callable. Can be updated based on the bind/unbind methods.
* token: A unique identifying value which confirms this Callable the one we expect. Typically the Library.
* proc types which are set to nil have their own default methods on Godot's side.
*/
Create_Callable2 :: proc(
        callable_userdata:       rawptr, //Should be something you can use to determine the Callable and/or the function to call.
        
        object_id:               ^Object, //Pointer to the Object instance which should be used as _this_ function's instance.
        call_func:               GDE.CallableCustomCall, //Up to the user to define, as its implementation will depend on how callable_userdata is provided.
        is_valid_func:           GDE.CallableCustomIsValid = nil, //If it's possible the callable is destroyed before disconnecting.
        free_func:               GDE.CallableCustomFree = nil, //Only needed if some memory it was using needs to be freed.
        hash_func:               GDE.CallableCustomHash = nil, //Godot runs a hash method twice. Not sure what that's used for.
        equal_func:              GDE.CallableCustomEqual = nil, //proc which will compare two callable_userdata in order to determine if they match.
        less_than_func:          GDE.CallableCustomLessThan = nil, //May be useful if you're sotring them in an array?
        to_string_func:          GDE.CallableCustomToString = nil, //Stringify the Callable info.
        get_argument_count_func: GDE.CallableCustomGetArgumentCount = nil, //Helper func to get arg count at runtime.
        token:                   GDE.ClassDB = GDW.Library, //Should be the GDE's library pointer.
    ) -> (r_callable: ^Callable) {
    //
    s_call_info:GDE.CallableCustomInfo2 = {
        callable_userdata= callable_userdata,
        token= token,
        object_id= gdAPI.Object_Utils.GetInstanceId(object_id),
        call_func= call_func,
        is_valid_func= is_valid_func,
        free_func= free_func,
        hash_func = hash_func,
        equal_func= equal_func,
        less_than_func= less_than_func,
        to_string_func= to_string_func,
        get_argument_count_func= get_argument_count_func,
    }
    gdAPI.Callable_Utils.CustomCreate2(r_callable, (&s_call_info))
    return
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
    ret:= newproc(variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]), variant_get_ptr(p_args[2]))
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

Connect_to :: proc(target_signal: string, subscription: ^Object, subscriber: ^Object, callback: proc "c" (self: ^Object)) {

}

subscription:: struct {
    target_signal: ^string,
    subscription: ^Object,
}
