package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


Rect2_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  get_center:  GDE.PtrBuiltInMethod,
  get_area:  GDE.PtrBuiltInMethod,
  has_area:  GDE.PtrBuiltInMethod,
  has_point:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  is_finite:  GDE.PtrBuiltInMethod,
  intersects:  GDE.PtrBuiltInMethod,
  encloses:  GDE.PtrBuiltInMethod,
  intersection:  GDE.PtrBuiltInMethod,
  merge:  GDE.PtrBuiltInMethod,
  expand:  GDE.PtrBuiltInMethod,
  get_support:  GDE.PtrBuiltInMethod,
  grow:  GDE.PtrBuiltInMethod,
  grow_side:  GDE.PtrBuiltInMethod,
  grow_individual:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Rect2: GDE.PtrOperatorEvaluator,
  VARIANT_OP_MULTIPLY_Transform2D: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Rect2_Methods :: proc(Rect2_method_store: ^Rect2_Methods_list) {
  Rect2_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 0)
  Rect2_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 1)
  Rect2_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 2)
  Rect2_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 3)
  Rect2_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 4)
  Rect2_method_store.get_center = Get_Builtin_Method(.RECT2, "get_center", 2428350749)
  Rect2_method_store.get_area = Get_Builtin_Method(.RECT2, "get_area", 466405837)
  Rect2_method_store.has_area = Get_Builtin_Method(.RECT2, "has_area", 3918633141)
  Rect2_method_store.has_point = Get_Builtin_Method(.RECT2, "has_point", 3190634762)
  Rect2_method_store.is_equal_approx = Get_Builtin_Method(.RECT2, "is_equal_approx", 1908192260)
  Rect2_method_store.is_finite = Get_Builtin_Method(.RECT2, "is_finite", 3918633141)
  Rect2_method_store.intersects = Get_Builtin_Method(.RECT2, "intersects", 819294880)
  Rect2_method_store.encloses = Get_Builtin_Method(.RECT2, "encloses", 1908192260)
  Rect2_method_store.intersection = Get_Builtin_Method(.RECT2, "intersection", 2282977743)
  Rect2_method_store.merge = Get_Builtin_Method(.RECT2, "merge", 2282977743)
  Rect2_method_store.expand = Get_Builtin_Method(.RECT2, "expand", 293272265)
  Rect2_method_store.get_support = Get_Builtin_Method(.RECT2, "get_support", 2026743667)
  Rect2_method_store.grow = Get_Builtin_Method(.RECT2, "grow", 39664498)
  Rect2_method_store.grow_side = Get_Builtin_Method(.RECT2, "grow_side", 4177736158)
  Rect2_method_store.grow_individual = Get_Builtin_Method(.RECT2, "grow_individual", 3203390369)
  Rect2_method_store.abs = Get_Builtin_Method(.RECT2, "abs", 3107653634)
  Rect2_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .RECT2, .NIL)
  Rect2_method_store.VARIANT_OP_EQUAL_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .RECT2, .RECT2)
  Rect2_method_store.VARIANT_OP_NOT_EQUAL_Rect2 = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .RECT2, .RECT2)
  Rect2_method_store.VARIANT_OP_MULTIPLY_Transform2D = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .RECT2, .TRANSFORM2D)
  Rect2_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2, .DICTIONARY)
  Rect2_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .RECT2, .ARRAY)
}
