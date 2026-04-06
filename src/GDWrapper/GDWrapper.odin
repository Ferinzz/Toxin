package GDWrapper

import "base:runtime"
import GDE "gdAPI/gdextension"
import "gdAPI"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"
//import Classes ".."

Library : GDE.ClassDB = nil


Init_Wrapper :: proc(p_get_proc_address : GDE.InterfaceGetProcAddress) {
    gdAPI.loadAPI(p_get_proc_address)
    Init_Builtins()
    Init_Variant_Converters()
}


/*
* MainLoop is a class that Godot uses to tick through the program logic.
* This function returns a pointer to the object. If SceneTree is your mainLoop (or your own version of it) call
* this to get the object instead of Node's get_tree which would provide a ref to SceneTree instead.
*/
getMainLoop :: proc() -> (gdLoop: ^Object) {
    @(static)getMainLoop:GDE.MethodBindPtr

    ClassDB:StringName
    gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "Engine", false)
    defer(StringName_M_List.Destroy(&ClassDB))
    myEngine:= gdAPI.GlobalGetSingleton(&ClassDB)

    if getMainLoop == nil {
        getMainLoop = classDBGetMethodBind3(.Engine, "get_main_loop", 1016888095)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(getMainLoop, myEngine, nil, &gdLoop)
    return
}
get_current_scene :: proc() -> ^Object {
    @(static)getCurrentScene: GDE.MethodBindPtr
    if getCurrentScene == nil {
        getCurrentScene = classDBGetMethodBind3(.SceneTree, "get_current_scene", 3160264692)
    }
    mySceneTree:= getMainLoop()
    r_ret:^Object
    gdAPI.Object_Utils.MethodBindPtrcall(getCurrentScene, mySceneTree, nil, &r_ret)
    return r_ret
}

getPerformance :: proc() -> ^Object {
    @(static)getMainLoop:GDE.MethodBindPtr

    ClassDB:StringName
    gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "Performance", false)
    defer(StringName_M_List.Destroy(&ClassDB))
    return gdAPI.GlobalGetSingleton(&ClassDB)
}

/*
* https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-add-child
* Force_readable_name default should be false if you care about performance. True if you really want a name to be visible to the user.
* Use internalMode to hide children from the user. But make sure to set include_internal to true when calling get_children.
*/
addChild :: proc(parent: ^Object, child: ^^Object, force_readable_name: Bool = false, internalMode: InternalMode = .INTERNAL_MODE_DISABLED) {

    force_readable_name:= force_readable_name
    internalMode:= internalMode

    @(static)addChild: GDE.MethodBindPtr
    if addChild == nil {
        addChild = classDBGetMethodBind3(.Node, "add_child", 3863233950)
    }

    args:= [?]rawptr {child, &force_readable_name, &internalMode}
    
    dummyReturn:rawptr
    gdAPI.Object_Utils.MethodBindPtrcall(addChild, parent, raw_data(args[:]), dummyReturn)
}

InternalMode :: enum GDE.Int {
    INTERNAL_MODE_DISABLED,
    INTERNAL_MODE_FRONT,
    INTERNAL_MODE_BACK,
}

getRoot :: proc() -> ^Object {
    @(static)getRoot: GDE.MethodBindPtr
    if getRoot == nil {
        getRoot = classDBGetMethodBind3(.SceneTree, "get_root", 1757182445)
    }
    mySceneTree:= getMainLoop()
    r_ret:^Object
    gdAPI.Object_Utils.MethodBindPtrcall(getRoot, mySceneTree, nil, &r_ret)
    return r_ret
}


StringConstruct :: proc {
    stringNameNewString,
    stringNameNewString_r,
}
stringNameNewString :: proc"c"(StringName_r: ^StringName, name: string) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(StringName_r, raw_data(name[:]), i64(len(name)))
    }
@(require_results)
stringNameNewString_r :: proc"c"(name: string) -> (r_ret: StringName) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(&r_ret, raw_data(name[:]), i64(len(name)))
        return
}

Get_Builtin_Method :: proc(variant_type: GDE.VariantType, method_name: string, hash: Int) -> GDE.PtrBuiltInMethod {
    method_name_SN: StringName
    defer StringName_M_List.Destroy(&method_name_SN)
    stringNameNewString(&method_name_SN, method_name)
    return gdAPI.Variant_Utils.GetPtrBuiltinMethod(variant_type, &method_name_SN, hash)
}

stringNameCompare :: proc {
    stringNameCompare_string,
    stringNameCompare_StringName,
}

//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
@(deprecated="use stringNameCompare_string")
stringNameCompare_cstring :: proc(l_value: ^StringName, r_value: cstring) -> (ret: Bool) {
    r_name: StringName
    gdAPI.StringName_Utils.Latin1Chars(&r_name, r_value, false)
    defer(StringName_M_List.Destroy(&r_name))

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_M_List.VARIANT_OP_EQUAL_StringName(l_value, &r_name, &ret)
    return ret
}

//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_string :: proc(l_value: ^StringName, r_value: string) -> (ret: Bool) {
    r_name: StringName
    StringConstruct(&r_name, r_value)
    defer(StringName_M_List.Destroy(&r_name))

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_M_List.VARIANT_OP_EQUAL_StringName(l_value, &r_name, &ret)
    return ret
}
//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_StringName :: proc(l_value: ^StringName, r_value: ^StringName) -> (ret: Bool) {

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_M_List.VARIANT_OP_EQUAL_StringName(l_value, r_value, &ret)
    return ret
}

getRid :: proc(ref: ^Object, r_ret: ^RID) {
    @(static)GetRID: GDE.MethodBindPtr
    if GetRID == nil do GetRID = classDBGetMethodBind3(.Resource, "get_rid", 2944877500)
    
    gdAPI.Object_Utils.MethodBindPtrcall(GetRID, ref, nil, r_ret)
}


Get_Method_Getter :: proc(type: GDE.VariantType, name: string) -> GDE.PtrGetter {
    name_SN:StringName
    StringConstruct(&name_SN, name)
    return gdAPI.Variant_Utils.GetPtrGetter(type, &name_SN)
}
Get_Method_Setter :: proc(type: GDE.VariantType, name: string) -> GDE.PtrGetter {
    name_SN:= StringConstruct(name)
    return gdAPI.Variant_Utils.GetPtrSetter(type, &name_SN)
}

StringNameGetBasename :: proc(StringNamePtr: ^StringName, r_String: ^gdstring) {
    @(static)stringNameGetBasename: GDE.PtrBuiltInMethod
    if stringNameGetBasename == nil {
        ClassDB:StringName
        gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "get_basename", false)
        defer(StringName_M_List.Destroy(&ClassDB))
        stringNameGetBasename = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.STRING_NAME, &ClassDB, 3942272618)
    }
    stringNameGetBasename(StringNamePtr, nil, r_String, 0)

}

GDStringJoin :: proc(packedString: ^PackedStringArray, r_String: ^gdstring) {
    @(static)gdStringJoin: GDE.PtrBuiltInMethod
    if gdStringJoin == nil {
        ClassDB:StringName
        gdAPI.StringName_Utils.Latin1Chars(&ClassDB, "join", false)
        defer(StringName_M_List.Destroy(&ClassDB))
        gdStringJoin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.STRING, &ClassDB, 3595973238)
    }

    args:= [1]rawptr {packedString}
    gdStringJoin(packedString, raw_data(args[:]), r_String, 1)
}

/*Returns the unique tag of the Class.
* Use with checkCast in order to verify if a GDObject received can be cast to the specific class.
* classTagName: string representing the name of the class. ie InputEvent
*/
get_ClassTagName :: proc(classTagName: string) -> ClassTag {
    
    classTagName_SN: StringName
    StringConstruct(&classTagName_SN, classTagName)
    defer(StringName_M_List.Destroy(&classTagName_SN))
    return gdAPI.ClassDB.GetClassTag(&classTagName_SN)
}

get_All_ClassTag :: proc {
    get_All_ClassTag_struct,
    get_All_ClassTag_array,
}

get_All_ClassTag_struct :: proc(classtypes: ^$T) where sics.type_is_struct(T){
    pos:^T = classtypes
    for field, i in reflect.struct_fields_zipped(T) {
        field_pos:^ClassTag=cast(^ClassTag)(uintptr(pos) + field.offset)
        field_pos^ = get_ClassTagName(field.name)
    }
};

/*
* Populate an array with the ClassTag(s).
* See Input.odin for an example InputEvent_get_ClassTag of its usage.
* classtypes: a pointer to an enumerated array of ClassTags.
*/
get_All_ClassTag_array :: proc(classtypes: ^$T/[$E]ClassTag) where sics.type_is_enum(E){
    for name, i in reflect.enum_field_names(E) {
        classtypes[E(i)] = get_ClassTagName(name)
    }
};



/*
* Use this function to generate a ptr call for your virutal functions.
* Can have up to 10 variables + the classInstancePointer.
* First variable of your procPointer should always be a pointer to your class struct. p_instance will be used there.
*
* procPointer : The proc to your variable. Passed from your callVirtualFunctionWithData
* p_instance : The instance pointer that Godot included in callVirtualFunctionWithData
* p_args : An array of args sent by Godot in callVirtualFunctionWithData
* r_ret : A pointer to hold the return value of your function
*/
virtualProcCall :: #force_inline proc (procPointer: $T, p_instance: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr)
                            where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 11){

    classStructPtr::sics.type_proc_parameter_type(T, 0)
    
    argcount :: sics.type_proc_parameter_count(T)

    when argcount == 1 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance)
        } else {
        procPointer(cast(classStructPtr)p_instance)}
    }
    else do when argcount > 1 do argT0::sics.type_proc_parameter_type(T, 1)

    else do when argcount > 2 do argT1 :: sics.type_proc_parameter_type(T, 2)
    
    else do when argcount > 3 do argT2 :: sics.type_proc_parameter_type(T, 3)
    
    else do when argcount > 4 do argT3 :: sics.type_proc_parameter_type(T, 4)
    
    else do when argcount > 5 do argT4 :: sics.type_proc_parameter_type(T, 5)
    
    else do when argcount > 6 do argT5 :: sics.type_proc_parameter_type(T, 6)
    
    else do when argcount > 7 do argT6 :: sics.type_proc_parameter_type(T, 7)
    
    else do when argcount > 8 do argT7 :: sics.type_proc_parameter_type(T, 8)
    
    else do when argcount > 9 do argT8 :: sics.type_proc_parameter_type(T, 9)
    
    else do when argcount > 10 do argT9 :: sics.type_proc_parameter_type(T, 10)
    
    when argcount == 2 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^)
        }
    }
    when argcount == 3 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^)
        }
    }
    when argcount == 4 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^)
        }
    }
    when argcount == 5 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^)
        }
    }
    when argcount == 6 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, ))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^)
        }
    }
    when argcount == 7 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^)
        }
    }
    when argcount == 8 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^)
        }
    }
    when argcount == 9 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^)
        }
    }
    when argcount == 10 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^)
        }
    }
    when argcount == 11 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(^sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^, (cast(^argT9)p_args[9])^)
        } else {
            procPointer(cast(classStructPtr)p_instance, (cast(^argT0)p_args[0])^, (cast(^argT1)p_args[1])^, (cast(^argT2)p_args[2])^,
                        (cast(^argT3)p_args[3])^, (cast(^argT4)p_args[4])^, (cast(^argT5)p_args[5])^ (cast(^argT6)p_args[6])^,
                        (cast(^argT7)p_args[7])^, (cast(^argT8)p_args[8])^, (cast(^argT9)p_args[9])^)
        }
    }
}