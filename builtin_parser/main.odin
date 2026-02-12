package builtin_parser

import "core:encoding/json"
import "core:os/os2"
import "core:fmt"
import "base:runtime"
import "core:strings"

main :: proc() {
    root, error := os2.get_absolute_path("builtin_parser\\example.json", context.allocator)
    if error != nil {
        fmt.println("error getting root.")
        return
    }
    fmt.println(root)
    data, err := os2.read_entire_file(root, context.allocator)
    fmt.println(err)
    //fmt.println(string(data[:]))
    val:=json.make_parser(data)
    //first, err_first:=json.parse(data)
    //fmt.println(first, err_first)
    //fmt.println(first.(json.Object)["builtin_classes"].(json.Array)[0].(json.Object)["name"])
    built_different: builtin
    json.unmarshal(data, &built_different)
    fmt.println(built_different.builtin_classes[1])
    buildem, err_buildem:= strings.builder_make()
    if err_buildem != nil {
        print_warning("failed to create builder")
    }
}

print_warning:: proc(message: string) {
    fmt.println(message)
}

builtin:: struct {
    builtin_classes: []struct {
		name: string,
		indexing_return_type: string,
		is_keyed: bool,
		constants: []struct
				{
					name: string,
					type: string,
					value: string,
				},
        ops: []operators,
        methods: []methods,
        constructors: []struct {
            index: int,
			arguments: [] struct {
						name: string,
						type: string
					}
            },
        has_destructor: bool,
}};
operators :: struct {
	name: string,
	right_type: string,
	return_type: string
}
methods:: struct {
    name: string,
	return_type: string,
	is_vararg: bool,
	is_const: bool,
	is_static: bool,
	hash: int,
	arguments: []struct {
			name: string,
			type: string
}
}
build_init_proc :: proc(json_data: ^builtin, ctx: runtime.Allocator) -> string {
x:=`init_%s_Methods :: proc() {`
//name
y:=`    String_Methods.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.%s)`
//variant_type
    
z:=`
}`

t:=`    String_Methods.Create%[0,v] = gdAPI.Variant_Utils.GetPtrConstructor(.%s, %[0,v])`
//index, variant_type
u:=`   String_Methods.%[1,%s] = Get_Builtin_Method(.%s, %s, %v)`
//,variant_type, methods[i].name, methods[i].hash
return t
}