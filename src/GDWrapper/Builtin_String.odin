package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


String_Methods: struct {
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}

init_String_Methods :: proc() {
    String_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING, .STRING)
    String_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING)
}
