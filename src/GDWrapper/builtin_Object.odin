#+ignore
package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

RID_Methods: struct {
	Create0: GDE.PtrConstructor,
	Create1: GDE.PtrConstructor,
    Destroy: GDE.PtrDestructor,
}

init_RID_Methods :: proc() {
	RID_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.RID, 0)
	RID_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.RID, 1)
}