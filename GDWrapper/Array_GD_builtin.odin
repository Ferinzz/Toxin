package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Array_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Array, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^Array, }),
    Create2: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ base: ^Array, type: ^Int, class_name: ^StringName, script: ^Variant, }),
    Create3: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedByteArray, }),
    Create4: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedInt32Array, }),
    Create5: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedInt64Array, }),
    Create6: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedFloat32Array, }),
    Create7: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedFloat64Array, }),
    Create8: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedStringArray, }),
    Create9: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedVector2Array, }),
    Create10: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedVector3Array, }),
    Create11: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedColorArray, }),
    Create12: proc "c" (p_base: ^Array,  #by_ptr p_args: struct{ from: ^PackedVector4Array, }),
    Destroy: proc "c" (p_base: ^Array),
    get_ptr: proc "c" (base: ^Variant) -> ^Array,
    IndxSetter : proc "c" (p_base: ^Array, p_index: Int, p_value: ^Variant),
    IndxGetter : proc "c" (p_base: ^Array, p_index: Int, r_value: ^Variant),
    size:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    is_empty:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    clear:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    hash:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    assign:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ array: ^Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    get:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ index: ^Int, }, r_return: ^Variant, p_argument_count: i64 = 1),
    set:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ index: ^Int, value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 2),
    push_back:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    push_front:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    append:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    append_array:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ array: ^Array, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    resize:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ size: ^Int, }, r_return: ^Int, p_argument_count: i64 = 1),
    insert:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ position: ^Int, value: ^Variant, }, r_return: ^Int, p_argument_count: i64 = 2),
    remove_at:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ position: ^Int, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    fill:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    erase:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    front:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    back:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    pick_random:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    find:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ what: ^Variant, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    find_custom:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ what: ^Variant, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    rfind_custom:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, from: ^Int, }, r_return: ^Int, p_argument_count: i64 = 2),
    count:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^Int, p_argument_count: i64 = 1),
    has:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, }, r_return: ^Bool, p_argument_count: i64 = 1),
    pop_back:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    pop_front:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    pop_at:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ position: ^Int, }, r_return: ^Variant, p_argument_count: i64 = 1),
    sort:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    sort_custom:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ func: ^Callable, }, r_return: ^rawptr = nil, p_argument_count: i64 = 1),
    shuffle:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    bsearch:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 2),
    bsearch_custom:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ value: ^Variant, func: ^Callable, before: ^Bool, }, r_return: ^Int, p_argument_count: i64 = 3),
    reverse:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    duplicate:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ deep: ^Bool, }, r_return: ^Array, p_argument_count: i64 = 1),
    duplicate_deep:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ deep_subresources_mode: ^Int, }, r_return: ^Array, p_argument_count: i64 = 1),
    slice:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ begin: ^Int, end: ^Int, step: ^Int, deep: ^Bool, }, r_return: ^Array, p_argument_count: i64 = 4),
    filter:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, }, r_return: ^Array, p_argument_count: i64 = 1),
    gdmap:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, }, r_return: ^Array, p_argument_count: i64 = 1),
    reduce:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, accum: ^Variant, }, r_return: ^Variant, p_argument_count: i64 = 2),
    gdany:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, }, r_return: ^Bool, p_argument_count: i64 = 1),
    all:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ method: ^Callable, }, r_return: ^Bool, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    min:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    is_typed:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    is_same_typed:  proc "c" (p_base: ^Array, #by_ptr p_args: struct{ array: ^Array, }, r_return: ^Bool, p_argument_count: i64 = 1),
    get_typed_builtin:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    get_typed_class_name:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^StringName, p_argument_count: i64 = 0),
    get_typed_script:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Variant, p_argument_count: i64 = 0),
    make_read_only:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^rawptr = nil, p_argument_count: i64 = 0),
    is_read_only:  proc "c" (p_base: ^Array, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Array, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Array, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_EQUAL_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_LESS_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_GREATER_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_ADD_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Array),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Array, p_right: ^Array, r_result: ^Bool),
}
init_Array_Methods :: proc(Array_method_store: ^Array_Methods_list) {
  Array_method_store.Create0 = cast(type_of(Array_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 0)
  Array_method_store.Create1 = cast(type_of(Array_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 1)
  Array_method_store.Create2 = cast(type_of(Array_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 2)
  Array_method_store.Create3 = cast(type_of(Array_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 3)
  Array_method_store.Create4 = cast(type_of(Array_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 4)
  Array_method_store.Create5 = cast(type_of(Array_method_store.Create5))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 5)
  Array_method_store.Create6 = cast(type_of(Array_method_store.Create6))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 6)
  Array_method_store.Create7 = cast(type_of(Array_method_store.Create7))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 7)
  Array_method_store.Create8 = cast(type_of(Array_method_store.Create8))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 8)
  Array_method_store.Create9 = cast(type_of(Array_method_store.Create9))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 9)
  Array_method_store.Create10 = cast(type_of(Array_method_store.Create10))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 10)
  Array_method_store.Create11 = cast(type_of(Array_method_store.Create11))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 11)
  Array_method_store.Create12 = cast(type_of(Array_method_store.Create12))gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 12)
  Array_method_store.Destroy = cast(type_of(Array_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.ARRAY)
    Array_method_store.get_ptr = cast(type_of(Array_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.ARRAY)
  Array_method_store.IndxGetter = cast(type_of(Array_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.ARRAY)
  Array_method_store.IndxSetter = cast(type_of(Array_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.ARRAY)
  Array_method_store.size = cast(type_of(Array_method_store.size))Get_Builtin_Method(.ARRAY, "size", 3173160232)
  Array_method_store.is_empty = cast(type_of(Array_method_store.is_empty))Get_Builtin_Method(.ARRAY, "is_empty", 3918633141)
  Array_method_store.clear = cast(type_of(Array_method_store.clear))Get_Builtin_Method(.ARRAY, "clear", 3218959716)
  Array_method_store.hash = cast(type_of(Array_method_store.hash))Get_Builtin_Method(.ARRAY, "hash", 3173160232)
  Array_method_store.assign = cast(type_of(Array_method_store.assign))Get_Builtin_Method(.ARRAY, "assign", 2307260970)
  Array_method_store.get = cast(type_of(Array_method_store.get))Get_Builtin_Method(.ARRAY, "get", 708700221)
  Array_method_store.set = cast(type_of(Array_method_store.set))Get_Builtin_Method(.ARRAY, "set", 3798478031)
  Array_method_store.push_back = cast(type_of(Array_method_store.push_back))Get_Builtin_Method(.ARRAY, "push_back", 3316032543)
  Array_method_store.push_front = cast(type_of(Array_method_store.push_front))Get_Builtin_Method(.ARRAY, "push_front", 3316032543)
  Array_method_store.append = cast(type_of(Array_method_store.append))Get_Builtin_Method(.ARRAY, "append", 3316032543)
  Array_method_store.append_array = cast(type_of(Array_method_store.append_array))Get_Builtin_Method(.ARRAY, "append_array", 2307260970)
  Array_method_store.resize = cast(type_of(Array_method_store.resize))Get_Builtin_Method(.ARRAY, "resize", 848867239)
  Array_method_store.insert = cast(type_of(Array_method_store.insert))Get_Builtin_Method(.ARRAY, "insert", 3176316662)
  Array_method_store.remove_at = cast(type_of(Array_method_store.remove_at))Get_Builtin_Method(.ARRAY, "remove_at", 2823966027)
  Array_method_store.fill = cast(type_of(Array_method_store.fill))Get_Builtin_Method(.ARRAY, "fill", 3316032543)
  Array_method_store.erase = cast(type_of(Array_method_store.erase))Get_Builtin_Method(.ARRAY, "erase", 3316032543)
  Array_method_store.front = cast(type_of(Array_method_store.front))Get_Builtin_Method(.ARRAY, "front", 1460142086)
  Array_method_store.back = cast(type_of(Array_method_store.back))Get_Builtin_Method(.ARRAY, "back", 1460142086)
  Array_method_store.pick_random = cast(type_of(Array_method_store.pick_random))Get_Builtin_Method(.ARRAY, "pick_random", 1460142086)
  Array_method_store.find = cast(type_of(Array_method_store.find))Get_Builtin_Method(.ARRAY, "find", 2336346817)
  Array_method_store.find_custom = cast(type_of(Array_method_store.find_custom))Get_Builtin_Method(.ARRAY, "find_custom", 2145562546)
  Array_method_store.rfind = cast(type_of(Array_method_store.rfind))Get_Builtin_Method(.ARRAY, "rfind", 2336346817)
  Array_method_store.rfind_custom = cast(type_of(Array_method_store.rfind_custom))Get_Builtin_Method(.ARRAY, "rfind_custom", 2145562546)
  Array_method_store.count = cast(type_of(Array_method_store.count))Get_Builtin_Method(.ARRAY, "count", 1481661226)
  Array_method_store.has = cast(type_of(Array_method_store.has))Get_Builtin_Method(.ARRAY, "has", 3680194679)
  Array_method_store.pop_back = cast(type_of(Array_method_store.pop_back))Get_Builtin_Method(.ARRAY, "pop_back", 1321915136)
  Array_method_store.pop_front = cast(type_of(Array_method_store.pop_front))Get_Builtin_Method(.ARRAY, "pop_front", 1321915136)
  Array_method_store.pop_at = cast(type_of(Array_method_store.pop_at))Get_Builtin_Method(.ARRAY, "pop_at", 3518259424)
  Array_method_store.sort = cast(type_of(Array_method_store.sort))Get_Builtin_Method(.ARRAY, "sort", 3218959716)
  Array_method_store.sort_custom = cast(type_of(Array_method_store.sort_custom))Get_Builtin_Method(.ARRAY, "sort_custom", 3470848906)
  Array_method_store.shuffle = cast(type_of(Array_method_store.shuffle))Get_Builtin_Method(.ARRAY, "shuffle", 3218959716)
  Array_method_store.bsearch = cast(type_of(Array_method_store.bsearch))Get_Builtin_Method(.ARRAY, "bsearch", 3372222236)
  Array_method_store.bsearch_custom = cast(type_of(Array_method_store.bsearch_custom))Get_Builtin_Method(.ARRAY, "bsearch_custom", 161317131)
  Array_method_store.reverse = cast(type_of(Array_method_store.reverse))Get_Builtin_Method(.ARRAY, "reverse", 3218959716)
  Array_method_store.duplicate = cast(type_of(Array_method_store.duplicate))Get_Builtin_Method(.ARRAY, "duplicate", 636440122)
  Array_method_store.duplicate_deep = cast(type_of(Array_method_store.duplicate_deep))Get_Builtin_Method(.ARRAY, "duplicate_deep", 1949240801)
  Array_method_store.slice = cast(type_of(Array_method_store.slice))Get_Builtin_Method(.ARRAY, "slice", 1393718243)
  Array_method_store.filter = cast(type_of(Array_method_store.filter))Get_Builtin_Method(.ARRAY, "filter", 4075186556)
  Array_method_store.gdmap = cast(type_of(Array_method_store.gdmap))Get_Builtin_Method(.ARRAY, "map", 4075186556)
  Array_method_store.reduce = cast(type_of(Array_method_store.reduce))Get_Builtin_Method(.ARRAY, "reduce", 4272450342)
  Array_method_store.gdany = cast(type_of(Array_method_store.gdany))Get_Builtin_Method(.ARRAY, "any", 4129521963)
  Array_method_store.all = cast(type_of(Array_method_store.all))Get_Builtin_Method(.ARRAY, "all", 4129521963)
  Array_method_store.max = cast(type_of(Array_method_store.max))Get_Builtin_Method(.ARRAY, "max", 1460142086)
  Array_method_store.min = cast(type_of(Array_method_store.min))Get_Builtin_Method(.ARRAY, "min", 1460142086)
  Array_method_store.is_typed = cast(type_of(Array_method_store.is_typed))Get_Builtin_Method(.ARRAY, "is_typed", 3918633141)
  Array_method_store.is_same_typed = cast(type_of(Array_method_store.is_same_typed))Get_Builtin_Method(.ARRAY, "is_same_typed", 2988181878)
  Array_method_store.get_typed_builtin = cast(type_of(Array_method_store.get_typed_builtin))Get_Builtin_Method(.ARRAY, "get_typed_builtin", 3173160232)
  Array_method_store.get_typed_class_name = cast(type_of(Array_method_store.get_typed_class_name))Get_Builtin_Method(.ARRAY, "get_typed_class_name", 1825232092)
  Array_method_store.get_typed_script = cast(type_of(Array_method_store.get_typed_script))Get_Builtin_Method(.ARRAY, "get_typed_script", 1460142086)
  Array_method_store.make_read_only = cast(type_of(Array_method_store.make_read_only))Get_Builtin_Method(.ARRAY, "make_read_only", 3218959716)
  Array_method_store.is_read_only = cast(type_of(Array_method_store.is_read_only))Get_Builtin_Method(.ARRAY, "is_read_only", 3918633141)
  Array_method_store.VARIANT_OP_NOT_ = cast(type_of(Array_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .ARRAY, .NIL)
  Array_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Array_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .ARRAY, .DICTIONARY)
  Array_method_store.VARIANT_OP_EQUAL_Array = cast(type_of(Array_method_store.VARIANT_OP_EQUAL_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_NOT_EQUAL_Array = cast(type_of(Array_method_store.VARIANT_OP_NOT_EQUAL_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_LESS_Array = cast(type_of(Array_method_store.VARIANT_OP_LESS_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_LESS_EQUAL_Array = cast(type_of(Array_method_store.VARIANT_OP_LESS_EQUAL_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_GREATER_Array = cast(type_of(Array_method_store.VARIANT_OP_GREATER_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_GREATER_EQUAL_Array = cast(type_of(Array_method_store.VARIANT_OP_GREATER_EQUAL_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_ADD_Array = cast(type_of(Array_method_store.VARIANT_OP_ADD_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_IN_Array = cast(type_of(Array_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .ARRAY, .ARRAY)
}
