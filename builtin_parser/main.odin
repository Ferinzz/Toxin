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
    val:=json.make_parser(data)
    built_different: builtin
    json.unmarshal(data, &built_different)
    fmt.println(built_different.builtin_classes[1])
    buildem, err_buildem:= strings.builder_make()
    if err_buildem != nil {
        print_warning("failed to create builder")
    }
    build_init_proc(built_different, context.allocator)
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
build_init_proc :: proc(json_data: builtin, ctx: runtime.Allocator) -> (string, string) {
    init_builder:=strings.builder_make(ctx)
    struct_builder:=strings.builder_make(ctx)
    ///////////////////////////////
    // Structure of the init proc
    //////////////////////////////
    init_proc_sig:=`init_%s_Methods :: proc(%[0]s_method_store: %[0]s_Methods_list) {{`
    //name
    Destructors:=`  %s_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(%w)`
    //name, variant_type
    Creators:=`  %s_method_store.Create%[1]v = gdAPI.Variant_Utils.GetPtrConstructor(.%s, %[1]v)`
    //name, index, variant_type
    Meth_Getter:=`  %s_method_store.%[2]s = Get_Builtin_Method(%[1]w, %[2]s, %v)`
    //name ,variant_type, methods[i].name, methods[i].hash
    Closing:=`}`

    /////////////////////////////
    // Structure of the builtin struct
    /////////////////////////////
    bltn_struct_declare:= `%s_Methods_list :: struct {{` //builtin name
    bltn_creator:= `  Create%v: GDE.PtrConstructor,` //index of Creator
    bltn_destructor:= `  Destroy: GDE.PtrDestructor,` //Include if Destructor true
    bltn_method:= `  %s:  GDE.PtrBuiltInMethod,` //Name of method: methods.name


    ////////////////////////////
    // Convert the unmarshalled json to Odin procs and structs
    ////////////////////////////

    BUILT_FROM:= &json_data.builtin_classes[0]
    variant_type:VariantType=.STRING
    buffer:[200]u8
    //Openers
    strings.write_string(&init_builder, fmt.bprintf(buffer[:], init_proc_sig, BUILT_FROM.name, newline =true))
    strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_struct_declare, BUILT_FROM.name, newline =true))

    //setup Constructors
    for creation, idx in BUILT_FROM.constructors {
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Creators, BUILT_FROM.name, idx, variant_type, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_creator, idx, newline =true))
    }

    //setup Destructors iff the builtin has one
    if BUILT_FROM.has_destructor {
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Destructors, BUILT_FROM.name, variant_type, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_destructor, newline =true))
    }

    //setup Methods
    for method, idx in BUILT_FROM.methods {
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Meth_Getter, BUILT_FROM.name, variant_type, method.name, method.hash, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_method, method.name, newline =true))
    }

    //pinch it off
    strings.write_string(&init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
    strings.write_string(&struct_builder, fmt.bprintf(buffer[:], Closing, newline =true))

    fmt.println(strings.to_string(init_builder))
    fmt.println(strings.to_string(struct_builder))
    return strings.to_string(init_builder), strings.to_string(struct_builder)
}

VariantType :: enum i32 {
	NIL,

	/*  atomic types */
	BOOL,
	INT,
	FLOAT,
	STRING,

	/* math types */
	VECTOR2,
	VECTOR2I,
	RECT2,
	RECT2I,
	VECTOR3,
}