package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:fmt"

/*Signal setup is a single step. Register the information with Godot.
* Godot recommends setting the name in the class struct itself.
myClassStruct :: struct {
selfPtr: GDE.ObjectPtr,
//some public variables
mySignalName: GDE.StringName
}
* Once it's registered, if done correctly, you will see the information in the documentation of your class.
* To send a signal you should then use the EmitSignal function at the appropriate time.
* Connection to another object's signal requires a pointer to the object, the StringName of the signal and class_name, a CallableCustomInfo2 struct.
* Careful when retrieving the object of a refCounted object. It will check the signals for refCount instead of the object itself... ie get_scene_tree
*/

@require_results
connectToSignal :: proc "c" (callback: ^GDE.CallableCustomInfo2, signal_name: ^GDE.StringName, object: GDE.ObjectPtr, flags: GDE.ConnectFlags = nil, loc := #caller_location) -> GDE.CallErrorType {
    context = runtime.default_context()

    //Keep a static pointer to the connect_to method. If not already assigned, fetch it.
    @(static) connect_to: GDE.MethodBindPtr
    if connect_to == nil{
        sn_SceneTree:GDE.StringName
        StringConstruct.stringNameNewLatin(&sn_SceneTree, "Object", false)
        Connect: GDE.StringName
        StringConstruct.stringNameNewLatin(&Connect, "connect", false)
        
        connect_to = gdAPI.classDBGetMethodBind(&sn_SceneTree, &Connect, 1518946055)

        Destructors.stringNameDestructor(&sn_SceneTree)
        Destructors.stringNameDestructor(&Connect)
    }

    
    myCallable:GDE.Callable
    Methods.makeCallable(&myCallable, callback)

    flags:=flags
    args:= [?]rawptr {signal_name, &myCallable, &flags}
    ret_err:GDE.CallErrorType
    gdAPI.objectMethodBindPtrCall(connect_to, object, raw_data(args[:]), &ret_err)

    //assert(ret_err == .CALL_OK, loc = loc)

    return ret_err

}

//will need className, signalName, argcount. hint doesn't seem to do anything in the docs?
registerSignal :: proc "c" (className, signalName: cstring, arg_type: []GDE.VariantType, arg_name: []cstring, $count: int, loc := #caller_location) {
    context = runtime.default_context()

    assert(len(arg_type) == count, "registerSignal: Length of []arg_type list does not match with count provided", loc)
    assert(len(arg_name) == count, "registerSignal: Length of []arg_name list does not match with count provided", loc)
    
    s_className: GDE.StringName
    s_signalName: GDE.StringName
    StringConstruct.stringNameNewLatin(&s_className, className, false)
    StringConstruct.stringNameNewLatin(&s_signalName, signalName, false)

    signalProp:[count]GDE.PropertyInfo
    for arg, index in arg_type{
        prop:= make_property(arg, arg_name[index])
        signalProp[index] = prop
    }

    gdAPI.classBDRegistClassSignal(Library, &s_className, &s_signalName, raw_data(signalProp[:]), count)

    Destructors.stringNameDestructor(&s_className)
    Destructors.stringNameDestructor(&s_signalName)

    for &prop in signalProp {
    destructProperty(&prop)
    }

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
}




//I'm not sure if the StringName of a signal is used anywhere at all. Maybe when receiving one?
//If not, I should consider asking the user to store this as a Variant to reduce the amount of assignments to convert to a Variant.
//Would then have an assert that the Variant passed is a StringName.
emitSignal0 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 1, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&ret)
}

emitSignal1 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 2, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&ret)
}

emitSignal2 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 3, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&ret)
}
emitSignal3 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 4, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&ret)
}
emitSignal4 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 5, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&ret)
}
emitSignal5 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg2: GDE.Variant
    variant_from(&arg6, p_arg5)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 6, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&arg6)
    Destructors.variantDestroy(&ret)
}
emitSignal6 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg2: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg2: GDE.Variant
    variant_from(&arg7, p_arg6)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 7, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&arg6)
    Destructors.variantDestroy(&arg7)
    Destructors.variantDestroy(&ret)
}
emitSignal7 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg2: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg2: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg2: GDE.Variant
    variant_from(&arg8, p_arg7)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 8, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&arg6)
    Destructors.variantDestroy(&arg7)
    Destructors.variantDestroy(&arg8)
    Destructors.variantDestroy(&ret)
}
emitSignal8 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg2: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg2: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg2: GDE.Variant
    variant_from(&arg8, p_arg7)
    arg2: GDE.Variant
    variant_from(&arg9, p_arg8)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 9, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&arg6)
    Destructors.variantDestroy(&arg7)
    Destructors.variantDestroy(&arg8)
    Destructors.variantDestroy(&arg9)
    Destructors.variantDestroy(&ret)
}
emitSignal9 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G, p_arg9: $H) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    //fmt.println("Signal bind call?")
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg2: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg2: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg2: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg2: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg2: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg2: GDE.Variant
    variant_from(&arg8, p_arg7)
    arg2: GDE.Variant
    variant_from(&arg9, p_arg8)
    arg2: GDE.Variant
    variant_from(&arg10, p_arg9)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]rawptr {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.objectMethodBindCall(Methods.objectEmitSignal, p_instance, raw_data(varSet[:]), 10, &ret, nil)

    // Destroy the arguments that need it.
    Destructors.variantDestroy(&arg1)
    Destructors.variantDestroy(&arg2)
    Destructors.variantDestroy(&arg3)
    Destructors.variantDestroy(&arg4)
    Destructors.variantDestroy(&arg5)
    Destructors.variantDestroy(&arg6)
    Destructors.variantDestroy(&arg7)
    Destructors.variantDestroy(&arg8)
    Destructors.variantDestroy(&arg9)
    Destructors.variantDestroy(&arg10)
    Destructors.variantDestroy(&ret)
}