package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


bool_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
}
init_bool_Methods :: proc(bool_method_store: ^bool_Methods_list) {
  bool_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 0)
  bool_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 1)
  bool_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 2)
  bool_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.BOOL, 3)
}
