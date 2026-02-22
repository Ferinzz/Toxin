package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


float_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
}
init_float_Methods :: proc(float_method_store: ^float_Methods_list) {
  float_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 0)
  float_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 1)
  float_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 2)
  float_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 3)
  float_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.FLOAT, 4)
}
