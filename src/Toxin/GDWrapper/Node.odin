package GDWrapper

import sics "base:intrinsics"

Node_Input :: proc (Node_methods: ^$T) {
    mb:^MethodBind
    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_name", 2002593661))
    Node_methods.get_name = cast(sics.type_field_type(T, "get_name"))make_generic_methodbind_call(sics.type_field_type(T, "get_name"), mb)

    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "set_name", 3304788590))
    Node_methods.set_name = cast(sics.type_field_type(T, "set_name"))make_generic_methodbind_call(sics.type_field_type(T, "set_name"), mb)

    mb = (cast(^MethodBind)classDBGetMethodBind3(.Node, "get_child_count", 894402480))
    Node_methods.get_child_count = cast(sics.type_field_type(T, "get_child_count"))make_generic_methodbind_call(sics.type_field_type(T, "get_child_count"), mb)
}