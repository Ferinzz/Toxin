package GDWrapper

import sics "base:intrinsics"

Node_Input :: proc (Node_methods: ^$T, loc := #caller_location) {
    mb:^MethodBind
    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_name", 2002593661, loc))
    Node_methods.get_name = cast(sics.type_field_type(T, "get_name"))make_generic_methodbind_call(sics.type_field_type(T, "get_name"), mb, loc)

    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "set_name", 3304788590, loc))
    Node_methods.set_name = cast(sics.type_field_type(T, "set_name"))make_generic_methodbind_call(sics.type_field_type(T, "set_name"), mb, loc)

    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_child_count", 894402480, loc))
    Node_methods.get_child_count = cast(sics.type_field_type(T, "get_child_count"))make_generic_methodbind_call(sics.type_field_type(T, "get_child_count"), mb, loc)
}

Node_Input_ :: proc (Node_methods: ^Node_MethodBind_List, loc := #caller_location) {

    Node_methods.get_name = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_name", 2002593661, loc))
    Node_methods.set_name = (cast(^MethodBind)classDBGetMethodBind3(.Node, "set_name", 3304788590, loc))
    Node_methods.get_child_count = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_child_count", 894402480, loc))
}


Node_MethodBind_List:: struct {
    set_name: ^MethodBind,
    get_name: ^MethodBind,
    get_child_count: ^MethodBind,
}