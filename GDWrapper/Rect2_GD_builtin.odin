package GDWrapper

import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:math"


Rect2_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Rect2, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Rect2,  #by_ptr p_args: struct{ from: ^Rect2, }),
    Create2: proc "c" (p_base: ^Rect2,  #by_ptr p_args: struct{ from: ^Rect2i, }),
    Create3: proc "c" (p_base: ^Rect2,  #by_ptr p_args: struct{ position: ^Vector2, size: ^Vector2, }),
    Create4: proc "c" (p_base: ^Rect2,  #by_ptr p_args: struct{ x: ^float, y: ^float, width: ^float, height: ^float, }),
    get_center:  proc "c" (p_base: ^Rect2, p_args: rawptr = nil, r_return: ^Vector2, p_argument_count: i64 = 0),
    get_area:  proc "c" (p_base: ^Rect2, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    has_area:  proc "c" (p_base: ^Rect2, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    has_point:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ point: ^Vector2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_equal_approx:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ rect: ^Rect2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    is_finite:  proc "c" (p_base: ^Rect2, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    intersects:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ b: ^Rect2, include_borders: ^Bool, }, r_return: ^Bool, p_argument_count: i64 = 2),
    encloses:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ b: ^Rect2, }, r_return: ^Bool, p_argument_count: i64 = 1),
    intersection:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ b: ^Rect2, }, r_return: ^Rect2, p_argument_count: i64 = 1),
    merge:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ b: ^Rect2, }, r_return: ^Rect2, p_argument_count: i64 = 1),
    expand:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ to: ^Vector2, }, r_return: ^Rect2, p_argument_count: i64 = 1),
    get_support:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ direction: ^Vector2, }, r_return: ^Vector2, p_argument_count: i64 = 1),
    grow:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ amount: ^float, }, r_return: ^Rect2, p_argument_count: i64 = 1),
    grow_side:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ side: ^Int, amount: ^float, }, r_return: ^Rect2, p_argument_count: i64 = 2),
    grow_individual:  proc "c" (p_base: ^Rect2, #by_ptr p_args: struct{ left: ^float, top: ^float, right: ^float, bottom: ^float, }, r_return: ^Rect2, p_argument_count: i64 = 4),
    abs:  proc "c" (p_base: ^Rect2, p_args: rawptr = nil, r_return: ^Rect2, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Rect2, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Rect2: proc "c" (p_left: ^Rect2, p_right: ^Rect2, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Rect2: proc "c" (p_left: ^Rect2, p_right: ^Rect2, r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Transform2D: proc "c" (p_left: ^Rect2, p_right: ^Transform2D, r_result: ^Rect2),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Rect2, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Rect2, p_right: ^Array, r_result: ^Bool),
}
init_Rect2_Methods :: proc(Rect2_method_store: ^Rect2_Methods_list) {
  Rect2_method_store.Create0 = cast(type_of(Rect2_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 0)
  Rect2_method_store.Create1 = cast(type_of(Rect2_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 1)
  Rect2_method_store.Create2 = cast(type_of(Rect2_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 2)
  Rect2_method_store.Create3 = cast(type_of(Rect2_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 3)
  Rect2_method_store.Create4 = cast(type_of(Rect2_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 4)
  Rect2_method_store.get_center = cast(type_of(Rect2_method_store.get_center))Get_Builtin_Method(.RECT2, "get_center", 2428350749)
  Rect2_method_store.get_area = cast(type_of(Rect2_method_store.get_area))Get_Builtin_Method(.RECT2, "get_area", 466405837)
  Rect2_method_store.has_area = cast(type_of(Rect2_method_store.has_area))Get_Builtin_Method(.RECT2, "has_area", 3918633141)
  Rect2_method_store.has_point = cast(type_of(Rect2_method_store.has_point))Get_Builtin_Method(.RECT2, "has_point", 3190634762)
  Rect2_method_store.is_equal_approx = cast(type_of(Rect2_method_store.is_equal_approx))Get_Builtin_Method(.RECT2, "is_equal_approx", 1908192260)
  Rect2_method_store.is_finite = cast(type_of(Rect2_method_store.is_finite))Get_Builtin_Method(.RECT2, "is_finite", 3918633141)
  Rect2_method_store.intersects = cast(type_of(Rect2_method_store.intersects))Get_Builtin_Method(.RECT2, "intersects", 819294880)
  Rect2_method_store.encloses = cast(type_of(Rect2_method_store.encloses))Get_Builtin_Method(.RECT2, "encloses", 1908192260)
  Rect2_method_store.intersection = cast(type_of(Rect2_method_store.intersection))Get_Builtin_Method(.RECT2, "intersection", 2282977743)
  Rect2_method_store.merge = cast(type_of(Rect2_method_store.merge))Get_Builtin_Method(.RECT2, "merge", 2282977743)
  Rect2_method_store.expand = cast(type_of(Rect2_method_store.expand))Get_Builtin_Method(.RECT2, "expand", 293272265)
  Rect2_method_store.get_support = cast(type_of(Rect2_method_store.get_support))Get_Builtin_Method(.RECT2, "get_support", 2026743667)
  Rect2_method_store.grow = cast(type_of(Rect2_method_store.grow))Get_Builtin_Method(.RECT2, "grow", 39664498)
  Rect2_method_store.grow_side = cast(type_of(Rect2_method_store.grow_side))Get_Builtin_Method(.RECT2, "grow_side", 4177736158)
  Rect2_method_store.grow_individual = cast(type_of(Rect2_method_store.grow_individual))Get_Builtin_Method(.RECT2, "grow_individual", 3203390369)
  Rect2_method_store.abs = cast(type_of(Rect2_method_store.abs))Get_Builtin_Method(.RECT2, "abs", 3107653634)
  Rect2_method_store.VARIANT_OP_NOT_ = cast(type_of(Rect2_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .RECT2, .NIL)
  Rect2_method_store.VARIANT_OP_EQUAL_Rect2 = cast(type_of(Rect2_method_store.VARIANT_OP_EQUAL_Rect2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .RECT2, .RECT2)
  Rect2_method_store.VARIANT_OP_NOT_EQUAL_Rect2 = cast(type_of(Rect2_method_store.VARIANT_OP_NOT_EQUAL_Rect2))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .RECT2, .RECT2)
  Rect2_method_store.VARIANT_OP_MULTIPLY_Transform2D = cast(type_of(Rect2_method_store.VARIANT_OP_MULTIPLY_Transform2D))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .RECT2, .TRANSFORM2D)
  Rect2_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Rect2_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2, .DICTIONARY)
  Rect2_method_store.VARIANT_OP_IN_Array = cast(type_of(Rect2_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2, .ARRAY)
}
