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

//TODO!! keyed getter/setter

main :: proc() {
    root, error := os2.get_absolute_path("builtin_parser\\example.json", context.allocator)
    if error != nil {
        print_warning("error getting root.", error)
        return
    }
    fmt.println(root)
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

}

print_warning:: proc(message: string, error: os2.Error) {
    fmt.println(message, error)
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
        operators: []operators,
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

builtin_set :: struct {
    name: string,
    init_proc: string,
    method_list: string,
    constants: string,
}

build_init_proc :: proc(json_data: builtin, ctx: runtime.Allocator) -> ([dynamic]builtin_set) {
    
    builtin_map:= make([dynamic]builtin_set, ctx)

    ///////////////////////////////
    // Structure of the init proc
    ///////////////////////////////
    init_proc_sig:=`init_%s_Methods :: proc(%[0]s_method_store: ^%[0]s_Methods_list) {{`
    //name
    Creators:=`  %s_method_store.Create%[1]v = gdAPI.Variant_Utils.GetPtrConstructor(.%s, %[1]v)`
    //name, index, variant_type
    Destructors:=`  %s_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.%v)`
    //name, variant_type
    op_eval:= `  %s_method_store.%s_%s = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.%[1]v, .%v, .%v)`
    //name, eval_enum, variant_type
    Meth_Getter:=`  %s_method_store.%[2]s = GDW.Get_Builtin_Method(.%[1]v, "%[2]s", %v)`
    //name ,variant_type, methods[i].name, methods[i].hash
    Closing:=`}`

    /////////////////////////////
    // Structure of the builtin struct
    /////////////////////////////
    bltn_struct_declare:= `%s_Methods_list :: struct {{` //builtin name
    bltn_creator:= `  Create%v: GDE.PtrConstructor,` //index of Creator
    bltn_destructor:= `  Destroy: GDE.PtrDestructor,` //Include if Destructor true
    bltn_method:= `  %s:  GDE.PtrBuiltInMethod,` //Name of method: methods.name
    bltn_ops:= `  %s_%s: GDE.PtrOperatorEvaluator,`

    ////////////////////////////
    // Convert the unmarshalled json to Odin procs and structs
    ////////////////////////////
    for BUILT_FROM, idx in json_data.builtin_classes {
        init_builder:=strings.builder_make(ctx)
        struct_builder:=strings.builder_make(ctx)
        consts_builder:=strings.builder_make(ctx)
        variant_type:GDE.VariantType= Get_Variant_Type_From_String(BUILT_FROM.name)
        buffer:[250]u8
        //signature and struct declaration
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
        for &method, idx in BUILT_FROM.methods {
            if method.name == "any" { 
                delete(method.name)
                method.name = "gdany"
            }
            if method.name == "map" { 
                delete(method.name)
                method.name = "gdmap"
            }
            strings.write_string(&init_builder, fmt.bprintf(buffer[:], Meth_Getter, BUILT_FROM.name, variant_type, method.name, method.hash, newline =true))
            strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_method, method.name, newline =true))
        }
        
        #partial switch variant_type {
            case .STRING_NAME,
            .INT,
            .NODE_PATH,
            .RID,
            .CALLABLE,
            .SIGNAL,
            .DICTIONARY,
            .ARRAY,
            .PACKED_BYTE_ARRAY,
            .PACKED_INT32_ARRAY,
            .PACKED_INT64_ARRAY,
            .PACKED_FLOAT32_ARRAY,
            .PACKED_FLOAT64_ARRAY,
            .PACKED_STRING_ARRAY,
            .PACKED_VECTOR2_ARRAY,
            .PACKED_VECTOR3_ARRAY,
            .PACKED_COLOR_ARRAY,
            .PACKED_VECTOR4_ARRAY,
            .NIL :
                for ops in BUILT_FROM.operators {
                    eval_enum:= Which_Ops(ops.name)
                    variant_type2:= Get_Variant_Type_From_String(ops.right_type)
                    //If the comparison type is Variant... There is no type in the enum for that. Don't fetch it.
                    if variant_type2 != .VARIANT_MAX {
                        strings.write_string(&init_builder, fmt.bprintf(buffer[:], op_eval, BUILT_FROM.name, eval_enum, ops.right_type, variant_type, variant_type2, newline =true))
                        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], bltn_ops, eval_enum, ops.right_type, newline =true))
                    }
                }
        }
        //pinch it off
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], Closing, newline =true))


        //Constants are just floating around
        //Constants only exist for compound types such as vec2, basis etc.
        consts:= `@(rodata)
%s_%s :GDW.%s`
        if len(BUILT_FROM.constants) > 0 && BUILT_FROM.name != "Quaternion" {
            outoput, did_alloc:=strings.replace_all(BUILT_FROM.constants[0].value, "(", "= {")
                //fmt.println(outoput)
            defer(delete(outoput))
            outoput2, did_alloc2:=strings.replace_all(outoput, ")", "}")
            //fmt.println(outoput)
            defer(delete(outoput2))
            strings.write_string(&consts_builder, fmt.bprintf(buffer[:], consts, BUILT_FROM.name, BUILT_FROM.constants[0].name, outoput2, newline =true))
        }

        //fmt.println(strings.to_string(init_builder))
        //fmt.println(strings.to_string(struct_builder))
        //fmt.println(BUILT_FROM.name)
        append(&builtin_map, builtin_set{BUILT_FROM.name, strings.to_string(init_builder), strings.to_string(struct_builder), strings.to_string(consts_builder)})
        //strings.builder_reset(&init_builder)
        //strings.builder_reset(&struct_builder)
        //fmt.println(builtin_map[idx].init_proc)
    }
    
    return builtin_map
}

Get_Variant_Type_From_String :: proc(className: string) -> GDE.VariantType {
    switch className {
        case "Nil" :
            return .NIL
        case "bool" :
            return .BOOL
        case "int" :
	        return .INT
        case "float" :
	        return .FLOAT
        case "String" :
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