package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

//WARNING: if Exported you must initialize arrays them with at least create0 at some point.

init_array_types:: proc(GDArray_Methods: ^GDArray_Methods_list) {

    arrayClass: StringName
    arraySize: StringName

    PackedStringArray_Methods.GetIndex = cast(proc(p_base: ^PackedStringArray, index: Int, r_ret: ^Variant))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_STRING_ARRAY)
    PackedStringArray_Methods.SetIndex = gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_STRING_ARRAY)
    PackedStringArray_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_STRING_ARRAY)
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "size", false)
    PackedStringArray_Methods.Size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "resize", false)
    PackedStringArray_Methods.Resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 848867239)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append", false)
    PackedStringArray_Methods.Append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 816187996)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get", false)
    PackedStringArray_Methods.Get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 2162347432)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "set", false)
    PackedStringArray_Methods.Set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 725585539)
    StringName_Methods.Destroy(&arraySize)

    StringName_Methods.Destroy(&arrayClass)

    //Fetch Godot's methods for Array class.
    gdAPI.StringName_Utils.Latin1Chars(&arrayClass, "Array", false)
    
    GDArray_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 0)
    PackedByteArray_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 0)
    PackedInt32Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT32_ARRAY, 0)
    PackedInt64Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_INT64_ARRAY, 0)
    PackedFloat32Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT32_ARRAY, 0)
    PackedFloat64Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_FLOAT64_ARRAY, 0)
    PackedStringArray_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_STRING_ARRAY, 0)
    PackedVector2Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR2_ARRAY, 0)
    PackedVector3Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR3_ARRAY, 0)
    PackedColorArray_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_COLOR_ARRAY, 0)
    PackedVector4Array_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_VECTOR4_ARRAY, 0)
    GDDictionary_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 0)
    
    GDArray_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 1)
    GDArray_Methods.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 2)
    GDArray_Methods.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 3)
    GDArray_Methods.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 4)
    GDArray_Methods.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 5)
    GDArray_Methods.Create6 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 6)
    GDArray_Methods.Create7 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 7)
    GDArray_Methods.Create8 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 8)
    GDArray_Methods.Create9 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 9)
    GDArray_Methods.Create10 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 10)
    GDArray_Methods.Create11 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 11)
    GDArray_Methods.Create11 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 12)
    
    GDArray_Methods.GetIndex = cast(proc(p_base: ^Class_Array, index: Int, r_ret: ^Variant))gdAPI.Variant_Utils.GetPtrIndexedGetter(.ARRAY)
    GDArray_Methods.SetIndex = gdAPI.Variant_Utils.GetPtrIndexedSetter(.ARRAY)
    GDArray_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.ARRAY)
    


    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get", false)
    GDArray_Methods.Get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 708700221)//
    PackedFloat64Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1401583798)
    PackedInt64Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 4103005248)
    PackedVector2Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2609058838)
    PackedVector3Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1394941017)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1227817084)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2972831132)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1401583798)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 4103005248)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2205440559)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "set", false)
    GDArray_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3798478031)
    PackedFloat64Array_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1113000516)
    PackedInt64Array_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3638975848)
    PackedVector2Array_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 635767250)
    PackedVector3Array_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3975343409)
    PackedVector4Array_Methods.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1350366223)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1444096570)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1113000516)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3638975848)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2175348267)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "size", false)
    GDArray_Methods.Size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    PackedFloat64Array_Methods.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3173160232)
    PackedInt64Array_Methods.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3173160232)
    PackedVector2Array_Methods.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3173160232)
    PackedVector3Array_Methods.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3173160232)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3173160232)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3173160232)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3173160232)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3173160232)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3173160232)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_empty", false)
    GDArray_Methods.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    PackedFloat64Array_Methods.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3918633141)
    PackedInt64Array_Methods.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3918633141)
    PackedVector2Array_Methods.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3918633141)
    PackedVector3Array_Methods.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3918633141)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3918633141)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3918633141)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3918633141)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3918633141)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3918633141)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "push_back", false)
    GDArray_Methods.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array_Methods.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array_Methods.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array_Methods.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array_Methods.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 694024632)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append", false)
    GDArray_Methods.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array_Methods.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array_Methods.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array_Methods.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array_Methods.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 694024632)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append_array", false)
    GDArray_Methods.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2307260970)
    PackedFloat64Array_Methods.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 792078629)
    PackedInt64Array_Methods.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2090311302)
    PackedVector2Array_Methods.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3887534835)
    PackedVector3Array_Methods.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 203538016)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 537428395)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 798822497)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2981316639)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1087733270)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 791097111)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "remove_at", false)
    GDArray_Methods.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2823966027)
    PackedFloat64Array_Methods.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2823966027)
    PackedInt64Array_Methods.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2823966027)
    PackedVector2Array_Methods.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2823966027)
    PackedVector3Array_Methods.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 2823966027)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 2823966027)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2823966027)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2823966027)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2823966027)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2823966027)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "insert", false)
    GDArray_Methods.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3176316662)
    PackedFloat64Array_Methods.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1379903876)
    PackedInt64Array_Methods.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1487112728)
    PackedVector2Array_Methods.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2225629369)
    PackedVector3Array_Methods.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3892262309)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 11085009)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 785289703)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1379903876)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1487112728)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1487112728)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "fill", false)
    GDArray_Methods.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array_Methods.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 833936903)
    PackedInt64Array_Methods.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2823966027)
    PackedVector2Array_Methods.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3790411178)
    PackedVector3Array_Methods.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3726392409)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3761353134)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3730314301)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 833936903)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2823966027)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2823966027)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "resize", false)
    GDArray_Methods.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 848867239)
    PackedFloat64Array_Methods.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 848867239)
    PackedInt64Array_Methods.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 848867239)
    PackedVector2Array_Methods.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 848867239)
    PackedVector3Array_Methods.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 848867239)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 848867239)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 848867239)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 848867239)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 848867239)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 848867239)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "clear", false)
    GDArray_Methods.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array_Methods.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array_Methods.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array_Methods.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array_Methods.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has", false)
    GDArray_Methods.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3680194679)
    PackedFloat64Array_Methods.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1296369134)
    PackedInt64Array_Methods.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 931488181)
    PackedVector2Array_Methods.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3190634762)
    PackedVector3Array_Methods.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1749054343)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 88913544)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3167426256)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1296369134)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 931488181)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 931488181)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3680194679)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "reverse", false)
    GDArray_Methods.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array_Methods.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array_Methods.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array_Methods.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array_Methods.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "slice", false)
    GDArray_Methods.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1393718243)
    PackedFloat64Array_Methods.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2192974324)
    PackedInt64Array_Methods.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1726550804)
    PackedVector2Array_Methods.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3864005350)
    PackedVector3Array_Methods.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 2086131305)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 2942803855)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2451797139)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1418229160)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1216021098)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_byte_array", false)
    PackedFloat64Array_Methods.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 247621236)
    PackedInt64Array_Methods.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 247621236)
    PackedVector2Array_Methods.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 247621236)
    PackedVector3Array_Methods.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 247621236)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 247621236)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 247621236)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 247621236)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 247621236)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "sort", false)
    GDArray_Methods.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array_Methods.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array_Methods.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array_Methods.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array_Methods.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bsearch", false)
    GDArray_Methods.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3372222236)
    PackedFloat64Array_Methods.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1175118842)
    PackedInt64Array_Methods.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 954237325)
    PackedVector2Array_Methods.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3341588170)
    PackedVector3Array_Methods.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1259277637)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1822067054)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2639732838)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1175118842)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3380005890)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 954237325)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "duplicate", false)
    GDArray_Methods.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 636440122)
    PackedFloat64Array_Methods.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1627308337)
    PackedInt64Array_Methods.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1961294120)
    PackedVector2Array_Methods.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1660374357)
    PackedVector3Array_Methods.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 4171207452)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 146203628)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3072026941)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3575107827)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3158844420)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 247621236)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 830099069)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find", false)
    GDArray_Methods.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2336346817)
    PackedFloat64Array_Methods.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1343150241)
    PackedInt64Array_Methods.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2984303840)
    PackedVector2Array_Methods.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1469606149)
    PackedVector3Array_Methods.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3718155780)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3091171314)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3156095363)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1343150241)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2984303840)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2984303840)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "rfind", false)
    GDArray_Methods.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2336346817)
    PackedFloat64Array_Methods.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1343150241)
    PackedInt64Array_Methods.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2984303840)
    PackedVector2Array_Methods.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1469606149)
    PackedVector3Array_Methods.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3718155780)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3091171314)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3156095363)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1343150241)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2984303840)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2984303840)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "count", false)
    GDArray_Methods.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1481661226)
    PackedFloat64Array_Methods.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2859915090)
    PackedInt64Array_Methods.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 4103005248)
    PackedVector2Array_Methods.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2798848307)
    PackedVector3Array_Methods.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 194580386)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3956594488)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1682108616)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2859915090)
    PackedInt32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 4103005248)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "erase", false)
    GDArray_Methods.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array_Methods.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array_Methods.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array_Methods.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array_Methods.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1776646889)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "hash", false)
    GDArray_Methods.hash = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    GDDictionary_Methods.hash = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "assign", false)
    //Parameters are incorrect.
    GDArray_Methods.assign = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2307260970)
    GDDictionary_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3642266950)
    StringName_Methods.Destroy(&arraySize)

    //*********************************\\
    //**********ARRAY UNIQUE***********\\
    //*********************************\\
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "push_front", false)
    GDArray_Methods.push_front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "front", false)
    GDArray_Methods.front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "back", false)
    GDArray_Methods.back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pick_random", false)
    GDArray_Methods.pick_random = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find_custom", false)
    GDArray_Methods.find_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2145562546)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "rfind_custom", false)
    GDArray_Methods.rfind_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2145562546)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_back", false)
    GDArray_Methods.pop_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1321915136)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_front", false)
    GDArray_Methods.pop_front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1321915136)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_at", false)
    GDArray_Methods.pop_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3518259424)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "sort_custom", false)
    GDArray_Methods.sort_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3470848906)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "shuffle", false)
    GDArray_Methods.shuffle = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bsearch_custom", false)
    GDArray_Methods.bsearch_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 161317131)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "filter", false)
    GDArray_Methods.filter = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4075186556)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "map", false)
    GDArray_Methods.gdmap = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4075186556)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "reduce", false)
    GDArray_Methods.reduce = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4272450342)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "any", false)
    GDArray_Methods.gdany = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4129521963)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "all", false)
    GDArray_Methods.all = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4129521963)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "max", false)
    GDArray_Methods.max = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "min", false)
    GDArray_Methods.min = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed", false)
    GDArray_Methods.is_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed", false)
    GDArray_Methods.is_same_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2988181878)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_builtin", false)
    GDArray_Methods.get_typed_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_class_name", false)
    GDArray_Methods.get_typed_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_script", false)
    GDArray_Methods.get_typed_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "make_read_only", false)
    GDArray_Methods.make_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    GDDictionary_Methods.make_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_read_only", false)
    GDArray_Methods.is_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    GDDictionary_Methods.is_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)


    //*********************************\\
    //********DICTIONARY UNIQUE********\\
    //*********************************\\
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "merge", false)
    GDDictionary_Methods.merge = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2079548978)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "merged", false)
    GDDictionary_Methods.merged = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2271165639)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has_all", false)
    GDDictionary_Methods.has_all = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2988181878)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find_key", false)
    GDDictionary_Methods.find_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1988825835)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "keys", false)
    GDDictionary_Methods.keys = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4144163970)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "values", false)
    GDDictionary_Methods.values = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4144163970)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "duplicate_deep", false)
    GDDictionary_Methods.duplicate_deep = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2160600714)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_or_add", false)
    GDDictionary_Methods.get_or_add = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1052551076)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed", false)
    GDDictionary_Methods.is_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed_key", false)
    GDDictionary_Methods.is_typed_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed_value", false)
    GDDictionary_Methods.is_typed_value = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed", false)
    GDDictionary_Methods.is_same_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed_key", false)
    GDDictionary_Methods.is_same_typed_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed_value", false)
    GDDictionary_Methods.is_same_typed_value = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_builtin", false)
    GDDictionary_Methods.get_typed_key_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_builtin", false)
    GDDictionary_Methods.get_typed_value_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_class_name", false)
    GDDictionary_Methods.get_typed_key_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_class_name", false)
    GDDictionary_Methods.get_typed_value_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_script", false)
    GDDictionary_Methods.get_typed_key_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_script", false)
    GDDictionary_Methods.get_typed_value_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)
    
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "recursive_equal", false)
    GDDictionary_Methods.recursive_equal = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1404404751)
    StringName_Methods.Destroy(&arraySize)

    //*********************************\\
    //********BYTE ARRAY UNIQUE********\\
    //*********************************\\
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_ascii", false)
    PackedByteArray_Methods.get_string_from_ascii = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf8", false)
    PackedByteArray_Methods.get_string_from_utf8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf16", false)
    PackedByteArray_Methods.get_string_from_utf16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf32", false)
    PackedByteArray_Methods.get_string_from_utf32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_wchar", false)
    PackedByteArray_Methods.get_string_from_wchar = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_multibyte_char", false)
    PackedByteArray_Methods.get_string_from_multibyte_char = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3134094431)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "hex_encode", false)
    PackedByteArray_Methods.hex_encode = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "compress", false)
    PackedByteArray_Methods.compress = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1845905913)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decompress", false)
    PackedByteArray_Methods.decompress = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decompress_dynamic", false)
    PackedByteArray_Methods.decompress_dynamic = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u8", false)
    PackedByteArray_Methods.decode_u8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s8", false)
    PackedByteArray_Methods.decode_s8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u16", false)
    PackedByteArray_Methods.decode_u16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s16", false)
    PackedByteArray_Methods.decode_s16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u32", false)
    PackedByteArray_Methods.decode_u32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s32", false)
    PackedByteArray_Methods.decode_s32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u64", false)
    PackedByteArray_Methods.decode_u64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s64", false)
    PackedByteArray_Methods.decode_s64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_half", false)
    PackedByteArray_Methods.decode_half = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_float", false)
    PackedByteArray_Methods.decode_float = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_double", false)
    PackedByteArray_Methods.decode_double = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has_encoded_var", false)
    PackedByteArray_Methods.has_encoded_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2914632957)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_var", false)
    PackedByteArray_Methods.decode_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1740420038)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_var_size", false)
    PackedByteArray_Methods.decode_var_size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 954237325)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_int32_array", false)
    PackedByteArray_Methods.to_int32_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3158844420)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_int64_array", false)
    PackedByteArray_Methods.to_int64_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1961294120)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_float32_array", false)
    PackedByteArray_Methods.to_float32_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3575107827)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_float64_array", false)
    PackedByteArray_Methods.to_float64_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1627308337)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector2_array", false)
    PackedByteArray_Methods.to_vector2_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1660374357)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector3_array", false)
    PackedByteArray_Methods.to_vector3_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4171207452)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector4_array", false)
    PackedByteArray_Methods.to_vector4_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 146203628)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_color_array", false)
    PackedByteArray_Methods.to_color_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3072026941)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap16", false)
    PackedByteArray_Methods.bswap16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap32", false)
    PackedByteArray_Methods.bswap32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap64", false)
    PackedByteArray_Methods.bswap64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u8", false)
    PackedByteArray_Methods.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s8", false)
    PackedByteArray_Methods.encode_s8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u16", false)
    PackedByteArray_Methods.encode_u16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s16", false)
    PackedByteArray_Methods.encode_s16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u32", false)
    PackedByteArray_Methods.encode_u32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s32", false)
    PackedByteArray_Methods.encode_s32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u64", false)
    PackedByteArray_Methods.encode_u64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s64", false)
    PackedByteArray_Methods.encode_s64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_half", false)
    PackedByteArray_Methods.encode_half = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_float", false)
    PackedByteArray_Methods.encode_float = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_double", false)
    PackedByteArray_Methods.encode_double = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_var", false)
    PackedByteArray_Methods.encode_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2604460497)
    StringName_Methods.Destroy(&arraySize)
    

    //dictionary_SN: StringName
    //StringConstruct.stringNameNewString(&dictionary_SN, "")

    GDDictionary_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.DICTIONARY)
    NodePath_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.NODE_PATH)
    Callable_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.CALLABLE)
    Signal_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.SIGNAL)
    PackedByteArray_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_BYTE_ARRAY)
    PackedInt32Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT32_ARRAY)
    PackedInt64Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT64_ARRAY)
    PackedFloat32Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT32_ARRAY)
    PackedFloat64Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT64_ARRAY)
    PackedVector2Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR2_ARRAY)
    PackedVector3Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR3_ARRAY)
    PackedVector4Array_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR4_ARRAY)
    PackedColorArray_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_COLOR_ARRAY)

    

    StringName_Methods.Destroy(&arrayClass)
}

/*
getIndex :: proc {
	GDArray.GetIndex,
	PackedStringArray.GetIndex,
}*/


PackedStringArray_Methods : struct {
    Create0: GDE.PtrConstructor,
    Size: GDE.PtrBuiltInMethod,
    Resize: GDE.PtrBuiltInMethod,
    Append: GDE.PtrBuiltInMethod,
    Get: GDE.PtrBuiltInMethod,
    Set: GDE.PtrBuiltInMethod,
    GetIndex: proc(p_base: ^PackedStringArray, index: Int, r_ret: ^Variant),
    SetIndex: GDE.PtrIndexedSetter,
    Destroy: GDE.PtrDestructor,
}

GDArray_Methods : GDArray_Methods_list

Class_Array :: struct {
    self: ^Array,
    using methods: ^GDArray_Methods_list,
}

GDArray_Methods_list :: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Create2: GDE.PtrConstructor,
    Create3: GDE.PtrConstructor,
    Create4: GDE.PtrConstructor,
    Create5: GDE.PtrConstructor,
    Create6: GDE.PtrConstructor,
    Create7: GDE.PtrConstructor,
    Create8: GDE.PtrConstructor,
    Create9: GDE.PtrConstructor,
    Create10: GDE.PtrConstructor,
    Create11: GDE.PtrConstructor,
    Create12: GDE.PtrConstructor,

    Destroy: GDE.PtrDestructor,

    GetIndex: proc(p_base: ^Class_Array, index: Int, r_ret: ^Variant),
    SetIndex: GDE.PtrIndexedSetter,

    Size: GDE.PtrBuiltInMethod,
    Resize: GDE.PtrBuiltInMethod,
    Append: GDE.PtrBuiltInMethod,
    Get: GDE.PtrBuiltInMethod,
    Set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    hash: GDE.PtrBuiltInMethod,
    assign: GDE.PtrBuiltInMethod,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    push_front: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    front: GDE.PtrBuiltInMethod,
    back: GDE.PtrBuiltInMethod,
    pick_random: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    find_custom: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    rfind_custom: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    pop_back: GDE.PtrBuiltInMethod,
    pop_front: GDE.PtrBuiltInMethod,
    pop_at: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    sort_custom: GDE.PtrBuiltInMethod,
    shuffle: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    bsearch_custom: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    filter: GDE.PtrBuiltInMethod,
    gdmap: GDE.PtrBuiltInMethod,
    reduce: GDE.PtrBuiltInMethod,
    gdany: GDE.PtrBuiltInMethod,
    all: GDE.PtrBuiltInMethod,
    max: GDE.PtrBuiltInMethod,
    min: GDE.PtrBuiltInMethod,
    is_typed: GDE.PtrBuiltInMethod,
    is_same_typed: GDE.PtrBuiltInMethod,
    get_typed_builtin: GDE.PtrBuiltInMethod,
    get_typed_class_name: GDE.PtrBuiltInMethod,
    get_typed_script: GDE.PtrBuiltInMethod,
    make_read_only: GDE.PtrBuiltInMethod,
    is_read_only: GDE.PtrBuiltInMethod,
}

GDDictionary_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    make_read_only: GDE.PtrBuiltInMethod,
    is_read_only: GDE.PtrBuiltInMethod,
    merge: GDE.PtrBuiltInMethod,
    merged: GDE.PtrBuiltInMethod,
    has_all: GDE.PtrBuiltInMethod,
    find_key: GDE.PtrBuiltInMethod,
    keys: GDE.PtrBuiltInMethod,
    values: GDE.PtrBuiltInMethod,
    duplicate_deep: GDE.PtrBuiltInMethod,
    get_or_add: GDE.PtrBuiltInMethod,
    is_typed: GDE.PtrBuiltInMethod,
    is_typed_key: GDE.PtrBuiltInMethod,
    is_typed_value: GDE.PtrBuiltInMethod,
    is_same_typed: GDE.PtrBuiltInMethod,
    is_same_typed_key: GDE.PtrBuiltInMethod,
    is_same_typed_value: GDE.PtrBuiltInMethod,
    get_typed_key_builtin: GDE.PtrBuiltInMethod,
    get_typed_value_builtin: GDE.PtrBuiltInMethod,
    get_typed_key_class_name: GDE.PtrBuiltInMethod,
    get_typed_value_class_name: GDE.PtrBuiltInMethod,
    get_typed_key_script: GDE.PtrBuiltInMethod,
    get_typed_value_script: GDE.PtrBuiltInMethod,
    recursive_equal: GDE.PtrBuiltInMethod,
    hash: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "assign",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3642266950,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		}
	]
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "merge",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2079548978,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		},
		{
			"name": "overwrite",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "merged",
	"return_type": "Dictionary",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2271165639,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		},
		{
			"name": "overwrite",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3680194679,
	"arguments": [
		{
			"name": "key",
			"type": "Variant"
		}
	]
},
{
	"name": "has_all",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2988181878,
	"arguments": [
		{
			"name": "keys",
			"type": "Array"
		}
	]
},
{
	"name": "find_key",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1988825835,
	"arguments": [
		{
			"name": "value",
			"type": "Variant"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1776646889,
	"arguments": [
		{
			"name": "key",
			"type": "Variant"
		}
	]
},
{
	"name": "hash",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "keys",
	"return_type": "Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4144163970
},
{
	"name": "values",
	"return_type": "Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4144163970
},
{
	"name": "duplicate",
	"return_type": "Dictionary",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 830099069,
	"arguments": [
		{
			"name": "deep",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "duplicate_deep",
	"return_type": "Dictionary",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2160600714,
	"arguments": [
		{
			"name": "deep_subresources_mode",
			"type": "int",
			"default_value": "1"
		}
	]
},
{
	"name": "get",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2205440559,
	"arguments": [
		{
			"name": "key",
			"type": "Variant"
		},
		{
			"name": "default",
			"type": "Variant",
			"default_value": "null"
		}
	]
},
{
	"name": "get_or_add",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1052551076,
	"arguments": [
		{
			"name": "key",
			"type": "Variant"
		},
		{
			"name": "default",
			"type": "Variant",
			"default_value": "null"
		}
	]
},
{
	"name": "set",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2175348267,
	"arguments": [
		{
			"name": "key",
			"type": "Variant"
		},
		{
			"name": "value",
			"type": "Variant"
		}
	]
},
{
	"name": "is_typed",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_typed_key",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_typed_value",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_same_typed",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3471775634,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		}
	]
},
{
	"name": "is_same_typed_key",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3471775634,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		}
	]
},
{
	"name": "is_same_typed_value",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3471775634,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		}
	]
},
{
	"name": "get_typed_key_builtin",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_typed_value_builtin",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_typed_key_class_name",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1825232092
},
{
	"name": "get_typed_value_class_name",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1825232092
},
{
	"name": "get_typed_key_script",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1460142086
},
{
	"name": "get_typed_value_script",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1460142086
},
{
	"name": "make_read_only",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "is_read_only",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "recursive_equal",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1404404751,
	"arguments": [
		{
			"name": "dictionary",
			"type": "Dictionary"
		},
		{
			"name": "recursion_count",
			"type": "int"
		}
	]
}
*/

PackedByteArray_Methods : struct {
    Create0: GDE.PtrConstructor,
    get:  GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    get_string_from_ascii: GDE.PtrBuiltInMethod,
    get_string_from_utf8: GDE.PtrBuiltInMethod,
    get_string_from_utf16: GDE.PtrBuiltInMethod,
    get_string_from_utf32: GDE.PtrBuiltInMethod,
    get_string_from_wchar: GDE.PtrBuiltInMethod,
    get_string_from_multibyte_char: GDE.PtrBuiltInMethod,
    hex_encode: GDE.PtrBuiltInMethod,
    compress: GDE.PtrBuiltInMethod,
    decompress: GDE.PtrBuiltInMethod,
    decompress_dynamic: GDE.PtrBuiltInMethod,
    decode_u8: GDE.PtrBuiltInMethod,
    decode_s8: GDE.PtrBuiltInMethod,
    decode_u16: GDE.PtrBuiltInMethod,
    decode_s16: GDE.PtrBuiltInMethod,
    decode_u32: GDE.PtrBuiltInMethod,
    decode_s32: GDE.PtrBuiltInMethod,
    decode_u64: GDE.PtrBuiltInMethod,
    decode_s64: GDE.PtrBuiltInMethod,
    decode_half: GDE.PtrBuiltInMethod,
    decode_float: GDE.PtrBuiltInMethod,
    decode_double: GDE.PtrBuiltInMethod,
    has_encoded_var: GDE.PtrBuiltInMethod,
    decode_var: GDE.PtrBuiltInMethod,
    decode_var_size: GDE.PtrBuiltInMethod,
    to_int32_array: GDE.PtrBuiltInMethod,
    to_int64_array: GDE.PtrBuiltInMethod,
    to_float32_array: GDE.PtrBuiltInMethod,
    to_float64_array: GDE.PtrBuiltInMethod,
    to_vector2_array: GDE.PtrBuiltInMethod,
    to_vector3_array: GDE.PtrBuiltInMethod,
    to_vector4_array: GDE.PtrBuiltInMethod,
    to_color_array: GDE.PtrBuiltInMethod,
    bswap16: GDE.PtrBuiltInMethod,
    bswap32: GDE.PtrBuiltInMethod,
    bswap64: GDE.PtrBuiltInMethod,
    encode_s8: GDE.PtrBuiltInMethod,
    encode_s16: GDE.PtrBuiltInMethod,
    encode_u32: GDE.PtrBuiltInMethod,
    encode_s32: GDE.PtrBuiltInMethod,
    encode_u64: GDE.PtrBuiltInMethod,
    encode_s64: GDE.PtrBuiltInMethod,
    encode_half: GDE.PtrBuiltInMethod,
    encode_u16: GDE.PtrBuiltInMethod,
    encode_float: GDE.PtrBuiltInMethod,
    encode_double: GDE.PtrBuiltInMethod,
    encode_var: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 791097111,
	"arguments": [
		{
			"name": "array",
			"type": "PackedByteArray"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1487112728,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 931488181,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2278869132,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 954237325,
	"hash_compatibility": [
		3380005890
	],
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236,
	"hash_compatibility": [
		851781288
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2984303840,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2984303840,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "get_string_from_ascii",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_string_from_utf8",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_string_from_utf16",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_string_from_utf32",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_string_from_wchar",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_string_from_multibyte_char",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "encoding",
			"type": "String",
			"default_value": "\"\""
		}
	]
},
{
	"name": "hex_encode",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "compress",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1845905913,
	"arguments": [
		{
			"name": "compression_mode",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "decompress",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2278869132,
	"arguments": [
		{
			"name": "buffer_size",
			"type": "int"
		},
		{
			"name": "compression_mode",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "decompress_dynamic",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2278869132,
	"arguments": [
		{
			"name": "max_output_size",
			"type": "int"
		},
		{
			"name": "compression_mode",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "decode_u8",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_s8",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_u16",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_s16",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_u32",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_s32",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_u64",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_s64",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_half",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1401583798,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_float",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1401583798,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "decode_double",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1401583798,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		}
	]
},
{
	"name": "has_encoded_var",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2914632957,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "allow_objects",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "decode_var",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1740420038,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "allow_objects",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "decode_var_size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 954237325,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "allow_objects",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "to_int32_array",
	"return_type": "PackedInt32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3158844420
},
{
	"name": "to_int64_array",
	"return_type": "PackedInt64Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1961294120
},
{
	"name": "to_float32_array",
	"return_type": "PackedFloat32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3575107827
},
{
	"name": "to_float64_array",
	"return_type": "PackedFloat64Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1627308337
},
{
	"name": "to_vector2_array",
	"return_type": "PackedVector2Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1660374357
},
{
	"name": "to_vector3_array",
	"return_type": "PackedVector3Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4171207452
},
{
	"name": "to_vector4_array",
	"return_type": "PackedVector4Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 146203628
},
{
	"name": "to_color_array",
	"return_type": "PackedColorArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3072026941
},
{
	"name": "bswap16",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "offset",
			"type": "int",
			"default_value": "0"
		},
		{
			"name": "count",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "bswap32",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "offset",
			"type": "int",
			"default_value": "0"
		},
		{
			"name": "count",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "bswap64",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "offset",
			"type": "int",
			"default_value": "0"
		},
		{
			"name": "count",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "encode_u8",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_s8",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_u16",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_s16",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_u32",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_s32",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_u64",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_s64",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "encode_half",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1113000516,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "encode_float",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1113000516,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "encode_double",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1113000516,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "encode_var",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2604460497,
	"arguments": [
		{
			"name": "byte_offset",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Variant"
		},
		{
			"name": "allow_objects",
			"type": "bool",
			"default_value": "false"
		}
	]
}
*/

PackedInt32Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3638975848,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1087733270,
	"arguments": [
		{
			"name": "array",
			"type": "PackedInt32Array"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1487112728,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 931488181,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedInt32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1216021098,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 954237325,
	"hash_compatibility": [
		3380005890
	],
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedInt32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3158844420,
	"hash_compatibility": [
		1997843129
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2984303840,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2984303840,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 694024632,
	"arguments": [
		{
			"name": "value",
			"type": "int"
		}
	]
}
,
*/

PackedInt64Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}
/*
{
					"name": "get",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 4103005248,
					"arguments": [
						{
							"name": "index",
							"type": "int"
						}
					]
				},
				{
					"name": "set",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 3638975848,
					"arguments": [
						{
							"name": "index",
							"type": "int"
						},
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "size",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 3173160232
				},
				{
					"name": "is_empty",
					"return_type": "bool",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 3918633141
				},
				{
					"name": "push_back",
					"return_type": "bool",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 694024632,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "append",
					"return_type": "bool",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 694024632,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "append_array",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 2090311302,
					"arguments": [
						{
							"name": "array",
							"type": "PackedInt64Array"
						}
					]
				},
				{
					"name": "remove_at",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 2823966027,
					"arguments": [
						{
							"name": "index",
							"type": "int"
						}
					]
				},
				{
					"name": "insert",
					"return_type": "int",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 1487112728,
					"arguments": [
						{
							"name": "at_index",
							"type": "int"
						},
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "fill",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 2823966027,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "resize",
					"return_type": "int",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 848867239,
					"arguments": [
						{
							"name": "new_size",
							"type": "int"
						}
					]
				},
				{
					"name": "clear",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 3218959716
				},
				{
					"name": "has",
					"return_type": "bool",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 931488181,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "reverse",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 3218959716
				},
				{
					"name": "slice",
					"return_type": "PackedInt64Array",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 1726550804,
					"arguments": [
						{
							"name": "begin",
							"type": "int"
						},
						{
							"name": "end",
							"type": "int",
							"default_value": "2147483647"
						}
					]
				},
				{
					"name": "to_byte_array",
					"return_type": "PackedByteArray",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 247621236
				},
				{
					"name": "sort",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 3218959716
				},
				{
					"name": "bsearch",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 954237325,
					"hash_compatibility": [
						3380005890
					],
					"arguments": [
						{
							"name": "value",
							"type": "int"
						},
						{
							"name": "before",
							"type": "bool",
							"default_value": "true"
						}
					]
				},
				{
					"name": "duplicate",
					"return_type": "PackedInt64Array",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 1961294120,
					"hash_compatibility": [
						2376370016
					]
				},
				{
					"name": "find",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 2984303840,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						},
						{
							"name": "from",
							"type": "int",
							"default_value": "0"
						}
					]
				},
				{
					"name": "rfind",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 2984303840,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						},
						{
							"name": "from",
							"type": "int",
							"default_value": "-1"
						}
					]
				},
				{
					"name": "count",
					"return_type": "int",
					"is_vararg": false,
					"is_const": true,
					"is_static": false,
					"hash": 4103005248,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				},
				{
					"name": "erase",
					"return_type": "bool",
					"is_vararg": false,
					"is_const": false,
					"is_static": false,
					"hash": 694024632,
					"arguments": [
						{
							"name": "value",
							"type": "int"
						}
					]
				}
			],
*/

PackedFloat32Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1401583798,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1113000516,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4094791666,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4094791666,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2981316639,
	"arguments": [
		{
			"name": "array",
			"type": "PackedFloat32Array"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1379903876,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 833936903,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1296369134,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedFloat32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1418229160,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1175118842,
	"hash_compatibility": [
		1188816338
	],
	"arguments": [
		{
			"name": "value",
			"type": "float"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedFloat32Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3575107827,
	"hash_compatibility": [
		831114784
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1343150241,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1343150241,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2859915090,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4094791666,
	"arguments": [
		{
			"name": "value",
			"type": "float"
		}
	]
}
*/

PackedFloat64Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}
/*
{
"name": "get",
"return_type": "float",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1401583798,
"arguments": [
{
"name": "index",
"type": "int"
}
]
},
{
"name": "set",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 1113000516,
"arguments": [
{
"name": "index",
"type": "int"
},
{
"name": "value",
"type": "float"
}
]
},
{
"name": "size",
"return_type": "int",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 3173160232
},
{
"name": "is_empty",
"return_type": "bool",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 3918633141
},
{
"name": "push_back",
"return_type": "bool",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 4094791666,
"arguments": [
{
"name": "value",
"type": "float"
}
]
},
{
"name": "append",
"return_type": "bool",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 4094791666,
"arguments": [
{
"name": "value",
"type": "float"
}
]
},
{
"name": "append_array",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 792078629,
"arguments": [
{
"name": "array",
"type": "PackedFloat64Array"
}
]
},
{
"name": "remove_at",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 2823966027,
"arguments": [
{
"name": "index",
"type": "int"
}
]
},
{
"name": "insert",
"return_type": "int",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 1379903876,
"arguments": [
{
"name": "at_index",
"type": "int"
},
{
"name": "value",
"type": "float"
}
]
},
{
"name": "fill",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 833936903,
"arguments": [
{
"name": "value",
"type": "float"
}
]
},
{
"name": "resize",
"return_type": "int",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 848867239,
"arguments": [
{
"name": "new_size",
"type": "int"
}
]
},
{
"name": "clear",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 3218959716
},
{
"name": "has",
"return_type": "bool",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1296369134,
"arguments": [
{
"name": "value",
"type": "float"
}
]
},
{
"name": "reverse",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 3218959716
},
{
"name": "slice",
"return_type": "PackedFloat64Array",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 2192974324,
"arguments": [
{
"name": "begin",
"type": "int"
},
{
"name": "end",
"type": "int",
"default_value": "2147483647"
}
]
},
{
"name": "to_byte_array",
"return_type": "PackedByteArray",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 247621236
},
{
"name": "sort",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 3218959716
},
{
"name": "bsearch",
"return_type": "int",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1175118842,
"hash_compatibility": [
1188816338
],
"arguments": [
{
"name": "value",
"type": "float"
},
{
"name": "before",
"type": "bool",
"default_value": "true"
}
]
},
{
"name": "duplicate",
"return_type": "PackedFloat64Array",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1627308337,
"hash_compatibility": [
949266573
]
},
{
"name": "find",
"return_type": "int",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1343150241,
"arguments": [
{
"name": "value",
"type": "float"
},
{
"name": "from",
"type": "int",
"default_value": "0"
}
]
},
{
"name": "rfind",
"return_type": "int",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 1343150241,
"arguments": [
{
"name": "value",
"type": "float"
},
{
"name": "from",
"type": "int",
"default_value": "-1"
}
]
},
{
"name": "count",
"return_type": "int",
"is_vararg": false,
"is_const": true,
"is_static": false,
"hash": 2859915090,
"arguments": [
{
"name": "value",
"type": "float"
}
]
},
{
"name": "erase",
"return_type": "bool",
"is_vararg": false,
"is_const": false,
"is_static": false,
"hash": 4094791666,
"arguments": [
{
"name": "value",
"type": "float"
}
]
}


PackedVector2Array_Methods : struct {
    Destroy: GDE.PtrDestructor,
}

PackedVector3Array_Methods : struct {
    Destroy: GDE.PtrDestructor,
}

PackedVector4Array_Methods : struct {
    Destroy: GDE.PtrDestructor,
}

PackedColorArray_Methods : struct {
    Destroy: GDE.PtrDestructor,
}
    */



PackedVector2Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "Vector2",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2609058838,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 635767250,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4188891560,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4188891560,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3887534835,
	"arguments": [
		{
			"name": "array",
			"type": "PackedVector2Array"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2225629369,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3790411178,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3190634762,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedVector2Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3864005350,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3341588170,
	"hash_compatibility": [
		3778035805
	],
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedVector2Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1660374357,
	"hash_compatibility": [
		3763646812
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1469606149,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1469606149,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2798848307,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 4188891560,
	"arguments": [
		{
			"name": "value",
			"type": "Vector2"
		}
	]
}
*/

PackedVector3Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "Vector3",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1394941017,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3975343409,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3295363524,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3295363524,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 203538016,
	"arguments": [
		{
			"name": "array",
			"type": "PackedVector3Array"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3892262309,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3726392409,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1749054343,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedVector3Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2086131305,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1259277637,
	"hash_compatibility": [
		219263630
	],
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedVector3Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4171207452,
	"hash_compatibility": [
		2754175465
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3718155780,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3718155780,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 194580386,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3295363524,
	"arguments": [
		{
			"name": "value",
			"type": "Vector3"
		}
	]
}

*/

PackedVector4Array_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "Vector4",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1227817084,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1350366223,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3289167688,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3289167688,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 537428395,
	"arguments": [
		{
			"name": "array",
			"type": "PackedVector4Array"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 11085009,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3761353134,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 88913544,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedVector4Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2942803855,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1822067054,
	"hash_compatibility": [
		735671678
	],
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedVector4Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 146203628,
	"hash_compatibility": [
		3186305013
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3091171314,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3091171314,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3956594488,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3289167688,
	"arguments": [
		{
			"name": "value",
			"type": "Vector4"
		}
	]
}
			],
*/

PackedColorArray_Methods : struct {
    Create0: GDE.PtrConstructor,
    get: GDE.PtrBuiltInMethod,
    set: GDE.PtrBuiltInMethod,
    size: GDE.PtrBuiltInMethod,
    is_empty: GDE.PtrBuiltInMethod,
    push_back: GDE.PtrBuiltInMethod,
    append: GDE.PtrBuiltInMethod,
    append_array: GDE.PtrBuiltInMethod,
    remove_at: GDE.PtrBuiltInMethod,
    insert: GDE.PtrBuiltInMethod,
    fill: GDE.PtrBuiltInMethod,
    resize: GDE.PtrBuiltInMethod,
    clear: GDE.PtrBuiltInMethod,
    has: GDE.PtrBuiltInMethod,
    reverse: GDE.PtrBuiltInMethod,
    slice: GDE.PtrBuiltInMethod,
    to_byte_array: GDE.PtrBuiltInMethod,
    sort: GDE.PtrBuiltInMethod,
    bsearch: GDE.PtrBuiltInMethod,
    duplicate: GDE.PtrBuiltInMethod,
    find: GDE.PtrBuiltInMethod,
    rfind: GDE.PtrBuiltInMethod,
    count: GDE.PtrBuiltInMethod,
    erase: GDE.PtrBuiltInMethod,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "get",
	"return_type": "Color",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2972831132,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "set",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1444096570,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "size",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "push_back",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1007858200,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "append",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1007858200,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "append_array",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 798822497,
	"arguments": [
		{
			"name": "array",
			"type": "PackedColorArray"
		}
	]
},
{
	"name": "remove_at",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 2823966027,
	"arguments": [
		{
			"name": "index",
			"type": "int"
		}
	]
},
{
	"name": "insert",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 785289703,
	"arguments": [
		{
			"name": "at_index",
			"type": "int"
		},
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "fill",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3730314301,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "resize",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 848867239,
	"arguments": [
		{
			"name": "new_size",
			"type": "int"
		}
	]
},
{
	"name": "clear",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "has",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3167426256,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "reverse",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "slice",
	"return_type": "PackedColorArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2451797139,
	"arguments": [
		{
			"name": "begin",
			"type": "int"
		},
		{
			"name": "end",
			"type": "int",
			"default_value": "2147483647"
		}
	]
},
{
	"name": "to_byte_array",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sort",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3218959716
},
{
	"name": "bsearch",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2639732838,
	"hash_compatibility": [
		314143821
	],
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		},
		{
			"name": "before",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "duplicate",
	"return_type": "PackedColorArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3072026941,
	"hash_compatibility": [
		1011903421
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3156095363,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rfind",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3156095363,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1682108616,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
},
{
	"name": "erase",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 1007858200,
	"arguments": [
		{
			"name": "value",
			"type": "Color"
		}
	]
}
*/