package Toxin

import "base:runtime"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"

/*
* Signal setup is a single step -> Register the information with Godot.
* Godot recommends setting the name in the class struct itself.
myClassStruct :: struct {
selfPtr: ^Object,
//some public variables
mySignalName: StringName
}
* Once it's registered, if done correctly, you will see the information in the documentation of your class.
* To send a signal you should then use the EmitSignal function at the appropriate time. Often in the Process proc.
*/

EmitError :: enum {
    WRONG_TYPE,
}

objectEmitSignal: GDE.MethodBindPtr

/*
* Register your GDE class's signal with Godot so that other classes can connect to it.
* Cannot connect to a signal if it has not already been registered with Godot.
* className: name of your GDE class the signal belongs to.
* signalName: name of the signal you want others to connect to.
* arg_type: The types of the arguments which will be sent to the signal receiver via EmitSignal
* arg_name: The names of each argument. These will be displayed in documentation section.
*/
@(deprecated="Use register_Signal instead")
registerSignal :: proc(className, signalName: cstring, arg_type: []GDE.VariantType, arg_name: []cstring, $count: int, loc := #caller_location) {

    assert(len(arg_type) == count, "registerSignal: Length of []arg_type list does not match with count provided", loc)
    assert(len(arg_name) == count, "registerSignal: Length of []arg_name list does not match with count provided", loc)

    s_className: StringName
    s_signalName: StringName
    gdAPI.StringName_Utils.Latin1Chars(&s_className, className, false)
    gdAPI.StringName_Utils.Latin1Chars(&s_signalName, signalName, false)

    signalProp:[count]GDE.PropertyInfo
    for arg, index in arg_type{
        prop:= make_property(arg, arg_name[index])
        signalProp[index] = prop
    }

    gdAPI.classBDRegistClassSignal(Library, &s_className, &s_signalName, raw_data(signalProp[:]), count)

    StringName_M_List.Destroy(&s_className)
    StringName_M_List.Destroy(&s_signalName)

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
register_Signal :: #force_inline proc(className: string, $arg_type: typeid, loc := #caller_location) -> ( signalName_SN: StringName, Error: EmitError)
    where (sics.type_is_struct(arg_type) && sics.type_is_named(arg_type))
    {

    className_SN: StringName
    //signalName_SN: StringName
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

    StringName_M_List.Destroy(&className_SN)
    //StringName_M_List.Destroy(&signalName_SN)

    for &prop in signalProp {
        destructProperty(&prop)
    }
    return signalName_SN, nil
}

/*
* emitSignal* :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P..)
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
Create_Callable :: proc(r_callable: ^Callable, 
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
    ) {
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
}

/*
* Callable sizes
* Callable 16
*** StringName
*** union {ObjectID, ^CustomCallable}
* All our Callable should be custom so we can assume that it will always be holding a CustomCallable.
* CustomExtensionCallable: 104
*** {CustomCallable{}, userdata, token, object{id}, ..proc pointers}
* There is no method unique to this class to get the Objectid that we passed in.
* CANNOT USE EXTENSION'S GET OBJECT FROM OBJECTID!?
* will need to use Callable's get_object method in order to get the object with any certainty.
*/

/*
* Connection to another object's signal
* There seems to be several connect and disconnect rules for signals, at least for C#
** I believe that GDE should not run afowl of the worst of it due to us always(?) using Connect
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
connectToSignal :: proc(object: ^Object, callback: ^Callable, signal_name: ^StringName, flags: ConnectFlags = nil, loc := #caller_location) -> GDE.CallErrorType {

    //Keep a static pointer to the connect_to method. If not already assigned, fetch it.
    @(static) connect_to: GDE.MethodBindPtr
    if connect_to == nil{
        connect_to = GDW.classDBGetMethodBind3(.SceneTree, "connect", 1518946055)
    }

    flags:=flags
    args:= [?]rawptr {signal_name, callback, &flags}
    ret_err:GDE.CallErrorType
    gdAPI.Object_Utils.MethodBindPtrcall(connect_to, object, raw_data(args[:]), &ret_err)

    //assert(ret_err == .CALL_OK, loc = loc)

    return ret_err

}

/*
* emitSignal creates a vararg list of ^Variants from the values passed in.
* destroy the Variants after they have been used by Godot or get memory leaks for some types.
*/
//TODO: consider having an exception for signal StringName variant constructors here.
//If following the template the p_instance == self.selfPtr
emitSignal0 :: proc "c" (p_instance: ^Object, signalName: ^StringName) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 1, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&ret)
}

emitSignal1 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    defer(variant_Destroy(&arg1))
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    defer(variant_Destroy(&arg2))
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2}

    // Add dummy return value storage.
    ret: GDE.Variant
    defer(variant_Destroy(&ret))

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 2, &ret, nil)
}

emitSignal2 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 3, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&ret)
}
emitSignal3 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 4, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&ret)
}
emitSignal4 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 5, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&ret)
}
emitSignal5 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    copy_to_variant(&arg6, p_arg5)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 6, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&arg6)
    variant_Destroy(&ret)
}
emitSignal6 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    copy_to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    copy_to_variant(&arg7, p_arg6)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 7, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&arg6)
    variant_Destroy(&arg7)
    variant_Destroy(&ret)
}
emitSignal7 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    copy_to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    copy_to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    copy_to_variant(&arg8, p_arg7)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 8, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&arg6)
    variant_Destroy(&arg7)
    variant_Destroy(&arg8)
    variant_Destroy(&ret)
}
emitSignal8 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    copy_to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    copy_to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    copy_to_variant(&arg8, p_arg7)
    arg9: GDE.Variant
    copy_to_variant(&arg9, p_arg8)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 9, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&arg6)
    variant_Destroy(&arg7)
    variant_Destroy(&arg8)
    variant_Destroy(&arg9)
    variant_Destroy(&ret)
}
emitSignal9 :: proc "c" (p_instance: ^Object, signalName: ^StringName, p_arg1: $P, p_arg2: $A, p_arg3: $B, p_arg4: $C, p_arg5: $D,
                         p_arg6: $E, p_arg7: $F, p_arg8: $G, p_arg9: $H) {
    context = runtime.default_context()
    // Set up the arguments for the call.
    arg1: GDE.Variant
    copy_to_variant(&arg1, signalName)
    arg2: GDE.Variant
    copy_to_variant(&arg2, p_arg1)
    arg3: GDE.Variant
    copy_to_variant(&arg3, p_arg2)
    arg4: GDE.Variant
    copy_to_variant(&arg4, p_arg3)
    arg5: GDE.Variant
    copy_to_variant(&arg5, p_arg4)
    arg6: GDE.Variant
    copy_to_variant(&arg6, p_arg5)
    arg7: GDE.Variant
    copy_to_variant(&arg7, p_arg6)
    arg8: GDE.Variant
    copy_to_variant(&arg8, p_arg7)
    arg9: GDE.Variant
    copy_to_variant(&arg9, p_arg8)
    arg10: GDE.Variant
    copy_to_variant(&arg10, p_arg9)
    //args: GDE.GDExtensionConstVariantPtrargs = {&arg1, &arg2};
    varSet:= [?]^GDE.Variant {&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10}

    // Add dummy return value storage.
    ret: GDE.Variant

    // Call the function.
    gdAPI.Object_Utils.MethodBindCall(objectEmitSignal, p_instance, raw_data(varSet[:]), 10, &ret, nil)

    // Destroy the arguments that need it.
    variant_Destroy(&arg1)
    variant_Destroy(&arg2)
    variant_Destroy(&arg3)
    variant_Destroy(&arg4)
    variant_Destroy(&arg5)
    variant_Destroy(&arg6)
    variant_Destroy(&arg7)
    variant_Destroy(&arg8)
    variant_Destroy(&arg9)
    variant_Destroy(&arg10)
    variant_Destroy(&ret)
}