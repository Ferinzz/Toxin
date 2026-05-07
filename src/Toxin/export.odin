#+feature using-stmt
package Toxin

import "base:builtin"
import "base:runtime"
import GDW "../GDWrapper"
import GDE "../GDWrapper/gdAPI/gdextension"
import "../GDWrapper/gdAPI"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"
import "core:strings"
import "core:strconv"
import "core:reflect"


export_error :: union {
    binding_error
}

binding_error:: enum {
    none,
    missing_getset_ptr,
}

/*
* Setter does not manange the ref counting. If it is a type which needs ref counting increment it with the Ref_Count proc group.
* Getter does increment the ref counting because there are few ways to avoid it due to how Godot stores memory of certain types.
* Buit why? Because sometimes Godot will call through the variant getter and sometimes it will call your getter directly.
*/
gsetter_userdata:: struct {
    rs_type: GDE.VariantType,
    getter_method: proc "c" (method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr),
    setter_method: proc "c" (method_userdata: rawptr, Object: rawptr, args: [^]rawptr, r_return: rawptr),
    userdata: rawptr,
    fieldname: cstring,
}

Export_Default :: proc(className_SN: ^StringName, getter_setter: ^gsetter_userdata, fieldName: string) {
    info:= make_property(getter_setter.rs_type, fieldName)
    Export4(className_SN, getter_setter, fieldName, &info, GDE.PROPERTY_USAGE_DEFAULT, GDE.Method_Flags_DEFAULT)
    destructProperty(&info)
}

Export4 :: proc(className_SN: ^StringName, getter_setter: ^gsetter_userdata, fieldName: string,\
    info: ^GDE.PropertyInfo, \
    property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT, methodType:= GDE.Method_Flags_DEFAULT, loc: runtime.Source_Code_Location = #caller_location) -> export_error {

    if getter_setter.getter_method == nil && getter_setter.setter_method == nil {
        return .missing_getset_ptr
    }
    getbuf:[100]u8
    setbuf:[100]u8
    getName:= fmt.bprint(getbuf[:], "get", fieldName, sep="_")
    setName:= fmt.bprint(setbuf[:], "set", fieldName, sep="_")
    Bind_Set2(getter_setter.rs_type, className_SN, setName, getter_setter, fieldName, methodType = methodType, loc = loc)
    Bind_Get2(getter_setter.rs_type, className_SN, getName, getter_setter, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, getter_setter.rs_type, info, getName, setName)
    return nil
}

Bind_Set2 :: #force_inline proc(variant_type: GDE.VariantType, className: ^StringName, \
                methodName: string, function: ^gsetter_userdata, argNames: string, \
                methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location)
{
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    //callFunc:= Gen_Variant_Setter2(function, loc=loc)

        argsInfo: [1]GDE.PropertyInfo

        index:int = int(variant_type)
        argsInfo[0] = make_property(GDE.VariantType(index), argNames)
        args_metadata: [1]GDE.ClassMethodArgumentMetadata
        args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE


    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = godotVariantSetterCallback,
        ptrcall_func = GDE.ClassMethodPtrCall(function.setter_method),
        method_flags = (methodType),
    }
    
        methodInfo.argument_count = 1
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]


    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&argsInfo[0])
}


Bind_Get2 :: #force_inline proc(variant_type: GDE.VariantType, className: ^StringName, methodName: string,
                        function: ^gsetter_userdata,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location
                        )
    {
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    returnInfo: GDE.PropertyInfo =  make_property(variant_type, "")
    
    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        //call_func = godotVariantGetterCallback,
        ptrcall_func = GDE.ClassMethodPtrCall(function.getter_method),
        method_flags = (methodType),
    }

    //will use a different passthrough method based on the type that is being got.
    switch variant_type {
        case .NIL:
            assert(false, "should not exportin nil as field type.")
        case .BOOL:
            methodInfo.call_func = Variant_Getter_Bool
        case .INT:
            methodInfo.call_func = Variant_Getter_Int
        case .FLOAT:
            methodInfo.call_func = Variant_Getter_Float
        case .VECTOR2:
            methodInfo.call_func = Variant_Getter_Vector2
        case .VECTOR2I:
            methodInfo.call_func = Variant_Getter_Vector2i
        case .RECT2:
            methodInfo.call_func = Variant_Getter_Rect
        case .RECT2I:
            methodInfo.call_func = Variant_Getter_Rect2i
        case .VECTOR3:
            methodInfo.call_func = Variant_Getter_Vector3
        case .VECTOR3I:
            methodInfo.call_func = Variant_Getter_Vector3i
        case .VECTOR4:
            methodInfo.call_func = Variant_Getter_Vector4
        case .VECTOR4I:
            methodInfo.call_func = Variant_Getter_Vector4i
        case .PLANE:
            methodInfo.call_func = Variant_Getter_Plane
        case .COLOR:
            methodInfo.call_func = Variant_Getter_Color
        case .QUATERNION:
            methodInfo.call_func = Variant_Getter_Quaternion
        case .STRING:
            methodInfo.call_func = Variant_Getter_GDString
        case .STRING_NAME:
            methodInfo.call_func = Variant_Getter_StringName
        case .NODE_PATH:
            methodInfo.call_func = Variant_Getter_NodePath
        case .RID:
            methodInfo.call_func = Variant_Getter_RID
        case .OBJECT:
            methodInfo.call_func = Variant_Getter_Object
        case .CALLABLE:
            methodInfo.call_func = Variant_Getter_Callable
        case .SIGNAL:
            methodInfo.call_func = Variant_Getter_Signal
        case .DICTIONARY:
            methodInfo.call_func = Variant_Getter_Dictionary
        case .TRANSFORM2D:
            methodInfo.call_func = Variant_Getter_Tansform2D
        case .AABB:
            methodInfo.call_func = Variant_Getter_AABB
        case .BASIS:
            methodInfo.call_func = Variant_Getter_Basis
        case .TRANSFORM3D:
            methodInfo.call_func = Variant_Getter_Transform3D
        case .PROJECTION:
            methodInfo.call_func = Variant_Getter_Projection
        case .ARRAY:
            methodInfo.call_func = Variant_Getter_Array
        case .PACKED_BYTE_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedByteArray
        case .PACKED_INT32_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedInt32Array
        case .PACKED_INT64_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedInt64Array
        case .PACKED_FLOAT32_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedFloat32Array
        case .PACKED_FLOAT64_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedFloat64Array
        case .PACKED_STRING_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedStringArray
        case .PACKED_VECTOR2_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedVector2Array
        case .PACKED_VECTOR3_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedVector3Array
        case .PACKED_COLOR_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedColorArray
        case .PACKED_VECTOR4_ARRAY:
            methodInfo.call_func = Variant_Getter_PackedVector4Array
        case .VARIANT_MAX:
            assert(false, "attempted to bind export a variant type outside the VariantType range.")
        case:
            assert(false, "attempted to bind export a variant type outside the VariantType range.")
    }
    
    methodInfo.argument_count = 0
    methodInfo.return_value_info = &returnInfo
    methodInfo.has_return_value = true
    methodInfo.arguments_info = nil
    methodInfo.arguments_metadata = nil

    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&returnInfo)
}


Variant_Setter_Packed :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, \
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    if p_args[0].VType == .ARRAY {
        context = runtime.default_context()
        when builtin.ODIN_DEBUG {
            message:= fmt.caprintf("incorrect type passed as Packed%sArray, this will cause extra allocations", (cast(^gsetter_userdata)method_userdata).rs_type)
            gdAPI.Logging.PrintErrorWithMessage("mistyped", message, (cast(^gsetter_userdata)method_userdata).fieldname,
            "", -1, true)
            delete(message)
        }
        Transform_Array_Call_Setter(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
        return
    }
    (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{variant_get_ptr(p_args[0])}), nil)
}

Transform_Array_Call_Setter :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, \
    p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
    marray:= cast(^Array)variant_get_ptr(p_args[0])
    #partial switch (cast(^gsetter_userdata)method_userdata).rs_type {
    case .PACKED_BYTE_ARRAY:
        parray: PackedByteArray
        GDW.PackedByteArray_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedByteArray_M_List.Destroy(&parray)
    case .PACKED_INT32_ARRAY:
        parray: PackedInt32Array
        GDW.PackedInt32Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedInt32Array_M_List.Destroy(&parray)
    case .PACKED_INT64_ARRAY:
        parray: PackedInt64Array
        GDW.PackedInt64Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedInt64Array_M_List.Destroy(&parray)
    case .PACKED_FLOAT32_ARRAY:
        parray: PackedFloat32Array
        GDW.PackedFloat32Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedFloat32Array_M_List.Destroy(&parray)
    case .PACKED_FLOAT64_ARRAY:
        parray: PackedFloat64Array
        GDW.PackedFloat64Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedFloat64Array_M_List.Destroy(&parray)
    case .PACKED_STRING_ARRAY:
        parray: PackedStringArray
        GDW.PackedStringArray_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedStringArray_M_List.Destroy(&parray)
    case .PACKED_VECTOR2_ARRAY:
        parray: PackedVector2Array
        GDW.PackedVector2Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedVector2Array_M_List.Destroy(&parray)
    case .PACKED_VECTOR3_ARRAY:
        parray: PackedVector3Array
        GDW.PackedVector3Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedVector3Array_M_List.Destroy(&parray)
    case .PACKED_COLOR_ARRAY:
        parray: PackedColorArray
        GDW.PackedColorArray_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedColorArray_M_List.Destroy(&parray)
    case .PACKED_VECTOR4_ARRAY:
        parray: PackedVector4Array
        GDW.PackedVector4Array_M_List.Create2(&parray, {marray})
        (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{&parray}), nil)
        GDW.PackedVector4Array_M_List.Destroy(&parray)
    }
}

godotVariantSetterCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,\
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    context= runtime.default_context()
    if p_argument_count != 1 {
        r_error^= {
            error=.CALL_ERROR_TOO_MANY_ARGUMENTS,
            argument= i32(p_argument_count),
            expected = 1,
        }
    }
    //inlined for speed.
    (cast(^gsetter_userdata)method_userdata).setter_method(method_userdata, p_instance, raw_data([]rawptr{variant_get_ptr(p_args[0])}), r_return)
    r_error^={}
}

godotVariantGetterCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    context= runtime.default_context()
    if p_argument_count != 0 {
        r_error^= {
            error=.CALL_ERROR_TOO_MANY_ARGUMENTS,
            argument= i32(p_argument_count),
            expected = 0,
        }
        return
    }
    method_userdata:= cast(^gsetter_userdata)method_userdata
    tr_return: variant_union_raw
    method_userdata.getter_method(method_userdata, p_instance, nil, &tr_return)
    r_error.error = .CALL_OK
    r_error.expected = 0
    r_error.argument = i32(p_argument_count)
    r_return.VType = method_userdata.rs_type
    insert_variant_data(r_return, &tr_return)
}

insert_variant_data :: proc(container: ^Variant, source: ^variant_union_raw) {
    switch container.VType {
    case .NIL,
    /*  atomic types */
	.BOOL, .INT, .FLOAT,
	/* math types */
	.VECTOR2, .VECTOR2I, .RECT2, .RECT2I, .VECTOR3, .VECTOR3I,
	.VECTOR4, .VECTOR4I, .PLANE, .QUATERNION,
	/* misc types */
	.COLOR,  .RID, .OBJECT:
        container.data = transmute([2]u64)(source.Vector4)
    case  .STRING:
        StringtoVariant(container, cast(^gdstring)source)
    case .STRING_NAME:
        StringNametoVariant(container, cast(^StringName)source)
    case .NODE_PATH:
        NodePathtoVariant(container, cast(^NodePath)source)
    case .CALLABLE:
        CallabletoVariant(container, cast(^Callable)source)
    case .SIGNAL:
        SignaltoVariant(container, cast(^Signal)source)
    case .DICTIONARY:
        DictionarytoVariant(container, cast(^Dictionary)source)
    case .ARRAY:
        ArraytoVariant(container, cast(^Array)source)
    //Godot sets these in its own bucket of memory. Need to assign this way so that it can cleanup appropriately.
	case .AABB:
        AABBtoVariant(container, cast(^AABB)source)
    case .BASIS:
        BasistoVariant(container, cast(^Basis)source)
    case .TRANSFORM3D:
        Transform3dtoVariant(container, cast(^Transform3D)source)
    case .TRANSFORM2D:
        Transform2DtoVariant(container, cast(^Transform2D)source)
    case .PROJECTION:
        ProjectiontoVariant(container, cast(^Projection)source)

	/* typed arrays */
	case .PACKED_BYTE_ARRAY:
        PackedByteArraytoVariant(container, cast(^PackedByteArray)source)//.get_ptr(variant)
	case .PACKED_INT32_ARRAY:
         GDW.Packedi32ArrayToVariant(container, &source.PackedInt32Array)
	case .PACKED_INT64_ARRAY:
         GDW.Packedi64ArrayToVariant(container, &source.PackedInt64Array)
	case .PACKED_FLOAT32_ARRAY:
         GDW.Packedf32ArrayToVariant(container, &source.PackedFloat32Array)
	case .PACKED_FLOAT64_ARRAY:
         GDW.Packedf64ArrayToVariant(container, &source.PackedFloat64Array)
	case .PACKED_STRING_ARRAY:
         GDW.PackedStringArrayToVariant(container, &source.PackedStringArray)
	case .PACKED_VECTOR2_ARRAY:
         GDW.PackedVec2ArrayToVariant(container, &source.PackedVector2Array)
	case .PACKED_VECTOR3_ARRAY:
         GDW.PackedVec3ArrayToVariant(container, &source.PackedVector3Array)
	case .PACKED_COLOR_ARRAY:
         GDW.PackedColorArrayToVariant(container, &source.PackedColorArray)
	case .PACKED_VECTOR4_ARRAY:
         GDW.PackedVec4ArrayToVariant(container, &source.PackedVector4Array)

	case .VARIANT_MAX:
        assert(true, "Variant without a correct type provided!")
    case:
        assert(true, "Variant without a correct type provided!")
    }
}

//I wouldn't need any of this if Godot set the type of the return type before calling out variant function.
Variant_Getter_Bool :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .BOOL
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Int :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .INT
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Float :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .FLOAT
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector2 :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR2
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector2i :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR2I
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Rect :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .RECT2
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Rect2i :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .RECT2I
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector3 :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR3
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector3i :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR3I
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector4 :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR4
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Vector4i :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .VECTOR4I
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Plane :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PLANE
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Color :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .COLOR
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Quaternion :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .QUATERNION
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_GDString :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .STRING
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_StringName :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .STRING_NAME
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_NodePath :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .NODE_PATH
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_RID :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .RID
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Object :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .OBJECT
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Callable :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .CALLABLE
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Signal :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .SIGNAL
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Dictionary :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .DICTIONARY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Tansform2D :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .TRANSFORM2D
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_AABB :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .AABB
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Basis :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .BASIS
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Transform3D :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .TRANSFORM3D
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Projection :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PROJECTION
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedByteArray :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_BYTE_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedInt32Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_INT32_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedInt64Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_INT64_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedFloat32Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_FLOAT32_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedFloat64Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_FLOAT64_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedStringArray :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_STRING_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedVector2Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_VECTOR2_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedVector3Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_VECTOR3_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedColorArray :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_COLOR_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
Variant_Getter_PackedVector4Array :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
        p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
    r_return.VType = .PACKED_VECTOR4_ARRAY
    godotVariantGetterCallback(method_userdata, p_instance, p_args, p_argument_count, r_return, r_error)
}
