package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


PackedByteArray_Methods_list :: struct {
    Create0: proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^PackedByteArray,  #by_ptr p_args: struct{ from: ^PackedByteArray, }),
    Create2: proc "c" (p_base: ^PackedByteArray,  #by_ptr p_args: struct{ from: ^Array, }),
    Destroy: proc "c" (p_base: ^PackedByteArray),
    get_ptr: proc "c" (base: ^Variant) -> ^PackedByteArray,
    IndxSetter : proc "c" (p_base: ^PackedByteArray, p_index: Int, p_value: ^Int),
    IndxGetter : proc "c" (p_base: ^PackedByteArray, p_index: Int, r_value: ^Int),
    get:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ index: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    size:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    push_back:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ array: ^PackedByteArray, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    remove_at:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ at_index: ^Int, value: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    fill:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ new_size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    clear:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    has:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^PackedByteArray, p_argument_count: i64 = 2),
    sort:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    duplicate:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ value: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 1),
    get_string_from_ascii:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_string_from_utf8:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_string_from_utf16:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_string_from_utf32:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_string_from_wchar:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_string_from_multibyte_char:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ encoding: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    hex_encode:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    compress:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ compression_mode: ^Int, }, r_return: ^PackedByteArray, p_argument_count: i64 = 1),
    decompress:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ buffer_size: ^Int, compression_mode: ^Int, }, r_return: ^PackedByteArray, p_argument_count: i64 = 2),
    decompress_dynamic:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ max_output_size: ^Int, compression_mode: ^Int, }, r_return: ^PackedByteArray, p_argument_count: i64 = 2),
    decode_u8:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_s8:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_u16:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_s16:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_u32:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_s32:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_u64:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_s64:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    decode_half:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^float, p_argument_count: i64 = 1),
    decode_float:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^float, p_argument_count: i64 = 1),
    decode_double:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, }, r_return: ^float, p_argument_count: i64 = 1),
    has_encoded_var:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, allow_objects: ^Bool, }, r_return: ^Bool, p_argument_count: i64 = 2),
    decode_var:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, allow_objects: ^Bool, }, r_return: ^Variant, p_argument_count: i64 = 2),
    decode_var_size:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, allow_objects: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    to_int32_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedInt32Array, p_argument_count: i64 = 0),
    to_int64_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedInt64Array, p_argument_count: i64 = 0),
    to_float32_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedFloat32Array, p_argument_count: i64 = 0),
    to_float64_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedFloat64Array, p_argument_count: i64 = 0),
    to_vector2_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedVector2Array, p_argument_count: i64 = 0),
    to_vector3_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedVector3Array, p_argument_count: i64 = 0),
    to_vector4_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedVector4Array, p_argument_count: i64 = 0),
    to_color_array:  proc "c" (p_base: ^PackedByteArray, p_args: rawptr = nil, r_return: ^PackedColorArray, p_argument_count: i64 = 0),
    bswap16:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ offset: ^Int, count: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    bswap32:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ offset: ^Int, count: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    bswap64:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ offset: ^Int, count: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_u8:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_s8:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_u16:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_s16:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_u32:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_s32:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_u64:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_s64:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_half:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_float:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_double:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^float, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    encode_var:  proc "c" (p_base: ^PackedByteArray, #by_ptr p_args: struct{ byte_offset: ^Int, value: ^Variant, allow_objects: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 3),
    VARIANT_OP_NOT_: proc "c" (p_left: ^PackedByteArray, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^PackedByteArray, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^PackedByteArray, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_EQUAL_PackedByteArray: proc "c" (p_left: ^PackedByteArray, p_right: ^PackedByteArray, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_PackedByteArray: proc "c" (p_left: ^PackedByteArray, p_right: ^PackedByteArray, r_result: ^Bool),
    VARIANT_OP_ADD_PackedByteArray: proc "c" (p_left: ^PackedByteArray, p_right: ^PackedByteArray, r_result: ^PackedByteArray),
}
init_PackedByteArray_Methods :: proc "c" (PackedByteArray_method_store: ^PackedByteArray_Methods_list) {
  PackedByteArray_method_store.Create0 = cast(type_of(PackedByteArray_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 0)
  PackedByteArray_method_store.Create1 = cast(type_of(PackedByteArray_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 1)
  PackedByteArray_method_store.Create2 = cast(type_of(PackedByteArray_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 2)
  PackedByteArray_method_store.Destroy = cast(type_of(PackedByteArray_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_BYTE_ARRAY)
    PackedByteArray_method_store.get_ptr = cast(type_of(PackedByteArray_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.IndxGetter = cast(type_of(PackedByteArray_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.IndxSetter = cast(type_of(PackedByteArray_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.get = cast(type_of(PackedByteArray_method_store.get))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get", 4103005248)
  PackedByteArray_method_store.set = cast(type_of(PackedByteArray_method_store.set))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "set", 3638975848)
  PackedByteArray_method_store.size = cast(type_of(PackedByteArray_method_store.size))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "size", 3173160232)
  PackedByteArray_method_store.is_empty = cast(type_of(PackedByteArray_method_store.is_empty))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "is_empty", 3918633141)
  PackedByteArray_method_store.push_back = cast(type_of(PackedByteArray_method_store.push_back))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "push_back", 694024632)
  PackedByteArray_method_store.append = cast(type_of(PackedByteArray_method_store.append))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "append", 694024632)
  PackedByteArray_method_store.append_array = cast(type_of(PackedByteArray_method_store.append_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "append_array", 791097111)
  PackedByteArray_method_store.remove_at = cast(type_of(PackedByteArray_method_store.remove_at))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "remove_at", 2823966027)
  PackedByteArray_method_store.insert = cast(type_of(PackedByteArray_method_store.insert))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "insert", 1487112728)
  PackedByteArray_method_store.fill = cast(type_of(PackedByteArray_method_store.fill))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "fill", 2823966027)
  PackedByteArray_method_store.resize = cast(type_of(PackedByteArray_method_store.resize))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "resize", 848867239)
  PackedByteArray_method_store.clear = cast(type_of(PackedByteArray_method_store.clear))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "clear", 3218959716)
  PackedByteArray_method_store.has = cast(type_of(PackedByteArray_method_store.has))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "has", 931488181)
  PackedByteArray_method_store.reverse = cast(type_of(PackedByteArray_method_store.reverse))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "reverse", 3218959716)
  PackedByteArray_method_store.slice = cast(type_of(PackedByteArray_method_store.slice))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "slice", 2278869132)
  PackedByteArray_method_store.sort = cast(type_of(PackedByteArray_method_store.sort))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "sort", 3218959716)
  PackedByteArray_method_store.bsearch = cast(type_of(PackedByteArray_method_store.bsearch))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bsearch", 954237325)
  PackedByteArray_method_store.duplicate = cast(type_of(PackedByteArray_method_store.duplicate))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "duplicate", 247621236)
  PackedByteArray_method_store.find = cast(type_of(PackedByteArray_method_store.find))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "find", 2984303840)
  PackedByteArray_method_store.rfind = cast(type_of(PackedByteArray_method_store.rfind))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "rfind", 2984303840)
  PackedByteArray_method_store.count = cast(type_of(PackedByteArray_method_store.count))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "count", 4103005248)
  PackedByteArray_method_store.erase = cast(type_of(PackedByteArray_method_store.erase))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "erase", 694024632)
  PackedByteArray_method_store.get_string_from_ascii = cast(type_of(PackedByteArray_method_store.get_string_from_ascii))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_ascii", 3942272618)
  PackedByteArray_method_store.get_string_from_utf8 = cast(type_of(PackedByteArray_method_store.get_string_from_utf8))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf8", 3942272618)
  PackedByteArray_method_store.get_string_from_utf16 = cast(type_of(PackedByteArray_method_store.get_string_from_utf16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf16", 3942272618)
  PackedByteArray_method_store.get_string_from_utf32 = cast(type_of(PackedByteArray_method_store.get_string_from_utf32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf32", 3942272618)
  PackedByteArray_method_store.get_string_from_wchar = cast(type_of(PackedByteArray_method_store.get_string_from_wchar))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_wchar", 3942272618)
  PackedByteArray_method_store.get_string_from_multibyte_char = cast(type_of(PackedByteArray_method_store.get_string_from_multibyte_char))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_multibyte_char", 3134094431)
  PackedByteArray_method_store.hex_encode = cast(type_of(PackedByteArray_method_store.hex_encode))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "hex_encode", 3942272618)
  PackedByteArray_method_store.compress = cast(type_of(PackedByteArray_method_store.compress))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "compress", 1845905913)
  PackedByteArray_method_store.decompress = cast(type_of(PackedByteArray_method_store.decompress))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decompress", 2278869132)
  PackedByteArray_method_store.decompress_dynamic = cast(type_of(PackedByteArray_method_store.decompress_dynamic))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decompress_dynamic", 2278869132)
  PackedByteArray_method_store.decode_u8 = cast(type_of(PackedByteArray_method_store.decode_u8))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u8", 4103005248)
  PackedByteArray_method_store.decode_s8 = cast(type_of(PackedByteArray_method_store.decode_s8))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s8", 4103005248)
  PackedByteArray_method_store.decode_u16 = cast(type_of(PackedByteArray_method_store.decode_u16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u16", 4103005248)
  PackedByteArray_method_store.decode_s16 = cast(type_of(PackedByteArray_method_store.decode_s16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s16", 4103005248)
  PackedByteArray_method_store.decode_u32 = cast(type_of(PackedByteArray_method_store.decode_u32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u32", 4103005248)
  PackedByteArray_method_store.decode_s32 = cast(type_of(PackedByteArray_method_store.decode_s32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s32", 4103005248)
  PackedByteArray_method_store.decode_u64 = cast(type_of(PackedByteArray_method_store.decode_u64))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u64", 4103005248)
  PackedByteArray_method_store.decode_s64 = cast(type_of(PackedByteArray_method_store.decode_s64))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s64", 4103005248)
  PackedByteArray_method_store.decode_half = cast(type_of(PackedByteArray_method_store.decode_half))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_half", 1401583798)
  PackedByteArray_method_store.decode_float = cast(type_of(PackedByteArray_method_store.decode_float))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_float", 1401583798)
  PackedByteArray_method_store.decode_double = cast(type_of(PackedByteArray_method_store.decode_double))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_double", 1401583798)
  PackedByteArray_method_store.has_encoded_var = cast(type_of(PackedByteArray_method_store.has_encoded_var))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "has_encoded_var", 2914632957)
  PackedByteArray_method_store.decode_var = cast(type_of(PackedByteArray_method_store.decode_var))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_var", 1740420038)
  PackedByteArray_method_store.decode_var_size = cast(type_of(PackedByteArray_method_store.decode_var_size))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_var_size", 954237325)
  PackedByteArray_method_store.to_int32_array = cast(type_of(PackedByteArray_method_store.to_int32_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_int32_array", 3158844420)
  PackedByteArray_method_store.to_int64_array = cast(type_of(PackedByteArray_method_store.to_int64_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_int64_array", 1961294120)
  PackedByteArray_method_store.to_float32_array = cast(type_of(PackedByteArray_method_store.to_float32_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_float32_array", 3575107827)
  PackedByteArray_method_store.to_float64_array = cast(type_of(PackedByteArray_method_store.to_float64_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_float64_array", 1627308337)
  PackedByteArray_method_store.to_vector2_array = cast(type_of(PackedByteArray_method_store.to_vector2_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector2_array", 1660374357)
  PackedByteArray_method_store.to_vector3_array = cast(type_of(PackedByteArray_method_store.to_vector3_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector3_array", 4171207452)
  PackedByteArray_method_store.to_vector4_array = cast(type_of(PackedByteArray_method_store.to_vector4_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector4_array", 146203628)
  PackedByteArray_method_store.to_color_array = cast(type_of(PackedByteArray_method_store.to_color_array))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_color_array", 3072026941)
  PackedByteArray_method_store.bswap16 = cast(type_of(PackedByteArray_method_store.bswap16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap16", 3638975848)
  PackedByteArray_method_store.bswap32 = cast(type_of(PackedByteArray_method_store.bswap32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap32", 3638975848)
  PackedByteArray_method_store.bswap64 = cast(type_of(PackedByteArray_method_store.bswap64))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap64", 3638975848)
  PackedByteArray_method_store.encode_u8 = cast(type_of(PackedByteArray_method_store.encode_u8))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u8", 3638975848)
  PackedByteArray_method_store.encode_s8 = cast(type_of(PackedByteArray_method_store.encode_s8))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s8", 3638975848)
  PackedByteArray_method_store.encode_u16 = cast(type_of(PackedByteArray_method_store.encode_u16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u16", 3638975848)
  PackedByteArray_method_store.encode_s16 = cast(type_of(PackedByteArray_method_store.encode_s16))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s16", 3638975848)
  PackedByteArray_method_store.encode_u32 = cast(type_of(PackedByteArray_method_store.encode_u32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u32", 3638975848)
  PackedByteArray_method_store.encode_s32 = cast(type_of(PackedByteArray_method_store.encode_s32))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s32", 3638975848)
  PackedByteArray_method_store.encode_u64 = cast(type_of(PackedByteArray_method_store.encode_u64))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u64", 3638975848)
  PackedByteArray_method_store.encode_s64 = cast(type_of(PackedByteArray_method_store.encode_s64))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s64", 3638975848)
  PackedByteArray_method_store.encode_half = cast(type_of(PackedByteArray_method_store.encode_half))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_half", 1113000516)
  PackedByteArray_method_store.encode_float = cast(type_of(PackedByteArray_method_store.encode_float))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_float", 1113000516)
  PackedByteArray_method_store.encode_double = cast(type_of(PackedByteArray_method_store.encode_double))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_double", 1113000516)
  PackedByteArray_method_store.encode_var = cast(type_of(PackedByteArray_method_store.encode_var))Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_var", 2604460497)
  PackedByteArray_method_store.VARIANT_OP_NOT_ = cast(type_of(PackedByteArray_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_BYTE_ARRAY, .NIL)
  PackedByteArray_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(PackedByteArray_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_BYTE_ARRAY, .DICTIONARY)
  PackedByteArray_method_store.VARIANT_OP_IN_Array = cast(type_of(PackedByteArray_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_BYTE_ARRAY, .ARRAY)
  PackedByteArray_method_store.VARIANT_OP_EQUAL_PackedByteArray = cast(type_of(PackedByteArray_method_store.VARIANT_OP_EQUAL_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.VARIANT_OP_NOT_EQUAL_PackedByteArray = cast(type_of(PackedByteArray_method_store.VARIANT_OP_NOT_EQUAL_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.VARIANT_OP_ADD_PackedByteArray = cast(type_of(PackedByteArray_method_store.VARIANT_OP_ADD_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
}
