package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Vector2i_ZERO : Vector2i= {0, 0}
@(rodata)
Vector2i_ONE : Vector2i= {1, 1}
@(rodata)
Vector2i_MIN : Vector2i= {-2147483648, -2147483648}
@(rodata)
Vector2i_MAX : Vector2i= {2147483647, 2147483647}
@(rodata)
Vector2i_LEFT : Vector2i= {-1, 0}
@(rodata)
Vector2i_RIGHT : Vector2i= {1, 0}
@(rodata)
Vector2i_UP : Vector2i= {0, -1}
@(rodata)
Vector2i_DOWN : Vector2i= {0, 1}

Vector2i_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
}
Vector2i_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector2i, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector2i,  #by_ptr p_args: struct{ from: ^Vector2i, }),
    Create2: proc "c" (p_base: ^Vector2i,  #by_ptr p_args: struct{ from: ^Vector2, }),
    Create3: proc "c" (p_base: ^Vector2i,  #by_ptr p_args: struct{ x: ^Int, y: ^Int, }),
    IndxSetter : proc "c" (p_base: ^Vector2i, p_index: Int, p_value: ^Int),
    IndxGetter : proc "c" (p_base: ^Vector2i, p_index: Int, r_value: ^Int),
    aspect:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    max_axis_index:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    min_axis_index:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    distance_to:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ to: ^Vector2i, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ to: ^Vector2i, }, r_return: ^Int, p_argument_count: i64 = 1),
    length:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    sign:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^Vector2i, p_argument_count: i64 = 0),
    abs:  proc "c" (p_base: ^Vector2i, p_args: rawptr = nil, r_return: ^Vector2i, p_argument_count: i64 = 0),
    clamp:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ min: ^Vector2i, max: ^Vector2i, }, r_return: ^Vector2i, p_argument_count: i64 = 2),
    clampi:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ min: ^Int, max: ^Int, }, r_return: ^Vector2i, p_argument_count: i64 = 2),
    snapped:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ step: ^Vector2i, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    snappedi:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ step: ^Int, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    min:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ with: ^Vector2i, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    mini:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ with: ^Vector2i, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    maxi:  proc "c" (p_base: ^Vector2i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector2i, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector2i, p_right: rawptr = nil,  r_result: ^Vector2i),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector2i, p_right: rawptr = nil,  r_result: ^Vector2i),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector2i, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector2i, p_right: ^Int, r_result: ^Vector2i),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector2i, p_right: ^Int, r_result: ^Vector2i),
    VARIANT_OP_MODULE_Int: proc "c" (p_left: ^Vector2i, p_right: ^Int, r_result: ^Vector2i),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector2i, p_right: ^float, r_result: ^Vector2),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector2i, p_right: ^float, r_result: ^Vector2),
    VARIANT_OP_EQUAL_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_LESS_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Bool),
    VARIANT_OP_ADD_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_SUBTRACT_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_MULTIPLY_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_DIVIDE_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_MODULE_Vector2i: proc "c" (p_left: ^Vector2i, p_right: ^Vector2i, r_result: ^Vector2i),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector2i, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector2i, p_right: ^Array, r_result: ^Bool),
}
init_Vector2i_Methods :: proc(Vector2i_method_store: ^Vector2i_Methods_list) {
  Vector2i_method_store.Create0 = cast(type_of(Vector2i_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 0)
  Vector2i_method_store.Create1 = cast(type_of(Vector2i_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 1)
  Vector2i_method_store.Create2 = cast(type_of(Vector2i_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 2)
  Vector2i_method_store.Create3 = cast(type_of(Vector2i_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR2I, 3)
  Vector2i_method_store.IndxGetter = cast(type_of(Vector2i_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.VECTOR2I)
  Vector2i_method_store.IndxSetter = cast(type_of(Vector2i_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.VECTOR2I)
  Vector2i_method_store.aspect = cast(type_of(Vector2i_method_store.aspect))Get_Builtin_Method(.VECTOR2I, "aspect", 466405837)
  Vector2i_method_store.max_axis_index = cast(type_of(Vector2i_method_store.max_axis_index))Get_Builtin_Method(.VECTOR2I, "max_axis_index", 3173160232)
  Vector2i_method_store.min_axis_index = cast(type_of(Vector2i_method_store.min_axis_index))Get_Builtin_Method(.VECTOR2I, "min_axis_index", 3173160232)
  Vector2i_method_store.distance_to = cast(type_of(Vector2i_method_store.distance_to))Get_Builtin_Method(.VECTOR2I, "distance_to", 707501214)
  Vector2i_method_store.distance_squared_to = cast(type_of(Vector2i_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR2I, "distance_squared_to", 1130029528)
  Vector2i_method_store.length = cast(type_of(Vector2i_method_store.length))Get_Builtin_Method(.VECTOR2I, "length", 466405837)
  Vector2i_method_store.length_squared = cast(type_of(Vector2i_method_store.length_squared))Get_Builtin_Method(.VECTOR2I, "length_squared", 3173160232)
  Vector2i_method_store.sign = cast(type_of(Vector2i_method_store.sign))Get_Builtin_Method(.VECTOR2I, "sign", 3444277866)
  Vector2i_method_store.abs = cast(type_of(Vector2i_method_store.abs))Get_Builtin_Method(.VECTOR2I, "abs", 3444277866)
  Vector2i_method_store.clamp = cast(type_of(Vector2i_method_store.clamp))Get_Builtin_Method(.VECTOR2I, "clamp", 186568249)
  Vector2i_method_store.clampi = cast(type_of(Vector2i_method_store.clampi))Get_Builtin_Method(.VECTOR2I, "clampi", 3686769569)
  Vector2i_method_store.snapped = cast(type_of(Vector2i_method_store.snapped))Get_Builtin_Method(.VECTOR2I, "snapped", 1735278196)
  Vector2i_method_store.snappedi = cast(type_of(Vector2i_method_store.snappedi))Get_Builtin_Method(.VECTOR2I, "snappedi", 2161988953)
  Vector2i_method_store.min = cast(type_of(Vector2i_method_store.min))Get_Builtin_Method(.VECTOR2I, "min", 1735278196)
  Vector2i_method_store.mini = cast(type_of(Vector2i_method_store.mini))Get_Builtin_Method(.VECTOR2I, "mini", 2161988953)
  Vector2i_method_store.max = cast(type_of(Vector2i_method_store.max))Get_Builtin_Method(.VECTOR2I, "max", 1735278196)
  Vector2i_method_store.maxi = cast(type_of(Vector2i_method_store.maxi))Get_Builtin_Method(.VECTOR2I, "maxi", 2161988953)
  Vector2i_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector2i_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector2i_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector2i_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR2I, .NIL)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector2i_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector2i_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_MODULE_Int = cast(type_of(Vector2i_method_store.VARIANT_OP_MODULE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR2I, .INT)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector2i_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .FLOAT)
  Vector2i_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector2i_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .FLOAT)
  Vector2i_method_store.VARIANT_OP_EQUAL_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_EQUAL_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_NOT_EQUAL_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_NOT_EQUAL_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_LESS_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_LESS_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_LESS_EQUAL_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_LESS_EQUAL_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_GREATER_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_GREATER_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_GREATER_EQUAL_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_GREATER_EQUAL_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_ADD_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_ADD_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_SUBTRACT_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_SUBTRACT_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_MULTIPLY_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_MULTIPLY_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_DIVIDE_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_DIVIDE_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_MODULE_Vector2i = cast(type_of(Vector2i_method_store.VARIANT_OP_MODULE_Vector2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR2I, .VECTOR2I)
  Vector2i_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector2i_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2I, .DICTIONARY)
  Vector2i_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector2i_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR2I, .ARRAY)
}
