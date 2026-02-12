package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


String_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
	casecmp_to: GDE.PtrBuiltInMethod,
	nocasecmp_to: GDE.PtrBuiltInMethod,
	naturalcasecmp_to: GDE.PtrBuiltInMethod,
	naturalnocasecmp_to: GDE.PtrBuiltInMethod,
	filecasecmp_to: GDE.PtrBuiltInMethod,
	filenocasecmp_to: GDE.PtrBuiltInMethod,
	length: GDE.PtrBuiltInMethod,
	substr: GDE.PtrBuiltInMethod,
	get_slice: GDE.PtrBuiltInMethod,
	get_slicec: GDE.PtrBuiltInMethod,
	get_slice_count: GDE.PtrBuiltInMethod,
	find: GDE.PtrBuiltInMethod,
	findn: GDE.PtrBuiltInMethod,
	count: GDE.PtrBuiltInMethod,
	countn: GDE.PtrBuiltInMethod,
	rfind: GDE.PtrBuiltInMethod,
	rfindn: GDE.PtrBuiltInMethod,
	match: GDE.PtrBuiltInMethod,
	matchn: GDE.PtrBuiltInMethod,
	begins_with: GDE.PtrBuiltInMethod,
	ends_with: GDE.PtrBuiltInMethod,
	is_subsequence_of: GDE.PtrBuiltInMethod,
	is_subsequence_ofn: GDE.PtrBuiltInMethod,
	bigrams: GDE.PtrBuiltInMethod,
	similarity: GDE.PtrBuiltInMethod,
	format: GDE.PtrBuiltInMethod,
	replace: GDE.PtrBuiltInMethod,
	replacen: GDE.PtrBuiltInMethod,
	replace_char: GDE.PtrBuiltInMethod,
	replace_chars: GDE.PtrBuiltInMethod,
	remove_char: GDE.PtrBuiltInMethod,
	remove_chars: GDE.PtrBuiltInMethod,
	repeat: GDE.PtrBuiltInMethod,
	reverse: GDE.PtrBuiltInMethod,
	insert: GDE.PtrBuiltInMethod,
	erase: GDE.PtrBuiltInMethod,
	capitalize: GDE.PtrBuiltInMethod,
	to_camel_case: GDE.PtrBuiltInMethod,
	to_pascal_case: GDE.PtrBuiltInMethod,
	to_snake_case: GDE.PtrBuiltInMethod,
	to_kebab_case: GDE.PtrBuiltInMethod,
	split: GDE.PtrBuiltInMethod,
	rsplit: GDE.PtrBuiltInMethod,
	split_floats: GDE.PtrBuiltInMethod,
	join: GDE.PtrBuiltInMethod,
	to_upper: GDE.PtrBuiltInMethod,
	to_lower: GDE.PtrBuiltInMethod,
	left: GDE.PtrBuiltInMethod,
	right: GDE.PtrBuiltInMethod,
	strip_edges: GDE.PtrBuiltInMethod,
	strip_escapes: GDE.PtrBuiltInMethod,
	lstrip: GDE.PtrBuiltInMethod,
	rstrip: GDE.PtrBuiltInMethod,
	get_extension: GDE.PtrBuiltInMethod,
	get_basename: GDE.PtrBuiltInMethod,
	path_join: GDE.PtrBuiltInMethod,
	unicode_at: GDE.PtrBuiltInMethod,
	indent: GDE.PtrBuiltInMethod,
	dedent: GDE.PtrBuiltInMethod,
	hash: GDE.PtrBuiltInMethod,
	md5_text: GDE.PtrBuiltInMethod,
	sha1_text: GDE.PtrBuiltInMethod,
	sha256_text: GDE.PtrBuiltInMethod,
	md5_buffer: GDE.PtrBuiltInMethod,
	sha1_buffer: GDE.PtrBuiltInMethod,
	sha256_buffer: GDE.PtrBuiltInMethod,
	is_empty: GDE.PtrBuiltInMethod,
	contains: GDE.PtrBuiltInMethod,
	containsn: GDE.PtrBuiltInMethod,
	is_absolute_path: GDE.PtrBuiltInMethod,
	is_relative_path: GDE.PtrBuiltInMethod,
	simplify_path: GDE.PtrBuiltInMethod,
	get_base_dir: GDE.PtrBuiltInMethod,
	get_file: GDE.PtrBuiltInMethod,
	xml_escape: GDE.PtrBuiltInMethod,
	xml_unescape: GDE.PtrBuiltInMethod,
	uri_encode: GDE.PtrBuiltInMethod,
	uri_decode: GDE.PtrBuiltInMethod,
	uri_file_decode: GDE.PtrBuiltInMethod,
	c_escape: GDE.PtrBuiltInMethod,
	c_unescape: GDE.PtrBuiltInMethod,
	json_escape: GDE.PtrBuiltInMethod,
	validate_node_name: GDE.PtrBuiltInMethod,
	validate_filename: GDE.PtrBuiltInMethod,
	is_valid_ascii_identifier: GDE.PtrBuiltInMethod,
	is_valid_unicode_identifier: GDE.PtrBuiltInMethod,
	is_valid_identifier: GDE.PtrBuiltInMethod,
	is_valid_int: GDE.PtrBuiltInMethod,
	is_valid_float: GDE.PtrBuiltInMethod,
	is_valid_hex_number: GDE.PtrBuiltInMethod,
	is_valid_html_color: GDE.PtrBuiltInMethod,
	is_valid_ip_address: GDE.PtrBuiltInMethod,
	is_valid_filename: GDE.PtrBuiltInMethod,
	to_int: GDE.PtrBuiltInMethod,
	to_float: GDE.PtrBuiltInMethod,
	hex_to_int: GDE.PtrBuiltInMethod,
	bin_to_int: GDE.PtrBuiltInMethod,
	lpad: GDE.PtrBuiltInMethod,
	rpad: GDE.PtrBuiltInMethod,
	pad_decimals: GDE.PtrBuiltInMethod,
	pad_zeros: GDE.PtrBuiltInMethod,
	trim_prefix: GDE.PtrBuiltInMethod,
	trim_suffix: GDE.PtrBuiltInMethod,
	to_ascii_buffer: GDE.PtrBuiltInMethod,
	to_utf8_buffer: GDE.PtrBuiltInMethod,
	to_utf16_buffer: GDE.PtrBuiltInMethod,
	to_utf32_buffer: GDE.PtrBuiltInMethod,
	to_wchar_buffer: GDE.PtrBuiltInMethod,
	to_multibyte_char_buffer: GDE.PtrBuiltInMethod,
	hex_decode: GDE.PtrBuiltInMethod,
	num_scientific: GDE.PtrBuiltInMethod,
	num: GDE.PtrBuiltInMethod,
	num_int64: GDE.PtrBuiltInMethod,
	num_uint64: GDE.PtrBuiltInMethod,
	chr: GDE.PtrBuiltInMethod,
	humanize_size: GDE.PtrBuiltInMethod,
}

init_String_Methods :: proc() {
    NodePath_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 0)
    NodePath_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 1)
    String_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 0)
    String_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 1)
    String_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING, .STRING)
    String_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING)
	String_Methods.casecmp_to = Get_Builtin_Method(.STRING, "casecmp_to", 2920860731)
}

NodePath_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Destroy: GDE.PtrDestructor,
}

/*
"methods": [
	"name": "casecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "nocasecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "naturalcasecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "naturalnocasecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "filecasecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "filenocasecmp_to",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "to",
			"type": "String"
		}
	]
},
{
	"name": "length",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "substr",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 787537301,
	"arguments": [
		{
			"name": "from",
			"type": "int"
		},
		{
			"name": "len",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "get_slice",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3535100402,
	"arguments": [
		{
			"name": "delimiter",
			"type": "String"
		},
		{
			"name": "slice",
			"type": "int"
		}
	]
},
{
	"name": "get_slicec",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 787537301,
	"arguments": [
		{
			"name": "delimiter",
			"type": "int"
		},
		{
			"name": "slice",
			"type": "int"
		}
	]
},
{
	"name": "get_slice_count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2920860731,
	"arguments": [
		{
			"name": "delimiter",
			"type": "String"
		}
	]
},
{
	"name": "find",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1760645412,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "findn",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1760645412,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2343087891,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		},
		{
			"name": "to",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "countn",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2343087891,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "0"
		},
		{
			"name": "to",
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
	"hash": 1760645412,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "rfindn",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1760645412,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "from",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "match",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "expr",
			"type": "String"
		}
	]
},
{
	"name": "matchn",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "expr",
			"type": "String"
		}
	]
},
{
	"name": "begins_with",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "text",
			"type": "String"
		}
	]
},
{
	"name": "ends_with",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "text",
			"type": "String"
		}
	]
},
{
	"name": "is_subsequence_of",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "text",
			"type": "String"
		}
	]
},
{
	"name": "is_subsequence_ofn",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "text",
			"type": "String"
		}
	]
},
{
	"name": "bigrams",
	"return_type": "PackedStringArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 747180633
},
{
	"name": "similarity",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2697460964,
	"arguments": [
		{
			"name": "text",
			"type": "String"
		}
	]
},
{
	"name": "format",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3212199029,
	"arguments": [
		{
			"name": "values",
			"type": "Variant"
		},
		{
			"name": "placeholder",
			"type": "String",
			"default_value": "\"{_}\""
		}
	]
},
{
	"name": "replace",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1340436205,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "forwhat",
			"type": "String"
		}
	]
},
{
	"name": "replacen",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1340436205,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		},
		{
			"name": "forwhat",
			"type": "String"
		}
	]
},
{
	"name": "replace_char",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 787537301,
	"arguments": [
		{
			"name": "key",
			"type": "int"
		},
		{
			"name": "with",
			"type": "int"
		}
	]
},
{
	"name": "replace_chars",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3535100402,
	"arguments": [
		{
			"name": "keys",
			"type": "String"
		},
		{
			"name": "with",
			"type": "int"
		}
	]
},
{
	"name": "remove_char",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "what",
			"type": "int"
		}
	]
},
{
	"name": "remove_chars",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "chars",
			"type": "String"
		}
	]
},
{
	"name": "repeat",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "count",
			"type": "int"
		}
	]
},
{
	"name": "reverse",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "insert",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 248737229,
	"arguments": [
		{
			"name": "position",
			"type": "int"
		},
		{
			"name": "what",
			"type": "String"
		}
	]
},
{
	"name": "erase",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 787537301,
	"arguments": [
		{
			"name": "position",
			"type": "int"
		},
		{
			"name": "chars",
			"type": "int",
			"default_value": "1"
		}
	]
},
{
	"name": "capitalize",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "to_camel_case",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "to_pascal_case",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "to_snake_case",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "to_kebab_case",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "split",
	"return_type": "PackedStringArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1252735785,
	"arguments": [
		{
			"name": "delimiter",
			"type": "String",
			"default_value": "\"\""
		},
		{
			"name": "allow_empty",
			"type": "bool",
			"default_value": "true"
		},
		{
			"name": "maxsplit",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "rsplit",
	"return_type": "PackedStringArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1252735785,
	"arguments": [
		{
			"name": "delimiter",
			"type": "String",
			"default_value": "\"\""
		},
		{
			"name": "allow_empty",
			"type": "bool",
			"default_value": "true"
		},
		{
			"name": "maxsplit",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "split_floats",
	"return_type": "PackedFloat64Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2092079095,
	"arguments": [
		{
			"name": "delimiter",
			"type": "String"
		},
		{
			"name": "allow_empty",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "join",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3595973238,
	"arguments": [
		{
			"name": "parts",
			"type": "PackedStringArray"
		}
	]
},
{
	"name": "to_upper",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "to_lower",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "left",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "length",
			"type": "int"
		}
	]
},
{
	"name": "right",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "length",
			"type": "int"
		}
	]
},
{
	"name": "strip_edges",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 907855311,
	"arguments": [
		{
			"name": "left",
			"type": "bool",
			"default_value": "true"
		},
		{
			"name": "right",
			"type": "bool",
			"default_value": "true"
		}
	]
},
{
	"name": "strip_escapes",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "lstrip",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "chars",
			"type": "String"
		}
	]
},
{
	"name": "rstrip",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "chars",
			"type": "String"
		}
	]
},
{
	"name": "get_extension",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_basename",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "path_join",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "path",
			"type": "String"
		}
	]
},
{
	"name": "unicode_at",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4103005248,
	"arguments": [
		{
			"name": "at",
			"type": "int"
		}
	]
},
{
	"name": "indent",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "prefix",
			"type": "String"
		}
	]
},
{
	"name": "dedent",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
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
	"name": "md5_text",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "sha1_text",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "sha256_text",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "md5_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sha1_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "sha256_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
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
	"name": "contains",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		}
	]
},
{
	"name": "containsn",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2566493496,
	"arguments": [
		{
			"name": "what",
			"type": "String"
		}
	]
},
{
	"name": "is_absolute_path",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_relative_path",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "simplify_path",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_base_dir",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "get_file",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "xml_escape",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3429816538,
	"arguments": [
		{
			"name": "escape_quotes",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "xml_unescape",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "uri_encode",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "uri_decode",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "uri_file_decode",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "c_escape",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "c_unescape",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "json_escape",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "validate_node_name",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "validate_filename",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3942272618
},
{
	"name": "is_valid_ascii_identifier",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_unicode_identifier",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_identifier",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_int",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_float",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_hex_number",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 593672999,
	"arguments": [
		{
			"name": "with_prefix",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "is_valid_html_color",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_ip_address",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid_filename",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "to_int",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "to_float",
	"return_type": "float",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 466405837
},
{
	"name": "hex_to_int",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "bin_to_int",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "lpad",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 248737229,
	"arguments": [
		{
			"name": "min_length",
			"type": "int"
		},
		{
			"name": "character",
			"type": "String",
			"default_value": "\" \""
		}
	]
},
{
	"name": "rpad",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 248737229,
	"arguments": [
		{
			"name": "min_length",
			"type": "int"
		},
		{
			"name": "character",
			"type": "String",
			"default_value": "\" \""
		}
	]
},
{
	"name": "pad_decimals",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "digits",
			"type": "int"
		}
	]
},
{
	"name": "pad_zeros",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2162347432,
	"arguments": [
		{
			"name": "digits",
			"type": "int"
		}
	]
},
{
	"name": "trim_prefix",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "prefix",
			"type": "String"
		}
	]
},
{
	"name": "trim_suffix",
	"return_type": "String",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3134094431,
	"arguments": [
		{
			"name": "suffix",
			"type": "String"
		}
	]
},
{
	"name": "to_ascii_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "to_utf8_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "to_utf16_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "to_utf32_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "to_wchar_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "to_multibyte_char_buffer",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3055765187,
	"arguments": [
		{
			"name": "encoding",
			"type": "String",
			"default_value": "\"\""
		}
	]
},
{
	"name": "hex_decode",
	"return_type": "PackedByteArray",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 247621236
},
{
	"name": "num_scientific",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 2710373411,
	"arguments": [
		{
			"name": "number",
			"type": "float"
		}
	]
},
{
	"name": "num",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 1555901022,
	"arguments": [
		{
			"name": "number",
			"type": "float"
		},
		{
			"name": "decimals",
			"type": "int",
			"default_value": "-1"
		}
	]
},
{
	"name": "num_int64",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 2111271071,
	"arguments": [
		{
			"name": "number",
			"type": "int"
		},
		{
			"name": "base",
			"type": "int",
			"default_value": "10"
		},
		{
			"name": "capitalize_hex",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "num_uint64",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 2111271071,
	"arguments": [
		{
			"name": "number",
			"type": "int"
		},
		{
			"name": "base",
			"type": "int",
			"default_value": "10"
		},
		{
			"name": "capitalize_hex",
			"type": "bool",
			"default_value": "false"
		}
	]
},
{
	"name": "chr",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 897497541,
	"arguments": [
		{
			"name": "code",
			"type": "int"
		}
	]
},
{
	"name": "humanize_size",
	"return_type": "String",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 897497541,
	"arguments": [
		{
			"name": "size",
			"type": "int"
		}
	]
}
,
*/