package type_tests

import "shared:GDWrapper/gdAPI"
import "shared:Toxin"
import "base:runtime"
import sics "base:intrinsics"
import GDW "shared:GDWrapper"

type_test :: struct {
    Bool: Toxin.Bool,
    Int: Toxin.Int,
    float: Toxin.float,
    Vector2: Toxin.Vector2,
    Vector2i: Toxin.Vector2i,
    Rect2: Toxin.Rect2,
    Rect2i: Toxin.Rect2i,
    Vector3: Toxin.Vector3,
    Vector3i: Toxin.Vector3i,
    Vector4: Toxin.Vector4,
    Vector4i: Toxin.Vector4i,
    Plane: Toxin.Plane,
    Color: Toxin.Color,
    Quaternion: Toxin.Quaternion,
    gdstring: Toxin.gdstring, // RefCounted
    StringName: Toxin.StringName, // RefCounted
    NodePath: Toxin.NodePath, // RefCounted
    RID: Toxin.RID,
    Object: Toxin.Object, // RefCounted
    Callable: Toxin.Callable, // RefCounted
    Signal: Toxin.Signal, // RefCounted
    Dictionary: Toxin.Dictionary, //Godot: construct dict, ref count dict, copy class ptr.
    Transform2D: Toxin.Transform2D, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    AABB: Toxin.AABB, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Basis: Toxin.Basis, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Transform3D: Toxin.Transform3D, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Projection: Toxin.Projection, //Godot: bucket alloc cleaned by Godot if sent by Godot.
    Array: Toxin.Array, //Godot: create then loop through to alloc each value.
    PackedByteArray: Toxin.PackedByteArray, //Godot: create
    PackedInt32Array: Toxin.PackedInt32Array, //Godot: create
    PackedInt64Array: Toxin.PackedInt64Array, //Godot: create
    PackedFloat32Array: Toxin.PackedFloat32Array, //Godot: create
    PackedFloat64Array: Toxin.PackedFloat64Array, //Godot: create
    PackedStringArray: Toxin.PackedStringArray, //Godot: create
    PackedVector2Array: Toxin.PackedVector2Array, //Godot: create
    PackedVector3Array: Toxin.PackedVector3Array, //Godot: create
    PackedColorArray: Toxin.PackedColorArray, //Godot: create
    PackedVector4Array: Toxin.PackedVector4Array, //Godot: create
}

type_test_deets: Toxin.Class_Deets = {
    required = {
        class_struct = type_test,
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Node,
        registerer = {self_register = type_test_registration,},
    },
    vtable = &type_test_vtable,
    Exporter = type_test_Export,
}

type_test_registration :: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    myself:= cast(^Toxin.Class_Deets)self
    Toxin.Register(myself, init_level, Toxin.make_get_virtual_func(type_test_vtable), type_test_Init)
}

type_test_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(type_test))Toxin.Create(p_class_user_data, p_notify_postinitialize)
    //If these are not 'created' before Godot attempts to use them the engine will panic.
    GDW.Array_M_List.Create0(&class.class.Array)
    GDW.Dictionary_M_List.Create0(&class.class.Dictionary)
    gdAPI.Callable_Utils.CustomCreate(&class.class.Callable, {})
    //Enginer will print an error if Quaternion is not normalized. Does not prevent functionality.
    class.class.Quaternion = 1
    return class.self
}

type_test_vtable:= Toxin.Node_v_table(type_test) {
    _process = proc "c" (self: ^Toxin.Class_Container(type_test), p_args: ^struct{delta: ^Toxin.float}) {

    }
}

type_test_Export :: proc(className: ^Toxin.StringName) {
    Toxin.Export(className, type_test, "RID")
    Toxin.Export(className, type_test, "Object")
    Toxin.Export(className, type_test, "Callable")
    Toxin.Export(className, type_test, "Signal")
    Toxin.Export(className, type_test, "PackedByteArray")
    Toxin.Export(className, type_test, "PackedInt32Array")
    Toxin.Export(className, type_test, "PackedInt64Array")
    Toxin.Export(className, type_test, "PackedFloat32Array")
    Toxin.Export(className, type_test, "PackedFloat64Array")
    Toxin.Export(className, type_test, "PackedStringArray")
    Toxin.Export(className, type_test, "PackedVector2Array")
    Toxin.Export(className, type_test, "PackedVector3Array")
    Toxin.Export(className, type_test, "PackedColorArray")
    Toxin.Export(className, type_test, "PackedVector4Array")
    Toxin.Export(className, type_test, "Dictionary")
    Toxin.Export(className, type_test, "Array")
    Toxin.Export(className, type_test, "Bool")
    Toxin.Export(className, type_test, "Int")
    Toxin.Export(className, type_test, "float")
    Toxin.Export(className, type_test, "Vector2")
    Toxin.Export(className, type_test, "Vector2i")
    Toxin.Export(className, type_test, "Rect2")
    Toxin.Export(className, type_test, "Rect2i")
    Toxin.Export(className, type_test, "Vector3")
    Toxin.Export(className, type_test, "Vector3i")
    Toxin.Export(className, type_test, "Vector4")
    Toxin.Export(className, type_test, "Vector4i")
    Toxin.Export(className, type_test, "Color")
    Toxin.Export(className, type_test, "Plane")
    Toxin.Export(className, type_test, "Quaternion")
    Toxin.Export(className, type_test, "Transform2D")
    Toxin.Export(className, type_test, "AABB")
    Toxin.Export(className, type_test, "Basis")
    Toxin.Export(className, type_test, "Transform3D")
    Toxin.Export(className, type_test, "Projection")
    Toxin.Export(className, type_test, "gdstring")
    Toxin.Export(className, type_test, "StringName")
    Toxin.Export(className, type_test, "NodePath")
}