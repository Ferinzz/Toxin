package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

//WARNING: if Exported you must initialize arrays them with at least create0 at some point.

init_array_types:: proc() {
    
    arrayClass: GDE.StringName
    arraySize: GDE.StringName

    PackedStringArray.GetIndex = gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_STRING_ARRAY)
    PackedStringArray.SetIndex = gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_STRING_ARRAY)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "size", false)
    PackedStringArray.Size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "resize", false)
    PackedStringArray.Resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 848867239)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append", false)
    PackedStringArray.Append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 816187996)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get", false)
    PackedStringArray.Get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 2162347432)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "set", false)
    PackedStringArray.Set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_STRING_ARRAY, &arraySize, 725585539)
    StringName_Methods.Destroy(&arraySize)

    StringName_Methods.Destroy(&arrayClass)

    //Fetch Godot's methods for Array class.
    gdAPI.StringName_Utils.Latin1Chars(&arrayClass, "Array", false)

    GDArray.create0 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 0)
    GDArray.create1 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 1)
    GDArray.create2 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 2)
    GDArray.create3 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 3)
    GDArray.create4 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 4)
    GDArray.create5 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 5)
    GDArray.create6 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 6)
    GDArray.create7 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 7)
    GDArray.create8 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 8)
    GDArray.create9 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 9)
    GDArray.create10 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 10)
    GDArray.create11 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 11)
    GDArray.create11 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 12)

    GDArray.GetIndex = gdAPI.Variant_Utils.GetPtrIndexedGetter(.ARRAY)
    GDArray.SetIndex = gdAPI.Variant_Utils.GetPtrIndexedSetter(.ARRAY)
    GDArray.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.ARRAY)



    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get", false)
    GDArray.Get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 708700221)//
    PackedFloat64Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1401583798)
    PackedInt64Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 4103005248)
    PackedVector2Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2609058838)
    PackedVector3Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1394941017)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1227817084)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2972831132)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1401583798)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 4103005248)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2205440559)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "set", false)
    GDArray.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3798478031)
    PackedFloat64Array.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1113000516)
    PackedInt64Array.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3638975848)
    PackedVector2Array.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 635767250)
    PackedVector3Array.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3975343409)
    PackedVector4Array.set = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1350366223)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1444096570)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1113000516)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3638975848)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2175348267)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "size", false)
    GDArray.Size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    PackedFloat64Array.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3173160232)
    PackedInt64Array.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3173160232)
    PackedVector2Array.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3173160232)
    PackedVector3Array.size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3173160232)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3173160232)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3173160232)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3173160232)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3173160232)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3173160232)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_empty", false)
    GDArray.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    PackedFloat64Array.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3918633141)
    PackedInt64Array.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3918633141)
    PackedVector2Array.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3918633141)
    PackedVector3Array.is_empty = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3918633141)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3918633141)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3918633141)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3918633141)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3918633141)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3918633141)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "push_back", false)
    GDArray.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array.push_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 694024632)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append", false)
    GDArray.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array.append = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 694024632)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "append_array", false)
    GDArray.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2307260970)
    PackedFloat64Array.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 792078629)
    PackedInt64Array.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2090311302)
    PackedVector2Array.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3887534835)
    PackedVector3Array.append_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 203538016)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 537428395)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 798822497)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2981316639)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1087733270)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 791097111)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "remove_at", false)
    GDArray.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2823966027)
    PackedFloat64Array.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2823966027)
    PackedInt64Array.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2823966027)
    PackedVector2Array.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2823966027)
    PackedVector3Array.remove_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 2823966027)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 2823966027)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2823966027)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2823966027)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2823966027)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2823966027)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "insert", false)
    GDArray.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3176316662)
    PackedFloat64Array.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1379903876)
    PackedInt64Array.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1487112728)
    PackedVector2Array.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2225629369)
    PackedVector3Array.insert = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3892262309)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 11085009)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 785289703)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1379903876)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1487112728)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1487112728)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "fill", false)
    GDArray.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 833936903)
    PackedInt64Array.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2823966027)
    PackedVector2Array.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3790411178)
    PackedVector3Array.fill = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3726392409)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3761353134)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3730314301)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 833936903)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2823966027)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2823966027)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "resize", false)
    GDArray.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 848867239)
    PackedFloat64Array.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 848867239)
    PackedInt64Array.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 848867239)
    PackedVector2Array.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 848867239)
    PackedVector3Array.resize = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 848867239)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 848867239)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 848867239)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 848867239)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 848867239)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 848867239)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "clear", false)
    GDArray.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array.clear = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has", false)
    GDArray.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3680194679)
    PackedFloat64Array.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1296369134)
    PackedInt64Array.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 931488181)
    PackedVector2Array.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3190634762)
    PackedVector3Array.has = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1749054343)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 88913544)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3167426256)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1296369134)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 931488181)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 931488181)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3680194679)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "reverse", false)
    GDArray.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array.reverse = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "slice", false)
    GDArray.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1393718243)
    PackedFloat64Array.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2192974324)
    PackedInt64Array.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1726550804)
    PackedVector2Array.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3864005350)
    PackedVector3Array.slice = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 2086131305)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 2942803855)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2451797139)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1418229160)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 1216021098)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_byte_array", false)
    PackedFloat64Array.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 247621236)
    PackedInt64Array.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 247621236)
    PackedVector2Array.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 247621236)
    PackedVector3Array.to_byte_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 247621236)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 247621236)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 247621236)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 247621236)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 247621236)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "sort", false)
    GDArray.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    PackedFloat64Array.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 3218959716)
    PackedInt64Array.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 3218959716)
    PackedVector2Array.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3218959716)
    PackedVector3Array.sort = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3218959716)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3218959716)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3218959716)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3218959716)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3218959716)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3218959716)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bsearch", false)
    GDArray.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3372222236)
    PackedFloat64Array.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1175118842)
    PackedInt64Array.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 954237325)
    PackedVector2Array.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 3341588170)
    PackedVector3Array.bsearch = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 1259277637)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 1822067054)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 2639732838)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1175118842)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3380005890)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 954237325)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "duplicate", false)
    GDArray.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 636440122)
    PackedFloat64Array.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1627308337)
    PackedInt64Array.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 1961294120)
    PackedVector2Array.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1660374357)
    PackedVector3Array.duplicate = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 4171207452)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 146203628)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3072026941)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 3575107827)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 3158844420)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 247621236)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 830099069)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find", false)
    GDArray.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2336346817)
    PackedFloat64Array.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1343150241)
    PackedInt64Array.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2984303840)
    PackedVector2Array.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1469606149)
    PackedVector3Array.find = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3718155780)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3091171314)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3156095363)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1343150241)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2984303840)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2984303840)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "rfind", false)
    GDArray.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2336346817)
    PackedFloat64Array.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 1343150241)
    PackedInt64Array.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 2984303840)
    PackedVector2Array.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 1469606149)
    PackedVector3Array.rfind = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3718155780)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3091171314)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 3156095363)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 1343150241)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 2984303840)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2984303840)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "count", false)
    GDArray.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1481661226)
    PackedFloat64Array.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 2859915090)
    PackedInt64Array.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 4103005248)
    PackedVector2Array.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 2798848307)
    PackedVector3Array.count = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 194580386)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3956594488)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1682108616)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 2859915090)
    PackedInt32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT32_ARRAY, &arraySize, 4103005248)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "erase", false)
    GDArray.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    PackedFloat64Array.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT64_ARRAY, &arraySize, 4094791666)
    PackedInt64Array.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_INT64_ARRAY, &arraySize, 694024632)
    PackedVector2Array.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR2_ARRAY, &arraySize, 4188891560)
    PackedVector3Array.erase = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR3_ARRAY, &arraySize, 3295363524)
    PackedVector4Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_VECTOR4_ARRAY, &arraySize, 3289167688)
    PackedColorArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_COLOR_ARRAY, &arraySize, 1007858200)
    PackedFloat32Array.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_FLOAT32_ARRAY, &arraySize, 4094791666)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 694024632)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1776646889)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "hash", false)
    GDArray.hash = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    GDDictionary.hash = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "assign", false)
    //Parameters are incorrect.
    GDArray.assign = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2307260970)
    GDDictionary.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3642266950)
    StringName_Methods.Destroy(&arraySize)

    //*********************************\\
    //**********ARRAY UNIQUE***********\\
    //*********************************\\
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "push_front", false)
    GDArray.push_front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3316032543)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "front", false)
    GDArray.front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "back", false)
    GDArray.back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pick_random", false)
    GDArray.pick_random = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find_custom", false)
    GDArray.find_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2145562546)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "rfind_custom", false)
    GDArray.rfind_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2145562546)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_back", false)
    GDArray.pop_back = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1321915136)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_front", false)
    GDArray.pop_front = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1321915136)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "pop_at", false)
    GDArray.pop_at = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3518259424)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "sort_custom", false)
    GDArray.sort_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3470848906)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "shuffle", false)
    GDArray.shuffle = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bsearch_custom", false)
    GDArray.bsearch_custom = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 161317131)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "filter", false)
    GDArray.filter = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4075186556)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "map", false)
    GDArray.gdmap = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4075186556)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "reduce", false)
    GDArray.reduce = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4272450342)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "any", false)
    GDArray.gdany = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4129521963)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "all", false)
    GDArray.all = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 4129521963)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "max", false)
    GDArray.max = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "min", false)
    GDArray.min = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed", false)
    GDArray.is_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed", false)
    GDArray.is_same_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 2988181878)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_builtin", false)
    GDArray.get_typed_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_class_name", false)
    GDArray.get_typed_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_script", false)
    GDArray.get_typed_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "make_read_only", false)
    GDArray.make_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3218959716)
    GDDictionary.make_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3218959716)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_read_only", false)
    GDArray.is_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.ARRAY, &arraySize, 3918633141)
    GDDictionary.is_read_only = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)


    //*********************************\\
    //********DICTIONARY UNIQUE********\\
    //*********************************\\
    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "merge", false)
    GDDictionary.merge = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2079548978)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "merged", false)
    GDDictionary.merged = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2271165639)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has_all", false)
    GDDictionary.has_all = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2988181878)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "find_key", false)
    GDDictionary.find_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1988825835)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "keys", false)
    GDDictionary.keys = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4144163970)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "values", false)
    GDDictionary.values = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 4144163970)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "duplicate_deep", false)
    GDDictionary.duplicate_deep = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 2160600714)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_or_add", false)
    GDDictionary.get_or_add = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1052551076)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed", false)
    GDDictionary.is_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed_key", false)
    GDDictionary.is_typed_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_typed_value", false)
    GDDictionary.is_typed_value = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3918633141)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed", false)
    GDDictionary.is_same_typed = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed_key", false)
    GDDictionary.is_same_typed_key = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "is_same_typed_value", false)
    GDDictionary.is_same_typed_value = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3471775634)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_builtin", false)
    GDDictionary.get_typed_key_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_builtin", false)
    GDDictionary.get_typed_value_builtin = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 3173160232)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_class_name", false)
    GDDictionary.get_typed_key_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_class_name", false)
    GDDictionary.get_typed_value_class_name = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1825232092)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_key_script", false)
    GDDictionary.get_typed_key_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_typed_value_script", false)
    GDDictionary.get_typed_value_script = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1460142086)
    StringName_Methods.Destroy(&arraySize)

    gdAPI.StringName_Utils.Latin1Chars(&arraySize, "recursive_equal", false)
    GDDictionary.recursive_equal = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.DICTIONARY, &arraySize, 1404404751)
    StringName_Methods.Destroy(&arraySize)

    //*********************************\\
    //********BYTE ARRAY UNIQUE********\\
    //*********************************\\
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_ascii", false)
    PackedByteArray.get_string_from_ascii = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf8", false)
    PackedByteArray.get_string_from_utf8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf16", false)
    PackedByteArray.get_string_from_utf16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_utf32", false)
    PackedByteArray.get_string_from_utf32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_wchar", false)
    PackedByteArray.get_string_from_wchar = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "get_string_from_multibyte_char", false)
    PackedByteArray.get_string_from_multibyte_char = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3134094431)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "hex_encode", false)
    PackedByteArray.hex_encode = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3942272618)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "compress", false)
    PackedByteArray.compress = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1845905913)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decompress", false)
    PackedByteArray.decompress = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decompress_dynamic", false)
    PackedByteArray.decompress_dynamic = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2278869132)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u8", false)
    PackedByteArray.decode_u8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s8", false)
    PackedByteArray.decode_s8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u16", false)
    PackedByteArray.decode_u16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s16", false)
    PackedByteArray.decode_s16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u32", false)
    PackedByteArray.decode_u32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s32", false)
    PackedByteArray.decode_s32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_u64", false)
    PackedByteArray.decode_u64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_s64", false)
    PackedByteArray.decode_s64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4103005248)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_half", false)
    PackedByteArray.decode_half = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_float", false)
    PackedByteArray.decode_float = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_double", false)
    PackedByteArray.decode_double = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1401583798)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "has_encoded_var", false)
    PackedByteArray.has_encoded_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2914632957)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_var", false)
    PackedByteArray.decode_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1740420038)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "decode_var_size", false)
    PackedByteArray.decode_var_size = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 954237325)
    StringName_Methods.Destroy(&arraySize)
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_int32_array", false)
    PackedByteArray.to_int32_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3158844420)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_int64_array", false)
    PackedByteArray.to_int64_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1961294120)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_float32_array", false)
    PackedByteArray.to_float32_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3575107827)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_float64_array", false)
    PackedByteArray.to_float64_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1627308337)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector2_array", false)
    PackedByteArray.to_vector2_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1660374357)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector3_array", false)
    PackedByteArray.to_vector3_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 4171207452)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_vector4_array", false)
    PackedByteArray.to_vector4_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 146203628)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "to_color_array", false)
    PackedByteArray.to_color_array = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3072026941)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap16", false)
    PackedByteArray.bswap16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap32", false)
    PackedByteArray.bswap32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "bswap64", false)
    PackedByteArray.bswap64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u8", false)
    PackedByteArray.get = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s8", false)
    PackedByteArray.encode_s8 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u16", false)
    PackedByteArray.encode_u16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s16", false)
    PackedByteArray.encode_s16 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)
    
gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u32", false)
    PackedByteArray.encode_u32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s32", false)
    PackedByteArray.encode_s32 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_u64", false)
    PackedByteArray.encode_u64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_s64", false)
    PackedByteArray.encode_s64 = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 3638975848)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_half", false)
    PackedByteArray.encode_half = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_float", false)
    PackedByteArray.encode_float = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_double", false)
    PackedByteArray.encode_double = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 1113000516)
    StringName_Methods.Destroy(&arraySize)

gdAPI.StringName_Utils.Latin1Chars(&arraySize, "encode_var", false)
    PackedByteArray.encode_var = gdAPI.Variant_Utils.GetPtrBuiltinMethod(.PACKED_BYTE_ARRAY, &arraySize, 2604460497)
    StringName_Methods.Destroy(&arraySize)
    

    //dictionary_SN: GDE.StringName
    //StringConstruct.stringNameNewString(&dictionary_SN, "")

    GDDictionary.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.DICTIONARY)
    NodePath.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.NODE_PATH)
    Callable.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.CALLABLE)
    Signal.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.SIGNAL)
    PackedByteArray.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_BYTE_ARRAY)
    PackedInt32Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT32_ARRAY)
    PackedInt64Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_INT64_ARRAY)
    PackedFloat32Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT32_ARRAY)
    PackedFloat64Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_FLOAT64_ARRAY)
    PackedVector2Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR2_ARRAY)
    PackedVector3Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR3_ARRAY)
    PackedVector4Array.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_VECTOR4_ARRAY)
    PackedColorArray.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_COLOR_ARRAY)
    PackedStringArray.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_STRING_ARRAY)

    

    StringName_Methods.Destroy(&arrayClass)
}

PackedStringArray : struct {
    Create0: GDE.PtrConstructor,
    Size: GDE.PtrBuiltInMethod,
    Resize: GDE.PtrBuiltInMethod,
    Append: GDE.PtrBuiltInMethod,
    Get: GDE.PtrBuiltInMethod,
    Set: GDE.PtrBuiltInMethod,
    GetIndex: GDE.PtrIndexedGetter,
    SetIndex: GDE.PtrIndexedSetter,
    Destroy: GDE.PtrDestructor,
}

GDArray : struct {
    create0: GDE.PtrConstructor,
    create1: GDE.PtrConstructor,
    create2: GDE.PtrConstructor,
    create3: GDE.PtrConstructor,
    create4: GDE.PtrConstructor,
    create5: GDE.PtrConstructor,
    create6: GDE.PtrConstructor,
    create7: GDE.PtrConstructor,
    create8: GDE.PtrConstructor,
    create9: GDE.PtrConstructor,
    create10: GDE.PtrConstructor,
    create11: GDE.PtrConstructor,
    create12: GDE.PtrConstructor,

    Destroy: GDE.PtrDestructor,

    GetIndex: GDE.PtrIndexedGetter,
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

GDDictionary : struct {
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

PackedByteArray: struct {
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


PackedInt32Array: struct {
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


PackedInt64Array: struct {
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

PackedFloat32Array: struct {
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


PackedFloat64Array: struct {
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

PackedVector2Array: struct {
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


PackedVector3Array: struct {
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


PackedVector4Array: struct {
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

PackedColorArray: struct {
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
