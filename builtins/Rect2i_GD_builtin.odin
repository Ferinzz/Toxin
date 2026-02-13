package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Rect2i_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  get_center:  GDE.PtrBuiltInMethod,
  get_area:  GDE.PtrBuiltInMethod,
  has_area:  GDE.PtrBuiltInMethod,
  has_point:  GDE.PtrBuiltInMethod,
  intersects:  GDE.PtrBuiltInMethod,
  encloses:  GDE.PtrBuiltInMethod,
  intersection:  GDE.PtrBuiltInMethod,
  merge:  GDE.PtrBuiltInMethod,
  expand:  GDE.PtrBuiltInMethod,
  grow:  GDE.PtrBuiltInMethod,
  grow_side:  GDE.PtrBuiltInMethod,
  grow_individual:  GDE.PtrBuiltInMethod,
  abs:  GDE.PtrBuiltInMethod,
}
init_Rect2i_Methods :: proc(Rect2i_method_store: ^Rect2i_Methods_list) {
  Rect2i_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 0)
  Rect2i_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 1)
  Rect2i_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 2)
  Rect2i_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 3)
  Rect2i_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.RECT2I, 4)
  Rect2i_method_store.get_center = GDW.Get_Builtin_Method(.RECT2I, "get_center", 3444277866)
  Rect2i_method_store.get_area = GDW.Get_Builtin_Method(.RECT2I, "get_area", 3173160232)
  Rect2i_method_store.has_area = GDW.Get_Builtin_Method(.RECT2I, "has_area", 3918633141)
  Rect2i_method_store.has_point = GDW.Get_Builtin_Method(.RECT2I, "has_point", 328189994)
  Rect2i_method_store.intersects = GDW.Get_Builtin_Method(.RECT2I, "intersects", 3434691493)
  Rect2i_method_store.encloses = GDW.Get_Builtin_Method(.RECT2I, "encloses", 3434691493)
  Rect2i_method_store.intersection = GDW.Get_Builtin_Method(.RECT2I, "intersection", 717431873)
  Rect2i_method_store.merge = GDW.Get_Builtin_Method(.RECT2I, "merge", 717431873)
  Rect2i_method_store.expand = GDW.Get_Builtin_Method(.RECT2I, "expand", 1355196872)
  Rect2i_method_store.grow = GDW.Get_Builtin_Method(.RECT2I, "grow", 1578070074)
  Rect2i_method_store.grow_side = GDW.Get_Builtin_Method(.RECT2I, "grow_side", 3191154199)
  Rect2i_method_store.grow_individual = GDW.Get_Builtin_Method(.RECT2I, "grow_individual", 1893743416)
  Rect2i_method_store.abs = GDW.Get_Builtin_Method(.RECT2I, "abs", 1469025700)
}
