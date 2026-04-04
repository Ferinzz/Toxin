package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Dictionary_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Dictionary, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Dictionary,  #by_ptr p_args: struct{ from: ^Dictionary, }),
    Create2: proc "c" (p_base: ^Dictionary,  #by_ptr p_args: struct{ base: ^Dictionary, key_type: ^Int, key_class_name: ^StringName, key_script: ^Variant, value_type: ^Int, value_class_name: ^StringName, value_script: ^Variant, }),
    Destroy: proc "c" (p_base: ^Dictionary),
    get_ptr: proc "c" (base: ^Variant) -> ^Dictionary,
    KeyedSetter : proc "c" (p_base: Dictionary, p_key: GDE.ConstTypePtr, p_value: GDE.ConstTypePtr),
    KeyedGetter : proc "c" (p_base: Dictionary, p_key: GDE.TypePtr, r_value: GDE.TypePtr),
    KeyedChecker : proc "c" (#by_ptr p_base: Variant, #by_ptr p_key: Variant) -> u32,
    IndxSetter : proc "c" (p_base: ^Dictionary, p_index: Int, p_value: ^Variant),
    IndxGetter : proc "c" (p_base: ^Dictionary, p_index: Int, r_value: ^Variant),
    size:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    clear:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    assign:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    sort:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    merge:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, overwrite: ^Bool, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    merged:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, overwrite: ^Bool, }, r_return: ^Dictionary, p_argument_count: i64 = 2),
    has:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ key: ^Variant, }, r_return: ^Bool, p_argument_count: i64 = 1),
    has_all:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ keys: ^Array, }, r_return: ^Bool, p_argument_count: i64 = 1),
    find_key:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^Variant, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ key: ^Variant, }, r_return: ^Bool, p_argument_count: i64 = 1),
    hash:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    keys:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Array, p_argument_count: i64 = 0),
    values:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Array, p_argument_count: i64 = 0),
    duplicate:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ deep: ^Bool, }, r_return: ^Dictionary, p_argument_count: i64 = 1),
    duplicate_deep:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ deep_subresources_mode: ^Int, }, r_return: ^Dictionary, p_argument_count: i64 = 1),
    get:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ key: ^Variant, default: ^Variant, }, r_return: ^Variant, p_argument_count: i64 = 2),
    get_or_add:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ key: ^Variant, default: ^Variant, }, r_return: ^Variant, p_argument_count: i64 = 2),
    set:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ key: ^Variant, value: ^Variant, }, r_return: ^Bool, p_argument_count: i64 = 2),
    is_typed:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_typed_key:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_typed_value:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_same_typed:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_same_typed_key:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_same_typed_value:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, }, r_return: ^Bool, p_argument_count: i64 = 1),
    get_typed_key_builtin:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_typed_value_builtin:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_typed_key_class_name:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    get_typed_value_class_name:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    get_typed_key_script:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    get_typed_value_script:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    make_read_only:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    is_read_only:  proc "c" (p_base: ^Dictionary, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    recursive_equal:  proc "c" (p_base: ^Dictionary, #by_ptr p_args: struct{ dictionary: ^Dictionary, recursion_count: ^Int, }, r_return: ^Bool, p_argument_count: i64 = 2),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Dictionary, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Dictionary: proc "c" (p_left: ^Dictionary, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Dictionary: proc "c" (p_left: ^Dictionary, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Dictionary, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Dictionary, p_right: ^Array, r_result: ^Bool),
}
init_Dictionary_Methods :: proc "c" (Dictionary_method_store: ^Dictionary_Methods_list) {
  Dictionary_method_store.Create0 = cast(type_of(Dictionary_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 0)
  Dictionary_method_store.Create1 = cast(type_of(Dictionary_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 1)
  Dictionary_method_store.Create2 = cast(type_of(Dictionary_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.DICTIONARY, 2)
  Dictionary_method_store.Destroy = cast(type_of(Dictionary_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.DICTIONARY)
    Dictionary_method_store.get_ptr = cast(type_of(Dictionary_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.DICTIONARY)
  Dictionary_method_store.KeyedSetter = cast(type_of(Dictionary_method_store.KeyedSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.DICTIONARY)
  Dictionary_method_store.KeyedGetter = cast(type_of(Dictionary_method_store.KeyedGetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.DICTIONARY)
  Dictionary_method_store.KeyedChecker = cast(type_of(Dictionary_method_store.KeyedChecker))gdAPI.Variant_Utils.GetPtrKeyedSetter(.DICTIONARY)
  Dictionary_method_store.IndxGetter = cast(type_of(Dictionary_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.DICTIONARY)
  Dictionary_method_store.IndxSetter = cast(type_of(Dictionary_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.DICTIONARY)
  Dictionary_method_store.size = cast(type_of(Dictionary_method_store.size))Get_Builtin_Method(.DICTIONARY, "size", 3173160232)
  Dictionary_method_store.is_empty = cast(type_of(Dictionary_method_store.is_empty))Get_Builtin_Method(.DICTIONARY, "is_empty", 3918633141)
  Dictionary_method_store.clear = cast(type_of(Dictionary_method_store.clear))Get_Builtin_Method(.DICTIONARY, "clear", 3218959716)
  Dictionary_method_store.assign = cast(type_of(Dictionary_method_store.assign))Get_Builtin_Method(.DICTIONARY, "assign", 3642266950)
  Dictionary_method_store.sort = cast(type_of(Dictionary_method_store.sort))Get_Builtin_Method(.DICTIONARY, "sort", 3218959716)
  Dictionary_method_store.merge = cast(type_of(Dictionary_method_store.merge))Get_Builtin_Method(.DICTIONARY, "merge", 2079548978)
  Dictionary_method_store.merged = cast(type_of(Dictionary_method_store.merged))Get_Builtin_Method(.DICTIONARY, "merged", 2271165639)
  Dictionary_method_store.has = cast(type_of(Dictionary_method_store.has))Get_Builtin_Method(.DICTIONARY, "has", 3680194679)
  Dictionary_method_store.has_all = cast(type_of(Dictionary_method_store.has_all))Get_Builtin_Method(.DICTIONARY, "has_all", 2988181878)
  Dictionary_method_store.find_key = cast(type_of(Dictionary_method_store.find_key))Get_Builtin_Method(.DICTIONARY, "find_key", 1988825835)
  Dictionary_method_store.erase = cast(type_of(Dictionary_method_store.erase))Get_Builtin_Method(.DICTIONARY, "erase", 1776646889)
  Dictionary_method_store.hash = cast(type_of(Dictionary_method_store.hash))Get_Builtin_Method(.DICTIONARY, "hash", 3173160232)
  Dictionary_method_store.keys = cast(type_of(Dictionary_method_store.keys))Get_Builtin_Method(.DICTIONARY, "keys", 4144163970)
  Dictionary_method_store.values = cast(type_of(Dictionary_method_store.values))Get_Builtin_Method(.DICTIONARY, "values", 4144163970)
  Dictionary_method_store.duplicate = cast(type_of(Dictionary_method_store.duplicate))Get_Builtin_Method(.DICTIONARY, "duplicate", 830099069)
  Dictionary_method_store.duplicate_deep = cast(type_of(Dictionary_method_store.duplicate_deep))Get_Builtin_Method(.DICTIONARY, "duplicate_deep", 2160600714)
  Dictionary_method_store.get = cast(type_of(Dictionary_method_store.get))Get_Builtin_Method(.DICTIONARY, "get", 2205440559)
  Dictionary_method_store.get_or_add = cast(type_of(Dictionary_method_store.get_or_add))Get_Builtin_Method(.DICTIONARY, "get_or_add", 1052551076)
  Dictionary_method_store.set = cast(type_of(Dictionary_method_store.set))Get_Builtin_Method(.DICTIONARY, "set", 2175348267)
  Dictionary_method_store.is_typed = cast(type_of(Dictionary_method_store.is_typed))Get_Builtin_Method(.DICTIONARY, "is_typed", 3918633141)
  Dictionary_method_store.is_typed_key = cast(type_of(Dictionary_method_store.is_typed_key))Get_Builtin_Method(.DICTIONARY, "is_typed_key", 3918633141)
  Dictionary_method_store.is_typed_value = cast(type_of(Dictionary_method_store.is_typed_value))Get_Builtin_Method(.DICTIONARY, "is_typed_value", 3918633141)
  Dictionary_method_store.is_same_typed = cast(type_of(Dictionary_method_store.is_same_typed))Get_Builtin_Method(.DICTIONARY, "is_same_typed", 3471775634)
  Dictionary_method_store.is_same_typed_key = cast(type_of(Dictionary_method_store.is_same_typed_key))Get_Builtin_Method(.DICTIONARY, "is_same_typed_key", 3471775634)
  Dictionary_method_store.is_same_typed_value = cast(type_of(Dictionary_method_store.is_same_typed_value))Get_Builtin_Method(.DICTIONARY, "is_same_typed_value", 3471775634)
  Dictionary_method_store.get_typed_key_builtin = cast(type_of(Dictionary_method_store.get_typed_key_builtin))Get_Builtin_Method(.DICTIONARY, "get_typed_key_builtin", 3173160232)
  Dictionary_method_store.get_typed_value_builtin = cast(type_of(Dictionary_method_store.get_typed_value_builtin))Get_Builtin_Method(.DICTIONARY, "get_typed_value_builtin", 3173160232)
  Dictionary_method_store.get_typed_key_class_name = cast(type_of(Dictionary_method_store.get_typed_key_class_name))Get_Builtin_Method(.DICTIONARY, "get_typed_key_class_name", 1825232092)
  Dictionary_method_store.get_typed_value_class_name = cast(type_of(Dictionary_method_store.get_typed_value_class_name))Get_Builtin_Method(.DICTIONARY, "get_typed_value_class_name", 1825232092)
  Dictionary_method_store.get_typed_key_script = cast(type_of(Dictionary_method_store.get_typed_key_script))Get_Builtin_Method(.DICTIONARY, "get_typed_key_script", 1460142086)
  Dictionary_method_store.get_typed_value_script = cast(type_of(Dictionary_method_store.get_typed_value_script))Get_Builtin_Method(.DICTIONARY, "get_typed_value_script", 1460142086)
  Dictionary_method_store.make_read_only = cast(type_of(Dictionary_method_store.make_read_only))Get_Builtin_Method(.DICTIONARY, "make_read_only", 3218959716)
  Dictionary_method_store.is_read_only = cast(type_of(Dictionary_method_store.is_read_only))Get_Builtin_Method(.DICTIONARY, "is_read_only", 3918633141)
  Dictionary_method_store.recursive_equal = cast(type_of(Dictionary_method_store.recursive_equal))Get_Builtin_Method(.DICTIONARY, "recursive_equal", 1404404751)
  Dictionary_method_store.VARIANT_OP_NOT_ = cast(type_of(Dictionary_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .DICTIONARY, .NIL)
  Dictionary_method_store.VARIANT_OP_EQUAL_Dictionary = cast(type_of(Dictionary_method_store.VARIANT_OP_EQUAL_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_NOT_EQUAL_Dictionary = cast(type_of(Dictionary_method_store.VARIANT_OP_NOT_EQUAL_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Dictionary_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .DICTIONARY, .DICTIONARY)
  Dictionary_method_store.VARIANT_OP_IN_Array = cast(type_of(Dictionary_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .DICTIONARY, .ARRAY)
}
