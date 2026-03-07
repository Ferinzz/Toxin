package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


Rect2i_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Rect2i, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Rect2i,  #by_ptr p_args: struct{ from: ^Rect2i, }),
    Create2: proc "c" (p_base: ^Rect2i,  #by_ptr p_args: struct{ from: ^Rect2, }),
    Create3: proc "c" (p_base: ^Rect2i,  #by_ptr p_args: struct{ position: ^Vector2i, size: ^Vector2i, }),
    Create4: proc "c" (p_base: ^Rect2i,  #by_ptr p_args: struct{ x: ^Int, y: ^Int, width: ^Int, height: ^Int, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Rect2i,
    get_center:  proc "c" (p_base: ^Rect2i, p_args: rawptr = nil, r_return: ^Vector2i, p_argument_count: i64 = 0),
    get_area:  proc "c" (p_base: ^Rect2i, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    has_area:  proc "c" (p_base: ^Rect2i, p_args: rawptr = nil, r_return: ^Bool, p_argument_count: i64 = 0),
    has_point:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ point: ^Vector2i, }, r_return: ^Bool, p_argument_count: i64 = 1),
    intersects:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ b: ^Rect2i, }, r_return: ^Bool, p_argument_count: i64 = 1),
    encloses:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ b: ^Rect2i, }, r_return: ^Bool, p_argument_count: i64 = 1),
    intersection:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ b: ^Rect2i, }, r_return: ^Rect2i, p_argument_count: i64 = 1),
    merge:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ b: ^Rect2i, }, r_return: ^Rect2i, p_argument_count: i64 = 1),
    expand:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ to: ^Vector2i, }, r_return: ^Rect2i, p_argument_count: i64 = 1),
    grow:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ amount: ^Int, }, r_return: ^Rect2i, p_argument_count: i64 = 1),
    grow_side:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ side: ^Int, amount: ^Int, }, r_return: ^Rect2i, p_argument_count: i64 = 2),
    grow_individual:  proc "c" (p_base: ^Rect2i, #by_ptr p_args: struct{ left: ^Int, top: ^Int, right: ^Int, bottom: ^Int, }, r_return: ^Rect2i, p_argument_count: i64 = 4),
    abs:  proc "c" (p_base: ^Rect2i, p_args: rawptr = nil, r_return: ^Rect2i, p_argument_count: i64 = 0),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Rect2i, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_EQUAL_Rect2i: proc "c" (p_left: ^Rect2i, p_right: ^Rect2i, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Rect2i: proc "c" (p_left: ^Rect2i, p_right: ^Rect2i, r_result: ^Bool),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Rect2i, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Rect2i, p_right: ^Array, r_result: ^Bool),
}
init_Rect2i_Methods :: proc(Rect2i_method_store: ^Rect2i_Methods_list) {
  Rect2i_method_store.Create0 = cast(type_of(Rect2i_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 0)
  Rect2i_method_store.Create1 = cast(type_of(Rect2i_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 1)
  Rect2i_method_store.Create2 = cast(type_of(Rect2i_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 2)
  Rect2i_method_store.Create3 = cast(type_of(Rect2i_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 3)
  Rect2i_method_store.Create4 = cast(type_of(Rect2i_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 4)
    Rect2i_method_store.get_ptr = cast(type_of(Rect2i_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.RECT2I)
  Rect2i_method_store.get_center = cast(type_of(Rect2i_method_store.get_center))Get_Builtin_Method(.RECT2I, "get_center", 3444277866)
  Rect2i_method_store.get_area = cast(type_of(Rect2i_method_store.get_area))Get_Builtin_Method(.RECT2I, "get_area", 3173160232)
  Rect2i_method_store.has_area = cast(type_of(Rect2i_method_store.has_area))Get_Builtin_Method(.RECT2I, "has_area", 3918633141)
  Rect2i_method_store.has_point = cast(type_of(Rect2i_method_store.has_point))Get_Builtin_Method(.RECT2I, "has_point", 328189994)
  Rect2i_method_store.intersects = cast(type_of(Rect2i_method_store.intersects))Get_Builtin_Method(.RECT2I, "intersects", 3434691493)
  Rect2i_method_store.encloses = cast(type_of(Rect2i_method_store.encloses))Get_Builtin_Method(.RECT2I, "encloses", 3434691493)
  Rect2i_method_store.intersection = cast(type_of(Rect2i_method_store.intersection))Get_Builtin_Method(.RECT2I, "intersection", 717431873)
  Rect2i_method_store.merge = cast(type_of(Rect2i_method_store.merge))Get_Builtin_Method(.RECT2I, "merge", 717431873)
  Rect2i_method_store.expand = cast(type_of(Rect2i_method_store.expand))Get_Builtin_Method(.RECT2I, "expand", 1355196872)
  Rect2i_method_store.grow = cast(type_of(Rect2i_method_store.grow))Get_Builtin_Method(.RECT2I, "grow", 1578070074)
  Rect2i_method_store.grow_side = cast(type_of(Rect2i_method_store.grow_side))Get_Builtin_Method(.RECT2I, "grow_side", 3191154199)
  Rect2i_method_store.grow_individual = cast(type_of(Rect2i_method_store.grow_individual))Get_Builtin_Method(.RECT2I, "grow_individual", 1893743416)
  Rect2i_method_store.abs = cast(type_of(Rect2i_method_store.abs))Get_Builtin_Method(.RECT2I, "abs", 1469025700)
  Rect2i_method_store.VARIANT_OP_NOT_ = cast(type_of(Rect2i_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .RECT2I, .NIL)
  Rect2i_method_store.VARIANT_OP_EQUAL_Rect2i = cast(type_of(Rect2i_method_store.VARIANT_OP_EQUAL_Rect2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .RECT2I, .RECT2I)
  Rect2i_method_store.VARIANT_OP_NOT_EQUAL_Rect2i = cast(type_of(Rect2i_method_store.VARIANT_OP_NOT_EQUAL_Rect2i))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .RECT2I, .RECT2I)
  Rect2i_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Rect2i_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2I, .DICTIONARY)
  Rect2i_method_store.VARIANT_OP_IN_Array = cast(type_of(Rect2i_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2I, .ARRAY)
}
