package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


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
}
init_Rect2_Methods :: proc(Rect2_method_store: ^Rect2_Methods_list) {
  Rect2_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 0)
  Rect2_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 1)
  Rect2_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 2)
  Rect2_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 3)
  Rect2_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2, 4)
  Rect2_method_store.get_center = GDW.Get_Builtin_Method(.RECT2, "get_center", 2428350749)
  Rect2_method_store.get_area = GDW.Get_Builtin_Method(.RECT2, "get_area", 466405837)
  Rect2_method_store.has_area = GDW.Get_Builtin_Method(.RECT2, "has_area", 3918633141)
  Rect2_method_store.has_point = GDW.Get_Builtin_Method(.RECT2, "has_point", 3190634762)
  Rect2_method_store.is_equal_approx = GDW.Get_Builtin_Method(.RECT2, "is_equal_approx", 1908192260)
  Rect2_method_store.is_finite = GDW.Get_Builtin_Method(.RECT2, "is_finite", 3918633141)
  Rect2_method_store.intersects = GDW.Get_Builtin_Method(.RECT2, "intersects", 819294880)
  Rect2_method_store.encloses = GDW.Get_Builtin_Method(.RECT2, "encloses", 1908192260)
  Rect2_method_store.intersection = GDW.Get_Builtin_Method(.RECT2, "intersection", 2282977743)
  Rect2_method_store.merge = GDW.Get_Builtin_Method(.RECT2, "merge", 2282977743)
  Rect2_method_store.expand = GDW.Get_Builtin_Method(.RECT2, "expand", 293272265)
  Rect2_method_store.get_support = GDW.Get_Builtin_Method(.RECT2, "get_support", 2026743667)
  Rect2_method_store.grow = GDW.Get_Builtin_Method(.RECT2, "grow", 39664498)
  Rect2_method_store.grow_side = GDW.Get_Builtin_Method(.RECT2, "grow_side", 4177736158)
  Rect2_method_store.grow_individual = GDW.Get_Builtin_Method(.RECT2, "grow_individual", 3203390369)
  Rect2_method_store.abs = GDW.Get_Builtin_Method(.RECT2, "abs", 3107653634)
}
