
package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "core:fmt"
import sics "base:intrinsics"
import "base:runtime"
import str "core:strings"
import s "core:slice"
import "core:math/rand"

Player :: struct {
    selfPtr: GDE.ObjectPtr,
    touching: GDE.Int
}

//See the input callback to see how this is being used. Setting as global to reduce creating repeatedly.
getMousePos: GDE.MethodBindPtr
classTagName: GDE.StringName
classTag: rawptr

/*
* This is where things will need to deviate. Either there's a ton of setting instanced in the scene
* or we need to load it via code.
* In the example, since it's 100% editor there's several object settings related to the texture which
* are configured in the tscn. Including radius of circleshape2D.
*/

registerPlayer:: proc "c" () {
    class_name: GDE.StringName
    parent_class_name: GDE.StringName

    GDW.StringConstruct.stringNameNewLatin(&class_name, "Player", false)
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Node2D", false)
    defer(GDW.Destructors.stringNameDestructor(&class_name))
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    class_info: GDE.ClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &stringraw, //For some reason does not work with UTF8 strings??
        set_func = nil,
        get_func = nil,
        get_property_list_func = nil,
        free_property_list_func = nil,
        property_can_revert_func = nil,
        property_get_revert_func = nil,
        validate_property_func = nil,
        notification_func = nil,
        to_string_func = nil,
        reference_func = nil,
        unreference_func = nil,
        create_instance_func = CreatePlayer,
        free_instance_func = DestroyPlayer,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  getVirtualWithDataPlayer,
        call_virtual_with_data_func = callVirtualFunctionWithDataPlayer,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //GDW.makePublic(Player, "timePassed")
    treeBindMethod()
}

extensionDeinitPlayer :: proc "c" (userdata: rawptr, initLevel: GDE.InitializationLevel) {
    
}


treeBindMethodPlayer :: proc "c" () {
    //body_shape_entered
    
    //Connect to mainLoop's phys tick signal.

}

CreatePlayer :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Node2D", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    defer(GDW.Destructors.stringNameDestructor(&class_name))

    
    fmt.println("My own Player", object)

    //ORIGINALLY I wanted to connect with the signal via code but for whatever
    //reason the bullet class doesn't exist when this would need it to..
    //
    //In Object of type 'Node2D': Attempt to connect nonexistent signal 'body_shape_entered' to callable '<CallableCustom>'.
    //was there a connection error:  %!(BAD ENUM VALUE=31)
    enterShapeInfo: GDE.CallableCustomInfo2 ={
        callable_userdata= cast(rawptr)onBodyEntered,
	    token= GDW.Library,
	    
	    call_func= signalCallbackPlayer,
    }
    
    signalName: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&signalName, "body_shape_entered", false)
    defer(GDW.Destructors.stringNameDestructor(&signalName))

    //connectErr:= GDW.connectToSignal(&enterShapeInfo, &signalName, object)
    //fmt.println("was there a connection error: ", connectErr)

    //Create extension object.
    
    self: ^Player = cast(^Player)GDW.gdAPI.mem_alloc(size_of(Player))
    self.selfPtr = object
    
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Player", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)


    return object

}


DestroyPlayer :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^Player = cast(^Player)p_instance
    GDW.gdAPI.mem_free(self)

}

class_destructorPlayer :: proc "c" (self: ^Player) {
    context = runtime.default_context()

    //GDW.gdAPI.mem_free(self)
    
}


getVirtualWithDataPlayer :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {

    if GDW.stringNameCompare(p_name, "_ready"){
        return cast(rawptr)initializePlayer
    }
    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)processPlayer
    }
    if GDW.stringNameCompare(p_name, "_physics_process"){
        return cast(rawptr)physics_processPlayer
    }
    if GDW.stringNameCompare(p_name, "_draw"){
        return cast(rawptr)drawPlayer
    }
    if GDW.stringNameCompare(p_name, "_exit_tree"){
        return cast(rawptr)exit_treePlayer
    }
    if GDW.stringNameCompare(p_name, "_input"){
        return cast(rawptr)inputPlayer
    }
    return nil
}


callVirtualFunctionWithDataPlayer :: proc "c" (p_instance: GDE.ClassInstancePtr, p_name: GDE.ConstStringNamePtr, virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    
    if virtualProcPtr == cast(rawptr)initializePlayer {
        GDW.virtualProcCall(initializePlayer, p_instance, p_args, r_ret)
        return
    }
    if virtualProcPtr == cast(rawptr)processPlayer {
        GDW.virtualProcCall(processPlayer, p_instance, p_args, r_ret)
        return
    }
    if virtualProcPtr == cast(rawptr)drawPlayer {
        GDW.virtualProcCall(drawPlayer, p_instance, p_args, r_ret)
        return
    }
    if virtualProcPtr == cast(rawptr)physics_processPlayer {
        GDW.virtualProcCall(physics_processPlayer, p_instance, p_args, r_ret)
        return
    }
    if virtualProcPtr == cast(rawptr)exit_treePlayer {
        GDW.virtualProcCall(exit_treePlayer, p_instance, p_args, r_ret)
        return
    }
    if virtualProcPtr == cast(rawptr)inputPlayer {
        GDW.virtualProcCall(inputPlayer, p_instance, p_args, r_ret)
        return
    }
}


initializePlayer :: proc "c" (self: ^Player) {
    context = runtime.default_context()




}

processPlayer :: proc "c" (self: ^Player) {
    context = runtime.default_context()
    
}

physics_processPlayer :: proc "c" (self: ^Player, delta: f64) {
    context = runtime.default_context()


}

drawPlayer :: proc "c" (self: ^Player) {

    context = runtime.default_context()
    
    
}


exit_treePlayer :: proc "c" (self: ^Player) {
    context = runtime.default_context()
    
}



//Input is some kind of object. There's a different object for each kind of input.
//Will need to see if it matches with the input type you're looking for.
//"name": "InputEventMouseMotion",
//proc(p_object: ConstObjectPtr, p_library: ClassLibraryPtr, r_class_name: UninitializedStringNamePtr) -> Bool


//Two methods of checking a class presented here. There's a third which uses the name of the
//class, but at least the mousemotion event doesn't have a name.
//First method commented out is the worst. It does a string compare between what you provide and
//what it derives from the class.
//Second method is more ideal as it simply does a compare between the types.
inputPlayer :: proc "c" (self: ^Player, event: GDE.ObjectPtr) {
    context = runtime.default_context()
    //event:= event
    //fmt.println("input")

    /*
    //className: GDE.StringName
    is_action := GDW.classDBGetMethodBind("Object", "is_class", 3927539163)
    //GDW.Methods.ObjGetClassName(event, GDW.Library, &className)
    
    //check name
    wantedClass: GDE.StringName
    exactMatch: GDE.Bool = true
    GDW.StringConstruct.stringNewLatin(&wantedClass, "InputEventMouseMotion")//, false)
    returnVal: GDE.Bool = false

    args:= [?]rawptr {&wantedClass, &exactMatch}

    GDW.gdAPI.objectMethodBindPtrCall(is_action, event, raw_data(args[:]), &returnVal)
    */
    if getMousePos == nil {
    getMousePos = GDW.classDBGetMethodBind("InputEventMouse", "get_position", 3341600327)}

    //classdb_get_class_tag
    getClassTag: GDE.InterfaceClassdbGetClassTag= cast(GDE.InterfaceClassdbGetClassTag)GDW.gdAPI.p_get_proc_address("classdb_get_class_tag")
    
    if classTagName.ptr == nil {
    GDW.StringConstruct.stringNameNewLatin(&classTagName, "InputEventMouseMotion", false)}
    
    //if classTag == nil {
    classTag = getClassTag(&classTagName)
    //}

    check:= GDW.Methods.checkCast(event, classTag)
    node2dSetPosition:= GDW.classDBGetMethodBind("Node2D", "set_position", 743155724)
    vec2: GDE.Vector2
    if (check != nil) {
        GDW.gdAPI.objectMethodBindPtrCall(getMousePos, event, nil, &vec2)
        //fmt.println(vec2)
        args:= [?]rawptr {&vec2}
        dummyReturn: rawptr
        //GDW.Methods.
        GDW.gdAPI.objectMethodBindPtrCall(node2dSetPosition, self.selfPtr, raw_data(args[:]), &dummyReturn)
    }
}


signalCallbackPlayer :: proc "c" (callable_userdata: rawptr, p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError){
    context = runtime.default_context()

    
    if callable_userdata == cast(rawptr)onBodyEntered {
        onBodyEntered(p_args)
        r_error.error=.CALL_OK
        return
    }

    r_error.error = .CALL_ERROR_INSTANCE_IS_NULL
    return
}

onBodyEntered :: proc "c" (args: GDE.ConstVariantPtrargs) {
    context = runtime.default_context()
    //body_rid: GDE.RID, body: GDE.ObjectPtr, body_shape_index: GDE.Int, local_shape_index: GDE.Int
    fmt.println("Body entered.")
}