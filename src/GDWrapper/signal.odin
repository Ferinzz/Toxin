package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

Signal_Methods: struct {
	Create0: GDE.PtrConstructor,
    Destroy: GDE.PtrDestructor,
}

init_Signal_Methods :: proc() {
	Signal_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 0)
	Callable_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 0)
}

/*
{
	"name": "is_null",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "get_object",
	"return_type": "Object",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4008621732
},
{
	"name": "get_object_id",
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
	"hash": 1825232092
},
{
	"name": "connect",
	"return_type": "int",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 979702392,
	"arguments": [
		{
			"name": "callable",
			"type": "Callable"
		},
		{
			"name": "flags",
			"type": "int",
			"default_value": "0"
		}
	]
},
{
	"name": "disconnect",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3470848906,
	"arguments": [
		{
			"name": "callable",
			"type": "Callable"
		}
	]
},
{
	"name": "is_connected",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4129521963,
	"arguments": [
		{
			"name": "callable",
			"type": "Callable"
		}
	]
},
{
	"name": "get_connections",
	"return_type": "Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4144163970
},
{
	"name": "has_connections",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "emit",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 3286317445
}
,
*/


Callable_Methods: struct {
	Create0: GDE.PtrConstructor,
    Destroy: GDE.PtrDestructor,
    is_custom: GDE.PtrBuiltInMethod,
    get_object: GDE.PtrBuiltInMethod,
}


/*
{
	"name": "create",
	"return_type": "Callable",
	"is_vararg": false,
	"is_const": false,
	"is_static": true,
	"hash": 1709381114,
	"arguments": [
		{
			"name": "variant",
			"type": "Variant"
		},
		{
			"name": "method",
			"type": "StringName"
		}
	]
},
{
	"name": "callv",
	"return_type": "Variant",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 413578926,
	"arguments": [
		{
			"name": "arguments",
			"type": "Array"
		}
	]
},
{
	"name": "is_null",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_custom",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_standard",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "is_valid",
	"return_type": "bool",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3918633141
},
{
	"name": "get_object",
	"return_type": "Object",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4008621732
},
{
	"name": "get_object_id",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_method",
	"return_type": "StringName",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 1825232092
},
{
	"name": "get_argument_count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_bound_arguments_count",
	"return_type": "int",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 3173160232
},
{
	"name": "get_bound_arguments",
	"return_type": "Array",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 4144163970
},
{
	"name": "get_unbound_arguments_count",
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
	"name": "bindv",
	"return_type": "Callable",
	"is_vararg": false,
	"is_const": false,
	"is_static": false,
	"hash": 3564560322,
	"arguments": [
		{
			"name": "arguments",
			"type": "Array"
		}
	]
},
{
	"name": "unbind",
	"return_type": "Callable",
	"is_vararg": false,
	"is_const": true,
	"is_static": false,
	"hash": 755001590,
	"arguments": [
		{
			"name": "argcount",
			"type": "int"
		}
	]
},
{
	"name": "call",
	"return_type": "Variant",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 3643564216
},
{
	"name": "call_deferred",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 3286317445
},
{
	"name": "rpc",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 3286317445
},
{
	"name": "rpc_id",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 2270047679,
	"arguments": [
		{
			"name": "peer_id",
			"type": "int"
		}
	]
},
{
	"name": "bind",
	"return_type": "Callable",
	"is_vararg": true,
	"is_const": true,
	"is_static": false,
	"hash": 3224143119
}
,
*/


