package type_tests

import "shared:Toxin"
import "base:runtime"

type_test_class :: struct {

}

type_test_deets:= Toxin.Class_Deets {
    class_struct = type_test_class,
    init_level = .INITIALIZATION_SCENE,
    GDClass_Index = .Node,
    vtable = &type_test_vtable,
    binder = type_test_Export,
}

type_test_registration :: proc(self: ^Toxin.Registerer, init_level: Toxin.InitializationLevel) {
    myself:= cast(^Toxin.Class_Deets)self
    Toxin.Register(myself, init_level, Toxin.make_get_virtual_func(type_test_vtable), type_test_Init)
}

type_test_Init :: proc "c" (p_class_user_data: ^Toxin.Class_Deets, p_notify_postinitialize: Toxin.Bool) -> (^Toxin.Object) {
    context = runtime.default_context()
    class:= cast(^Toxin.Class_Container(type_test_class))Toxin.Create(p_class_user_data, p_notify_postinitialize)
    return cast(^Toxin.Object)class
}

type_test_vtable:= Toxin.Node_v_table(type_test_class) {
    _process = proc "c" (self: ^Toxin.Class_Container(type_test_class), p_args: ^struct{delta: ^Toxin.float}) {

    }
}

type_test_Export :: proc(className: ^Toxin.StringName) {

}