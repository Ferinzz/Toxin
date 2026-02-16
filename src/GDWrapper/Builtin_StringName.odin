#+ignore
package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

StringName_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}

init_StringName_Methods :: proc() {
    StringName_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 0)
    StringName_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.STRING_NAME, 1)
    StringName_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING_NAME)
    StringName_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING_NAME)
}

