package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


StringName_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  casecmp_to:  GDE.PtrBuiltInMethod,
  nocasecmp_to:  GDE.PtrBuiltInMethod,
  naturalcasecmp_to:  GDE.PtrBuiltInMethod,
  naturalnocasecmp_to:  GDE.PtrBuiltInMethod,
  filecasecmp_to:  GDE.PtrBuiltInMethod,
  filenocasecmp_to:  GDE.PtrBuiltInMethod,
  length:  GDE.PtrBuiltInMethod,
  substr:  GDE.PtrBuiltInMethod,
  get_slice:  GDE.PtrBuiltInMethod,
  get_slicec:  GDE.PtrBuiltInMethod,
  get_slice_count:  GDE.PtrBuiltInMethod,
  find:  GDE.PtrBuiltInMethod,
  findn:  GDE.PtrBuiltInMethod,
  count:  GDE.PtrBuiltInMethod,
  countn:  GDE.PtrBuiltInMethod,
  rfind:  GDE.PtrBuiltInMethod,
  rfindn:  GDE.PtrBuiltInMethod,
  match:  GDE.PtrBuiltInMethod,
  matchn:  GDE.PtrBuiltInMethod,
  begins_with:  GDE.PtrBuiltInMethod,
  ends_with:  GDE.PtrBuiltInMethod,
  is_subsequence_of:  GDE.PtrBuiltInMethod,
  is_subsequence_ofn:  GDE.PtrBuiltInMethod,
  bigrams:  GDE.PtrBuiltInMethod,
  similarity:  GDE.PtrBuiltInMethod,
  format:  GDE.PtrBuiltInMethod,
  replace:  GDE.PtrBuiltInMethod,
  replacen:  GDE.PtrBuiltInMethod,
  replace_char:  GDE.PtrBuiltInMethod,
  replace_chars:  GDE.PtrBuiltInMethod,
  remove_char:  GDE.PtrBuiltInMethod,
  remove_chars:  GDE.PtrBuiltInMethod,
  repeat:  GDE.PtrBuiltInMethod,
  reverse:  GDE.PtrBuiltInMethod,
  insert:  GDE.PtrBuiltInMethod,
  erase:  GDE.PtrBuiltInMethod,
  capitalize:  GDE.PtrBuiltInMethod,
  to_camel_case:  GDE.PtrBuiltInMethod,
  to_pascal_case:  GDE.PtrBuiltInMethod,
  to_snake_case:  GDE.PtrBuiltInMethod,
  to_kebab_case:  GDE.PtrBuiltInMethod,
  split:  GDE.PtrBuiltInMethod,
  rsplit:  GDE.PtrBuiltInMethod,
  split_floats:  GDE.PtrBuiltInMethod,
  join:  GDE.PtrBuiltInMethod,
  to_upper:  GDE.PtrBuiltInMethod,
  to_lower:  GDE.PtrBuiltInMethod,
  left:  GDE.PtrBuiltInMethod,
  right:  GDE.PtrBuiltInMethod,
  strip_edges:  GDE.PtrBuiltInMethod,
  strip_escapes:  GDE.PtrBuiltInMethod,
  lstrip:  GDE.PtrBuiltInMethod,
  rstrip:  GDE.PtrBuiltInMethod,
  get_extension:  GDE.PtrBuiltInMethod,
  get_basename:  GDE.PtrBuiltInMethod,
  path_join:  GDE.PtrBuiltInMethod,
  unicode_at:  GDE.PtrBuiltInMethod,
  indent:  GDE.PtrBuiltInMethod,
  dedent:  GDE.PtrBuiltInMethod,
  md5_text:  GDE.PtrBuiltInMethod,
  sha1_text:  GDE.PtrBuiltInMethod,
  sha256_text:  GDE.PtrBuiltInMethod,
  md5_buffer:  GDE.PtrBuiltInMethod,
  sha1_buffer:  GDE.PtrBuiltInMethod,
  sha256_buffer:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  contains:  GDE.PtrBuiltInMethod,
  containsn:  GDE.PtrBuiltInMethod,
  is_absolute_path:  GDE.PtrBuiltInMethod,
  is_relative_path:  GDE.PtrBuiltInMethod,
  simplify_path:  GDE.PtrBuiltInMethod,
  get_base_dir:  GDE.PtrBuiltInMethod,
  get_file:  GDE.PtrBuiltInMethod,
  xml_escape:  GDE.PtrBuiltInMethod,
  xml_unescape:  GDE.PtrBuiltInMethod,
  uri_encode:  GDE.PtrBuiltInMethod,
  uri_decode:  GDE.PtrBuiltInMethod,
  uri_file_decode:  GDE.PtrBuiltInMethod,
  c_escape:  GDE.PtrBuiltInMethod,
  c_unescape:  GDE.PtrBuiltInMethod,
  json_escape:  GDE.PtrBuiltInMethod,
  validate_node_name:  GDE.PtrBuiltInMethod,
  validate_filename:  GDE.PtrBuiltInMethod,
  is_valid_ascii_identifier:  GDE.PtrBuiltInMethod,
  is_valid_unicode_identifier:  GDE.PtrBuiltInMethod,
  is_valid_identifier:  GDE.PtrBuiltInMethod,
  is_valid_int:  GDE.PtrBuiltInMethod,
  is_valid_float:  GDE.PtrBuiltInMethod,
  is_valid_hex_number:  GDE.PtrBuiltInMethod,
  is_valid_html_color:  GDE.PtrBuiltInMethod,
  is_valid_ip_address:  GDE.PtrBuiltInMethod,
  is_valid_filename:  GDE.PtrBuiltInMethod,
  to_int:  GDE.PtrBuiltInMethod,
  to_float:  GDE.PtrBuiltInMethod,
  hex_to_int:  GDE.PtrBuiltInMethod,
  bin_to_int:  GDE.PtrBuiltInMethod,
  lpad:  GDE.PtrBuiltInMethod,
  rpad:  GDE.PtrBuiltInMethod,
  pad_decimals:  GDE.PtrBuiltInMethod,
  pad_zeros:  GDE.PtrBuiltInMethod,
  trim_prefix:  GDE.PtrBuiltInMethod,
  trim_suffix:  GDE.PtrBuiltInMethod,
  to_ascii_buffer:  GDE.PtrBuiltInMethod,
  to_utf8_buffer:  GDE.PtrBuiltInMethod,
  to_utf16_buffer:  GDE.PtrBuiltInMethod,
  to_utf32_buffer:  GDE.PtrBuiltInMethod,
  to_wchar_buffer:  GDE.PtrBuiltInMethod,
  to_multibyte_char_buffer:  GDE.PtrBuiltInMethod,
  hex_decode:  GDE.PtrBuiltInMethod,
  hash:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Rect2i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector3: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector3i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector4: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Vector4i: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Plane: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Quaternion: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_AABB: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Basis: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Transform3D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Projection: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Color: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_StringName: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_NodePath: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_RID: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Object: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Callable: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Signal: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedByteArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedInt32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedInt64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedFloat32Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedFloat64Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_PackedStringArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedVector2Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedVector3Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedColorArray: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_PackedVector4Array: GDE.PtrOperatorEvaluator,
}
init_StringName_Methods :: proc(StringName_method_store: ^StringName_Methods_list) {
  StringName_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 0)
  StringName_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 1)
  StringName_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 2)
  StringName_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING_NAME)
  StringName_method_store.VARIANT_OP_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.casecmp_to = Get_Builtin_Method(.STRING_NAME, "casecmp_to", 2920860731)
  StringName_method_store.nocasecmp_to = Get_Builtin_Method(.STRING_NAME, "nocasecmp_to", 2920860731)
  StringName_method_store.naturalcasecmp_to = Get_Builtin_Method(.STRING_NAME, "naturalcasecmp_to", 2920860731)
  StringName_method_store.naturalnocasecmp_to = Get_Builtin_Method(.STRING_NAME, "naturalnocasecmp_to", 2920860731)
  StringName_method_store.filecasecmp_to = Get_Builtin_Method(.STRING_NAME, "filecasecmp_to", 2920860731)
  StringName_method_store.filenocasecmp_to = Get_Builtin_Method(.STRING_NAME, "filenocasecmp_to", 2920860731)
  StringName_method_store.length = Get_Builtin_Method(.STRING_NAME, "length", 3173160232)
  StringName_method_store.substr = Get_Builtin_Method(.STRING_NAME, "substr", 787537301)
  StringName_method_store.get_slice = Get_Builtin_Method(.STRING_NAME, "get_slice", 3535100402)
  StringName_method_store.get_slicec = Get_Builtin_Method(.STRING_NAME, "get_slicec", 787537301)
  StringName_method_store.get_slice_count = Get_Builtin_Method(.STRING_NAME, "get_slice_count", 2920860731)
  StringName_method_store.find = Get_Builtin_Method(.STRING_NAME, "find", 1760645412)
  StringName_method_store.findn = Get_Builtin_Method(.STRING_NAME, "findn", 1760645412)
  StringName_method_store.count = Get_Builtin_Method(.STRING_NAME, "count", 2343087891)
  StringName_method_store.countn = Get_Builtin_Method(.STRING_NAME, "countn", 2343087891)
  StringName_method_store.rfind = Get_Builtin_Method(.STRING_NAME, "rfind", 1760645412)
  StringName_method_store.rfindn = Get_Builtin_Method(.STRING_NAME, "rfindn", 1760645412)
  StringName_method_store.match = Get_Builtin_Method(.STRING_NAME, "match", 2566493496)
  StringName_method_store.matchn = Get_Builtin_Method(.STRING_NAME, "matchn", 2566493496)
  StringName_method_store.begins_with = Get_Builtin_Method(.STRING_NAME, "begins_with", 2566493496)
  StringName_method_store.ends_with = Get_Builtin_Method(.STRING_NAME, "ends_with", 2566493496)
  StringName_method_store.is_subsequence_of = Get_Builtin_Method(.STRING_NAME, "is_subsequence_of", 2566493496)
  StringName_method_store.is_subsequence_ofn = Get_Builtin_Method(.STRING_NAME, "is_subsequence_ofn", 2566493496)
  StringName_method_store.bigrams = Get_Builtin_Method(.STRING_NAME, "bigrams", 747180633)
  StringName_method_store.similarity = Get_Builtin_Method(.STRING_NAME, "similarity", 2697460964)
  StringName_method_store.format = Get_Builtin_Method(.STRING_NAME, "format", 3212199029)
  StringName_method_store.replace = Get_Builtin_Method(.STRING_NAME, "replace", 1340436205)
  StringName_method_store.replacen = Get_Builtin_Method(.STRING_NAME, "replacen", 1340436205)
  StringName_method_store.replace_char = Get_Builtin_Method(.STRING_NAME, "replace_char", 787537301)
  StringName_method_store.replace_chars = Get_Builtin_Method(.STRING_NAME, "replace_chars", 3535100402)
  StringName_method_store.remove_char = Get_Builtin_Method(.STRING_NAME, "remove_char", 2162347432)
  StringName_method_store.remove_chars = Get_Builtin_Method(.STRING_NAME, "remove_chars", 3134094431)
  StringName_method_store.repeat = Get_Builtin_Method(.STRING_NAME, "repeat", 2162347432)
  StringName_method_store.reverse = Get_Builtin_Method(.STRING_NAME, "reverse", 3942272618)
  StringName_method_store.insert = Get_Builtin_Method(.STRING_NAME, "insert", 248737229)
  StringName_method_store.erase = Get_Builtin_Method(.STRING_NAME, "erase", 787537301)
  StringName_method_store.capitalize = Get_Builtin_Method(.STRING_NAME, "capitalize", 3942272618)
  StringName_method_store.to_camel_case = Get_Builtin_Method(.STRING_NAME, "to_camel_case", 3942272618)
  StringName_method_store.to_pascal_case = Get_Builtin_Method(.STRING_NAME, "to_pascal_case", 3942272618)
  StringName_method_store.to_snake_case = Get_Builtin_Method(.STRING_NAME, "to_snake_case", 3942272618)
  StringName_method_store.to_kebab_case = Get_Builtin_Method(.STRING_NAME, "to_kebab_case", 3942272618)
  StringName_method_store.split = Get_Builtin_Method(.STRING_NAME, "split", 1252735785)
  StringName_method_store.rsplit = Get_Builtin_Method(.STRING_NAME, "rsplit", 1252735785)
  StringName_method_store.split_floats = Get_Builtin_Method(.STRING_NAME, "split_floats", 2092079095)
  StringName_method_store.join = Get_Builtin_Method(.STRING_NAME, "join", 3595973238)
  StringName_method_store.to_upper = Get_Builtin_Method(.STRING_NAME, "to_upper", 3942272618)
  StringName_method_store.to_lower = Get_Builtin_Method(.STRING_NAME, "to_lower", 3942272618)
  StringName_method_store.left = Get_Builtin_Method(.STRING_NAME, "left", 2162347432)
  StringName_method_store.right = Get_Builtin_Method(.STRING_NAME, "right", 2162347432)
  StringName_method_store.strip_edges = Get_Builtin_Method(.STRING_NAME, "strip_edges", 907855311)
  StringName_method_store.strip_escapes = Get_Builtin_Method(.STRING_NAME, "strip_escapes", 3942272618)
  StringName_method_store.lstrip = Get_Builtin_Method(.STRING_NAME, "lstrip", 3134094431)
  StringName_method_store.rstrip = Get_Builtin_Method(.STRING_NAME, "rstrip", 3134094431)
  StringName_method_store.get_extension = Get_Builtin_Method(.STRING_NAME, "get_extension", 3942272618)
  StringName_method_store.get_basename = Get_Builtin_Method(.STRING_NAME, "get_basename", 3942272618)
  StringName_method_store.path_join = Get_Builtin_Method(.STRING_NAME, "path_join", 3134094431)
  StringName_method_store.unicode_at = Get_Builtin_Method(.STRING_NAME, "unicode_at", 4103005248)
  StringName_method_store.indent = Get_Builtin_Method(.STRING_NAME, "indent", 3134094431)
  StringName_method_store.dedent = Get_Builtin_Method(.STRING_NAME, "dedent", 3942272618)
  StringName_method_store.md5_text = Get_Builtin_Method(.STRING_NAME, "md5_text", 3942272618)
  StringName_method_store.sha1_text = Get_Builtin_Method(.STRING_NAME, "sha1_text", 3942272618)
  StringName_method_store.sha256_text = Get_Builtin_Method(.STRING_NAME, "sha256_text", 3942272618)
  StringName_method_store.md5_buffer = Get_Builtin_Method(.STRING_NAME, "md5_buffer", 247621236)
  StringName_method_store.sha1_buffer = Get_Builtin_Method(.STRING_NAME, "sha1_buffer", 247621236)
  StringName_method_store.sha256_buffer = Get_Builtin_Method(.STRING_NAME, "sha256_buffer", 247621236)
  StringName_method_store.is_empty = Get_Builtin_Method(.STRING_NAME, "is_empty", 3918633141)
  StringName_method_store.contains = Get_Builtin_Method(.STRING_NAME, "contains", 2566493496)
  StringName_method_store.containsn = Get_Builtin_Method(.STRING_NAME, "containsn", 2566493496)
  StringName_method_store.is_absolute_path = Get_Builtin_Method(.STRING_NAME, "is_absolute_path", 3918633141)
  StringName_method_store.is_relative_path = Get_Builtin_Method(.STRING_NAME, "is_relative_path", 3918633141)
  StringName_method_store.simplify_path = Get_Builtin_Method(.STRING_NAME, "simplify_path", 3942272618)
  StringName_method_store.get_base_dir = Get_Builtin_Method(.STRING_NAME, "get_base_dir", 3942272618)
  StringName_method_store.get_file = Get_Builtin_Method(.STRING_NAME, "get_file", 3942272618)
  StringName_method_store.xml_escape = Get_Builtin_Method(.STRING_NAME, "xml_escape", 3429816538)
  StringName_method_store.xml_unescape = Get_Builtin_Method(.STRING_NAME, "xml_unescape", 3942272618)
  StringName_method_store.uri_encode = Get_Builtin_Method(.STRING_NAME, "uri_encode", 3942272618)
  StringName_method_store.uri_decode = Get_Builtin_Method(.STRING_NAME, "uri_decode", 3942272618)
  StringName_method_store.uri_file_decode = Get_Builtin_Method(.STRING_NAME, "uri_file_decode", 3942272618)
  StringName_method_store.c_escape = Get_Builtin_Method(.STRING_NAME, "c_escape", 3942272618)
  StringName_method_store.c_unescape = Get_Builtin_Method(.STRING_NAME, "c_unescape", 3942272618)
  StringName_method_store.json_escape = Get_Builtin_Method(.STRING_NAME, "json_escape", 3942272618)
  StringName_method_store.validate_node_name = Get_Builtin_Method(.STRING_NAME, "validate_node_name", 3942272618)
  StringName_method_store.validate_filename = Get_Builtin_Method(.STRING_NAME, "validate_filename", 3942272618)
  StringName_method_store.is_valid_ascii_identifier = Get_Builtin_Method(.STRING_NAME, "is_valid_ascii_identifier", 3918633141)
  StringName_method_store.is_valid_unicode_identifier = Get_Builtin_Method(.STRING_NAME, "is_valid_unicode_identifier", 3918633141)
  StringName_method_store.is_valid_identifier = Get_Builtin_Method(.STRING_NAME, "is_valid_identifier", 3918633141)
  StringName_method_store.is_valid_int = Get_Builtin_Method(.STRING_NAME, "is_valid_int", 3918633141)
  StringName_method_store.is_valid_float = Get_Builtin_Method(.STRING_NAME, "is_valid_float", 3918633141)
  StringName_method_store.is_valid_hex_number = Get_Builtin_Method(.STRING_NAME, "is_valid_hex_number", 593672999)
  StringName_method_store.is_valid_html_color = Get_Builtin_Method(.STRING_NAME, "is_valid_html_color", 3918633141)
  StringName_method_store.is_valid_ip_address = Get_Builtin_Method(.STRING_NAME, "is_valid_ip_address", 3918633141)
  StringName_method_store.is_valid_filename = Get_Builtin_Method(.STRING_NAME, "is_valid_filename", 3918633141)
  StringName_method_store.to_int = Get_Builtin_Method(.STRING_NAME, "to_int", 3173160232)
  StringName_method_store.to_float = Get_Builtin_Method(.STRING_NAME, "to_float", 466405837)
  StringName_method_store.hex_to_int = Get_Builtin_Method(.STRING_NAME, "hex_to_int", 3173160232)
  StringName_method_store.bin_to_int = Get_Builtin_Method(.STRING_NAME, "bin_to_int", 3173160232)
  StringName_method_store.lpad = Get_Builtin_Method(.STRING_NAME, "lpad", 248737229)
  StringName_method_store.rpad = Get_Builtin_Method(.STRING_NAME, "rpad", 248737229)
  StringName_method_store.pad_decimals = Get_Builtin_Method(.STRING_NAME, "pad_decimals", 2162347432)
  StringName_method_store.pad_zeros = Get_Builtin_Method(.STRING_NAME, "pad_zeros", 2162347432)
  StringName_method_store.trim_prefix = Get_Builtin_Method(.STRING_NAME, "trim_prefix", 3134094431)
  StringName_method_store.trim_suffix = Get_Builtin_Method(.STRING_NAME, "trim_suffix", 3134094431)
  StringName_method_store.to_ascii_buffer = Get_Builtin_Method(.STRING_NAME, "to_ascii_buffer", 247621236)
  StringName_method_store.to_utf8_buffer = Get_Builtin_Method(.STRING_NAME, "to_utf8_buffer", 247621236)
  StringName_method_store.to_utf16_buffer = Get_Builtin_Method(.STRING_NAME, "to_utf16_buffer", 247621236)
  StringName_method_store.to_utf32_buffer = Get_Builtin_Method(.STRING_NAME, "to_utf32_buffer", 247621236)
  StringName_method_store.to_wchar_buffer = Get_Builtin_Method(.STRING_NAME, "to_wchar_buffer", 247621236)
  StringName_method_store.to_multibyte_char_buffer = Get_Builtin_Method(.STRING_NAME, "to_multibyte_char_buffer", 3055765187)
  StringName_method_store.hex_decode = Get_Builtin_Method(.STRING_NAME, "hex_decode", 247621236)
  StringName_method_store.hash = Get_Builtin_Method(.STRING_NAME, "hash", 3173160232)
  StringName_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .STRING_NAME, .NIL)
  StringName_method_store.VARIANT_OP_MODULE_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .BOOL)
  StringName_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .INT)
  StringName_method_store.VARIANT_OP_MODULE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .FLOAT)
  StringName_method_store.VARIANT_OP_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_NOT_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_ADD_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_MODULE_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_IN_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .STRING)
  StringName_method_store.VARIANT_OP_MODULE_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR2)
  StringName_method_store.VARIANT_OP_MODULE_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR2I)
  StringName_method_store.VARIANT_OP_MODULE_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RECT2)
  StringName_method_store.VARIANT_OP_MODULE_Rect2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RECT2I)
  StringName_method_store.VARIANT_OP_MODULE_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR3)
  StringName_method_store.VARIANT_OP_MODULE_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR3I)
  StringName_method_store.VARIANT_OP_MODULE_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .TRANSFORM2D)
  StringName_method_store.VARIANT_OP_MODULE_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR4)
  StringName_method_store.VARIANT_OP_MODULE_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .VECTOR4I)
  StringName_method_store.VARIANT_OP_MODULE_Plane = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PLANE)
  StringName_method_store.VARIANT_OP_MODULE_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .QUATERNION)
  StringName_method_store.VARIANT_OP_MODULE_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .AABB)
  StringName_method_store.VARIANT_OP_MODULE_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .BASIS)
  StringName_method_store.VARIANT_OP_MODULE_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .TRANSFORM3D)
  StringName_method_store.VARIANT_OP_MODULE_Projection = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PROJECTION)
  StringName_method_store.VARIANT_OP_MODULE_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .COLOR)
  StringName_method_store.VARIANT_OP_NOT_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_LESS_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_LESS_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_GREATER_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_GREATER_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_ADD_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_MODULE_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_IN_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .STRING_NAME)
  StringName_method_store.VARIANT_OP_MODULE_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .NODE_PATH)
  StringName_method_store.VARIANT_OP_MODULE_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .RID)
  StringName_method_store.VARIANT_OP_MODULE_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .OBJECT)
  StringName_method_store.VARIANT_OP_IN_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .OBJECT)
  StringName_method_store.VARIANT_OP_MODULE_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .CALLABLE)
  StringName_method_store.VARIANT_OP_MODULE_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .SIGNAL)
  StringName_method_store.VARIANT_OP_MODULE_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .DICTIONARY)
  StringName_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .DICTIONARY)
  StringName_method_store.VARIANT_OP_MODULE_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .ARRAY)
  StringName_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_BYTE_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_INT32_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_INT64_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_FLOAT32_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_FLOAT64_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_STRING_ARRAY)
  StringName_method_store.VARIANT_OP_IN_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING_NAME, .PACKED_STRING_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR2_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR3_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_COLOR_ARRAY)
  StringName_method_store.VARIANT_OP_MODULE_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING_NAME, .PACKED_VECTOR4_ARRAY)
}
