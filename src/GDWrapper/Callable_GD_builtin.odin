package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Callable_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  create:  GDE.PtrBuiltInMethod,
  callv:  GDE.PtrBuiltInMethod,
  is_null:  GDE.PtrBuiltInMethod,
  is_custom:  GDE.PtrBuiltInMethod,
  is_standard:  GDE.PtrBuiltInMethod,
  is_valid:  GDE.PtrBuiltInMethod,
  get_object:  GDE.PtrBuiltInMethod,
  get_object_id:  GDE.PtrBuiltInMethod,
  get_method:  GDE.PtrBuiltInMethod,
  get_argument_count:  GDE.PtrBuiltInMethod,
  get_bound_arguments_count:  GDE.PtrBuiltInMethod,
  get_bound_arguments:  GDE.PtrBuiltInMethod,
  get_unbound_arguments_count:  GDE.PtrBuiltInMethod,
  hash:  GDE.PtrBuiltInMethod,
  bindv:  GDE.PtrBuiltInMethod,
  unbind:  GDE.PtrBuiltInMethod,
  call:  GDE.PtrBuiltInMethod,
  call_deferred:  GDE.PtrBuiltInMethod,
  rpc:  GDE.PtrBuiltInMethod,
  rpc_id:  GDE.PtrBuiltInMethod,
  bind:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Callable: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Callable: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Callable_Methods :: proc(Callable_method_store: ^Callable_Methods_list) {
  Callable_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 0)
  Callable_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 1)
  Callable_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.CALLABLE, 2)
  Callable_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.CALLABLE)
  Callable_method_store.create = Get_Builtin_Method(.CALLABLE, "create", 1709381114)
  Callable_method_store.callv = Get_Builtin_Method(.CALLABLE, "callv", 413578926)
  Callable_method_store.is_null = Get_Builtin_Method(.CALLABLE, "is_null", 3918633141)
  Callable_method_store.is_custom = Get_Builtin_Method(.CALLABLE, "is_custom", 3918633141)
  Callable_method_store.is_standard = Get_Builtin_Method(.CALLABLE, "is_standard", 3918633141)
  Callable_method_store.is_valid = Get_Builtin_Method(.CALLABLE, "is_valid", 3918633141)
  Callable_method_store.get_object = Get_Builtin_Method(.CALLABLE, "get_object", 4008621732)
  Callable_method_store.get_object_id = Get_Builtin_Method(.CALLABLE, "get_object_id", 3173160232)
  Callable_method_store.get_method = Get_Builtin_Method(.CALLABLE, "get_method", 1825232092)
  Callable_method_store.get_argument_count = Get_Builtin_Method(.CALLABLE, "get_argument_count", 3173160232)
  Callable_method_store.get_bound_arguments_count = Get_Builtin_Method(.CALLABLE, "get_bound_arguments_count", 3173160232)
  Callable_method_store.get_bound_arguments = Get_Builtin_Method(.CALLABLE, "get_bound_arguments", 4144163970)
  Callable_method_store.get_unbound_arguments_count = Get_Builtin_Method(.CALLABLE, "get_unbound_arguments_count", 3173160232)
  Callable_method_store.hash = Get_Builtin_Method(.CALLABLE, "hash", 3173160232)
  Callable_method_store.bindv = Get_Builtin_Method(.CALLABLE, "bindv", 3564560322)
  Callable_method_store.unbind = Get_Builtin_Method(.CALLABLE, "unbind", 755001590)
  Callable_method_store.call = Get_Builtin_Method(.CALLABLE, "call", 3643564216)
  Callable_method_store.call_deferred = Get_Builtin_Method(.CALLABLE, "call_deferred", 3286317445)
  Callable_method_store.rpc = Get_Builtin_Method(.CALLABLE, "rpc", 3286317445)
  Callable_method_store.rpc_id = Get_Builtin_Method(.CALLABLE, "rpc_id", 2270047679)
  Callable_method_store.bind = Get_Builtin_Method(.CALLABLE, "bind", 3224143119)
  Callable_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .CALLABLE, .NIL)
  Callable_method_store.VARIANT_OP_EQUAL_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .CALLABLE, .CALLABLE)
  Callable_method_store.VARIANT_OP_NOT_EQUAL_Callable = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .CALLABLE, .CALLABLE)
  Callable_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .CALLABLE, .DICTIONARY)
  Callable_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .CALLABLE, .ARRAY)
}
