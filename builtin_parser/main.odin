package builtin_parser

import "core:encoding/json"
import "core:os"
import "core:fmt"
import "base:runtime"
import "core:strings"
//import GDW "shared:GDWrapper"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:bytes"
//import "../builtins"

/*
TODO!
Projection_Constants := [Projection_Const_names]Projection {
  .IDENTITY = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
  .ZERO = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}
Projection_Const_names :: enum {
  Projection_ZERO,
  Projection_IDENTITY,
}
*/

main :: proc() {
    root, error := os.get_absolute_path("builtin_parser\\example.json", context.allocator)
    if error != nil {
        print_warning("error getting root.", error)
        return
    }
    fmt.println(root)
    data, err := os.read_entire_file("C:\\Odin_programs\\toxin_new_pull\\extension_api.json", context.allocator)
    
    if err != nil {
        print_warning("file could not be read: ", err)
    }
    val:=json.make_parser(data)
    built_different: builtin
    global_enums: global_enums
    json.unmarshal(data, &built_different)
    json.unmarshal(data, &global_enums)
    buildem, err_buildem:= strings.builder_make()
    if err_buildem != nil {
        print_warning("failed to create builder", err_buildem)
    }
    final:=build_init_proc(built_different, global_enums, context.allocator)
    
    header:=`package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


`
    for classes in final {
        //fmt.println(classes.method_list)
        //fmt.println(classes.init_proc)
        //fmt.println(classes.constants)
        fmt.println(classes.name)
        file_path:string
        if classes.name != "" {
            file_path= fmt.aprintf("C:\\Odin_programs\\toxin_new_pull\\GD_Builtins\\%s_GD_builtin.odin", classes.name)
        }
        else
        {
            file_path= fmt.aprintf("C:\\Odin_programs\\toxin_new_pull\\GD_Builtins\\Globals_GD_builtin.odin")
        }
        file, open_err:= os.create(file_path)
        if open_err == nil {
            count, write_err:= os.write_strings(file, header, classes.constants, classes.enums, classes.method_list, classes.init_proc, classes.globals)
            fmt.println("wrote: ", count, write_err)
        } else {
            print_warning("could not open file_path", open_err)
        }
        delete(file_path)
    }

}

print_warning:: proc(message: string, error: os.Error) {
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
        enums: []enums,
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

enums :: struct {
    name: string,
    values: []struct{
        name: string,
        value: int,
    }
}

builtin_set :: struct {
    name: string,
    init_proc: string,
    method_list: string,
    constants: string,
    enums: string,
    globals: string,
}

global_enums :: struct {
    global_enums: [] struct {
    name: string,
    is_bitfield: bool,
    values: []struct{
        name: string,
        value: int,
    },
}}

build_init_proc :: proc(json_data: builtin, glob_data: global_enums, ctx: runtime.Allocator) -> ([dynamic]builtin_set) {
    
    builtin_map:= make([dynamic]builtin_set, ctx)

    ///////////////////////////////
    // Structure of the init proc
    ///////////////////////////////
    init_proc_sig:=`init_%s_Methods :: proc(%[0]s_method_store: ^%[0]s_Methods_list) {{`
    //name
    Creators:=`  %s_method_store.Create%[1]v = cast(type_of(%[0]s_method_store.Create%[1]v))gdAPI.Variant_Utils.GetPtrConstructor(.%s, %[1]v)`
    //name, index, variant_type
    Destructors:=`  %s_method_store.Destroy = cast(type_of(%[0]s_method_store.Destroy))gdAPI.Variant_Utils.GetPtrDestructor(.%v)`
    //name, variant_type
    Ptr_Getter:= `    %s_method_store.get_ptr = cast(type_of(%[0]s_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.%v)`
    op_eval:= `  %s_method_store.%s_%s = cast(type_of(%[0]s_method_store.%[1]s_%[2]s))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.%[1]v, .%v, .%v)`
    //name, eval_enum, variant_type
    Meth_Getter:=`  %s_method_store.%[2]s = cast(type_of(%[0]s_method_store.%[2]s))Get_Builtin_Method(.%[1]v, "%[3]s", %v)`
    Index_Getter:=`  %s_method_store.IndxGetter = cast(type_of(%[0]s_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.%[1]v)
  %[0]s_method_store.IndxSetter = cast(type_of(%[0]s_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.%[1]v)`
    Keyed_Getter:=`  %s_method_store.KeyedSetter = cast(type_of(%[0]s_method_store.KeyedSetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.%[1]v)
  %[0]s_method_store.KeyedGetter = cast(type_of(%[0]s_method_store.KeyedGetter))gdAPI.Variant_Utils.GetPtrKeyedSetter(.%[1]v)
  %[0]s_method_store.KeyedChecker = cast(type_of(%[0]s_method_store.KeyedChecker))gdAPI.Variant_Utils.GetPtrKeyedSetter(.%[1]v)`
    //name ,variant_type, methods[i].name, methods[i].hash
    Closing:=`}`

    /////////////////////////////
    // Structure of the builtin struct
    /////////////////////////////
    bltn_struct_declare:= `%s_Methods_list :: struct {{` //builtin name
    bltn_creator:= `    Create%v: GDE.PtrConstructor,` //index of Creator
    bltn_creator_proc:= `    Create%v: proc "c" (p_base: ^%s, ` //#by_ptr p_args: struct{{%s: %s,}),` //index of Creator, builtin_type, arg_name from_type
    bltn_destructor:= `    Destroy: GDE.PtrDestructor,` //Include if Destructor true
    bltn_destructor_proc:= `    Destroy: proc "c" (p_base: ^%s),` //Include if Destructor true; builtin_type
    bltn_ptr_getter:= `    get_ptr: proc "c" (base: ^Variant) -> ^%s,` //returns the typePtr from the Variant. Mainly useful for Packed*Arrays because of how nasty their class is.
    keyed:= `    KeyedSetter : proc "c" (p_base: %[0]s, p_key: GDE.ConstTypePtr, p_value: GDE.ConstTypePtr),
    KeyedGetter : proc "c" (p_base: %[0]s, p_key: GDE.TypePtr, r_value: GDE.TypePtr),
    KeyedChecker : proc "c" (#by_ptr p_base: Variant, #by_ptr p_key: Variant) -> u32,` //if the type is keyed it will have these three methods
    indexed:= `    IndxSetter : proc "c" (p_base: ^%[0]s, p_index: Int, p_value: ^%[1]s),
    IndxGetter : proc "c" (p_base: ^%[0]s, p_index: Int, r_value: ^%[1]s),` //if the type has a index return, it will have these two methods
    bltn_method:= `    %s:  GDE.PtrBuiltInMethod,` //Name of method: methods.name
    bltn_method_proc:=`    %s:  proc "c" (p_base: ^%s,` // #by_ptr p_args: struct{{%s: %s,}, 
    bltn_method_return:= ` r_return: ^%s, p_argument_count: i64 = %v),`
    bltn_ops:= `    %s_%s: GDE.PtrOperatorEvaluator,`
    bltn_ops_proc:= `    %s_%s: proc "c" (`
    bltn_ops_proc_left:= `p_left: ^%s, `
    bltn_ops_proc_right:= `p_right: ^%s,`
    bltn_ops_proc_result:= ` r_result: ^%s),`

    arg_struct_open:= ` #by_ptr p_args: struct{{ `
    arg_struct_vals:= `%s: ^%s, `

    /////////////////////////
    // ENUMS
    ////////////////////////
    enum_name:= `
%s_%s :: enum i64 {{`
    enum_field:= `  %s = %v,`
    ebit_field:= `  %s,`
          enum_flags:= `
%s_%s_Flags :: bit_set [%[0]s_%[1]s; i64]`

    ////////////////////////////
    // Convert the unmarshalled json to Odin procs and structs
    ////////////////////////////
    for &BUILT_FROM, idx in json_data.builtin_classes {
        init_builder:=strings.builder_make(ctx)
        struct_builder:=strings.builder_make(ctx)
        consts_builder:=strings.builder_make(ctx)
        consts_enum:=strings.builder_make(ctx)

        Correct_Type_String(&BUILT_FROM.name, ctx)
        fmt.println(BUILT_FROM.name)
        variant_type:GDE.VariantType= Get_Variant_Type_From_String(BUILT_FROM.name)
        buffer:[250]u8
        //signature and struct declaration
        fmt.sbprintf(&init_builder, init_proc_sig, BUILT_FROM.name, newline =true)
        fmt.sbprintf(&struct_builder, bltn_struct_declare, BUILT_FROM.name, newline =true)
        //setup Constructors
        for creation, idx in BUILT_FROM.constructors {
            fmt.sbprintf(&init_builder, Creators, BUILT_FROM.name, idx, variant_type, newline =true)
            fmt.println(BUILT_FROM.name)
            if BUILT_FROM.name == "Nil" {
                fmt.sbprintf(&struct_builder, bltn_creator_proc, idx, "rawptr = nil")
            }
            else
            {
                fmt.sbprintf(&struct_builder, bltn_creator_proc, idx, BUILT_FROM.name)
            }
            if len(creation.arguments) == 0 {
                fmt.sbprintf(&struct_builder, "p_args: rawptr = nil),", newline = true)
            }
            else
            {
                fmt.sbprintf(&struct_builder, arg_struct_open)
                for &args in creation.arguments {
                    Correct_Type_String(&args.type, ctx)
                    fmt.sbprintf(&struct_builder, arg_struct_vals, args.name, args.type)
                }
                fmt.sbprintf(&struct_builder, `}),`, newline = true)
            }
        }

        //setup Destructors iff the builtin has one
        if BUILT_FROM.has_destructor {
            fmt.sbprintf(&init_builder, Destructors, BUILT_FROM.name, variant_type, newline =true)
            fmt.sbprintf(&struct_builder, bltn_destructor_proc, BUILT_FROM.name, newline =true)
        }

        fmt.sbprintf(&init_builder, Ptr_Getter, BUILT_FROM.name, variant_type, newline =true)
        
        if BUILT_FROM.name == "Nil" {
            fmt.sbprintf(&struct_builder, bltn_ptr_getter, "rawptr", newline =true)
        }
        else {
            fmt.sbprintf(&struct_builder, bltn_ptr_getter, BUILT_FROM.name, newline =true)
        }

        if BUILT_FROM.is_keyed == true {
            fmt.sbprintf(&struct_builder, keyed, BUILT_FROM.name, newline =true)
            fmt.sbprintf(&init_builder, Keyed_Getter, BUILT_FROM.name, variant_type, newline =true)
        }
        if BUILT_FROM.indexing_return_type != "" {
            Correct_Type_String(&BUILT_FROM.indexing_return_type, ctx)
            fmt.sbprintf(&struct_builder, indexed, BUILT_FROM.name, BUILT_FROM.indexing_return_type, newline =true)
            fmt.sbprintf(&init_builder, Index_Getter, BUILT_FROM.name, variant_type, newline =true)

        }

        //setup Methods
        for &method, idx in BUILT_FROM.methods {
            method_gdstring:= strings.clone(method.name, ctx)
            if method.name == "any" { 
                delete(method.name)
                method.name = "gdany"
            }
            if method.name == "map" { 
                delete(method.name)
                method.name = "gdmap"
            }

            fmt.sbprintf(&init_builder, Meth_Getter, BUILT_FROM.name, variant_type, method.name, method_gdstring, method.hash, newline =true)
            fmt.sbprintf(&struct_builder, bltn_method_proc, method.name, BUILT_FROM.name)
            delete(method_gdstring)
            if len(method.arguments) == 0 {
                fmt.sbprintf(&struct_builder, " p_args: rawptr = nil,", newline = false)
            }
            else
            {
                fmt.sbprintf(&struct_builder, arg_struct_open)
                for &args in method.arguments {
                    Correct_Type_String(&args.type, ctx)
                    fmt.sbprintf(&struct_builder, arg_struct_vals, args.name, args.type)
                }
                fmt.sbprintf(&struct_builder, `},`, newline = false)
            }
                if method.return_type == "" {
                    delete(method.return_type)
                    method.return_type = "rawptr = nil"
                }
                else {
                    Correct_Type_String(&method.return_type, ctx)}
                fmt.sbprintf(&struct_builder, bltn_method_return, method.return_type, len(method.arguments), newline = true)
        }

        for &ops in BUILT_FROM.operators {
            eval_enum:= Which_Ops(ops.name)
            Correct_Type_String(&ops.return_type, ctx)
            Correct_Type_String(&ops.right_type, ctx)
            variant_type2:= Get_Variant_Type_From_String(ops.right_type)
            //If the comparison type is Variant... There is no type in the enum for that. Don't fetch it.
            if variant_type2 != .VARIANT_MAX {
                fmt.sbprintf(&init_builder, op_eval, BUILT_FROM.name, eval_enum, ops.right_type, variant_type, variant_type2, newline =true)
                fmt.sbprintf(&struct_builder, bltn_ops_proc, eval_enum, ops.right_type)
                if BUILT_FROM.name == "Nil" {
                    fmt.sbprintf(&struct_builder, "p_left: rawptr = nil, ")
                    if ops.right_type != "" &&
                       ops.right_type != "Nil" {
                        fmt.sbprintf(&struct_builder, bltn_ops_proc_right, ops.right_type)
                    }
                    else
                    {
                        fmt.sbprint(&struct_builder, "p_right: rawptr = nil, ")
                    }
                }
                else
                {
                    fmt.sbprintf(&struct_builder, bltn_ops_proc_left, BUILT_FROM.name)
                    if ops.right_type != "" {
                        fmt.sbprintf(&struct_builder, bltn_ops_proc_right, ops.right_type)
                    }
                    else
                    {
                        fmt.sbprint(&struct_builder, "p_right: rawptr = nil, ")
                    }
                }
                if ops.return_type != "" {
                    fmt.sbprintf(&struct_builder, bltn_ops_proc_result, ops.return_type, newline =true)
                }
                else
                {
                    fmt.sbprint(&struct_builder, `r_result: rawptr = nil),
`)
                }
            }
        }

    /////////////////////////
    // ENUMS
    ////////////////////////
    if len(BUILT_FROM.enums) > 0 {
      for constants in BUILT_FROM.enums {
        strings.write_string(&consts_enum, fmt.bprintf(buffer[:], enum_name, BUILT_FROM.name, constants.name, newline =true))
        for val in constants.values {
            strings.write_string(&consts_enum, fmt.bprintf(buffer[:], enum_field, val.name, val.value, newline =true))
        }
        fmt.sbprintf(&consts_enum, "}", newline =true)
      }
      //fmt.println(strings.to_string(enum_builder))
    }
        //pinch it off
        fmt.sbprintf(&init_builder, Closing, newline =true)
        fmt.sbprintf(&struct_builder, Closing, newline =true)


        //Constants are just floating around
        //Constants only exist for compound types such as vec2, basis etc.
        consts:= `@(rodata)
%s_%s : %s`
        consts2:= `    %s,`
        consts3:= `    .%s = %s,`
        const_enum_name:= `%s_consts :: enum c.int {{`
        const_impl:= `@(export, rodata)
%s_Defaults := [%s_consts]%s {{`
        if len(BUILT_FROM.constants) > 0 && BUILT_FROM.name != "Quaternion" {
            fmt.sbprintf(&consts_builder, const_enum_name, BUILT_FROM.name, newline =true)
            for constants in BUILT_FROM.constants {
                inf:bool
                inf_replacement:string
                if strings.contains(constants.value, "inf"){
                    inf_replacement, inf = strings.replace_all(constants.value, "inf", "math.INF_F32")
                } else {inf_replacement=constants.value}
                
                outoput, did_alloc:=strings.replace_all(inf_replacement, "(", "= {")
                if inf do delete(inf_replacement)
                outoput2, did_alloc2:=strings.replace_all(outoput, ")", "}")
                delete(outoput)
                //fmt.sbprintf(&consts_builder, consts, BUILT_FROM.name, constants.name, outoput2, newline =true)
                fmt.sbprintf(&consts_builder, consts2, constants.name, newline =true)
                delete(outoput2)
            }
            fmt.sbprintf(&consts_builder, `}`, newline =true)
        }

        //need to use a special find proc in order to find where the open brackets starts.
	    find :: proc(r: rune) -> bool {
	    	return r != '{'
	    }
        if len(BUILT_FROM.constants) > 0 && BUILT_FROM.name != "Quaternion" {
            fmt.sbprintf(&consts_builder, const_impl, BUILT_FROM.name, BUILT_FROM.name, BUILT_FROM.name, newline =true)
            for constants in BUILT_FROM.constants {
                inf:bool
                inf_replacement:string
                if strings.contains(constants.value, "inf"){
                    inf_replacement, inf = strings.replace_all(constants.value, "inf", "math.INF_F32")
                } else {inf_replacement=constants.value}
                
                outoput, did_alloc:=strings.replace_all(inf_replacement, "(", " {")
                outoput2, did_alloc2:=strings.replace_all(outoput, ")", "}")
                if inf do delete(inf_replacement)
                trunc:= strings.trim_left_proc(outoput2, find)
                fmt.println(strings.trim_left_proc(outoput2, find))
                //delete(outoput)
                fmt.sbprintf(&consts_builder, consts3, constants.name, trunc[:], newline =true)
                delete(outoput2)
            }
            fmt.sbprintf(&consts_builder, `}`, newline =true)
        }

        //fmt.println(strings.to_string(init_builder))
        //fmt.println(strings.to_string(struct_builder))
        //fmt.println(BUILT_FROM.name)
        append(&builtin_map, builtin_set{BUILT_FROM.name, strings.to_string(init_builder), strings.to_string(struct_builder), strings.to_string(consts_builder), strings.to_string(consts_enum), ""})
        //strings.builder_reset(&init_builder)
        //strings.builder_reset(&struct_builder)
        //fmt.println(builtin_map[idx].init_proc)
    }
    
    /////////////////////////
    // globals
    ////////////////////////
    globals_enum:=strings.builder_make(ctx)
    global_name:= `
%s :: enum i64 {{`
    global_field:= `  %s = %v,`
    global_ebit_field:= `  %s,`
    global_flags:= `
%s_Flags :: bit_set [%[0]s; i64]`
    if len(glob_data.global_enums) > 0 {
      for constants in glob_data.global_enums {
        if constants.name != "PropertyUsageFlags" &&
        constants.name != "PropertyHint" &&
        constants.name != "Variant.Operator" &&
        constants.name != "Variant.Type" &&
        constants.name != "MethodFlags" {
        if constants.is_bitfield == true {
        fmt.sbprintf(&globals_enum, global_flags, constants.name, newline =false)
        }
        fmt.sbprintf(&globals_enum, global_name, constants.name, newline =true)
        for val in constants.values {
          if constants.is_bitfield {
            fmt.sbprintf(&globals_enum, global_ebit_field, val.name, newline =true)
          } else
          {
            fmt.sbprintf(&globals_enum, global_field, val.name, val.value, newline =true)
          }
        }
        fmt.sbprintf(&globals_enum, "}", newline =true)
      }}
    }
    fmt.println(glob_data)
    append(&builtin_map, builtin_set{globals=strings.to_string(globals_enum)})
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

Reserved_Odin_Types :=[?]string {"map","any", "enum", "context", "in", "out"}

Correct_Type_String :: proc(muh_type: ^string, ctx: runtime.Allocator) {
  ok:bool
  switch muh_type^ {
    case "int":
      delete(muh_type^)
      muh_type^ = "Int"
      return 
    case "String":
      delete(muh_type^)
      muh_type^ = "gdstring"
      return 
    case "bool":
      delete(muh_type^)
      muh_type^ = "Bool"
      return 
    //case "Nil":
    //  delete(muh_type^)
    //  muh_type^ = "nil"
    //  return 
    case "const GDExtensionInitializationFunction*" :{
      delete(muh_type^)
      muh_type^ = "GDE.InitializationFunction"
      return
    }
  }
  is_enum: bool
  if strings.contains( muh_type^, "typedarray") {
      delete(muh_type^)
      muh_type^ = "Array"
      return 
  } else
  if strings.contains( muh_type^, "typeddictionary") {
      delete(muh_type^)
      muh_type^ = "Dictionary"
      return 
  } else
  if strings.contains(muh_type^, "enum") {
      temp:=muh_type^
      muh_type^, ok = strings.replace(muh_type^, "enum::", "", -1, ctx)
      assert(ok, "could not allocate new string for type")
      //delete(temp)
      is_enum = true
  } else
  if strings.contains(muh_type^, "bitfield") {
      temp:=muh_type^
      muh_type^, ok = strings.replace(muh_type^, "bitfield::", "", -1, ctx)
      assert(ok, muh_type^)
      is_enum = true
  }
  if strings.contains(muh_type^, ".") {
    temp:=muh_type^
    muh_type^, ok = strings.replace(muh_type^, ".", "_", -1, ctx)
    assert(ok, muh_type^)
  }
  if is_enum{
    if muh_type^ == "Side" {
      delete(muh_type^)
      muh_type^ = "Side"
      fmt.println(muh_type^)
    } else
    if muh_type^ == "HorizontalAlignment" {
      delete(muh_type^)
      muh_type^ = "HorizontalAlignment"
    } else
    if muh_type^ == "Key" {
      delete(muh_type^)
      muh_type^ = "Key"
    } else
    if muh_type^ == "VerticalAlignment" {
      delete(muh_type^)
      muh_type^ = "VerticalAlignment"
    } else
    if muh_type^ == "MouseButtonMask" {
      delete(muh_type^)
      muh_type^ = "MouseButtonMask"
    } else
    if muh_type^ == "Vector3_Axis" {
      delete(muh_type^)
      muh_type^ = "Vector3_Axis"
    } else
    if muh_type^ == "Vector2_Axis" {
      delete(muh_type^)
      muh_type^ = "Vector2_Axis"
    } else
    if muh_type^ == "Vector4_Axis" {
      delete(muh_type^)
      muh_type^ = "Vector4_Axis"
    } else
    if muh_type^ == "Error" {
        delete(muh_type^)
        muh_type^ = "Error"
    }
    return 
  }
  if strings.contains(muh_type^, "const void") {
      delete(muh_type^)
      muh_type^ = "void"
      fmt.println(muh_type^)
      return 
  }
  return
}