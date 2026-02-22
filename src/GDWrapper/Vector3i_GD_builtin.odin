package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


@(rodata)
Vector3i_ZERO : Vector3i= {0, 0, 0}
@(rodata)
Vector3i_ONE : Vector3i= {1, 1, 1}
@(rodata)
Vector3i_MIN : Vector3i= {-2147483648, -2147483648, -2147483648}
@(rodata)
Vector3i_MAX : Vector3i= {2147483647, 2147483647, 2147483647}
@(rodata)
Vector3i_LEFT : Vector3i= {-1, 0, 0}
@(rodata)
Vector3i_RIGHT : Vector3i= {1, 0, 0}
@(rodata)
Vector3i_UP : Vector3i= {0, 1, 0}
@(rodata)
Vector3i_DOWN : Vector3i= {0, -1, 0}
@(rodata)
Vector3i_FORWARD : Vector3i= {0, 0, -1}
@(rodata)
Vector3i_BACK : Vector3i= {0, 0, 1}

Vector3i_Axis :: enum i64 {
  AXIS_X = 0,
  AXIS_Y = 1,
  AXIS_Z = 2,
}
Vector3i_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Vector3i, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Vector3i,  #by_ptr p_args: struct{ from: ^Vector3i, }),
    Create2: proc "c" (p_base: ^Vector3i,  #by_ptr p_args: struct{ from: ^Vector3, }),
    Create3: proc "c" (p_base: ^Vector3i,  #by_ptr p_args: struct{ x: ^Int, y: ^Int, z: ^Int, }),
    IndxSetter : proc "c" (p_base: ^Vector3i, p_index: Int, p_value: ^Int),
    IndxGetter : proc "c" (p_base: ^Vector3i, p_index: Int, r_value: ^Int),
    min_axis_index:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    max_axis_index:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    distance_to:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ to: ^Vector3i, }, r_return: ^float, p_argument_count: i64 = 1),
    distance_squared_to:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ to: ^Vector3i, }, r_return: ^Int, p_argument_count: i64 = 1),
    length:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    length_squared:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    sign:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^Vector3i, p_argument_count: i64 = 0),
    abs:  proc "c" (p_base: ^Vector3i, p_args: rawptr = nil, r_return: ^Vector3i, p_argument_count: i64 = 0),
    clamp:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ min: ^Vector3i, max: ^Vector3i, }, r_return: ^Vector3i, p_argument_count: i64 = 2),
    clampi:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ min: ^Int, max: ^Int, }, r_return: ^Vector3i, p_argument_count: i64 = 2),
    snapped:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ step: ^Vector3i, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    snappedi:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ step: ^Int, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    min:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ with: ^Vector3i, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    mini:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    max:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ with: ^Vector3i, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    maxi:  proc "c" (p_base: ^Vector3i, #by_ptr p_args: struct{ with: ^Int, }, r_return: ^Vector3i, p_argument_count: i64 = 1),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Vector3i, p_right: rawptr = nil,  r_result: ^Vector3i),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Vector3i, p_right: rawptr = nil,  r_result: ^Vector3i),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Vector3i, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Vector3i, p_right: ^Int, r_result: ^Vector3i),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Vector3i, p_right: ^Int, r_result: ^Vector3i),
    VARIANT_OP_MODULE_Int: proc "c" (p_left: ^Vector3i, p_right: ^Int, r_result: ^Vector3i),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Vector3i, p_right: ^float, r_result: ^Vector3),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Vector3i, p_right: ^float, r_result: ^Vector3),
    VARIANT_OP_EQUAL_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_LESS_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_LESS_EQUAL_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_GREATER_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_GREATER_EQUAL_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Bool),
    VARIANT_OP_ADD_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_SUBTRACT_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_MULTIPLY_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_DIVIDE_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_MODULE_Vector3i: proc "c" (p_left: ^Vector3i, p_right: ^Vector3i, r_result: ^Vector3i),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Vector3i, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Vector3i, p_right: ^Array, r_result: ^Bool),
}
init_Vector3i_Methods :: proc(Vector3i_method_store: ^Vector3i_Methods_list) {
  Vector3i_method_store.Create0 = cast(type_of(Vector3i_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 0)
  Vector3i_method_store.Create1 = cast(type_of(Vector3i_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 1)
  Vector3i_method_store.Create2 = cast(type_of(Vector3i_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 2)
  Vector3i_method_store.Create3 = cast(type_of(Vector3i_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.VECTOR3I, 3)
  Vector3i_method_store.IndxGetter = cast(type_of(Vector3i_method_store.Vector3iIndxGetter))gdAPI.Variant_Utils.GetPtrKeyedGetter(.VECTOR3I)
  Vector3i_method_store.IndxSetter = cast(type_of(Vector3i_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.VECTOR3I)
  Vector3i_method_store.min_axis_index = cast(type_of(Vector3i_method_store.min_axis_index))Get_Builtin_Method(.VECTOR3I, "min_axis_index", 3173160232)
  Vector3i_method_store.max_axis_index = cast(type_of(Vector3i_method_store.max_axis_index))Get_Builtin_Method(.VECTOR3I, "max_axis_index", 3173160232)
  Vector3i_method_store.distance_to = cast(type_of(Vector3i_method_store.distance_to))Get_Builtin_Method(.VECTOR3I, "distance_to", 1975170430)
  Vector3i_method_store.distance_squared_to = cast(type_of(Vector3i_method_store.distance_squared_to))Get_Builtin_Method(.VECTOR3I, "distance_squared_to", 2947717320)
  Vector3i_method_store.length = cast(type_of(Vector3i_method_store.length))Get_Builtin_Method(.VECTOR3I, "length", 466405837)
  Vector3i_method_store.length_squared = cast(type_of(Vector3i_method_store.length_squared))Get_Builtin_Method(.VECTOR3I, "length_squared", 3173160232)
  Vector3i_method_store.sign = cast(type_of(Vector3i_method_store.sign))Get_Builtin_Method(.VECTOR3I, "sign", 3729604559)
  Vector3i_method_store.abs = cast(type_of(Vector3i_method_store.abs))Get_Builtin_Method(.VECTOR3I, "abs", 3729604559)
  Vector3i_method_store.clamp = cast(type_of(Vector3i_method_store.clamp))Get_Builtin_Method(.VECTOR3I, "clamp", 1086892323)
  Vector3i_method_store.clampi = cast(type_of(Vector3i_method_store.clampi))Get_Builtin_Method(.VECTOR3I, "clampi", 1077216921)
  Vector3i_method_store.snapped = cast(type_of(Vector3i_method_store.snapped))Get_Builtin_Method(.VECTOR3I, "snapped", 1989319750)
  Vector3i_method_store.snappedi = cast(type_of(Vector3i_method_store.snappedi))Get_Builtin_Method(.VECTOR3I, "snappedi", 2377625641)
  Vector3i_method_store.min = cast(type_of(Vector3i_method_store.min))Get_Builtin_Method(.VECTOR3I, "min", 1989319750)
  Vector3i_method_store.mini = cast(type_of(Vector3i_method_store.mini))Get_Builtin_Method(.VECTOR3I, "mini", 2377625641)
  Vector3i_method_store.max = cast(type_of(Vector3i_method_store.max))Get_Builtin_Method(.VECTOR3I, "max", 1989319750)
  Vector3i_method_store.maxi = cast(type_of(Vector3i_method_store.maxi))Get_Builtin_Method(.VECTOR3I, "maxi", 2377625641)
  Vector3i_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Vector3i_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Vector3i_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_NOT_ = cast(type_of(Vector3i_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .VECTOR3I, .NIL)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Vector3i_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Vector3i_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_MODULE_Int = cast(type_of(Vector3i_method_store.VARIANT_OP_MODULE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR3I, .INT)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Vector3i_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .FLOAT)
  Vector3i_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Vector3i_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .FLOAT)
  Vector3i_method_store.VARIANT_OP_EQUAL_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_EQUAL_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_NOT_EQUAL_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_NOT_EQUAL_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_LESS_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_LESS_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_LESS_EQUAL_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_LESS_EQUAL_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_GREATER_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_GREATER_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_GREATER_EQUAL_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_GREATER_EQUAL_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_ADD_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_ADD_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_SUBTRACT_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_SUBTRACT_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_MULTIPLY_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_MULTIPLY_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_DIVIDE_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_DIVIDE_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_MODULE_Vector3i = cast(type_of(Vector3i_method_store.VARIANT_OP_MODULE_Vector3i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MODULE, .VECTOR3I, .VECTOR3I)
  Vector3i_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Vector3i_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3I, .DICTIONARY)
  Vector3i_method_store.VARIANT_OP_IN_Array = cast(type_of(Vector3i_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .VECTOR3I, .ARRAY)
}
