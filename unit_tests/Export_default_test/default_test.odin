package default_test

import "shared:Toxin"
import "core:fmt"
import "base:runtime"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"

init:: proc ()  {
    //Register custom class.
    type_test_defaults_deets.required.registerer->self_register(.INITIALIZATION_SCENE)
    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
}

scene_tree_obj: ^GDW.Object
root_node_instance: ^GDW.Object
root:^Toxin.Object

MainLoopFrameCallback :: proc "c" () {
    context = runtime.default_context()

    //Setup an object to hold the MainLoop object.
    scene_tree_obj = GDW.getMainLoop()
    //Fetch the root of the current sceneTree
    root= GDW.getRoot()
    scene:= GDW.get_current_scene()

    //Create a class. Your extension registerations should all be done and all classes available at this point.
    //A scene is not added when running editor mode unless there is already a default scene. Check for the scene before trying to add the child to it.
    //if scene != nil {
            root_node_instance = gdAPI.ClassDB.ConstructObject(&type_test_defaults_deets.SN)
            GDW.addChild(root, &root_node_instance)
        //}

    Toxin.myMainLoopCallbacks.frame_func = MainLoopFrameCallback2
    gdAPI.RegisterMainLoopCallbacks(GDW.Library, &Toxin.myMainLoopCallbacks)
    
}
MainLoopFrameCallback2 :: proc "c" () {
    context = runtime.default_context()
}

type_test_defaults_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    fmt.println("11!!special stress test!!")
    class:= cast(^Toxin.Class_Container(type_test_defaults))Toxin.Create(p_class_user_data, p_notify_postinitialize)
    //If these are not 'created' before Godot attempts to use them the engine will panic.
        fmt.println("Iinit classsssss")
    GDW.Array_M_List.Create0(&class.class.Array)
    GDW.Dictionary_M_List.Create0(&class.class.Dictionary)
    gdAPI.Callable_Utils.CustomCreate(&class.class.Callable, {})
    //Enginer will print an error if Quaternion is not normalized. Does not prevent functionality.
    class.class.Quaternion = 1
        if class.class.Bool == false {
            fmt.println("initialized")
        }
    return class.self
}

type_test_defaults_vtable:= Toxin.Node_v_table(type_test_defaults) {
    _ready = proc "c" (self: ^Toxin.Class_Container(type_test_defaults)) {
        context = runtime.default_context()
        fmt.println("I'm ready!!")
        if self.class.Bool != false {
            fmt.println("Bool error")
        }
        if self.class.Int != 0 {
            fmt.println("Int error")
        }
        if self.class.float != 0 {
            fmt.println("float error")
        }
        if self.class.Vector2.y != 0 && self.class.Vector2.x != 0 {
            fmt.println("Vector2 error")
        }
        if self.class.Vector2i.y != 0 && self.class.Vector2i.x != 0 {
            fmt.println("Vector2i error")
        }
        if self.class.Rect2.x != 0 &&
            self.class.Rect2.y != 0 &&
            self.class.Rect2.width != 0 &&
            self.class.Rect2.height != 0 {
            fmt.println("Rect2 error")
        }
        if self.class.Rect2i.x != 0 &&
           self.class.Rect2i.y != 0 &&
           self.class.Rect2i.width != 0 &&
           self.class.Rect2i.height != 0 {
            fmt.println("Rect2i error")
        }
        if self.class.Vector3.x != 0 &&
           self.class.Vector3.y != 0 &&
           self.class.Vector3.z != 0 {
            fmt.println("Vector3 error")
        }
        if self.class.Vector3i.x != 0 &&
           self.class.Vector3i.y != 0 &&
           self.class.Vector3i.z != 0 {
            fmt.println("Vector3i error")
        }
        if self.class.Vector4.x != 0 &&
           self.class.Vector4.y != 0 &&
           self.class.Vector4.z != 0 &&
           self.class.Vector4.w != 0 {
            fmt.println("Vector4 error")
        }
        if self.class.Vector4i.x != 0 &&
           self.class.Vector4i.y != 0 &&
           self.class.Vector4i.z != 0 &&
           self.class.Vector4i.w != 0 {
            fmt.println("Vector4i error")
        }
        if self.class.Plane != {} {
            fmt.println("Plane error")
        }
        if self.class.Color != {} {
            fmt.println("Color error")
        }
        if self.class.Quaternion  != 1 {
            fmt.println("Quaternion error")
        }
        if self.class.gdstring.ptr != nil {
            fmt.println("gdstring error")
        }
        if self.class.StringName.ptr != nil {
            fmt.println("StringName error")
        }
        if self.class.NodePath.ptr != nil {
            fmt.println("NodePath error")
        }
        if self.class.RID.ptr != 0 {
            fmt.println("RID error")
        }
        if self.class.Object.proxy != nil {
            fmt.println("Object error")
        }
        if self.class.Callable == {} {
            fmt.println("Callable error")
        }
        if self.class.Signal != {} {
            fmt.println("Signal error")
        }
        if self.class.Dictionary.id == nil {
            fmt.println("Dictionary error")
        }
        if self.class.Transform2D != {} {
            fmt.println("Transform2D error")
        }
        if self.class.AABB != {} {
            fmt.println("AABB error")
        }
        if self.class.Basis != {} {
            fmt.println("Basis error:", self.class.Basis)
        }
        if self.class.Transform3D != {} {
            fmt.println("Transform3D error")
        }
        if self.class.Projection != {} {
            fmt.println("Projection error")
        }
        if self.class.Array == {} {
            fmt.println("Array error")
        }
        if self.class.PackedByteArray != {} {
            fmt.println("PackedByteArray error")
        }
        if self.class.PackedInt32Array != {} {
            fmt.println("PackedInt32Array error")
        }
        if self.class.PackedInt64Array != {} {
            fmt.println("PackedInt64Array error")
        }
        if self.class.PackedFloat32Array != {} {
            fmt.println("PackedFloat32Array error")
        }
        if self.class.PackedFloat64Array != {} {
            fmt.println("PackedFloat64Array error")
        }
        if self.class.PackedStringArray != {} {
            fmt.println("PackedStringArray error")
        }
        if self.class.PackedVector2Array != {} {
            fmt.println("PackedVector2Array error")
        }
        if self.class.PackedVector3Array != {} {
            fmt.println("PackedVector3Array error")
        }
        if self.class.PackedColorArray != {} {
            fmt.println("PackedColorArray error")
        }
        if self.class.PackedVector4Array != {} {
            fmt.println("PackedVector4Array error")
        }
    },
    _process = proc "c" (self: ^Toxin.Class_Container(type_test_defaults), p_args: ^struct{delta: ^Toxin.float}) {
        context = runtime.default_context()
        //fmt.println("error")

    }
}

type_test_defaults :: struct {
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

type_test_defaults_deets: Toxin.Class_Deets = {
    required = {
        class_struct = type_test_defaults,
        init_level = .INITIALIZATION_SCENE,
        GDClass_Index = .Node,
        registerer = {self_register = type_test_registration,},
    },
    vtable = &type_test_defaults_vtable,
    Exporter = type_test_defaults_Export,
}

type_test_registration :: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    myself:= cast(^Toxin.Class_Deets)self
    Toxin.Register(myself, init_level, Toxin.make_get_virtual_func(type_test_defaults_vtable), type_test_defaults_Init)
    fmt.println("11!!special stress test!!")
    fmt.println(myself.SN)
}

type_test_defaults_Export :: proc(className: ^Toxin.StringName) {
    Toxin.Export(className, type_test_defaults, "RID")
    Toxin.Export(className, type_test_defaults, "Object")
    Toxin.Export(className, type_test_defaults, "Callable")
    Toxin.Export(className, type_test_defaults, "Signal")
    Toxin.Export(className, type_test_defaults, "PackedByteArray")
    Toxin.Export(className, type_test_defaults, "PackedInt32Array")
    Toxin.Export(className, type_test_defaults, "PackedInt64Array")
    Toxin.Export(className, type_test_defaults, "PackedFloat32Array")
    Toxin.Export(className, type_test_defaults, "PackedFloat64Array")
    Toxin.Export(className, type_test_defaults, "PackedStringArray")
    Toxin.Export(className, type_test_defaults, "PackedVector2Array")
    Toxin.Export(className, type_test_defaults, "PackedVector3Array")
    Toxin.Export(className, type_test_defaults, "PackedColorArray")
    Toxin.Export(className, type_test_defaults, "PackedVector4Array")
    Toxin.Export(className, type_test_defaults, "Dictionary")
    Toxin.Export(className, type_test_defaults, "Array")
    Toxin.Export(className, type_test_defaults, "Bool")
    Toxin.Export(className, type_test_defaults, "Int")
    Toxin.Export(className, type_test_defaults, "float")
    Toxin.Export(className, type_test_defaults, "Vector2")
    Toxin.Export(className, type_test_defaults, "Vector2i")
    Toxin.Export(className, type_test_defaults, "Rect2")
    Toxin.Export(className, type_test_defaults, "Rect2i")
    Toxin.Export(className, type_test_defaults, "Vector3")
    Toxin.Export(className, type_test_defaults, "Vector3i")
    Toxin.Export(className, type_test_defaults, "Vector4")
    Toxin.Export(className, type_test_defaults, "Vector4i")
    Toxin.Export(className, type_test_defaults, "Color")
    Toxin.Export(className, type_test_defaults, "Plane")
    Toxin.Export(className, type_test_defaults, "Quaternion")
    Toxin.Export(className, type_test_defaults, "Transform2D")
    Toxin.Export(className, type_test_defaults, "AABB")
    Toxin.Export(className, type_test_defaults, "Basis")
    Toxin.Export(className, type_test_defaults, "Transform3D")
    Toxin.Export(className, type_test_defaults, "Projection")
    Toxin.Export(className, type_test_defaults, "gdstring")
    Toxin.Export(className, type_test_defaults, "StringName")
    Toxin.Export(className, type_test_defaults, "NodePath")
}