package GDWrapper

import "base:runtime"
import GDE "gdAPI/gdextension"
import "gdAPI"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"



Init_Wrapper :: proc "c" (p_get_proc_address : GDE.InterfaceGetProcAddress) {
    gdAPI.loadAPI(p_get_proc_address)
    Init_Builtins()
    Init_Variant_Converters()
}

InternalMode :: enum GDE.Int {
    INTERNAL_MODE_DISABLED,
    INTERNAL_MODE_FRONT,
    INTERNAL_MODE_BACK,
}


StringConstruct :: proc {
    stringNameNewString,
    stringNameNewString_r,
}

stringNameNewString :: proc "c" (StringName_r: ^StringName, name: string) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(StringName_r, raw_data(name[:]), i64(len(name)))
    }


@(require_results)
stringNameNewString_r :: proc "c" (name: string) -> (r_ret: StringName) {
        gdAPI.StringName_Utils.Utf8CharsAndLen(&r_ret, raw_data(name[:]), i64(len(name)))
        return
}


Get_Builtin_Method :: proc "c" (variant_type: GDE.VariantType, method_name: string, hash: Int) -> GDE.PtrBuiltInMethod {
    method_name_SN: StringName
    stringNameNewString(&method_name_SN, method_name)
    //defer StringName_M_List.Destroy(&method_name_SN)
    defer {
        fmethod_name:= GDE.Variant{VType = .STRING_NAME}
        fmethod_name.data[0] = transmute(u64)(method_name_SN.ptr)
        gdAPI.Variant_Utils.Destroy(&fmethod_name)
    }
    return gdAPI.Variant_Utils.GetPtrBuiltinMethod(variant_type, &method_name_SN, hash)
}

stringNameCompare :: proc {
    stringNameCompare_string,
    stringNameCompare_StringName,
}

//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_string :: proc "c" (l_value: ^StringName, r_value: string) -> (ret: Bool) {
    r_name: StringName
    StringConstruct(&r_name, r_value)
    defer(StringName_M_List.Destroy(&r_name))

    //Can't do a direct compare because sometimes maybe the stringName could be a reference to a reference to a reference to a StringName.
    StringName_M_List.VARIANT_OP_EQUAL_StringName(l_value, &r_name, &ret)
    return ret
}

//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare_StringName :: proc "c" (l_value: ^StringName, r_value: ^StringName) -> (ret: Bool) {

    StringName_M_List.VARIANT_OP_EQUAL_StringName(l_value, r_value, &ret)
    return ret
}

stringname_destroy :: proc(name: StringName) {
      destruct:=GDE.Variant{
        .STRING_NAME,
        {transmute(u64)name,0}
      }
      gdAPI.Variant_Utils.Destroy(&destruct)
}

/*
getRid :: proc "c" (ref: ^Object, r_ret: ^RID) {
    @(static)GetRID: GDE.MethodBindPtr
    if GetRID == nil do GetRID = classDBGetMethodBind3(.Resource, "get_rid", 2944877500)
    
    gdAPI.Object_Utils.MethodBindPtrcall(GetRID, ref, nil, r_ret)
}
*/

Get_Method_Getter :: proc "c" (type: GDE.VariantType, name: string) -> GDE.PtrGetter {
    name_SN:StringName
    StringConstruct(&name_SN, name)
    return gdAPI.Variant_Utils.GetPtrGetter(type, &name_SN)
}
Get_Method_Setter :: proc "c" (type: GDE.VariantType, name: string) -> GDE.PtrGetter {
    name_SN:= StringConstruct(name)
    return gdAPI.Variant_Utils.GetPtrSetter(type, &name_SN)
}
