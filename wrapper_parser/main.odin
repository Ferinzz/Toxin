package main


import "core:encoding/json"
import "core:os"
import "core:fmt"
import "base:runtime"
import "core:strings"
import GDE "../GDWrapper/gdAPI/gdextension"

main :: proc() {

  //data, err := os.read_entire_file(root, context.allocator)
  data, err := os.read_entire_file("C:\\Odin_programs\\toxin_new_pull\\extension_api.json", context.allocator)
  
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
  create_class_files(built_different)
}

create_class_files :: proc(data: builtin) -> (classes_wrapped: [dynamic]string) {

    for &class in data.classes {
        for &method in class.methods {
            if method.is_virtual == true {continue}
            class_file:= create_class_string(class.name, &method)
            append(&classes_wrapped, class_file)
        }
    }
    return {}
}

create_class_string :: proc(class_name: string, class_method: ^methods) -> string {
    method_wrapped:= strings.builder_make()
    fmt.sbprintf(&method_wrapped, proc_sig, class_name, class_method.name)
    fmt.sbprintf(&method_wrapped, object, class_name)
    for &args in class_method.arguments {
        Correct_Type_String(&args.type)
            //Godot uses some param names which are reserved in Odin.
            if args.name == "any" { 
              delete(args.name)
              args.name = "gdany"
            }
            else
            if args.name == "map" { 
              delete(args.name)
              args.name = "gdmap"
            }
            else
            if args.name == "enum" {
              delete(args.name)
              args.name = "p_enum"
            }
            else
            if args.name == "context" {
              delete(args.name)
              args.name = "trans_context"
            }
            else
            if args.name == "in" {
              delete(args.name)
              args.name = "point_in"
            }
            else
            if args.name == "out" {
              delete(args.name)
              args.name = "point_out"
            }
            variant_type:GDE.VariantType= Get_Variant_Type_From_String(args.type)
            if variant_type != .NIL{
              temp:=args.type
              concat_err: runtime.Allocator_Error
              if variant_type == .OBJECT {
                //args.type, concat_err = strings.concatenate({"^GDW.", args.type})
              } else {
                //args.type, concat_err = strings.concatenate({"GDW.", args.type})
              }
              //assert(concat_err==nil, args.type)
              //delete(temp)
              fmt.sbprintf(&method_wrapped, arg, args.name, args.type, newline =false)
            } else
            {
                fmt.println(args.type)
              fmt.sbprintf(&method_wrapped, class_arg, args.name, args.type, newline =false)
            }
        //fmt.sbprintf(&method_wrapped, arg, args.name, args.type)
    }
    if class_method.return_value.type != "" {
        //fmt.println(method.return_value.type)
        Correct_Type_String(&class_method.return_value.type)
        //fmt.println(method.return_value.type)
        variant_type:GDE.VariantType= Get_Variant_Type_From_String(class_method.return_value.type)
        if variant_type != .NIL {
          temp:=class_method.return_value.type
          concat_err: runtime.Allocator_Error
          //class_method.return_value.type, concat_err = strings.concatenate({"GDW.", class_method.return_value.type})
          //assert(concat_err==nil, method.return_value.type)
          //delete(temp)
            fmt.sbprintf(&method_wrapped, ret, class_method.return_value.type)
        }else
        {
            //fmt.println(class_method.return_value.type)
          fmt.sbprintf(&method_wrapped, class_ret, class_method.return_value.type, newline =false)
        }
    }
    fmt.sbprintf(&method_wrapped, `) {{`, newline = true)
    fmt.sbprintf(&method_wrapped, method_call, class_name, class_method.name, class_name)
    if len(class_method.arguments) > 0 {
        fmt.sbprint(&method_wrapped, `{`)
        for args in class_method.arguments {
            fmt.sbprintf(&method_wrapped, call_args, args.name)
        }
        fmt.sbprint(&method_wrapped, `}, `)
    }
    if class_method.return_value.type != "" {
        //fmt.println("return exists")
        fmt.sbprintf(&method_wrapped, ret_arg)
    }
    fmt.sbprintf(&method_wrapped, `)`, newline = true)
    fmt.sbprintf(&method_wrapped, call_close, newline = true)
    if class_method.return_value.type != "" {
        fmt.println(strings.to_string(method_wrapped))
    }
    return strings.to_string(method_wrapped)
}

print_warning:: proc(message: string, error: os.Error) {
  fmt.println(message, error)
};

builtin:: struct {
  classes: []struct {
		name: string,
		is_refcounted: bool,
		is_instantiable: bool,
    inherits: string,
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
  }
};

signal:: struct {
  name:string,
  arguments:[]struct {
    name:string,
    type:string,
  }
};

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
};
property::struct{
  type:string,
  name:string,
  setter:string,
  getter:string,
};

builtin_set :: struct {
  name: string,
  init_proc: string,
  method_list: string,
  constants: string,
  //properties: string,
  //properties_init: string,
  enums: string,
  virtuals_init: string,
  virtuals_list: string,
  virtuals_sig: string,
  virtuals_deinit: string,
  virtuals_check: string,
};


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


Correct_Type_String :: proc(muh_type: ^string) {
  ok:bool
  //if muh_type^ == string("Side") do fmt.println(muh_type^)
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
    case "Nil":
      delete(muh_type^)
      muh_type^ = "nil"
      return 
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
      muh_type^, ok = strings.replace(muh_type^, "enum::", "", -1)
      assert(ok, "could not allocate new string for type")
      //delete(temp)
      is_enum = true
  } else
  if strings.contains(muh_type^, "bitfield") {
      temp:=muh_type^
      muh_type^, ok = strings.replace(muh_type^, "bitfield::", "", -1)
      assert(ok, muh_type^)
      is_enum = true
      //delete(temp)
  }
  if strings.contains(muh_type^, ".") {
    temp:=muh_type^
    muh_type^, ok = strings.replace(muh_type^, ".", "_", -1)
    assert(ok, muh_type^)
    //delete(temp)
    //return muh_type
  }
  if is_enum{
    if muh_type^ == "Side" {
      delete(muh_type^)
      muh_type^ = "GDW.Side"
      fmt.println(muh_type^)
    } else
    if muh_type^ == "HorizontalAlignment" {
      delete(muh_type^)
      muh_type^ = "GDW.HorizontalAlignment"
    } else
    if muh_type^ == "Key" {
      delete(muh_type^)
      muh_type^ = "GDW.Key"
    } else
    if muh_type^ == "VerticalAlignment" {
      delete(muh_type^)
      muh_type^ = "GDW.VerticalAlignment"
    } else
    if muh_type^ == "MouseButtonMask" {
      delete(muh_type^)
      muh_type^ = "GDW.MouseButtonMask"
    } else
    if muh_type^ == "Vector3_Axis" {
      delete(muh_type^)
      muh_type^ = "GDW.Vector3_Axis"
    } else
    if muh_type^ == "Vector2_Axis" {
      delete(muh_type^)
      muh_type^ = "GDW.Vector2_Axis"
    } else
    if muh_type^ == "Vector4_Axis" {
      delete(muh_type^)
      muh_type^ = "GDW.Vector4_Axis"
    } else
    if muh_type^ == "Error" {
        delete(muh_type^)
        muh_type^ = "GDW.Error"
    } else
    if muh_type^ == "PropertyHint" {
        delete(muh_type^)
        muh_type^ = "GDW.PropertyHint"
    } else
    if muh_type^ == "Variant_Type" {
        delete(muh_type^)
        muh_type^ = "GDE.VariantType"
    } else
    if muh_type^ == "MouseButton" {
        delete(muh_type^)
        muh_type^ = "GDW.MouseButton"
    } else
    if muh_type^ == "JoyButton" {
        delete(muh_type^)
        muh_type^ = "GDW.JoyButton"
    } else
    if muh_type^ == "JoyAxis" {
        delete(muh_type^)
        muh_type^ = "GDW.JoyAxis"
    } else
    if muh_type^ == "KeyModifierMask" {
        delete(muh_type^)
        muh_type^ = "GDW.KeyModifierMask"
    } else
    if muh_type^ == "InlineAlignment" {
        delete(muh_type^)
        muh_type^ = "GDW.InlineAlignment"
    } else
    if muh_type^ == "EulerOrder" {
        delete(muh_type^)
        muh_type^ = "GDW.EulerOrder"
    } else
    if muh_type^ == "MIDIMessage" {
        delete(muh_type^)
        muh_type^ = "GDW.MIDIMessage"
    } else
    if muh_type^ == "Corner" {
        delete(muh_type^)
        muh_type^ = "GDW.Corner"
    } else
    if muh_type^ == "InlineAlignment" {
        delete(muh_type^)
        muh_type^ = "GDW.InlineAlignment"
    } else
    if muh_type^ == "ClockDirection" {
        delete(muh_type^)
        muh_type^ = "GDW.ClockDirection"
    } else
    if muh_type^ == "KeyLocation" {
        delete(muh_type^)
        muh_type^ = "GDW.KeyLocation"
    } else
    if muh_type^ == "PropertyUsageFlags" {
        delete(muh_type^)
        muh_type^ = "GDE.PropertyUsageFlags"
    }

    return 
  }
  if strings.contains(muh_type^, "void") {
      delete(muh_type^)
      muh_type^ = "GDW.void"
      fmt.println(muh_type^)
      return 
  }
  if muh_type^ == "Variant_Type" {
      delete(muh_type^)
      muh_type^ = "GDE.VariantType"
      return
  }
  count:= strings.count(muh_type^, "*"); 
  if count > 0 {
    prefix: string
    switch count {
      case 2:
        prefix = "[^]"
      case 1:
        prefix = "^"
    }
    type:string=cpp_type(muh_type^)
    type= struct_types(type)
    delete(muh_type^)
    muh_type^=strings.concatenate({prefix, type})
  }
  return
}

cpp_type :: proc(segment: string) -> string {
  
    switch {
    case strings.contains(segment, "uint8_t"):
      return "u8"
    case strings.contains(segment, "uint32_t"):
      return "u32"
    case strings.contains(segment, "uint64_t"):
      return "u64"
    case strings.contains(segment, "int8_t"):
      return "i8"
    case strings.contains(segment, "int32_t"):
      return "i32"
    case strings.contains(segment, "int64_t"):
      return "i64"
    case strings.contains(segment, "float"):
      return "f32"
    case strings.contains(segment, "real_t"):
      return "f64"
    }
    return segment
}

struct_types :: proc(segment: string) -> string {
  switch {
  case strings.contains(segment, "AudioFrame"):
    return "GDW.AudioFrame"
  case strings.contains(segment, "CaretInfo"):
    return "GDW.CaretInfo"
  case strings.contains(segment, "Glyph"):
    return "GDW.Glyph"
  case strings.contains(segment, "ObjectID"):
    return "GDW.ObjectID"
  case strings.contains(segment, "PhysicsServer2DExtensionMotionResult"):
    return "GDW.PhysicsServer2DExtensionMotionResult"
  case strings.contains(segment, "PhysicsServer2DExtensionRayResult"):
    return "GDW.PhysicsServer2DExtensionRayResult"
  case strings.contains(segment, "PhysicsServer2DExtensionShapeRestInfo"):
    return "GDW.PhysicsServer2DExtensionShapeRestInfo"
  case strings.contains(segment, "PhysicsServer2DExtensionShapeResult"):
    return "GDW.PhysicsServer2DExtensionShapeResult"
  case strings.contains(segment, "PhysicsServer3DExtensionMotionCollision"):
    return "GDW.PhysicsServer3DExtensionMotionCollision"
  case strings.contains(segment, "PhysicsServer3DExtensionMotionResult"):
    return "GDW.PhysicsServer3DExtensionMotionResult"
  case strings.contains(segment, "PhysicsServer3DExtensionRayResult"):
    return "GDW.PhysicsServer3DExtensionRayResult"
  case strings.contains(segment, "PhysicsServer3DExtensionShapeRestInfo"):
    return "GDW.PhysicsServer3DExtensionShapeRestInfo"
  case strings.contains(segment, "PhysicsServer3DExtensionShapeResult"):
    return "GDW.PhysicsServer3DExtensionShapeResult"
  case strings.contains(segment, "ScriptLanguageExtensionProfilingInfo"):
    return "GDW.ScriptLanguageExtensionProfilingInfo"
  }
  return segment
}