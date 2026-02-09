package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


String_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}

init_String_Methods :: proc() {
    NodePath_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 0)
    NodePath_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 1)
    String_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 0)
    String_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING, 1)
    String_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING, .STRING)
    String_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING)
}

NodePath_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Destroy: GDE.PtrDestructor,
}

/*
{
	"name": "is_absolute",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "get_name_count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_name",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2948586938,
	"arguments": [
		{
			"name": "idx",
			"type": "int"
		}
	]
},
{
	"name": "get_subname_count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
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
	"name": "get_subname",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 2948586938,
	"arguments": [
		{
			"name": "idx",
			"type": "int"
		}
	]
},
{
	"name": "get_concatenated_names",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1825232092
},
{
	"name": "get_concatenated_subnames",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1825232092
},
{
	"name": "slice",
	"return_type": "NodePath",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 421628484,
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
	"name": "get_as_property_path",
	"return_type": "NodePath",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1598598043
},
{
	"name": "is_empty",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
}
,
*/
