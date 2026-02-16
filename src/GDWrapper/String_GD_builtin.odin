package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


String_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
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
  hash:  GDE.PtrBuiltInMethod,
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
  num_scientific:  GDE.PtrBuiltInMethod,
  num:  GDE.PtrBuiltInMethod,
  num_int64:  GDE.PtrBuiltInMethod,
  num_uint64:  GDE.PtrBuiltInMethod,
  chr:  GDE.PtrBuiltInMethod,
  humanize_size:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_bool: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_int: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MODULE_float: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_String: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_String: GDE.PtrOperatorEvaluator,
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
init_String_Methods :: proc(String_method_store: ^String_Methods_list) {
  String_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 0)
  String_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 1)
  String_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 2)
  String_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 3)
  String_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING)
  String_method_store.casecmp_to = Get_Builtin_Method(.STRING, "casecmp_to", 2920860731)
  String_method_store.nocasecmp_to = Get_Builtin_Method(.STRING, "nocasecmp_to", 2920860731)
  String_method_store.naturalcasecmp_to = Get_Builtin_Method(.STRING, "naturalcasecmp_to", 2920860731)
  String_method_store.naturalnocasecmp_to = Get_Builtin_Method(.STRING, "naturalnocasecmp_to", 2920860731)
  String_method_store.filecasecmp_to = Get_Builtin_Method(.STRING, "filecasecmp_to", 2920860731)
  String_method_store.filenocasecmp_to = Get_Builtin_Method(.STRING, "filenocasecmp_to", 2920860731)
  String_method_store.length = Get_Builtin_Method(.STRING, "length", 3173160232)
  String_method_store.substr = Get_Builtin_Method(.STRING, "substr", 787537301)
  String_method_store.get_slice = Get_Builtin_Method(.STRING, "get_slice", 3535100402)
  String_method_store.get_slicec = Get_Builtin_Method(.STRING, "get_slicec", 787537301)
  String_method_store.get_slice_count = Get_Builtin_Method(.STRING, "get_slice_count", 2920860731)
  String_method_store.find = Get_Builtin_Method(.STRING, "find", 1760645412)
  String_method_store.findn = Get_Builtin_Method(.STRING, "findn", 1760645412)
  String_method_store.count = Get_Builtin_Method(.STRING, "count", 2343087891)
  String_method_store.countn = Get_Builtin_Method(.STRING, "countn", 2343087891)
  String_method_store.rfind = Get_Builtin_Method(.STRING, "rfind", 1760645412)
  String_method_store.rfindn = Get_Builtin_Method(.STRING, "rfindn", 1760645412)
  String_method_store.match = Get_Builtin_Method(.STRING, "match", 2566493496)
  String_method_store.matchn = Get_Builtin_Method(.STRING, "matchn", 2566493496)
  String_method_store.begins_with = Get_Builtin_Method(.STRING, "begins_with", 2566493496)
  String_method_store.ends_with = Get_Builtin_Method(.STRING, "ends_with", 2566493496)
  String_method_store.is_subsequence_of = Get_Builtin_Method(.STRING, "is_subsequence_of", 2566493496)
  String_method_store.is_subsequence_ofn = Get_Builtin_Method(.STRING, "is_subsequence_ofn", 2566493496)
  String_method_store.bigrams = Get_Builtin_Method(.STRING, "bigrams", 747180633)
  String_method_store.similarity = Get_Builtin_Method(.STRING, "similarity", 2697460964)
  String_method_store.format = Get_Builtin_Method(.STRING, "format", 3212199029)
  String_method_store.replace = Get_Builtin_Method(.STRING, "replace", 1340436205)
  String_method_store.replacen = Get_Builtin_Method(.STRING, "replacen", 1340436205)
  String_method_store.replace_char = Get_Builtin_Method(.STRING, "replace_char", 787537301)
  String_method_store.replace_chars = Get_Builtin_Method(.STRING, "replace_chars", 3535100402)
  String_method_store.remove_char = Get_Builtin_Method(.STRING, "remove_char", 2162347432)
  String_method_store.remove_chars = Get_Builtin_Method(.STRING, "remove_chars", 3134094431)
  String_method_store.repeat = Get_Builtin_Method(.STRING, "repeat", 2162347432)
  String_method_store.reverse = Get_Builtin_Method(.STRING, "reverse", 3942272618)
  String_method_store.insert = Get_Builtin_Method(.STRING, "insert", 248737229)
  String_method_store.erase = Get_Builtin_Method(.STRING, "erase", 787537301)
  String_method_store.capitalize = Get_Builtin_Method(.STRING, "capitalize", 3942272618)
  String_method_store.to_camel_case = Get_Builtin_Method(.STRING, "to_camel_case", 3942272618)
  String_method_store.to_pascal_case = Get_Builtin_Method(.STRING, "to_pascal_case", 3942272618)
  String_method_store.to_snake_case = Get_Builtin_Method(.STRING, "to_snake_case", 3942272618)
  String_method_store.to_kebab_case = Get_Builtin_Method(.STRING, "to_kebab_case", 3942272618)
  String_method_store.split = Get_Builtin_Method(.STRING, "split", 1252735785)
  String_method_store.rsplit = Get_Builtin_Method(.STRING, "rsplit", 1252735785)
  String_method_store.split_floats = Get_Builtin_Method(.STRING, "split_floats", 2092079095)
  String_method_store.join = Get_Builtin_Method(.STRING, "join", 3595973238)
  String_method_store.to_upper = Get_Builtin_Method(.STRING, "to_upper", 3942272618)
  String_method_store.to_lower = Get_Builtin_Method(.STRING, "to_lower", 3942272618)
  String_method_store.left = Get_Builtin_Method(.STRING, "left", 2162347432)
  String_method_store.right = Get_Builtin_Method(.STRING, "right", 2162347432)
  String_method_store.strip_edges = Get_Builtin_Method(.STRING, "strip_edges", 907855311)
  String_method_store.strip_escapes = Get_Builtin_Method(.STRING, "strip_escapes", 3942272618)
  String_method_store.lstrip = Get_Builtin_Method(.STRING, "lstrip", 3134094431)
  String_method_store.rstrip = Get_Builtin_Method(.STRING, "rstrip", 3134094431)
  String_method_store.get_extension = Get_Builtin_Method(.STRING, "get_extension", 3942272618)
  String_method_store.get_basename = Get_Builtin_Method(.STRING, "get_basename", 3942272618)
  String_method_store.path_join = Get_Builtin_Method(.STRING, "path_join", 3134094431)
  String_method_store.unicode_at = Get_Builtin_Method(.STRING, "unicode_at", 4103005248)
  String_method_store.indent = Get_Builtin_Method(.STRING, "indent", 3134094431)
  String_method_store.dedent = Get_Builtin_Method(.STRING, "dedent", 3942272618)
  String_method_store.hash = Get_Builtin_Method(.STRING, "hash", 3173160232)
  String_method_store.md5_text = Get_Builtin_Method(.STRING, "md5_text", 3942272618)
  String_method_store.sha1_text = Get_Builtin_Method(.STRING, "sha1_text", 3942272618)
  String_method_store.sha256_text = Get_Builtin_Method(.STRING, "sha256_text", 3942272618)
  String_method_store.md5_buffer = Get_Builtin_Method(.STRING, "md5_buffer", 247621236)
  String_method_store.sha1_buffer = Get_Builtin_Method(.STRING, "sha1_buffer", 247621236)
  String_method_store.sha256_buffer = Get_Builtin_Method(.STRING, "sha256_buffer", 247621236)
  String_method_store.is_empty = Get_Builtin_Method(.STRING, "is_empty", 3918633141)
  String_method_store.contains = Get_Builtin_Method(.STRING, "contains", 2566493496)
  String_method_store.containsn = Get_Builtin_Method(.STRING, "containsn", 2566493496)
  String_method_store.is_absolute_path = Get_Builtin_Method(.STRING, "is_absolute_path", 3918633141)
  String_method_store.is_relative_path = Get_Builtin_Method(.STRING, "is_relative_path", 3918633141)
  String_method_store.simplify_path = Get_Builtin_Method(.STRING, "simplify_path", 3942272618)
  String_method_store.get_base_dir = Get_Builtin_Method(.STRING, "get_base_dir", 3942272618)
  String_method_store.get_file = Get_Builtin_Method(.STRING, "get_file", 3942272618)
  String_method_store.xml_escape = Get_Builtin_Method(.STRING, "xml_escape", 3429816538)
  String_method_store.xml_unescape = Get_Builtin_Method(.STRING, "xml_unescape", 3942272618)
  String_method_store.uri_encode = Get_Builtin_Method(.STRING, "uri_encode", 3942272618)
  String_method_store.uri_decode = Get_Builtin_Method(.STRING, "uri_decode", 3942272618)
  String_method_store.uri_file_decode = Get_Builtin_Method(.STRING, "uri_file_decode", 3942272618)
  String_method_store.c_escape = Get_Builtin_Method(.STRING, "c_escape", 3942272618)
  String_method_store.c_unescape = Get_Builtin_Method(.STRING, "c_unescape", 3942272618)
  String_method_store.json_escape = Get_Builtin_Method(.STRING, "json_escape", 3942272618)
  String_method_store.validate_node_name = Get_Builtin_Method(.STRING, "validate_node_name", 3942272618)
  String_method_store.validate_filename = Get_Builtin_Method(.STRING, "validate_filename", 3942272618)
  String_method_store.is_valid_ascii_identifier = Get_Builtin_Method(.STRING, "is_valid_ascii_identifier", 3918633141)
  String_method_store.is_valid_unicode_identifier = Get_Builtin_Method(.STRING, "is_valid_unicode_identifier", 3918633141)
  String_method_store.is_valid_identifier = Get_Builtin_Method(.STRING, "is_valid_identifier", 3918633141)
  String_method_store.is_valid_int = Get_Builtin_Method(.STRING, "is_valid_int", 3918633141)
  String_method_store.is_valid_float = Get_Builtin_Method(.STRING, "is_valid_float", 3918633141)
  String_method_store.is_valid_hex_number = Get_Builtin_Method(.STRING, "is_valid_hex_number", 593672999)
  String_method_store.is_valid_html_color = Get_Builtin_Method(.STRING, "is_valid_html_color", 3918633141)
  String_method_store.is_valid_ip_address = Get_Builtin_Method(.STRING, "is_valid_ip_address", 3918633141)
  String_method_store.is_valid_filename = Get_Builtin_Method(.STRING, "is_valid_filename", 3918633141)
  String_method_store.to_int = Get_Builtin_Method(.STRING, "to_int", 3173160232)
  String_method_store.to_float = Get_Builtin_Method(.STRING, "to_float", 466405837)
  String_method_store.hex_to_int = Get_Builtin_Method(.STRING, "hex_to_int", 3173160232)
  String_method_store.bin_to_int = Get_Builtin_Method(.STRING, "bin_to_int", 3173160232)
  String_method_store.lpad = Get_Builtin_Method(.STRING, "lpad", 248737229)
  String_method_store.rpad = Get_Builtin_Method(.STRING, "rpad", 248737229)
  String_method_store.pad_decimals = Get_Builtin_Method(.STRING, "pad_decimals", 2162347432)
  String_method_store.pad_zeros = Get_Builtin_Method(.STRING, "pad_zeros", 2162347432)
  String_method_store.trim_prefix = Get_Builtin_Method(.STRING, "trim_prefix", 3134094431)
  String_method_store.trim_suffix = Get_Builtin_Method(.STRING, "trim_suffix", 3134094431)
  String_method_store.to_ascii_buffer = Get_Builtin_Method(.STRING, "to_ascii_buffer", 247621236)
  String_method_store.to_utf8_buffer = Get_Builtin_Method(.STRING, "to_utf8_buffer", 247621236)
  String_method_store.to_utf16_buffer = Get_Builtin_Method(.STRING, "to_utf16_buffer", 247621236)
  String_method_store.to_utf32_buffer = Get_Builtin_Method(.STRING, "to_utf32_buffer", 247621236)
  String_method_store.to_wchar_buffer = Get_Builtin_Method(.STRING, "to_wchar_buffer", 247621236)
  String_method_store.to_multibyte_char_buffer = Get_Builtin_Method(.STRING, "to_multibyte_char_buffer", 3055765187)
  String_method_store.hex_decode = Get_Builtin_Method(.STRING, "hex_decode", 247621236)
  String_method_store.num_scientific = Get_Builtin_Method(.STRING, "num_scientific", 2710373411)
  String_method_store.num = Get_Builtin_Method(.STRING, "num", 1555901022)
  String_method_store.num_int64 = Get_Builtin_Method(.STRING, "num_int64", 2111271071)
  String_method_store.num_uint64 = Get_Builtin_Method(.STRING, "num_uint64", 2111271071)
  String_method_store.chr = Get_Builtin_Method(.STRING, "chr", 897497541)
  String_method_store.humanize_size = Get_Builtin_Method(.STRING, "humanize_size", 897497541)
  String_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .STRING, .NIL)
  String_method_store.VARIANT_OP_MODULE_bool = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .BOOL)
  String_method_store.VARIANT_OP_MODULE_int = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .INT)
  String_method_store.VARIANT_OP_MODULE_float = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .FLOAT)
  String_method_store.VARIANT_OP_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING, .STRING)
  String_method_store.VARIANT_OP_NOT_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING, .STRING)
  String_method_store.VARIANT_OP_LESS_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .STRING, .STRING)
  String_method_store.VARIANT_OP_LESS_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .STRING, .STRING)
  String_method_store.VARIANT_OP_GREATER_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .STRING, .STRING)
  String_method_store.VARIANT_OP_GREATER_EQUAL_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .STRING, .STRING)
  String_method_store.VARIANT_OP_ADD_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING, .STRING)
  String_method_store.VARIANT_OP_MODULE_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .STRING)
  String_method_store.VARIANT_OP_IN_String = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .STRING)
  String_method_store.VARIANT_OP_MODULE_Vector2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR2)
  String_method_store.VARIANT_OP_MODULE_Vector2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR2I)
  String_method_store.VARIANT_OP_MODULE_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .RECT2)
  String_method_store.VARIANT_OP_MODULE_Rect2i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .RECT2I)
  String_method_store.VARIANT_OP_MODULE_Vector3 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR3)
  String_method_store.VARIANT_OP_MODULE_Vector3i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR3I)
  String_method_store.VARIANT_OP_MODULE_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .TRANSFORM2D)
  String_method_store.VARIANT_OP_MODULE_Vector4 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR4)
  String_method_store.VARIANT_OP_MODULE_Vector4i = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .VECTOR4I)
  String_method_store.VARIANT_OP_MODULE_Plane = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PLANE)
  String_method_store.VARIANT_OP_MODULE_Quaternion = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .QUATERNION)
  String_method_store.VARIANT_OP_MODULE_AABB = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .AABB)
  String_method_store.VARIANT_OP_MODULE_Basis = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .BASIS)
  String_method_store.VARIANT_OP_MODULE_Transform3D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .TRANSFORM3D)
  String_method_store.VARIANT_OP_MODULE_Projection = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PROJECTION)
  String_method_store.VARIANT_OP_MODULE_Color = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .COLOR)
  String_method_store.VARIANT_OP_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING, .STRING_NAME)
  String_method_store.VARIANT_OP_NOT_EQUAL_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .STRING, .STRING_NAME)
  String_method_store.VARIANT_OP_ADD_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .STRING, .STRING_NAME)
  String_method_store.VARIANT_OP_MODULE_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .STRING_NAME)
  String_method_store.VARIANT_OP_IN_StringName = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .STRING_NAME)
  String_method_store.VARIANT_OP_MODULE_NodePath = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .NODE_PATH)
  String_method_store.VARIANT_OP_MODULE_RID = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .RID)
  String_method_store.VARIANT_OP_MODULE_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .OBJECT)
  String_method_store.VARIANT_OP_IN_Object = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .OBJECT)
  String_method_store.VARIANT_OP_MODULE_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .CALLABLE)
  String_method_store.VARIANT_OP_MODULE_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .SIGNAL)
  String_method_store.VARIANT_OP_MODULE_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .DICTIONARY)
  String_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .DICTIONARY)
  String_method_store.VARIANT_OP_MODULE_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .ARRAY)
  String_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedByteArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_BYTE_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedInt32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_INT32_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedInt64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_INT64_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedFloat32Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_FLOAT32_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedFloat64Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_FLOAT64_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_STRING_ARRAY)
  String_method_store.VARIANT_OP_IN_PackedStringArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .STRING, .PACKED_STRING_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedVector2Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_VECTOR2_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedVector3Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_VECTOR3_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedColorArray = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_COLOR_ARRAY)
  String_method_store.VARIANT_OP_MODULE_PackedVector4Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .STRING, .PACKED_VECTOR4_ARRAY)
}
