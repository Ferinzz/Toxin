package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

StringName_Methods: struct {
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}

init_StringName_Methods :: proc() {
    StringName_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING_NAME)
    StringName_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.STRING_NAME)
}

