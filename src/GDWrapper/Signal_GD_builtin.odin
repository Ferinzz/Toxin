package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Signal_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  is_null:  GDE.PtrBuiltInMethod,
  get_object:  GDE.PtrBuiltInMethod,
  get_object_id:  GDE.PtrBuiltInMethod,
  get_name:  GDE.PtrBuiltInMethod,
  connect:  GDE.PtrBuiltInMethod,
  disconnect:  GDE.PtrBuiltInMethod,
  is_connected:  GDE.PtrBuiltInMethod,
  get_connections:  GDE.PtrBuiltInMethod,
  has_connections:  GDE.PtrBuiltInMethod,
  emit:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Signal: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Signal: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Signal_Methods :: proc(Signal_method_store: ^Signal_Methods_list) {
  Signal_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 0)
  Signal_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 1)
  Signal_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.SIGNAL, 2)
  Signal_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.SIGNAL)
  Signal_method_store.is_null = Get_Builtin_Method(.SIGNAL, "is_null", 3918633141)
  Signal_method_store.get_object = Get_Builtin_Method(.SIGNAL, "get_object", 4008621732)
  Signal_method_store.get_object_id = Get_Builtin_Method(.SIGNAL, "get_object_id", 3173160232)
  Signal_method_store.get_name = Get_Builtin_Method(.SIGNAL, "get_name", 1825232092)
  Signal_method_store.connect = Get_Builtin_Method(.SIGNAL, "connect", 979702392)
  Signal_method_store.disconnect = Get_Builtin_Method(.SIGNAL, "disconnect", 3470848906)
  Signal_method_store.is_connected = Get_Builtin_Method(.SIGNAL, "is_connected", 4129521963)
  Signal_method_store.get_connections = Get_Builtin_Method(.SIGNAL, "get_connections", 4144163970)
  Signal_method_store.has_connections = Get_Builtin_Method(.SIGNAL, "has_connections", 3918633141)
  Signal_method_store.emit = Get_Builtin_Method(.SIGNAL, "emit", 3286317445)
  Signal_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .SIGNAL, .NIL)
  Signal_method_store.VARIANT_OP_EQUAL_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .SIGNAL, .SIGNAL)
  Signal_method_store.VARIANT_OP_NOT_EQUAL_Signal = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .SIGNAL, .SIGNAL)
  Signal_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .SIGNAL, .DICTIONARY)
  Signal_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .SIGNAL, .ARRAY)
}
