package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


NodePath_Methods_list :: struct {
    Create0: proc "c" (p_base: ^NodePath, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^NodePath,  #by_ptr p_args: struct{ from: ^NodePath, }),
    Create2: proc "c" (p_base: ^NodePath,  #by_ptr p_args: struct{ from: ^gdstring, }),
    Destroy: proc "c" (p_base: ^NodePath),
    get_ptr: proc "c" (base: ^Variant) -> ^NodePath,
    is_absolute:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    get_name_count:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_name:  proc "c" (p_base: ^NodePath, #by_ptr p_args: struct{ idx: ^Int, }, r_return: ^StringName, p_argument_count: i64 = 1),
    get_subname_count:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    hash:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_subname:  proc "c" (p_base: ^NodePath, #by_ptr p_args: struct{ idx: ^Int, }, r_return: ^StringName, p_argument_count: i64 = 1),
    get_concatenated_names:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    get_concatenated_subnames:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    slice:  proc "c" (p_base: ^NodePath, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, }, r_return: ^NodePath, p_argument_count: i64 = 2),
    get_as_property_path:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^NodePath, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^NodePath, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^NodePath, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_NodePath: proc "c" (p_left: ^NodePath, p_right: ^NodePath, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_NodePath: proc "c" (p_left: ^NodePath, p_right: ^NodePath, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^NodePath, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^NodePath, p_right: ^Array, r_result: ^Bool),
}
init_NodePath_Methods :: proc(NodePath_method_store: ^NodePath_Methods_list) {
  NodePath_method_store.Create0 = cast(type_of(NodePath_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 0)
  NodePath_method_store.Create1 = cast(type_of(NodePath_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 1)
  NodePath_method_store.Create2 = cast(type_of(NodePath_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 2)
  NodePath_method_store.Destroy = cast(type_of(NodePath_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.NODE_PATH)
    NodePath_method_store.get_ptr = cast(type_of(NodePath_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.NODE_PATH)
  NodePath_method_store.is_absolute = cast(type_of(NodePath_method_store.is_absolute))Get_Builtin_Method(.NODE_PATH, "is_absolute", 3918633141)
  NodePath_method_store.get_name_count = cast(type_of(NodePath_method_store.get_name_count))Get_Builtin_Method(.NODE_PATH, "get_name_count", 3173160232)
  NodePath_method_store.get_name = cast(type_of(NodePath_method_store.get_name))Get_Builtin_Method(.NODE_PATH, "get_name", 2948586938)
  NodePath_method_store.get_subname_count = cast(type_of(NodePath_method_store.get_subname_count))Get_Builtin_Method(.NODE_PATH, "get_subname_count", 3173160232)
  NodePath_method_store.hash = cast(type_of(NodePath_method_store.hash))Get_Builtin_Method(.NODE_PATH, "hash", 3173160232)
  NodePath_method_store.get_subname = cast(type_of(NodePath_method_store.get_subname))Get_Builtin_Method(.NODE_PATH, "get_subname", 2948586938)
  NodePath_method_store.get_concatenated_names = cast(type_of(NodePath_method_store.get_concatenated_names))Get_Builtin_Method(.NODE_PATH, "get_concatenated_names", 1825232092)
  NodePath_method_store.get_concatenated_subnames = cast(type_of(NodePath_method_store.get_concatenated_subnames))Get_Builtin_Method(.NODE_PATH, "get_concatenated_subnames", 1825232092)
  NodePath_method_store.slice = cast(type_of(NodePath_method_store.slice))Get_Builtin_Method(.NODE_PATH, "slice", 421628484)
  NodePath_method_store.get_as_property_path = cast(type_of(NodePath_method_store.get_as_property_path))Get_Builtin_Method(.NODE_PATH, "get_as_property_path", 1598598043)
  NodePath_method_store.is_empty = cast(type_of(NodePath_method_store.is_empty))Get_Builtin_Method(.NODE_PATH, "is_empty", 3918633141)
  NodePath_method_store.VARIANT_OP_NOT_ = cast(type_of(NodePath_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .NODE_PATH, .NIL)
  NodePath_method_store.VARIANT_OP_EQUAL_NodePath = cast(type_of(NodePath_method_store.VARIANT_OP_EQUAL_NodePath))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .NODE_PATH, .NODE_PATH)
  NodePath_method_store.VARIANT_OP_NOT_EQUAL_NodePath = cast(type_of(NodePath_method_store.VARIANT_OP_NOT_EQUAL_NodePath))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .NODE_PATH, .NODE_PATH)
  NodePath_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(NodePath_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NODE_PATH, .DICTIONARY)
  NodePath_method_store.VARIANT_OP_IN_Array = cast(type_of(NodePath_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .NODE_PATH, .ARRAY)
}
