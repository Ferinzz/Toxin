package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


PackedByteArray_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  get:  GDE.PtrBuiltInMethod,
  set:  GDE.PtrBuiltInMethod,
  size:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  push_back:  GDE.PtrBuiltInMethod,
  append:  GDE.PtrBuiltInMethod,
  append_array:  GDE.PtrBuiltInMethod,
  remove_at:  GDE.PtrBuiltInMethod,
  insert:  GDE.PtrBuiltInMethod,
  fill:  GDE.PtrBuiltInMethod,
  resize:  GDE.PtrBuiltInMethod,
  clear:  GDE.PtrBuiltInMethod,
  has:  GDE.PtrBuiltInMethod,
  reverse:  GDE.PtrBuiltInMethod,
  slice:  GDE.PtrBuiltInMethod,
  sort:  GDE.PtrBuiltInMethod,
  bsearch:  GDE.PtrBuiltInMethod,
  duplicate:  GDE.PtrBuiltInMethod,
  find:  GDE.PtrBuiltInMethod,
  rfind:  GDE.PtrBuiltInMethod,
  count:  GDE.PtrBuiltInMethod,
  erase:  GDE.PtrBuiltInMethod,
  get_string_from_ascii:  GDE.PtrBuiltInMethod,
  get_string_from_utf8:  GDE.PtrBuiltInMethod,
  get_string_from_utf16:  GDE.PtrBuiltInMethod,
  get_string_from_utf32:  GDE.PtrBuiltInMethod,
  get_string_from_wchar:  GDE.PtrBuiltInMethod,
  get_string_from_multibyte_char:  GDE.PtrBuiltInMethod,
  hex_encode:  GDE.PtrBuiltInMethod,
  compress:  GDE.PtrBuiltInMethod,
  decompress:  GDE.PtrBuiltInMethod,
  decompress_dynamic:  GDE.PtrBuiltInMethod,
  decode_u8:  GDE.PtrBuiltInMethod,
  decode_s8:  GDE.PtrBuiltInMethod,
  decode_u16:  GDE.PtrBuiltInMethod,
  decode_s16:  GDE.PtrBuiltInMethod,
  decode_u32:  GDE.PtrBuiltInMethod,
  decode_s32:  GDE.PtrBuiltInMethod,
  decode_u64:  GDE.PtrBuiltInMethod,
  decode_s64:  GDE.PtrBuiltInMethod,
  decode_half:  GDE.PtrBuiltInMethod,
  decode_float:  GDE.PtrBuiltInMethod,
  decode_double:  GDE.PtrBuiltInMethod,
  has_encoded_var:  GDE.PtrBuiltInMethod,
  decode_var:  GDE.PtrBuiltInMethod,
  decode_var_size:  GDE.PtrBuiltInMethod,
  to_int32_array:  GDE.PtrBuiltInMethod,
  to_int64_array:  GDE.PtrBuiltInMethod,
  to_float32_array:  GDE.PtrBuiltInMethod,
  to_float64_array:  GDE.PtrBuiltInMethod,
  to_vector2_array:  GDE.PtrBuiltInMethod,
  to_vector3_array:  GDE.PtrBuiltInMethod,
  to_vector4_array:  GDE.PtrBuiltInMethod,
  to_color_array:  GDE.PtrBuiltInMethod,
  bswap16:  GDE.PtrBuiltInMethod,
  bswap32:  GDE.PtrBuiltInMethod,
  bswap64:  GDE.PtrBuiltInMethod,
  encode_u8:  GDE.PtrBuiltInMethod,
  encode_s8:  GDE.PtrBuiltInMethod,
  encode_u16:  GDE.PtrBuiltInMethod,
  encode_s16:  GDE.PtrBuiltInMethod,
  encode_u32:  GDE.PtrBuiltInMethod,
  encode_s32:  GDE.PtrBuiltInMethod,
  encode_u64:  GDE.PtrBuiltInMethod,
  encode_s64:  GDE.PtrBuiltInMethod,
  encode_half:  GDE.PtrBuiltInMethod,
  encode_float:  GDE.PtrBuiltInMethod,
  encode_double:  GDE.PtrBuiltInMethod,
  encode_var:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_PackedByteArray: GDE.PtrOperatorEvaluator,
}
init_PackedByteArray_Methods :: proc(PackedByteArray_method_store: ^PackedByteArray_Methods_list) {
  PackedByteArray_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 0)
  PackedByteArray_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 1)
  PackedByteArray_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.PACKED_BYTE_ARRAY, 2)
  PackedByteArray_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.get = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get", 4103005248)
  PackedByteArray_method_store.set = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "set", 3638975848)
  PackedByteArray_method_store.size = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "size", 3173160232)
  PackedByteArray_method_store.is_empty = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "is_empty", 3918633141)
  PackedByteArray_method_store.push_back = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "push_back", 694024632)
  PackedByteArray_method_store.append = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "append", 694024632)
  PackedByteArray_method_store.append_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "append_array", 791097111)
  PackedByteArray_method_store.remove_at = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "remove_at", 2823966027)
  PackedByteArray_method_store.insert = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "insert", 1487112728)
  PackedByteArray_method_store.fill = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "fill", 2823966027)
  PackedByteArray_method_store.resize = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "resize", 848867239)
  PackedByteArray_method_store.clear = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "clear", 3218959716)
  PackedByteArray_method_store.has = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "has", 931488181)
  PackedByteArray_method_store.reverse = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "reverse", 3218959716)
  PackedByteArray_method_store.slice = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "slice", 2278869132)
  PackedByteArray_method_store.sort = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "sort", 3218959716)
  PackedByteArray_method_store.bsearch = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bsearch", 954237325)
  PackedByteArray_method_store.duplicate = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "duplicate", 247621236)
  PackedByteArray_method_store.find = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "find", 2984303840)
  PackedByteArray_method_store.rfind = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "rfind", 2984303840)
  PackedByteArray_method_store.count = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "count", 4103005248)
  PackedByteArray_method_store.erase = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "erase", 694024632)
  PackedByteArray_method_store.get_string_from_ascii = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_ascii", 3942272618)
  PackedByteArray_method_store.get_string_from_utf8 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf8", 3942272618)
  PackedByteArray_method_store.get_string_from_utf16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf16", 3942272618)
  PackedByteArray_method_store.get_string_from_utf32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_utf32", 3942272618)
  PackedByteArray_method_store.get_string_from_wchar = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_wchar", 3942272618)
  PackedByteArray_method_store.get_string_from_multibyte_char = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "get_string_from_multibyte_char", 3134094431)
  PackedByteArray_method_store.hex_encode = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "hex_encode", 3942272618)
  PackedByteArray_method_store.compress = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "compress", 1845905913)
  PackedByteArray_method_store.decompress = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decompress", 2278869132)
  PackedByteArray_method_store.decompress_dynamic = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decompress_dynamic", 2278869132)
  PackedByteArray_method_store.decode_u8 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u8", 4103005248)
  PackedByteArray_method_store.decode_s8 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s8", 4103005248)
  PackedByteArray_method_store.decode_u16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u16", 4103005248)
  PackedByteArray_method_store.decode_s16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s16", 4103005248)
  PackedByteArray_method_store.decode_u32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u32", 4103005248)
  PackedByteArray_method_store.decode_s32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s32", 4103005248)
  PackedByteArray_method_store.decode_u64 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_u64", 4103005248)
  PackedByteArray_method_store.decode_s64 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_s64", 4103005248)
  PackedByteArray_method_store.decode_half = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_half", 1401583798)
  PackedByteArray_method_store.decode_float = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_float", 1401583798)
  PackedByteArray_method_store.decode_double = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_double", 1401583798)
  PackedByteArray_method_store.has_encoded_var = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "has_encoded_var", 2914632957)
  PackedByteArray_method_store.decode_var = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_var", 1740420038)
  PackedByteArray_method_store.decode_var_size = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "decode_var_size", 954237325)
  PackedByteArray_method_store.to_int32_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_int32_array", 3158844420)
  PackedByteArray_method_store.to_int64_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_int64_array", 1961294120)
  PackedByteArray_method_store.to_float32_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_float32_array", 3575107827)
  PackedByteArray_method_store.to_float64_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_float64_array", 1627308337)
  PackedByteArray_method_store.to_vector2_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector2_array", 1660374357)
  PackedByteArray_method_store.to_vector3_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector3_array", 4171207452)
  PackedByteArray_method_store.to_vector4_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_vector4_array", 146203628)
  PackedByteArray_method_store.to_color_array = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "to_color_array", 3072026941)
  PackedByteArray_method_store.bswap16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap16", 3638975848)
  PackedByteArray_method_store.bswap32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap32", 3638975848)
  PackedByteArray_method_store.bswap64 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "bswap64", 3638975848)
  PackedByteArray_method_store.encode_u8 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u8", 3638975848)
  PackedByteArray_method_store.encode_s8 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s8", 3638975848)
  PackedByteArray_method_store.encode_u16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u16", 3638975848)
  PackedByteArray_method_store.encode_s16 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s16", 3638975848)
  PackedByteArray_method_store.encode_u32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u32", 3638975848)
  PackedByteArray_method_store.encode_s32 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s32", 3638975848)
  PackedByteArray_method_store.encode_u64 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_u64", 3638975848)
  PackedByteArray_method_store.encode_s64 = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_s64", 3638975848)
  PackedByteArray_method_store.encode_half = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_half", 1113000516)
  PackedByteArray_method_store.encode_float = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_float", 1113000516)
  PackedByteArray_method_store.encode_double = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_double", 1113000516)
  PackedByteArray_method_store.encode_var = Get_Builtin_Method(.PACKED_BYTE_ARRAY, "encode_var", 2604460497)
  PackedByteArray_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .PACKED_BYTE_ARRAY, .NIL)
  PackedByteArray_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_BYTE_ARRAY, .DICTIONARY)
  PackedByteArray_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .PACKED_BYTE_ARRAY, .ARRAY)
  PackedByteArray_method_store.VARIANT_OP_EQUAL_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.VARIANT_OP_NOT_EQUAL_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
  PackedByteArray_method_store.VARIANT_OP_ADD_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .PACKED_BYTE_ARRAY, .PACKED_BYTE_ARRAY)
}
