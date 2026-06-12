package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


@(rodata)
Vector4i_ZERO : Vector4i= {0, 0, 0, 0}
@(rodata)
Vector4i_ONE : Vector4i= {1, 1, 1, 1}
@(rodata)
Vector4i_MIN : Vector4i= {-2147483648, -2147483648, -2147483648, -2147483648}
@(rodata)
Vector4i_MAX : Vector4i= {2147483647, 2147483647, 2147483647, 2147483647}

Vector4i_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
  AXIS_Z = 2,
  AXIS_W = 3,
}
Vector4i_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector4i, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector4i,  #by_ptr p_args: struct{ from: ^Vector4i, }),
    Create2: proc "c" (p_base: ^Vector4i,  #by_ptr p_args: struct{ from: ^Vector4, }),
    Create3: proc "c" (p_base: ^Vector4i,  #by_ptr p_args: struct{ x: ^Int, y: ^Int, z: ^Int, w: ^Int, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Vector4i,
    IndxSetter : proc "c" (p_base: ^Vector4i, p_index: Int, p_value: ^Int),
    IndxGetter : proc "c" (p_base: ^Vector4i, p_index: Int, r_value: ^Int),
    min_axis_index:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    max_axis_index:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    length:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    sign:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^Vector4i, p_argument_count: i64 = 0),
    abs:  proc "c" (p_base: ^Vector4i, p_args: rawptr = nil, r_return: ^Vector4i, p_argument_count: i64 = 0),
    clamp:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ min: ^Vector4i, max: ^Vector4i, }, r_return: ^Vector4i, p_argument_count: i64 = 2),
    clampi:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ min: ^Int, max: ^Int, }, r_return: ^Vector4i, p_argument_count: i64 = 2),
    snapped:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ step: ^Vector4i, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    snappedi:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ step: ^Int, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    min:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ with: ^Vector4i, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    mini:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ with: ^Vector4i, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    maxi:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector4i, p_argument_count: i64 = 1),
    distance_to:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ to: ^Vector4i, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector4i, #by_ptr p_args: struct{ to: ^Vector4i, }, r_return: ^Int, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector4i, p_right: rawptr = nil,  r_result: ^Vector4i),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector4i, p_right: rawptr = nil,  r_result: ^Vector4i),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector4i, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector4i, p_right: ^Int, r_result: ^Vector4i),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector4i, p_right: ^Int, r_result: ^Vector4i),
    VARIANT_OP_MODULE_Int: proc "c" (p_left: ^Vector4i, p_right: ^Int, r_result: ^Vector4i),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector4i, p_right: ^float, r_result: ^Vector4),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector4i, p_right: ^float, r_result: ^Vector4),
    VARIANT_OP_EQUAL_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_LESS_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Bool),
    VARIANT_OP_ADD_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_SUBTRACT_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_MULTIPLY_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_DIVIDE_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_MODULE_Vector4i: proc "c" (p_left: ^Vector4i, p_right: ^Vector4i, r_result: ^Vector4i),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector4i, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector4i, p_right: ^Array, r_result: ^Bool),
}
init_Vector4i_Methods :: proc(Vector4i_method_store: ^Vector4i_Methods_list) {
  Vector4i_method_store.Create0 = cast(type_of(Vector4i_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 0)
  Vector4i_method_store.Create1 = cast(type_of(Vector4i_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 1)
  Vector4i_method_store.Create2 = cast(type_of(Vector4i_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 2)
  Vector4i_method_store.Create3 = cast(type_of(Vector4i_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR4I, 3)
    Vector4i_method_store.get_ptr = cast(type_of(Vector4i_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.VECTOR4I)
  Vector4i_method_store.IndxGetter = cast(type_of(Vector4i_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.VECTOR4I)
  Vector4i_method_store.IndxSetter = cast(type_of(Vector4i_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.VECTOR4I)
  Vector4i_method_store.min_axis_index = cast(type_of(Vector4i_method_store.min_axis_index))Get_Builtin_Method(.VECTOR4I, "min_axis_index", 3173160232)
  Vector4i_method_store.max_axis_index = cast(type_of(Vector4i_method_store.max_axis_index))Get_Builtin_Method(.VECTOR4I, "max_axis_index", 3173160232)
  Vector4i_method_store.length = cast(type_of(Vector4i_method_store.length))Get_Builtin_Method(.VECTOR4I, "length", 466405837)
  Vector4i_method_store.length_squared = cast(type_of(Vector4i_method_store.length_squared))Get_Builtin_Method(.VECTOR4I, "length_squared", 3173160232)
  Vector4i_method_store.sign = cast(type_of(Vector4i_method_store.sign))Get_Builtin_Method(.VECTOR4I, "sign", 4134919947)
  Vector4i_method_store.abs = cast(type_of(Vector4i_method_store.abs))Get_Builtin_Method(.VECTOR4I, "abs", 4134919947)
  Vector4i_method_store.clamp = cast(type_of(Vector4i_method_store.clamp))Get_Builtin_Method(.VECTOR4I, "clamp", 3046490913)
  Vector4i_method_store.clampi = cast(type_of(Vector4i_method_store.clampi))Get_Builtin_Method(.VECTOR4I, "clampi", 2994578256)
  Vector4i_method_store.snapped = cast(type_of(Vector4i_method_store.snapped))Get_Builtin_Method(.VECTOR4I, "snapped", 1181693102)
  Vector4i_method_store.snappedi = cast(type_of(Vector4i_method_store.snappedi))Get_Builtin_Method(.VECTOR4I, "snappedi", 1476494415)
  Vector4i_method_store.min = cast(type_of(Vector4i_method_store.min))Get_Builtin_Method(.VECTOR4I, "min", 1181693102)
  Vector4i_method_store.mini = cast(type_of(Vector4i_method_store.mini))Get_Builtin_Method(.VECTOR4I, "mini", 1476494415)
  Vector4i_method_store.max = cast(type_of(Vector4i_method_store.max))Get_Builtin_Method(.VECTOR4I, "max", 1181693102)
  Vector4i_method_store.maxi = cast(type_of(Vector4i_method_store.maxi))Get_Builtin_Method(.VECTOR4I, "maxi", 1476494415)
  Vector4i_method_store.distance_to = cast(type_of(Vector4i_method_store.distance_to))Get_Builtin_Method(.VECTOR4I, "distance_to", 3446086573)
  Vector4i_method_store.distance_squared_to = cast(type_of(Vector4i_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR4I, "distance_squared_to", 346708794)
  Vector4i_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector4i_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector4i_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector4i_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR4I, .NIL)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector4i_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector4i_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_MODULE_Int = cast(type_of(Vector4i_method_store.VARIANT_OP_MODULE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR4I, .INT)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector4i_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .FLOAT)
  Vector4i_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector4i_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .FLOAT)
  Vector4i_method_store.VARIANT_OP_EQUAL_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_EQUAL_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_NOT_EQUAL_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_NOT_EQUAL_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_LESS_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_LESS_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_LESS_EQUAL_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_LESS_EQUAL_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_GREATER_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_GREATER_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_GREATER_EQUAL_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_GREATER_EQUAL_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_ADD_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_ADD_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_SUBTRACT_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_SUBTRACT_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_MULTIPLY_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_MULTIPLY_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_DIVIDE_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_DIVIDE_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_MODULE_Vector4i = cast(type_of(Vector4i_method_store.VARIANT_OP_MODULE_Vector4i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR4I, .VECTOR4I)
  Vector4i_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector4i_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4I, .DICTIONARY)
  Vector4i_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector4i_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR4I, .ARRAY)
}
