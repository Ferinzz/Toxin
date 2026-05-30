
package Toxin

import "base:builtin"
import "base:runtime"
import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import sics "base:intrinsics"
import "core:fmt"


//CS is Class_Struct
gsetter_userdata_t:: struct($T:typeid, $CS: typeid) {
    gs_type: GDE.VariantType,
    getter_method: proc "c" (Object: ^Class_Container(CS)) -> T,
    setter_method: proc "c" (Object: ^Class_Container(CS), args: ^T),
    fieldname: string,
}

//Does not support pass by copy.
Export_Default2 :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t) {
    info:= make_property(getter_setter.gs_type, getter_setter.fieldname)
    Export5(className_SN, getter_setter, &info, GDE.PROPERTY_USAGE_DEFAULT, GDE.Method_Flags_DEFAULT)
    destructProperty(&info)
}

Export5 :: proc(className_SN: ^StringName, getter_setter: ^$T/gsetter_userdata_t, info: ^GDE.PropertyInfo, \
    property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT, methodType:= GDE.Method_Flags_DEFAULT, loc: runtime.Source_Code_Location = #caller_location) -> export_error {

    if getter_setter.getter_method == nil && getter_setter.setter_method == nil {
        return .missing_getset_ptr
    }
    getbuf:[100]u8
    setbuf:[100]u8
    getName:= fmt.bprint(getbuf[:], "get", getter_setter.fieldname, sep="_")
    setName:= fmt.bprint(setbuf[:], "set", getter_setter.fieldname, sep="_")
    _bind_default(getter_setter.setter_method, className_SN, setName)
    _bind_default(getter_setter.getter_method, className_SN, getName)
    //Bind_Set3(className_SN, setName, getter_setter, getter_setter.fieldname, methodType = methodType, loc = loc)
    //Bind_Get2(getter_setter.gs_type, className_SN, getName, getter_setter, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, getter_setter.fieldname, getter_setter.gs_type, info, getName, setName)
    return nil
}


Bind_Set3 :: #force_inline proc(className: ^StringName, \
                methodName: string, function: ^gsetter_userdata, argNames: string, \
                methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location)
{
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    argsInfo: [1]GDE.PropertyInfo

    index:int = int(function.gs_type)
    argsInfo[0] = make_property(GDE.VariantType(index), argNames)
    args_metadata: [1]GDE.ClassMethodArgumentMetadata
    args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE


    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)(function),
        ptrcall_func = set_passthrough,
        method_flags = (methodType),
    }
    #partial switch function.gs_type {
        case .ARRAY:
            methodInfo.call_func = Variant_Setter_Array
        case .PACKED_BYTE_ARRAY, .PACKED_INT32_ARRAY, .PACKED_INT64_ARRAY,
          .PACKED_FLOAT32_ARRAY, .PACKED_FLOAT64_ARRAY, .PACKED_STRING_ARRAY,
          .PACKED_VECTOR2_ARRAY, .PACKED_VECTOR3_ARRAY, .PACKED_COLOR_ARRAY,
          .PACKED_VECTOR4_ARRAY :
            methodInfo.call_func = Variant_Setter_Packed
        case:
            methodInfo.call_func = godotVariantSetterCallback
    }
    
        methodInfo.argument_count = 1
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]


    gdAPI.ClassDB.RegisterExtensionClassMethod(Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&argsInfo[0])
}
