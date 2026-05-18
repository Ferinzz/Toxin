package Toxin

import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import "base:runtime"
import sics "base:intrinsics"
import Classes "../GD_Classes"
import "base:builtin"

callable_container:: struct {
    function: rawptr, //there is no method to get the call_func so it's being stored on our end.
    callable: Callable,
}

arg_deets :: struct {
    name: string,
    variant_type: GDE.VariantType,
}

@(require_results)
register_signal2 :: proc (className: ^StringName, signalName: string, args: []arg_deets) -> (signalSName: StringName) {
    gdAPI.StringName_Utils.Utf8CharsAndLen(&signalSName, raw_data(signalName), i64(len(signalName)))

    signalProp:[32]GDE.PropertyInfo
    for arg, i in args {
        signalProp[i] = make_property(arg.variant_type, arg.name)
    }

    gdAPI.ClassDB.RegisterExtensionClassSignal(GDW.Library, className, &signalSName, raw_data(signalProp[:]), i64(len(args)))
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
    ) -> (r_callable: Callable) {
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
    gdAPI.Callable_Utils.CustomCreate2(&r_callable, (&s_call_info))
    return
}

//container needs to exist for as long as this can be called.
@(require_results)
create_callable_container :: proc(
        function:                rawptr, //function pointer to the proc this should be calling.
        argcount:                int, //number of arguments in the function.
        
        object_id:               ^Object, //Pointer to the Object instance which should be used as _this_ function's instance.
        is_valid_func:           GDE.CallableCustomIsValid = nil, //If it's possible the callable is destroyed before disconnecting.
        free_func:               GDE.CallableCustomFree = nil, //Only needed if some memory it was using needs to be freed.
        hash_func:               GDE.CallableCustomHash = nil, //Godot runs a hash method twice. Not sure what that's used for.
        equal_func:              GDE.CallableCustomEqual = nil, //proc which will compare two callable_userdata in order to determine if they match.
        less_than_func:          GDE.CallableCustomLessThan = nil, //May be useful if you're sotring them in an array?
        to_string_func:          GDE.CallableCustomToString = nil, //Stringify the Callable info.
        get_argument_count_func: GDE.CallableCustomGetArgumentCount = nil, //Helper func to get arg count at runtime.
        token:                   GDE.ClassDB = GDW.Library, //Should be the GDE's library pointer.
        allocator:               runtime.Allocator              = context.allocator,
        loc:= #caller_location,
    ) -> (container: ^callable_container) {
    passthrough: GDE.CallableCustomCall
    switch argcount {
    case 0:
        passthrough = GDE.CallableCustomCall(Signal_Callback0)
    case 1:
        passthrough = GDE.CallableCustomCall(Signal_Callback1)
    case 2:
        passthrough = GDE.CallableCustomCall(Signal_Callback2)
    case 3:
        passthrough = GDE.CallableCustomCall(Signal_Callback3)
    case 4:
        passthrough = GDE.CallableCustomCall(Signal_Callback4)
    case 5:
        passthrough = GDE.CallableCustomCall(Signal_Callback5)
    case 6:
        passthrough = GDE.CallableCustomCall(Signal_Callback6)
    case:
        assert(false, "too many arguments. Custom callable currently supports 6 arguments", loc)
    }
    container = new(callable_container, allocator)
    container.callable = Create_Callable2(container, object_id, passthrough, is_valid_func, free_func, hash_func, equal_func, less_than_func, to_string_func, get_argument_count_func, token)
    container.function = function
    return
}

//First arg should be StringName of the signal
//called automatically by emit_signal procs
emit_signal_variant :: proc(p_instance: ^Object, args: []^Variant) -> GDW.Error {
    ret: GDE.Variant
    gdAPI.Object_Utils.MethodBindCall(cast(GDE.MethodBindPtr)(Object_M_methods.emit_signal._emit_signal), p_instance, raw_data(args[:]), i64(len(args)), &ret, nil)
    when builtin.ODIN_DEBUG {
        assert(ret.VType == .INT, "signals should not have a return value.")
    }
    return GDW.Error(ret.data[0])
}

emitSignal :: proc{
    emitSignal0,
    emitSignal1,
    emitSignal2,
    emitSignal3,
    emitSignal4,
    emitSignal5,
    emitSignal6,
    emitSignal7,
    emitSignal8,
    emitSignal9,
    emit_signal_variant,
}

/*
* binds are useful when you would like to register values into a callable for use in each call.
* bound values are included after all other values of a call.
* Example: a signal doesn't send any values but you would like to include the same value for your callback each time.
* This creates a NEW callable from the one that you pass
*/
@(require_results)
callable_bind :: proc(callable: ^Callable, args: ..Variant) -> (callee: Callable) {
    argsv:Array
    append_slice(&argsv, args)
    GDW.Callable_M_List.bindv(callable, {&argsv}, &callee)
    return
}

append_slice :: proc(dest: ^Array, source: []Variant) {
    size:Int
    if dest.id != nil {
        GDW.Array_M_List.size(dest, r_return= &size)
    } else {
        GDW.Array_M_List.Create0(dest)
    }

    newsize:Int=size+ i64(len(source))
    r_size: Int
    GDW.Array_M_List.resize(dest, {&newsize}, &r_size)
    //if r_size != newsize {
    //    return
    //}
    for &v, idx in source {
        index:= i64(idx) + size
        GDW.Array_M_List.IndxSetter(dest, index, &v)
    }
}

check_variant_callback :: #force_inline proc(expected, received: Int, function: rawptr) -> (r_error: GDE.CallError) {
    
    if received > expected {
        r_error = {
            .CALL_ERROR_TOO_MANY_ARGUMENTS,
            i32(received),
            i32(expected)
        }
        return
    }
    if received < expected {
        r_error = {
            .CALL_ERROR_TOO_FEW_ARGUMENTS,
            i32(received),
            i32(expected)
        }
        return
    }
    if function == nil {
        r_error = {
            .CALL_ERROR_INVALID_METHOD,
            i32(received),
            i32(expected),
        }
        return
    }
    r_error = {
        .CALL_OK,
        i32(received),
        i32(expected),
    }
    return
}

Signal_Callback0 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(0, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object))(callable_self.function))\
            (&obj)
}

Signal_Callback1 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(1, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]))
}

Signal_Callback2 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(2, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr, arg2: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]))
}

Signal_Callback3 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(3, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr, arg2: rawptr, arg3: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]), variant_get_ptr(p_args[2]))
}

Signal_Callback4 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(4, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr, arg2: rawptr, arg3: rawptr, arg4: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]), variant_get_ptr(p_args[2]), variant_get_ptr(p_args[3]))
}

Signal_Callback5 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(5, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr, arg2: rawptr, arg3: rawptr, arg4: rawptr, arg5: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]), variant_get_ptr(p_args[2]), variant_get_ptr(p_args[3]), variant_get_ptr(p_args[4]))
}

Signal_Callback6 :: proc "c" (callable_self: callable_container, p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context = runtime.default_context()
    r_error^ = check_variant_callback(6, p_argument_count, callable_self.function)
    if r_error.error != .CALL_OK {
        return
    }
    p_args:[]^Variant=p_args[:p_argument_count]
    callable_self:=callable_self
    obj: Object
    GDW.Callable_M_List.get_object(&callable_self.callable, nil, &obj)
            (cast(proc(object: ^Object, arg1: rawptr, arg2: rawptr, arg3: rawptr, arg4: rawptr, arg5: rawptr, arg6: rawptr))(callable_self.function))\
            (&obj, variant_get_ptr(p_args[0]), variant_get_ptr(p_args[1]), variant_get_ptr(p_args[2]), variant_get_ptr(p_args[3]), variant_get_ptr(p_args[4]), variant_get_ptr(p_args[5]))
}

/*
* emitSignal creates a vararg list of ^Variants from the values passed in.
* destroy the Variants after they have been used by Godot or get memory leaks for some types.
* should return OK or ERR_UNAVAILABLE
*/
emitSignal0 :: proc "c" (p_instance: ^Object, signalName: ^StringName) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName^)
    defer(variant_Destroy(&arg1))
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1}
    return emit_signal_variant(p_instance, varSet[:])
}

emitSignal1 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    defer(variant_Destroy(&arg1))
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    defer(variant_Destroy(&arg2))
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2}

    return emit_signal_variant(p_instance, varSet[:])
}

emitSignal2 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3}
    
    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal3 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal4 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal5 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    to_variant(&arg6, p_arg5)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&arg6))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])

}
emitSignal6 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    to_variant(&arg7, p_arg6)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&arg6))
    defer(variant_Destroy(&arg7))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal7 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    to_variant(&arg8, p_arg7)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&arg6))
    defer(variant_Destroy(&arg7))
    defer(variant_Destroy(&arg8))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal8 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    to_variant(&arg8, p_arg7)
    arg9: GDE.Variant
    to_variant(&arg9, p_arg8)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&arg6))
    defer(variant_Destroy(&arg7))
    defer(variant_Destroy(&arg8))
    defer(variant_Destroy(&arg9))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
emitSignal9 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G, p_arg9: $H) -> GDW.Error  {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    to_variant(&arg1, signalName)
    arg2: GDE.Variant
    to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    to_variant(&arg8, p_arg7)
    arg9: GDE.Variant
    to_variant(&arg9, p_arg8)
    arg10: GDE.Variant
    to_variant(&arg10, p_arg9)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10}

    // Destroy the arguments that need it.
    defer(variant_Destroy(&arg1))
    defer(variant_Destroy(&arg2))
    defer(variant_Destroy(&arg3))
    defer(variant_Destroy(&arg4))
    defer(variant_Destroy(&arg5))
    defer(variant_Destroy(&arg6))
    defer(variant_Destroy(&arg7))
    defer(variant_Destroy(&arg8))
    defer(variant_Destroy(&arg9))
    defer(variant_Destroy(&arg10))
    defer(variant_Destroy(&ret))

    return emit_signal_variant(p_instance, varSet[:])
}
