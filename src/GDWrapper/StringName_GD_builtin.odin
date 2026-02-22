package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


StringName_Methods_list :: struct {
    Create0: proc "c" (p_base: ^StringName, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^StringName,  #by_ptr p_args: struct{ from: ^StringName, }),
    Create2: proc "c" (p_base: ^StringName,  #by_ptr p_args: struct{ from: ^gdstring, }),
    Destroy: GDE.PtrDestructor,
    casecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    nocasecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    naturalcasecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    naturalnocasecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    filecasecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    filenocasecmp_to:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ to: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    length:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    substr:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ from: ^Int, len: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    get_slice:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^gdstring, slice: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    get_slicec:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^Int, slice: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    get_slice_count:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^gdstring, }, r_return: ^Int, p_argument_count: i64 = 1),
    find:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    findn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, to: ^Int, }, r_return: ^Int, p_argument_count: i64 = 3),
    countn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, to: ^Int, }, r_return: ^Int, p_argument_count: i64 = 3),
    rfind:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfindn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    match:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ expr: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    matchn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ expr: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    begins_with:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ text: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    ends_with:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ text: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_subsequence_of:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ text: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_subsequence_ofn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ text: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    bigrams:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedStringArray, p_argument_count: i64 = 0),
    similarity:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ text: ^gdstring, }, r_return: ^float, p_argument_count: i64 = 1),
    format:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ values: ^Variant, placeholder: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    replace:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, forwhat: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    replacen:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, forwhat: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    replace_char:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ key: ^Int, with: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    replace_chars:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ keys: ^gdstring, with: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    remove_char:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    remove_chars:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ chars: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    repeat:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ count: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    reverse:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    insert:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ position: ^Int, what: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    erase:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ position: ^Int, chars: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    capitalize:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    to_camel_case:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    to_pascal_case:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    to_snake_case:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    to_kebab_case:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    split:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^gdstring, allow_empty: ^Bool, maxsplit: ^Int, }, r_return: ^PackedStringArray, p_argument_count: i64 = 3),
    rsplit:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^gdstring, allow_empty: ^Bool, maxsplit: ^Int, }, r_return: ^PackedStringArray, p_argument_count: i64 = 3),
    split_floats:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ delimiter: ^gdstring, allow_empty: ^Bool, }, r_return: ^PackedFloat64Array, p_argument_count: i64 = 2),
    join:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ parts: ^PackedStringArray, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    to_upper:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    to_lower:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    left:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ length: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    right:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ length: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    strip_edges:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ left: ^Bool, right: ^Bool, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    strip_escapes:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    lstrip:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ chars: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    rstrip:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ chars: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    get_extension:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_basename:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    path_join:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ path: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    unicode_at:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ at: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    indent:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ prefix: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    dedent:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    md5_text:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    sha1_text:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    sha256_text:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    md5_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sha1_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    sha256_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    contains:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    containsn:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ what: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_absolute_path:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_relative_path:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    simplify_path:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_base_dir:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    get_file:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    xml_escape:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ escape_quotes: ^Bool, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    xml_unescape:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    uri_encode:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    uri_decode:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    uri_file_decode:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    c_escape:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    c_unescape:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    json_escape:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    validate_node_name:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    validate_filename:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^gdstring, p_argument_count: i64 = 0),
    is_valid_ascii_identifier:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_unicode_identifier:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_identifier:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_int:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_float:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_hex_number:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ with_prefix: ^Bool, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_valid_html_color:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_ip_address:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_valid_filename:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    to_int:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_float:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    hex_to_int:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    bin_to_int:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    lpad:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ min_length: ^Int, character: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    rpad:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ min_length: ^Int, character: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 2),
    pad_decimals:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ digits: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    pad_zeros:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ digits: ^Int, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    trim_prefix:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ prefix: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    trim_suffix:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ suffix: ^gdstring, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    to_ascii_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    to_utf8_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    to_utf16_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    to_utf32_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    to_wchar_buffer:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    to_multibyte_char_buffer:  proc "c" (p_base: ^StringName, #by_ptr p_args: struct{ encoding: ^gdstring, }, r_return: ^PackedByteArray, p_argument_count: i64 = 1),
    hex_decode:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^PackedByteArray, p_argument_count: i64 = 0),
    hash:  proc "c" (p_base: ^StringName, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^StringName, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MODULE_Bool: proc "c" (p_left: ^StringName, p_right: ^Bool, r_result: ^gdstring),
    VARIANT_OP_MODULE_Int: proc "c" (p_left: ^StringName, p_right: ^Int, r_result: ^gdstring),
    VARIANT_OP_MODULE_float: proc "c" (p_left: ^StringName, p_right: ^float, r_result: ^gdstring),
    VARIANT_OP_EQUAL_gdstring: proc "c" (p_left: ^StringName, p_right: ^gdstring, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_gdstring: proc "c" (p_left: ^StringName, p_right: ^gdstring, r_result: ^Bool),
    VARIANT_OP_ADD_gdstring: proc "c" (p_left: ^StringName, p_right: ^gdstring, r_result: ^gdstring),
    VARIANT_OP_MODULE_gdstring: proc "c" (p_left: ^StringName, p_right: ^gdstring, r_result: ^gdstring),
    VARIANT_OP_IN_gdstring: proc "c" (p_left: ^StringName, p_right: ^gdstring, r_result: ^Bool),
    VARIANT_OP_MODULE_Vector2: proc "c" (p_left: ^StringName, p_right: ^Vector2, r_result: ^gdstring),
    VARIANT_OP_MODULE_Vector2i: proc "c" (p_left: ^StringName, p_right: ^Vector2i, r_result: ^gdstring),
    VARIANT_OP_MODULE_Rect2: proc "c" (p_left: ^StringName, p_right: ^Rect2, r_result: ^gdstring),
    VARIANT_OP_MODULE_Rect2i: proc "c" (p_left: ^StringName, p_right: ^Rect2i, r_result: ^gdstring),
    VARIANT_OP_MODULE_Vector3: proc "c" (p_left: ^StringName, p_right: ^Vector3, r_result: ^gdstring),
    VARIANT_OP_MODULE_Vector3i: proc "c" (p_left: ^StringName, p_right: ^Vector3i, r_result: ^gdstring),
    VARIANT_OP_MODULE_Transform2D: proc "c" (p_left: ^StringName, p_right: ^Transform2D, r_result: ^gdstring),
    VARIANT_OP_MODULE_Vector4: proc "c" (p_left: ^StringName, p_right: ^Vector4, r_result: ^gdstring),
    VARIANT_OP_MODULE_Vector4i: proc "c" (p_left: ^StringName, p_right: ^Vector4i, r_result: ^gdstring),
    VARIANT_OP_MODULE_Plane: proc "c" (p_left: ^StringName, p_right: ^Plane, r_result: ^gdstring),
    VARIANT_OP_MODULE_Quaternion: proc "c" (p_left: ^StringName, p_right: ^Quaternion, r_result: ^gdstring),
    VARIANT_OP_MODULE_AABB: proc "c" (p_left: ^StringName, p_right: ^AABB, r_result: ^gdstring),
    VARIANT_OP_MODULE_Basis: proc "c" (p_left: ^StringName, p_right: ^Basis, r_result: ^gdstring),
    VARIANT_OP_MODULE_Transform3D: proc "c" (p_left: ^StringName, p_right: ^Transform3D, r_result: ^gdstring),
    VARIANT_OP_MODULE_Projection: proc "c" (p_left: ^StringName, p_right: ^Projection, r_result: ^gdstring),
    VARIANT_OP_MODULE_Color: proc "c" (p_left: ^StringName, p_right: ^Color, r_result: ^gdstring),
    VARIANT_OP_EQUAL_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_LESS_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_GREATER_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_ADD_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^gdstring),
    VARIANT_OP_MODULE_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^gdstring),
    VARIANT_OP_IN_StringName: proc "c" (p_left: ^StringName, p_right: ^StringName, r_result: ^Bool),
    VARIANT_OP_MODULE_NodePath: proc "c" (p_left: ^StringName, p_right: ^NodePath, r_result: ^gdstring),
    VARIANT_OP_MODULE_RID: proc "c" (p_left: ^StringName, p_right: ^RID, r_result: ^gdstring),
    VARIANT_OP_MODULE_Object: proc "c" (p_left: ^StringName, p_right: ^Object, r_result: ^gdstring),
    VARIANT_OP_IN_Object: proc "c" (p_left: ^StringName, p_right: ^Object, r_result: ^Bool),
    VARIANT_OP_MODULE_Callable: proc "c" (p_left: ^StringName, p_right: ^Callable, r_result: ^gdstring),
    VARIANT_OP_MODULE_Signal: proc "c" (p_left: ^StringName, p_right: ^Signal, r_result: ^gdstring),
    VARIANT_OP_MODULE_Dictionary: proc "c" (p_left: ^StringName, p_right: ^Dictionary, r_result: ^gdstring),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^StringName, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_MODULE_Array: proc "c" (p_left: ^StringName, p_right: ^Array, r_result: ^gdstring),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^StringName, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_MODULE_PackedByteArray: proc "c" (p_left: ^StringName, p_right: ^PackedByteArray, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedInt32Array: proc "c" (p_left: ^StringName, p_right: ^PackedInt32Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedInt64Array: proc "c" (p_left: ^StringName, p_right: ^PackedInt64Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedFloat32Array: proc "c" (p_left: ^StringName, p_right: ^PackedFloat32Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedFloat64Array: proc "c" (p_left: ^StringName, p_right: ^PackedFloat64Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedStringArray: proc "c" (p_left: ^StringName, p_right: ^PackedStringArray, r_result: ^gdstring),
    VARIANT_OP_IN_PackedStringArray: proc "c" (p_left: ^StringName, p_right: ^PackedStringArray, r_result: ^Bool),
    VARIANT_OP_MODULE_PackedVector2Array: proc "c" (p_left: ^StringName, p_right: ^PackedVector2Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedVector3Array: proc "c" (p_left: ^StringName, p_right: ^PackedVector3Array, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedColorArray: proc "c" (p_left: ^StringName, p_right: ^PackedColorArray, r_result: ^gdstring),
    VARIANT_OP_MODULE_PackedVector4Array: proc "c" (p_left: ^StringName, p_right: ^PackedVector4Array, r_result: ^gdstring),
}
init_StringName_Methods :: proc(StringName_method_store: ^StringName_Methods_list) {
  StringName_method_store.Create0 = cast(type_of(StringName_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 0)
  StringName_method_store.Create1 = cast(type_of(StringName_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 1)
  StringName_method_store.Create2 = cast(type_of(StringName_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 2)
  StringName_method_store.Destroy = cast(type_of(StringName_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.STRING_NAME)
  StringName_method_store.casecmp_to = cast(type_of(StringName_method_store.casecmp_to))Get_Builtin_Method(.STRING_NAME, "casecmp_to", 2920860731)
  StringName_method_store.nocasecmp_to = cast(type_of(StringName_method_store.nocasecmp_to))Get_Builtin_Method(.STRING_NAME, "nocasecmp_to", 2920860731)
  StringName_method_store.naturalcasecmp_to = cast(type_of(StringName_method_store.naturalcasecmp_to))Get_Builtin_Method(.STRING_NAME, "naturalcasecmp_to", 2920860731)
  StringName_method_store.naturalnocasecmp_to = cast(type_of(StringName_method_store.naturalnocasecmp_to))Get_Builtin_Method(.STRING_NAME, "naturalnocasecmp_to", 2920860731)
  StringName_method_store.filecasecmp_to = cast(type_of(StringName_method_store.filecasecmp_to))Get_Builtin_Method(.STRING_NAME, "filecasecmp_to", 2920860731)
  StringName_method_store.filenocasecmp_to = cast(type_of(StringName_method_store.filenocasecmp_to))Get_Builtin_Method(.STRING_NAME, "filenocasecmp_to", 2920860731)
  StringName_method_store.length = cast(type_of(StringName_method_store.length))Get_Builtin_Method(.STRING_NAME, "length", 3173160232)
  StringName_method_store.substr = cast(type_of(StringName_method_store.substr))Get_Builtin_Method(.STRING_NAME, "substr", 787537301)
  StringName_method_store.get_slice = cast(type_of(StringName_method_store.get_slice))Get_Builtin_Method(.STRING_NAME, "get_slice", 3535100402)
  StringName_method_store.get_slicec = cast(type_of(StringName_method_store.get_slicec))Get_Builtin_Method(.STRING_NAME, "get_slicec", 787537301)
  StringName_method_store.get_slice_count = cast(type_of(StringName_method_store.get_slice_count))Get_Builtin_Method(.STRING_NAME, "get_slice_count", 2920860731)
  StringName_method_store.find = cast(type_of(StringName_method_store.find))Get_Builtin_Method(.STRING_NAME, "find", 1760645412)
  StringName_method_store.findn = cast(type_of(StringName_method_store.findn))Get_Builtin_Method(.STRING_NAME, "findn", 1760645412)
  StringName_method_store.count = cast(type_of(StringName_method_store.count))Get_Builtin_Method(.STRING_NAME, "count", 2343087891)
  StringName_method_store.countn = cast(type_of(StringName_method_store.countn))Get_Builtin_Method(.STRING_NAME, "countn", 2343087891)
  StringName_method_store.rfind = cast(type_of(StringName_method_store.rfind))Get_Builtin_Method(.STRING_NAME, "rfind", 1760645412)
  StringName_method_store.rfindn = cast(type_of(StringName_method_store.rfindn))Get_Builtin_Method(.STRING_NAME, "rfindn", 1760645412)
  StringName_method_store.match = cast(type_of(StringName_method_store.match))Get_Builtin_Method(.STRING_NAME, "match", 2566493496)
  StringName_method_store.matchn = cast(type_of(StringName_method_store.matchn))Get_Builtin_Method(.STRING_NAME, "matchn", 2566493496)
  StringName_method_store.begins_with = cast(type_of(StringName_method_store.begins_with))Get_Builtin_Method(.STRING_NAME, "begins_with", 2566493496)
  StringName_method_store.ends_with = cast(type_of(StringName_method_store.ends_with))Get_Builtin_Method(.STRING_NAME, "ends_with", 2566493496)
  StringName_method_store.is_subsequence_of = cast(type_of(StringName_method_store.is_subsequence_of))Get_Builtin_Method(.STRING_NAME, "is_subsequence_of", 2566493496)
  StringName_method_store.is_subsequence_ofn = cast(type_of(StringName_method_store.is_subsequence_ofn))Get_Builtin_Method(.STRING_NAME, "is_subsequence_ofn", 2566493496)
  StringName_method_store.bigrams = cast(type_of(StringName_method_store.bigrams))Get_Builtin_Method(.STRING_NAME, "bigrams", 747180633)
  StringName_method_store.similarity = cast(type_of(StringName_method_store.similarity))Get_Builtin_Method(.STRING_NAME, "similarity", 2697460964)
  StringName_method_store.format = cast(type_of(StringName_method_store.format))Get_Builtin_Method(.STRING_NAME, "format", 3212199029)
  StringName_method_store.replace = cast(type_of(StringName_method_store.replace))Get_Builtin_Method(.STRING_NAME, "replace", 1340436205)
  StringName_method_store.replacen = cast(type_of(StringName_method_store.replacen))Get_Builtin_Method(.STRING_NAME, "replacen", 1340436205)
  StringName_method_store.replace_char = cast(type_of(StringName_method_store.replace_char))Get_Builtin_Method(.STRING_NAME, "replace_char", 787537301)
  StringName_method_store.replace_chars = cast(type_of(StringName_method_store.replace_chars))Get_Builtin_Method(.STRING_NAME, "replace_chars", 3535100402)
  StringName_method_store.remove_char = cast(type_of(StringName_method_store.remove_char))Get_Builtin_Method(.STRING_NAME, "remove_char", 2162347432)
  StringName_method_store.remove_chars = cast(type_of(StringName_method_store.remove_chars))Get_Builtin_Method(.STRING_NAME, "remove_chars", 3134094431)
  StringName_method_store.repeat = cast(type_of(StringName_method_store.repeat))Get_Builtin_Method(.STRING_NAME, "repeat", 2162347432)
  StringName_method_store.reverse = cast(type_of(StringName_method_store.reverse))Get_Builtin_Method(.STRING_NAME, "reverse", 3942272618)
  StringName_method_store.insert = cast(type_of(StringName_method_store.insert))Get_Builtin_Method(.STRING_NAME, "insert", 248737229)
  StringName_method_store.erase = cast(type_of(StringName_method_store.erase))Get_Builtin_Method(.STRING_NAME, "erase", 787537301)
  StringName_method_store.capitalize = cast(type_of(StringName_method_store.capitalize))Get_Builtin_Method(.STRING_NAME, "capitalize", 3942272618)
  StringName_method_store.to_camel_case = cast(type_of(StringName_method_store.to_camel_case))Get_Builtin_Method(.STRING_NAME, "to_camel_case", 3942272618)
  StringName_method_store.to_pascal_case = cast(type_of(StringName_method_store.to_pascal_case))Get_Builtin_Method(.STRING_NAME, "to_pascal_case", 3942272618)
  StringName_method_store.to_snake_case = cast(type_of(StringName_method_store.to_snake_case))Get_Builtin_Method(.STRING_NAME, "to_snake_case", 3942272618)
  StringName_method_store.to_kebab_case = cast(type_of(StringName_method_store.to_kebab_case))Get_Builtin_Method(.STRING_NAME, "to_kebab_case", 3942272618)
  StringName_method_store.split = cast(type_of(StringName_method_store.split))Get_Builtin_Method(.STRING_NAME, "split", 1252735785)
  StringName_method_store.rsplit = cast(type_of(StringName_method_store.rsplit))Get_Builtin_Method(.STRING_NAME, "rsplit", 1252735785)
  StringName_method_store.split_floats = cast(type_of(StringName_method_store.split_floats))Get_Builtin_Method(.STRING_NAME, "split_floats", 2092079095)
  StringName_method_store.join = cast(type_of(StringName_method_store.join))Get_Builtin_Method(.STRING_NAME, "join", 3595973238)
  StringName_method_store.to_upper = cast(type_of(StringName_method_store.to_upper))Get_Builtin_Method(.STRING_NAME, "to_upper", 3942272618)
  StringName_method_store.to_lower = cast(type_of(StringName_method_store.to_lower))Get_Builtin_Method(.STRING_NAME, "to_lower", 3942272618)
  StringName_method_store.left = cast(type_of(StringName_method_store.left))Get_Builtin_Method(.STRING_NAME, "left", 2162347432)
  StringName_method_store.right = cast(type_of(StringName_method_store.right))Get_Builtin_Method(.STRING_NAME, "right", 2162347432)
  StringName_method_store.strip_edges = cast(type_of(StringName_method_store.strip_edges))Get_Builtin_Method(.STRING_NAME, "strip_edges", 907855311)
  StringName_method_store.strip_escapes = cast(type_of(StringName_method_store.strip_escapes))Get_Builtin_Method(.STRING_NAME, "strip_escapes", 3942272618)
  StringName_method_store.lstrip = cast(type_of(StringName_method_store.lstrip))Get_Builtin_Method(.STRING_NAME, "lstrip", 3134094431)
  StringName_method_store.rstrip = cast(type_of(StringName_method_store.rstrip))Get_Builtin_Method(.STRING_NAME, "rstrip", 3134094431)
  StringName_method_store.get_extension = cast(type_of(StringName_method_store.get_extension))Get_Builtin_Method(.STRING_NAME, "get_extension", 3942272618)
  StringName_method_store.get_basename = cast(type_of(StringName_method_store.get_basename))Get_Builtin_Method(.STRING_NAME, "get_basename", 3942272618)
  StringName_method_store.path_join = cast(type_of(StringName_method_store.path_join))Get_Builtin_Method(.STRING_NAME, "path_join", 3134094431)
  StringName_method_store.unicode_at = cast(type_of(StringName_method_store.unicode_at))Get_Builtin_Method(.STRING_NAME, "unicode_at", 4103005248)
  StringName_method_store.indent = cast(type_of(StringName_method_store.indent))Get_Builtin_Method(.STRING_NAME, "indent", 3134094431)
  StringName_method_store.dedent = cast(type_of(StringName_method_store.dedent))Get_Builtin_Method(.STRING_NAME, "dedent", 3942272618)
  StringName_method_store.md5_text = cast(type_of(StringName_method_store.md5_text))Get_Builtin_Method(.STRING_NAME, "md5_text", 3942272618)
  StringName_method_store.sha1_text = cast(type_of(StringName_method_store.sha1_text))Get_Builtin_Method(.STRING_NAME, "sha1_text", 3942272618)
  StringName_method_store.sha256_text = cast(type_of(StringName_method_store.sha256_text))Get_Builtin_Method(.STRING_NAME, "sha256_text", 3942272618)
  StringName_method_store.md5_buffer = cast(type_of(StringName_method_store.md5_buffer))Get_Builtin_Method(.STRING_NAME, "md5_buffer", 247621236)
  StringName_method_store.sha1_buffer = cast(type_of(StringName_method_store.sha1_buffer))Get_Builtin_Method(.STRING_NAME, "sha1_buffer", 247621236)
  StringName_method_store.sha256_buffer = cast(type_of(StringName_method_store.sha256_buffer))Get_Builtin_Method(.STRING_NAME, "sha256_buffer", 247621236)
  StringName_method_store.is_empty = cast(type_of(StringName_method_store.is_empty))Get_Builtin_Method(.STRING_NAME, "is_empty", 3918633141)
  StringName_method_store.contains = cast(type_of(StringName_method_store.contains))Get_Builtin_Method(.STRING_NAME, "contains", 2566493496)
  StringName_method_store.containsn = cast(type_of(StringName_method_store.containsn))Get_Builtin_Method(.STRING_NAME, "containsn", 2566493496)
  StringName_method_store.is_absolute_path = cast(type_of(StringName_method_store.is_absolute_path))Get_Builtin_Method(.STRING_NAME, "is_absolute_path", 3918633141)
  StringName_method_store.is_relative_path = cast(type_of(StringName_method_store.is_relative_path))Get_Builtin_Method(.STRING_NAME, "is_relative_path", 3918633141)
  StringName_method_store.simplify_path = cast(type_of(StringName_method_store.simplify_path))Get_Builtin_Method(.STRING_NAME, "simplify_path", 3942272618)
  StringName_method_store.get_base_dir = cast(type_of(StringName_method_store.get_base_dir))Get_Builtin_Method(.STRING_NAME, "get_base_dir", 3942272618)
  StringName_method_store.get_file = cast(type_of(StringName_method_store.get_file))Get_Builtin_Method(.STRING_NAME, "get_file", 3942272618)
  StringName_method_store.xml_escape = cast(type_of(StringName_method_store.xml_escape))Get_Builtin_Method(.STRING_NAME, "xml_escape", 3429816538)
  StringName_method_store.xml_unescape = cast(type_of(StringName_method_store.xml_unescape))Get_Builtin_Method(.STRING_NAME, "xml_unescape", 3942272618)
  StringName_method_store.uri_encode = cast(type_of(StringName_method_store.uri_encode))Get_Builtin_Method(.STRING_NAME, "uri_encode", 3942272618)
  StringName_method_store.uri_decode = cast(type_of(StringName_method_store.uri_decode))Get_Builtin_Method(.STRING_NAME, "uri_decode", 3942272618)
  StringName_method_store.uri_file_decode = cast(type_of(StringName_method_store.uri_file_decode))Get_Builtin_Method(.STRING_NAME, "uri_file_decode", 3942272618)
  StringName_method_store.c_escape = cast(type_of(StringName_method_store.c_escape))Get_Builtin_Method(.STRING_NAME, "c_escape", 3942272618)
  StringName_method_store.c_unescape = cast(type_of(StringName_method_store.c_unescape))Get_Builtin_Method(.STRING_NAME, "c_unescape", 3942272618)
  StringName_method_store.json_escape = cast(type_of(StringName_method_store.json_escape))Get_Builtin_Method(.STRING_NAME, "json_escape", 3942272618)
  StringName_method_store.validate_node_name = cast(type_of(StringName_method_store.validate_node_name))Get_Builtin_Method(.STRING_NAME, "validate_node_name", 3942272618)
  StringName_method_store.validate_filename = cast(type_of(StringName_method_store.validate_filename))Get_Builtin_Method(.STRING_NAME, "validate_filename", 3942272618)
  StringName_method_store.is_valid_ascii_identifier = cast(type_of(StringName_method_store.is_valid_ascii_identifier))Get_Builtin_Method(.STRING_NAME, "is_valid_ascii_identifier", 3918633141)
  StringName_method_store.is_valid_unicode_identifier = cast(type_of(StringName_method_store.is_valid_unicode_identifier))Get_Builtin_Method(.STRING_NAME, "is_valid_unicode_identifier", 3918633141)
  StringName_method_store.is_valid_identifier = cast(type_of(StringName_method_store.is_valid_identifier))Get_Builtin_Method(.STRING_NAME, "is_valid_identifier", 3918633141)
  StringName_method_store.is_valid_int = cast(type_of(StringName_method_store.is_valid_int))Get_Builtin_Method(.STRING_NAME, "is_valid_int", 3918633141)
  StringName_method_store.is_valid_float = cast(type_of(StringName_method_store.is_valid_float))Get_Builtin_Method(.STRING_NAME, "is_valid_float", 3918633141)
  StringName_method_store.is_valid_hex_number = cast(type_of(StringName_method_store.is_valid_hex_number))Get_Builtin_Method(.STRING_NAME, "is_valid_hex_number", 593672999)
  StringName_method_store.is_valid_html_color = cast(type_of(StringName_method_store.is_valid_html_color))Get_Builtin_Method(.STRING_NAME, "is_valid_html_color", 3918633141)
  StringName_method_store.is_valid_ip_address = cast(type_of(StringName_method_store.is_valid_ip_address))Get_Builtin_Method(.STRING_NAME, "is_valid_ip_address", 3918633141)
  StringName_method_store.is_valid_filename = cast(type_of(StringName_method_store.is_valid_filename))Get_Builtin_Method(.STRING_NAME, "is_valid_filename", 3918633141)
  StringName_method_store.to_int = cast(type_of(StringName_method_store.to_int))Get_Builtin_Method(.STRING_NAME, "to_int", 3173160232)
  StringName_method_store.to_float = cast(type_of(StringName_method_store.to_float))Get_Builtin_Method(.STRING_NAME, "to_float", 466405837)
  StringName_method_store.hex_to_int = cast(type_of(StringName_method_store.hex_to_int))Get_Builtin_Method(.STRING_NAME, "hex_to_int", 3173160232)
  StringName_method_store.bin_to_int = cast(type_of(StringName_method_store.bin_to_int))Get_Builtin_Method(.STRING_NAME, "bin_to_int", 3173160232)
  StringName_method_store.lpad = cast(type_of(StringName_method_store.lpad))Get_Builtin_Method(.STRING_NAME, "lpad", 248737229)
  StringName_method_store.rpad = cast(type_of(StringName_method_store.rpad))Get_Builtin_Method(.STRING_NAME, "rpad", 248737229)
  StringName_method_store.pad_decimals = cast(type_of(StringName_method_store.pad_decimals))Get_Builtin_Method(.STRING_NAME, "pad_decimals", 2162347432)
  StringName_method_store.pad_zeros = cast(type_of(StringName_method_store.pad_zeros))Get_Builtin_Method(.STRING_NAME, "pad_zeros", 2162347432)
  StringName_method_store.trim_prefix = cast(type_of(StringName_method_store.trim_prefix))Get_Builtin_Method(.STRING_NAME, "trim_prefix", 3134094431)
  StringName_method_store.trim_suffix = cast(type_of(StringName_method_store.trim_suffix))Get_Builtin_Method(.STRING_NAME, "trim_suffix", 3134094431)
  StringName_method_store.to_ascii_buffer = cast(type_of(StringName_method_store.to_ascii_buffer))Get_Builtin_Method(.STRING_NAME, "to_ascii_buffer", 247621236)
  StringName_method_store.to_utf8_buffer = cast(type_of(StringName_method_store.to_utf8_buffer))Get_Builtin_Method(.STRING_NAME, "to_utf8_buffer", 247621236)
  StringName_method_store.to_utf16_buffer = cast(type_of(StringName_method_store.to_utf16_buffer))Get_Builtin_Method(.STRING_NAME, "to_utf16_buffer", 247621236)
  StringName_method_store.to_utf32_buffer = cast(type_of(StringName_method_store.to_utf32_buffer))Get_Builtin_Method(.STRING_NAME, "to_utf32_buffer", 247621236)
  StringName_method_store.to_wchar_buffer = cast(type_of(StringName_method_store.to_wchar_buffer))Get_Builtin_Method(.STRING_NAME, "to_wchar_buffer", 247621236)
  StringName_method_store.to_multibyte_char_buffer = cast(type_of(StringName_method_store.to_multibyte_char_buffer))Get_Builtin_Method(.STRING_NAME, "to_multibyte_char_buffer", 3055765187)
  StringName_method_store.hex_decode = cast(type_of(StringName_method_store.hex_decode))Get_Builtin_Method(.STRING_NAME, "hex_decode", 247621236)
  StringName_method_store.hash = cast(type_of(StringName_method_store.hash))Get_Builtin_Method(.STRING_NAME, "hash", 3173160232)
  StringName_method_store.VARIANT_OP_NOT_ = cast(type_of(StringName_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .STRING_NAME, .NIL)
  StringName_method_store.VARIANT_OP_MODULE_Bool = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Bool))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .BOOL)
  StringName_method_store.VARIANT_OP_MODULE_Int = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .INT)
  StringName_method_store.VARIANT_OP_MODULE_float = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .FLOAT)
  StringName_method_store.VARIANT_OP_EQUAL_gdstring = cast(type_of(StringName_method_store.VARIANT_OP_EQUAL_gdstring))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_NOT_EQUAL_gdstring = cast(type_of(StringName_method_store.VARIANT_OP_NOT_EQUAL_gdstring))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_ADD_gdstring = cast(type_of(StringName_method_store.VARIANT_OP_ADD_gdstring))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_MODULE_gdstring = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_gdstring))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_IN_gdstring = cast(type_of(StringName_method_store.VARIANT_OP_IN_gdstring))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_MODULE_Vector2 = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR2)
  StringName_method_store.VARIANT_OP_MODULE_Vector2i = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR2I)
  StringName_method_store.VARIANT_OP_MODULE_Rect2 = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Rect2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RECT2)
  StringName_method_store.VARIANT_OP_MODULE_Rect2i = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Rect2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RECT2I)
  StringName_method_store.VARIANT_OP_MODULE_Vector3 = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector3))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR3)
  StringName_method_store.VARIANT_OP_MODULE_Vector3i = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR3I)
  StringName_method_store.VARIANT_OP_MODULE_Transform2D = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .TRANSFORM2D)
  StringName_method_store.VARIANT_OP_MODULE_Vector4 = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector4))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR4)
  StringName_method_store.VARIANT_OP_MODULE_Vector4i = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR4I)
  StringName_method_store.VARIANT_OP_MODULE_Plane = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Plane))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PLANE)
  StringName_method_store.VARIANT_OP_MODULE_Quaternion = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Quaternion))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .QUATERNION)
  StringName_method_store.VARIANT_OP_MODULE_AABB = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_AABB))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .AABB)
  StringName_method_store.VARIANT_OP_MODULE_Basis = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Basis))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .BASIS)
  StringName_method_store.VARIANT_OP_MODULE_Transform3D = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Transform3D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .TRANSFORM3D)
  StringName_method_store.VARIANT_OP_MODULE_Projection = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Projection))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PROJECTION)
  StringName_method_store.VARIANT_OP_MODULE_Color = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .COLOR)
  StringName_method_store.VARIANT_OP_EQUAL_StringName = cast(type_of(StringName_method_store.VARIANT_OP_EQUAL_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_NOT_EQUAL_StringName = cast(type_of(StringName_method_store.VARIANT_OP_NOT_EQUAL_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_LESS_StringName = cast(type_of(StringName_method_store.VARIANT_OP_LESS_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_LESS_EQUAL_StringName = cast(type_of(StringName_method_store.VARIANT_OP_LESS_EQUAL_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_GREATER_StringName = cast(type_of(StringName_method_store.VARIANT_OP_GREATER_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_GREATER_EQUAL_StringName = cast(type_of(StringName_method_store.VARIANT_OP_GREATER_EQUAL_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_ADD_StringName = cast(type_of(StringName_method_store.VARIANT_OP_ADD_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_MODULE_StringName = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_IN_StringName = cast(type_of(StringName_method_store.VARIANT_OP_IN_StringName))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_MODULE_NodePath = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_NodePath))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .NODE_PATH)
  StringName_method_store.VARIANT_OP_MODULE_RID = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_RID))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RID)
  StringName_method_store.VARIANT_OP_MODULE_Object = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .OBJECT)
  StringName_method_store.VARIANT_OP_IN_Object = cast(type_of(StringName_method_store.VARIANT_OP_IN_Object))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .OBJECT)
  StringName_method_store.VARIANT_OP_MODULE_Callable = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Callable))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .CALLABLE)
  StringName_method_store.VARIANT_OP_MODULE_Signal = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Signal))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .SIGNAL)
  StringName_method_store.VARIANT_OP_MODULE_Dictionary = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .DICTIONARY)
  StringName_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(StringName_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .DICTIONARY)
  StringName_method_store.VARIANT_OP_MODULE_Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .ARRAY)
  StringName_method_store.VARIANT_OP_IN_Array = cast(type_of(StringName_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedByteArray = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedByteArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_BYTE_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedInt32Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedInt32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_INT32_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedInt64Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedInt64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_INT64_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedFloat32Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedFloat32Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_FLOAT32_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedFloat64Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedFloat64Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_FLOAT64_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedStringArray = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedStringArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_STRING_ARRAY)
  StringName_method_store.VARIANT_OP_IN_PackedStringArray = cast(type_of(StringName_method_store.VARIANT_OP_IN_PackedStringArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .PACKED_STRING_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector2Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedVector2Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR2_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector3Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedVector3Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR3_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedColorArray = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedColorArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_COLOR_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector4Array = cast(type_of(StringName_method_store.VARIANT_OP_MODULE_PackedVector4Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR4_ARRAY)
}
