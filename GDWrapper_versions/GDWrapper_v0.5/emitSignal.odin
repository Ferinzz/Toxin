package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"

/*
* Signal setup is a single step -> Register the information with Godot.
* Godot recommends setting the name in the class struct itself.
myClassStruct :: struct {
selfPtr: GDE.ObjectPtr,
//some public variables
mySignalName: GDE.StringName
}
* Once it's registered, if done correctly, you will see the information in the documentation of your class.
* To send a signal you should then use the EmitSignal function at the appropriate time. Often in the Process proc.
*/

EmitError :: enum {
    WRONG_TYPE,
}

/*
* Register your GDE class's signal with Godot so that other classes can connect to it.
* Cannot connect to a signal if it has not already been registered with Godot.
* className: name of your GDE class the signal belongs to.
* signalName: name of the signal you want others to connect to.
* arg_type: The types of the arguments which will be sent to the signal receiver via EmitSignal
* arg_name: The names of each argument. These will be displayed in documentation section.
*/
@(deprecated="Use register_Signal instead")
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

/**
* Register your GDE class's signal with Godot so that other classes can connect to it.
* Classes cannot connect to a signal if it has not already been registered with Godot -> Make sure everything is registered before you start connecting things.
* className: name of your GDE class the signal belongs to.
* signalName: name of the signal you want others to connect to.
**
* Returns
* signalName_SN: the StringName which is required to emitSignal and can be used to connect to the signal.
* Error: The error if there is any.
*/
@(require_results)
register_Signal :: #force_inline proc "c" (className: string, $arg_type: typeid, loc := #caller_location) -> ( signalName_SN: GDE.StringName, Error: EmitError)
    where (sics.type_is_struct(arg_type) && sics.type_is_named(arg_type))
    {
    context = runtime.default_context()
    
    className_SN: GDE.StringName
    //signalName_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    StringConstruct.stringNameNewString(&signalName_SN, type_info_of(arg_type).variant.(runtime.Type_Info_Named).name)

    signalProp:[sics.type_struct_field_count(arg_type)]GDE.PropertyInfo
    
    for name, index in type_info_of(arg_type).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Struct).names[:sics.type_struct_field_count(arg_type)] {

        // Lookup the type of the value at this index.
        // Do a search for this type in the GDE.GDTypes list. This ensures that only types supported by Godot are sent to Godot.
        variantIndex, ok := slice.linear_search(GDE.GDTypes[:], (type_info_of(arg_type).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Struct).types[:sics.type_struct_field_count(arg_type)])[index].id)
        
        if ok == false {
            return signalName_SN, .WRONG_TYPE
        }
        variant_type:=GDE.VariantType(variantIndex)
        
        prop:= make_property(variant_type, name)
        signalProp[index] = prop
    }

    gdAPI.classBDRegistClassSignal(Library, &className_SN, &signalName_SN, raw_data(signalProp[:]), sics.type_struct_field_count(arg_type))

    Destructors.stringNameDestructor(&className_SN)
    //Destructors.stringNameDestructor(&signalName_SN)

    for &prop in signalProp {
        destructProperty(&prop)
    }
    return signalName_SN, nil
}

/*
* emitSignal* :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName, p_arg1: $P..)
* p_instance: pointer to the current class Object
* signaleName: stringName of the signal being emitted. Nodes in the SceneTree will be listening for a signal with this name.
* p_arg*: The GDE.TypePtr to the variable being passed to those listening.
*/
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

/*
* Connection to another object's signal
* callback: A struct containing information about how Godot should handle your particular signal callback.
* At minimum shoudl include the following.
** callable_userdata: rawptr to the function which should be used.
** token: The class library to look through for something. Usually the one registered at the start of your extension)
** call_func: A general callback function which Godot will call when the signal occurs
* signal_name: The name of the signal you are listening for.
* object: The specific Object which is connecting to some other signal.
* flags: Additional behavioural options for the signal you are connecting.
a pointer to the object, the StringName of the signal and class_name, a CallableCustomInfo2 struct.
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


//I'm not sure if the StringName of a signal is used anywhere at all. Maybe when receiving one?
//If not, I should consider asking the user to store this as a Variant to reduce the amount of assignments to convert to a Variant.
//Would then have an assert that the Variant passed is a StringName.
//If following the template the p_instance == self.selfPtr
emitSignal0 :: proc "c" (p_instance: GDE.ObjectPtr, signalName: ^GDE.StringName) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg6: GDE.Variant
    variant_from(&arg6, p_arg5)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg6: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg7: GDE.Variant
    variant_from(&arg7, p_arg6)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg6: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg7: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg8: GDE.Variant
    variant_from(&arg8, p_arg7)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg6: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg7: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg8: GDE.Variant
    variant_from(&arg8, p_arg7)
    arg9: GDE.Variant
    variant_from(&arg9, p_arg8)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9}

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
    arg1: GDE.Variant
    variant_from(&arg1, signalName)
    arg2: GDE.Variant
    variant_from(&arg2, p_arg1)
    arg3: GDE.Variant
    variant_from(&arg3, p_arg2)
    arg4: GDE.Variant
    variant_from(&arg4, p_arg3)
    arg5: GDE.Variant
    variant_from(&arg5, p_arg4)
    arg6: GDE.Variant
    variant_from(&arg6, p_arg5)
    arg7: GDE.Variant
    variant_from(&arg7, p_arg6)
    arg8: GDE.Variant
    variant_from(&arg8, p_arg7)
    arg9: GDE.Variant
    variant_from(&arg9, p_arg8)
    arg10: GDE.Variant
    variant_from(&arg10, p_arg9)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10}

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