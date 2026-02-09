package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"


AABB_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}
Basis_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}
Transform3D_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}
Transform2D_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}
Projection_Methods: struct {
    Create0: GDE.PtrConstructor,
    Create1: GDE.PtrConstructor,
    Compare: GDE.PtrOperatorEvaluator,
    Destroy: GDE.PtrDestructor,
}

init_Small_Arrays :: proc() {
    NodePath_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 0)
    NodePath_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.NODE_PATH, 1)
    AABB_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 0)
    AABB_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.AABB, 1)
    AABB_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .AABB, .AABB)
    AABB_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.AABB)

    Basis_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 0)
    Basis_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.BASIS, 1)
    Basis_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .BASIS, .BASIS)
    Basis_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.BASIS)

    Transform3D_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 0)
    Transform3D_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM3D, 1)
    Transform3D_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM3D, .TRANSFORM3D)
    Transform3D_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.TRANSFORM3D)

    Transform2D_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 0)
    Transform2D_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.TRANSFORM2D, 1)
    Transform2D_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .TRANSFORM2D, .TRANSFORM2D)
    Transform2D_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.TRANSFORM2D)

    Projection_Methods.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 0)
    Projection_Methods.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.PROJECTION, 1)
    Projection_Methods.Compare = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .PROJECTION, .PROJECTION)
    Projection_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.PROJECTION)
}
