package builtin_parser

import "core:encoding/json"
import "core:os/os2"
import "core:fmt"
import "base:runtime"
import "core:strings"
import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:bytes"
//import "../builtins"

main :: proc() {
    root, error := os2.get_absolute_path("builtin_parser\\example.json", context.allocator)
    if error != nil {
        print_warning("error getting root.", error)
        return
    }
    fmt.println(root)
    //data, err := os2.read_entire_file(root, context.allocator)
    data, err := os2.read_entire_file("C:\\Odin_programs\\toxin_new_pull\\extension_api.json", context.allocator)
    
    if err != nil {
        print_warning("file could not be read: ", err)
    }
    val:=json.make_parser(data)
    built_different: builtin
    json.unmarshal(data, &built_different)
    buildem, err_buildem:= strings.builder_make()
    if err_buildem != nil {
        print_warning("failed to create builder", err_buildem)
    }
    final:=build_init_proc(built_different, context.allocator)
/*
    header:=`package builtins

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


`
    for classes in final {
        //fmt.println(classes.method_list)
        //fmt.println(classes.init_proc)
        //fmt.println(classes.constants)

        file_path:= fmt.aprintf("C:\\Odin_programs\\toxin_new_pull\\builtins\\%s_GD_builtin.odin", classes.name)
        file, open_err:= os2.create(file_path)
        if open_err == nil {
            count, write_err:= os2.write_strings(file, header, classes.method_list, classes.constants, classes.init_proc)
            fmt.println("wrote: ", count, write_err)
        } else {
            print_warning("could not open file_path", open_err)
        }
        delete(file_path)
    }
*/
}

print_warning:: proc(message: string, error: os2.Error) {
    fmt.println(message, error)
}

builtin:: struct {
    classes: []struct {
		name: string,
		is_refcounted: bool,
		is_instantiable: bool,
        api_type: string, //Only core or editor
		constants: []struct
				{
					name: string,
					type: string,
					value: int,
				},
        enums: []struct {
            name: string,
            is_bitfield: bool,
            values: [] struct {
					name: string,
					value: int,
            }
        },
        methods: []methods,
        signals: []signal,
        properties:[]property,
}};
signal:: struct {
    name:string,
    arguments:[]struct {
        name:string,
        type:string,
    }
}
methods:: struct {
    name: string,
	is_const: bool,
	is_static: bool,
    is_required: bool,
    is_vararg: bool,
    is_virtual: bool,
	hash: int,
    return_value: struct {
        type: string, //"typedarray::StringName" internally screaming
        meta: string,
    },
	arguments: []struct {
			name: string,
			type: string,
            meta: string,
			default_value: string,
    }
}
property::struct{
    type:string,
    name:string,
    setter:string,
    getter:string,
}

builtin_set :: struct {
    name: string,
    init_proc: string,
    method_list: string,
    constants: string,
    properties: string,
    properties_init: string,
}


build_init_proc :: proc(json_data: builtin, ctx: runtime.Allocator) -> ([dynamic]builtin_set) {
    
    builtin_map:= make([dynamic]builtin_set, ctx)

    ///////////////////////////////
    // Structure of the init proc
    ///////////////////////////////
    class_decl:=`%s :: ^Object`
    init_proc_sig:=`%s_Init_ :: proc (%[0]s_methods: ^%[0]s_MethodBind_List, loc := #caller_location) {{`
    //name, name, name
    Meth_Getter:=`  %s_methods.%s = (cast(^MethodBind)classDBGetMethodBind3(.%s, "%s", %v, loc))`
    //name, method.name, variant_type, method.name, hash
    Closing:=`}`

    /////////////////////////////
    // Structure of the builtin struct
    /////////////////////////////
    _MethodBind_List:= `%s_MethodBind_List :: struct {{` //name
    class_name:= `  %s: ^MethodBind,` //method.name

    ////////////////////////////
    // Convert the unmarshalled json to Odin procs and structs
    ////////////////////////////
    for BUILT_FROM, idx in json_data.classes {
        init_builder:=strings.builder_make(ctx)
        struct_builder:=strings.builder_make(ctx)
        consts_builder:=strings.builder_make(ctx)
        props_builder:=strings.builder_make(ctx)
        props_init_builder:=strings.builder_make(ctx)

        variant_type:GDE.VariantType= Get_Variant_Type_From_String(BUILT_FROM.name)
        buffer:[250]u8
        //signature and struct declaration
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], init_proc_sig, BUILT_FROM.name, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], _MethodBind_List, BUILT_FROM.name, newline =true))

        //setup Methods
        if len(BUILT_FROM.methods) > 0 {
        for &method, idx in BUILT_FROM.methods {
            if method.is_virtual do continue
            if method.name == "any" { 
                delete(method.name)
                method.name = "gdany"
            }
            if method.name == "map" { 
                delete(method.name)
                method.name = "gdmap"
            }
            strings.write_string(&init_builder, fmt.bprintf(buffer[:], Meth_Getter, BUILT_FROM.name, method.name, BUILT_FROM.name, method.name, method.hash, newline =true))
            strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_name, method.name, newline =true))
        }
        }
        //pinch it off
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], Closing, newline =true))


        //Constants are just floating around
        //Constants only exist for compound types such as vec2, basis etc.
        consts:= `%s_Constants :: enum {{`
        consts_value:= `  %s= %v,`
        if len(BUILT_FROM.constants) > 0 {
            strings.write_string(&consts_builder, fmt.bprintf(buffer[:], consts, BUILT_FROM.name, newline =true))
            for constants in BUILT_FROM.constants {
                strings.write_string(&consts_builder, fmt.bprintf(buffer[:], consts_value, constants.name, constants.value, newline =true))
            }
            strings.write_string(&consts_builder, fmt.bprintf(buffer[:], Closing, newline =true))
            //fmt.println(strings.to_string(consts_builder))
        }

        //Properties
        propetry_header:= `%s_properties :: struct {{`
        property_value:= `  %s_%s :: struct {{
    %s: proc "c" (p_base: %[0]s r_value: ^%[1]s),
    %s: proc "c" (p_base: %[0]s, p_value: ^%[1]s),
  }`
        property_init:= `%[0]s_init_props :: proc(%[0]s_prop: ^%[0]s_properties, loc:= #caller_location) {{`
        property_methodbind:= `
  %s_prop.%[1]s_%[3]s.%[4]s = GDW.Get_Method_Getter(.%[2]s, %[1]s)
  %[0]s_prop.%[1]s_%[3]s.%[5]s = GDW.Get_Method_Setter(.%[2]s, %[1]s)`
        if len(BUILT_FROM.properties) > 0 {
            strings.write_string(&props_builder, fmt.bprintf(buffer[:], propetry_header, BUILT_FROM.name, newline =true))
            strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_init, BUILT_FROM.name, newline =true))
            for &properties in BUILT_FROM.properties {
                strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind, BUILT_FROM.name, properties.name, Get_Variant_Type_From_String(properties.type), properties.type, properties.getter, properties.setter, newline =true))
                switch properties.type {
                    case "int":
                        delete(properties.type)
                        properties.type = "Int"
                    case "String":
                        delete(properties.type)
                        properties.type = "gdstring"
                    case "bool":
                        delete(properties.type)
                        properties.type = "Bool"
                    case "Nil":
                        delete(properties.type)
                        properties.type = "nil"
                }
                strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value, properties.name, properties.type, properties.getter, properties.setter, newline =true))
            }
            strings.write_string(&props_builder, fmt.bprintf(buffer[:], Closing, newline =true))
            strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
            //fmt.println(strings.to_string(props_builder))
            fmt.println(strings.to_string(props_init_builder))
        }

        //fmt.println(strings.to_string(init_builder))
        //fmt.println(strings.to_string(struct_builder))
        //fmt.println(BUILT_FROM.name)
        append(&builtin_map, builtin_set{BUILT_FROM.name, strings.to_string(init_builder), strings.to_string(struct_builder), strings.to_string(consts_builder), strings.to_string(props_builder), strings.to_string(props_init_builder)})
        //strings.builder_reset(&init_builder)
        //strings.builder_reset(&struct_builder)
        //fmt.println(builtin_map[idx].init_proc)
    }
    
    return builtin_map
}

Get_Variant_Type_From_String :: proc(className: string) -> GDE.VariantType {
    switch className {
        case "Nil", "nil" :
            return .NIL
        case "bool", "Bool" :
            return .BOOL
        case "int", "Int" :
	        return .INT
        case "float" :
	        return .FLOAT
        case "String", "gdstring" :
	        return .STRING
        case "Vector2" :
	        return .VECTOR2
        case "Vector2i" :
	        return .VECTOR2I
        case "Rect2" :
	        return .RECT2
        case "Rect2i" :
	        return .RECT2I
        case "Vector3" :
	        return .VECTOR3
        case "Vector3i" :
	        return .VECTOR3I
        case "Transform2D" :
	        return .TRANSFORM2D
        case "Vector4" :
	        return .VECTOR4
        case "Vector4i" :
	        return .VECTOR4I
        case "Plane" :
	        return .PLANE
        case "Quaternion" :
	        return .QUATERNION
        case "AABB" :
	        return .AABB
        case "Basis" :
	        return .BASIS
        case "Transform3D" :
	        return .TRANSFORM3D
        case "Projection" :
	        return .PROJECTION
        case "Color":
            return .COLOR
        case "StringName" :
            return .STRING_NAME
        case "NodePath" :
            return .NODE_PATH
        case "RID" :
            return .RID
        case "Callable" :
            return .CALLABLE
        case "Signal" :
            return .SIGNAL
        case "Dictionary" :
            return .DICTIONARY
        case "Array" :
            return .ARRAY
        case "PackedByteArray" :
            return .PACKED_BYTE_ARRAY
        case "PackedInt32Array" :
            return .PACKED_INT32_ARRAY
        case "PackedInt64Array" :
            return .PACKED_INT64_ARRAY
        case "PackedFloat32Array" :
            return .PACKED_FLOAT32_ARRAY
        case "PackedFloat64Array" :
            return .PACKED_FLOAT64_ARRAY
        case "PackedStringArray" :
            return .PACKED_STRING_ARRAY
        case "PackedVector2Array" :
            return .PACKED_VECTOR2_ARRAY
        case "PackedVector3Array" :
            return .PACKED_VECTOR3_ARRAY
        case "PackedColorArray" :
            return .PACKED_COLOR_ARRAY
        case "PackedVector4Array" :
            return .PACKED_VECTOR4_ARRAY
        case "Object" :
            return .OBJECT
        case "Variant" :
            return .VARIANT_MAX
        case :
            return .NIL
    }
}

Which_Ops :: proc(opsName: string) -> GDE.VariantOperator {
    switch opsName {
        case "==":
            return .VARIANT_OP_EQUAL
        case "!=":
            return .VARIANT_OP_NOT_EQUAL
        case "unary-":
            return .VARIANT_OP_NEGATE
        case "unary+":
            return .VARIANT_OP_POSITIVE
        case "~":
            return .VARIANT_OP_BIT_NEGATE
        case "and":
            return .VARIANT_OP_AND
        case "or":
            return .VARIANT_OP_OR
        case "xor":
            return .VARIANT_OP_XOR
        case "not":
            return .VARIANT_OP_NOT
        case "<":
            return .VARIANT_OP_LESS
        case "<=":
            return .VARIANT_OP_LESS_EQUAL
        case ">":
            return .VARIANT_OP_GREATER
        case ">=":
            return .VARIANT_OP_GREATER_EQUAL
        case "+":
            return .VARIANT_OP_ADD
        case "-":
            return .VARIANT_OP_SUBTRACT
        case "*":
            return .VARIANT_OP_MULTIPLY
        case "/":
            return .VARIANT_OP_DIVIDE
        case "%":
            return .VARIANT_OP_MODULE
        case "**":
            return .VARIANT_OP_POWER
        case "<<":
            return .VARIANT_OP_SHIFT_LEFT
        case ">>":
            return .VARIANT_OP_SHIFT_RIGHT
        case "&":
            return .VARIANT_OP_BIT_AND
        case "|":
            return .VARIANT_OP_BIT_OR
        case "^":
            return .VARIANT_OP_BIT_XOR
        case "in" :
            return .VARIANT_OP_IN
        case :
            return .VARIANT_OP_MAX
    }
    return .VARIANT_OP_MAX
}

Reserved_Odin_Types :=[?]string {"map","any"}