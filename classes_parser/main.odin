package classes_parser

import "core:encoding/json"
import "core:os"
import "core:fmt"
import "base:runtime"
import "core:strings"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "core:bytes"
//import "../GD_Classes"

main :: proc() {
  root, error := os.get_absolute_path("classes_parser\\example.json", context.allocator)
  if error != nil {
    print_warning("error getting root.", error)
    return
  }
  fmt.println(root)
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
  final:=build_init_proc(built_different, context.allocator)

  header:=`package GD_Classes

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


`

  file_path:= "C:\\Odin_programs\\toxin_new_pull\\GD_Classes\\AAAUtils_GD_Class.odin"
  file, open_err:= os.create(file_path)
  if open_err == nil {
    os.write_strings(file, header, Method_Callback_Compare_Info)
    class_n:= `  %s,`
    class_sn:= `  .%s = GDW.StringName({{nil}),`
    closer:=`
};`
    buffer:[400]u8
    class_list:=strings.builder_make(context.temp_allocator)
    class_sn_list:=strings.builder_make(context.temp_allocator)
    strings.write_string(&class_list, ClassName_Index)
    strings.write_string(&class_sn_list, ClassName_StringNames)
    for class in built_different.classes {
      strings.write_string(&class_list, fmt.bprintf(buffer[:], class_n, class.name, newline =true))
      strings.write_string(&class_sn_list, fmt.bprintf(buffer[:], class_sn, class.name, newline =true))
    }
    strings.write_string(&class_list, closer)
    strings.write_string(&class_sn_list, closer)
    os.write_string(file, strings.to_string(class_list))
    os.write_string(file, strings.to_string(class_sn_list))
    os.close(file)
  }
  for classes in final {
    //fmt.println(classes.method_list)
    //fmt.println(classes.init_proc)
    //fmt.println(classes.constants)

    file_path:= fmt.aprintf("C:\\Odin_programs\\toxin_new_pull\\GD_Classes\\%s_GD_Class.odin", classes.name)
    file, open_err:= os.create(file_path)
    if open_err == nil {
      //count, write_err:= os.write_strings(file, header, 
      os.write_strings(file, header, 
                            classes.name,
                            ` :: ^GDW.Object

`,
                            classes.virtuals_list,
                            classes.enums,
                            classes.constants,
                            //classes.properties,
                            classes.method_list,
                            classes.init_proc,
                            classes.virtuals_init,
                            //classes.properties_init,
                            )
      //fmt.println("wrote: ", count, write_err)
    } else {
      print_warning("could not open file_path", open_err)
    }
    os.close(file)
    delete(file_path)
  }
  //Create the init-all test file.
  //@user: yes this could be better to loop through it only once. I just wrote it straight through.. Deal.
  test_builder:strings.Builder
  strings.builder_init(&test_builder)

  File_Opening_Move:= `package GD_Classes_test_init

import Classes "../GD_Classes"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import GDW "shared:GDWrapper"
import "base:runtime"
import "core:fmt"
import "core:strings"`

  extension_entry:= `@export
godot_entry_init :: proc "c" (p_get_proc_address: GDE.InterfaceGetProcAddress, p_library: GDE.ClassDB, initialization: ^GDE.Initialization) {
    //GDW.initGodotContext()
    context = runtime.default_context()
    fmt.println("running Classes init tests")
    GDW.Library = p_library
    GDW.Init_Wrapper(p_get_proc_address)
    INIT_ALL_OF_THEM()
    test_classes()

    initialization.initialize = extensionInit
    initialization.deinitialize = extensionDeinit
    initialization.userdata     = nil
    initialization.minimum_initialization_level = .INITIALIZATION_SCENE
};`
  val_checker:= `val_check :: proc(source: any, values: ..any, loc:= #caller_location, struct_name:= #caller_expression(source)) {
    procedure := fmt.caprint(struct_name)
    file_path:= strings.clone_to_cstring(loc.file_path)
    //gdAPI.Logging.PrintWarning(struct_name_c, procedure, file_path, int(loc.line), true)
    for val, idx in values {
        MB_ptr, m_call:= expand_values((^struct{MB_ptr: rawptr, m_call: proc()})(val.data)^)
        if MB_ptr == nil {
          value:=fmt.caprint(val, "MethodBind failed")
          gdAPI.Logging.PrintError(value, procedure, file_path, loc.line, true)
          delete(value)
        }

        if m_call == nil {
          value:=fmt.caprint(val, "m_call failed")
          gdAPI.Logging.PrintError(value, procedure, file_path, loc.line, true)
          delete(value)
        }
    }
    delete(procedure)
    delete(file_path)
}`

  fmt.sbprint(&test_builder, File_Opening_Move, "\n",extension_entry, "\n", val_checker)


  classes_init_proc:= `//DO NOT DO THIS!!!!! iT TAKES 5 MINUTES TO COMPILE IN -O:SPEED
//speed in debug mode is still pretty fast though.
INIT_ALL_OF_THEM :: proc() {`
fmt.sbprint(&test_builder, classes_init_proc)
  MB_Holder_Init:= `  Classes.%s_Init_(&%[0]s_M_Holder)` //className
  for classes in final {
    fmt.sbprintf(&test_builder, MB_Holder_Init, classes.name, newline = true)
  }
  fmt.sbprint(&test_builder, `
}
`)
  MB_List_Holder:= `  %s_M_Holder: Classes.%[0]s_MethodBind_List` //className
  for classes in final {
    fmt.sbprintf(&test_builder, MB_List_Holder, classes.name, newline = true)
  }
  test_proc_name:: `test_classes :: proc() {`
  fmt.sbprint(&test_builder, test_proc_name)
  check_call:= `  val_check(%s_M_Holder, expand_values(%[0]s_M_Holder))`
  for classes in final {
    fmt.sbprintf(&test_builder, check_call, classes.name, newline = true)
  }
  fmt.sbprint(&test_builder, `
}
`)
  extension_init:= `extensionInit :: proc "c" (userdata: rawptr, init_Level: GDE.InitializationLevel) {
    context = runtime.default_context()
    //fmt.println(Toxin.reg_list)
    //There are multiple steps to the init process which Godot goes through.
    //You may want to register or intitialize certain aspects of your extension at different times.
    switch init_Level{
        case .INITIALIZATION_CORE:
            /*
            * Register the different classes which should be considered Core to the rest of the system.
            */
            
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Register the different classes which depend on core classes.
            */
            return
        case .INITIALIZATION_SCENE:
            /*
            * Register the different classes which depend on servers classes.
            */
            //Need to register our MainLoop callbacks at some point.
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Register the different classes which should be used with the Editor.
            */
            return
        //Prettys 
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            gdAPI.Logging.PrintWarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
        case :
            assert(true, "This should be impossible!!")
    };

    return
};;


//This function will be called when the Godot program is closing.
//It will be called once at each level of the deinit process.
//deinit is in reverse order with INITIALIZATION_EDITOR first and INITIALIZATION_CORE last.
extensionDeinit :: proc "c" (userdata: rawptr, deinitLevel: GDE.InitializationLevel) {
    context = runtime.default_context()

    switch deinitLevel{
        case .INITIALIZATION_CORE:
            /*
            * Free the different classes which should be considered Core to the rest of the system.
            */
            return
        case .INITIALIZATION_SERVERS:
            /*
            * Free the different classes which depend on core classes.
            */
            return
        case .INITIALIZATION_SCENE:
            /*
            * Free the different classes which depend on servers classes.
            */
            return
        //INITIALIZATION_EDITOR should only happen if running from the editor.
        case .INITIALIZATION_EDITOR:
            /*
            * Free the different classes which should be used with the Editor.
            */
            return
        case .MAX_INITIALIZATION_LEVEL:
            /*
            * This should be impossible unless they add a new level of initialization at some point.
            */
            gdAPI.Logging.PrintWarningWithMessage("I am MAX level.", "Maximum leve", "", "", 123, true)
            assert(true, "This should be impossible!!")
            return
        case :
            assert(true, "This should not be impossible!!")
    };
};;`
  fmt.sbprint(&test_builder, extension_init)

  is_Classes_init_open:bool
  gdextension_open: bool
  project_open: bool
  GDScript_open: bool
  Classes_init_test: ^os.File
  gdextension: ^os.File
  project_file: ^os.File
  GDScript_file: ^os.File
  classes_create_err: os.Error

  test_dir_err:= os.make_directory("Classes_init_test")
  if test_dir_err != nil && test_dir_err != .Exist{
    print_warning("could not create classes test folder.", test_dir_err)
  } else {
    Classes_init_test, classes_create_err = os.create("Classes_init_test/Classes_init_test.odin")
    if classes_create_err == .Exist{
      Classes_init_test, classes_create_err= os.open("Classes_init_test/Classes_init_test.odin",{.Write})
      if classes_create_err == nil {
        is_Classes_init_open = true
      } else {print_warning("could not open or create classes test file. ", classes_create_err)}
    }
    else if classes_create_err != nil {
      print_warning("could not create classes test file. ", classes_create_err)
    } else {
      is_Classes_init_open = true}
    
    gdextension, classes_create_err = os.create("Classes_init_test/Classes_test.gdextension")
    if classes_create_err == .Exist{
      gdextension, classes_create_err= os.open("Classes_init_test/Classes_test.gdextension",{.Write})
      if classes_create_err == nil {
        gdextension_open = true
      } else {print_warning("could not open or create Classes_test.gdextension test file. ", classes_create_err)}
    }
    else if classes_create_err != nil {
      print_warning("could not create Classes_test.gdextension test file. ", classes_create_err)
    } else {
      gdextension_open = true
    }
    
    project_file, classes_create_err = os.create("Classes_init_test/project.godot")
    if classes_create_err == .Exist{
      project_file, classes_create_err= os.open("Classes_init_test/project.godot",{.Write})
      if classes_create_err == nil {
        project_open = true
      } else {print_warning("could not open or create project.godot test file. ", classes_create_err)}
    }
    else if classes_create_err != nil {
      print_warning("could not create project.godot test file. ", classes_create_err)
    } else {
      project_open = true}
    
    GDScript_file, classes_create_err = os.create("Classes_init_test/Classes_test.gd")
    if classes_create_err == .Exist{
      GDScript_file, classes_create_err= os.open("Classes_init_test/Classes_test.gd",{.Write})
      if classes_create_err == nil {
        GDScript_open = true
      } else {print_warning("could not open or create project.godot test file. ", classes_create_err)}
    }
    else if classes_create_err != nil {
      print_warning("could not create project.godot test file. ", classes_create_err)
    } else {
      GDScript_open = true}
  }


  if is_Classes_init_open == true {
    wrote_count, classes_write_err:= os.write_string(Classes_init_test, strings.to_string(test_builder))
    if classes_write_err != nil {
      print_warning("could not save Classes_init_test.odin", classes_write_err)
    }
  }

  gdextension_file:: `[configuration]

entry_symbol = "godot_entry_init"
compatibility_minimum = "4.5"

[libraries]
linux.debug = "Classes_init_test.so"
windows.debug = "Classes_init_test.dll"
windows.release = "Classes_init_test.dll" : "Content/Frameworks"
macos.release = "Classes_init_test.dylib" : "Contents/Frameworks"
macos.debug = "Classes_init_test.dylib" : "Contents/Frameworks"`
  if gdextension_open == true {
    wrote_count, gdextension_err:= os.write_string(gdextension, gdextension_file)
    if gdextension_err != nil {
      print_warning("could not save Classes_test.gdextension", gdextension_err)
    }
  }

  godot_project_file:: `config_version=5`
  if is_Classes_init_open == true {
    wrote_count, project_err:= os.write_string(project_file, godot_project_file)
    if project_err != nil {
      print_warning("could not save project.godot", project_err)
    }
  }

  GDScript_file_txt:: `extends SceneTree

func _init():
    var manager = Engine.get_singleton("GDExtensionManager")
    if manager == null:
        print("GDExtensionManager not available")
        quit()
        return

    var path = "Classes_test.gdextension"

    var err = manager.load_extension(path)
    if err == OK:
        print("Extension loaded")
    else:
        print("Failed to load extension: ", err)
    
    quit(0)`
  if GDScript_open == true {
    wrote_count, project_err:= os.write_string(GDScript_file, GDScript_file_txt)
    if project_err != nil {
      print_warning("could not save project.godot", project_err)
    }
  }

  fmt.println("Write Comleted")
};

print_warning:: proc(message: string, error: os.Error) {
  fmt.println(message, error)
};



Method_Callback_Compare_Info :: `
Method_Callback_Compare_Info :: struct {
    name: GDW.StringName,
    p_hash: u32,
};`


ClassName_Index :: `
ClassName_Index :: enum {
  nil,
`

ClassName_StringNames :: `
@(private)
ClassName_StringNames : [ClassName_Index]GDW.StringName = {
  .nil = GDW.StringName({nil}),
`

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
};


build_init_proc :: proc(json_data: builtin, ctx: runtime.Allocator) -> ([dynamic]builtin_set) {
  
  builtin_map:= make([dynamic]builtin_set, ctx)

  ///////////////////////////////
  // Structure of the init proc
  ///////////////////////////////
  class_decl:=`%s :: ^Object`
  init_proc_sig:=`%s_Init_ :: proc (%[0]s_methods: ^%[0]s_MethodBind_List, loc := #caller_location) {{
  MB_ptr_call:=gdAPI.get_Interface_Address("object_method_bind_ptrcall")`
  //name, name, name
  Meth_Getter:=`  %s_methods.%s._%[1]s = (cast(^GDW.MethodBind)GDW.classDBGetMethodBind3(.%s, "%s", %v, loc))`
  //name, method.name, variant_type, method.name, hash
  ptrCall_getter:=`  %s_methods.%s.m_call = cast(type_of(%[0]s_methods.%[1]s.m_call))MB_ptr_call`
  //name, method.name, variant_type, method.name, hash
  Closing:=`};`

  /////////////////////////////
  // Structure of the builtin struct
  /////////////////////////////
  _MethodBind_List:= `%s_MethodBind_List :: struct {{` //name
  class_name:= `  %s: struct{{
    using _%[0]s: ^GDW.MethodBind,
    m_call: proc(_:^GDW.MethodBind, obj: %[1]s, `
  class_args_maybe:= `%s`//`struct{` //methodName
  class_args:=`%s: ^%s, `//argName, argType
  class_args_close:=`}`
  class_close:=`, r_ret: ^%s)
  },` //method.name
  /*
  is_relative_: struct{
    using _is_relative: ^GDW.MethodBind,
    m_call: proc(_:^GDW.MethodBind, p_instance: GDE.ObjectPtr, #by_ptr p_args: struct{_:^Toxin.Vector2}, r_ret: GDE.TypePtr = nil),
  },*/

  Virtual_Proc_Sig:=`
%s_Init_Virtuals_Info :: proc(info: ^%[0]s_Virtual_Info) {{`
//ClassName
  Virtual_Listing:= `    info.%[0]s.p_hash = %v
    info.%[0]s.name = GDW.StringConstruct("%[0]s")`
    //VirtualName, virtualHash
  Virtual_Struct_Sig:= `%s_Virtual_Info :: struct {{
`//ClassName
  Virtual_Struct_Field:= `    %s: Method_Callback_Compare_Info,`
//MethodName
  ////////////////////////////
  // Convert the unmarshalled json to Odin procs and structs
  ////////////////////////////
  for BUILT_FROM, idx in json_data.classes {
    init_builder:=strings.builder_make(ctx)
    struct_builder:=strings.builder_make(ctx)
    consts_builder:=strings.builder_make(ctx)
    //props_builder:=strings.builder_make(ctx)
    //props_init_builder:=strings.builder_make(ctx)
    enum_builder:=strings.builder_make(ctx) //btw, several enums have the same name but different fields based on the class they're part of.
    virtuals_builder:=strings.builder_make(ctx)
    virtuals_list_builder:=strings.builder_make(ctx)

    buffer:[400]u8
    //signature and struct declaration
    strings.write_string(&init_builder, fmt.bprintf(buffer[:], init_proc_sig, BUILT_FROM.name, newline =true))
    strings.write_string(&struct_builder, fmt.bprintf(buffer[:], _MethodBind_List, BUILT_FROM.name, newline =true))

    virtual_opened:=false
    //setup Methods
    if len(BUILT_FROM.methods) > 0 {
    for &method, idx in BUILT_FROM.methods {
      
      if !method.is_virtual {
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], Meth_Getter, BUILT_FROM.name, method.name, BUILT_FROM.name, method.name, method.hash, newline =true))
        strings.write_string(&init_builder, fmt.bprintf(buffer[:], ptrCall_getter, BUILT_FROM.name, method.name, newline =true))
        strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_name, method.name, BUILT_FROM.name, newline =false))
        
        if method.is_vararg {
          strings.write_string(&struct_builder, `#by_ptr args: struct{ vararg: [^]^GDW.Variant, count: ^GDE.Int, call_err: ^GDE.CallError }`)  
        }
        else if len(method.arguments) == 0 {
          strings.write_string(&struct_builder, `args: rawptr = nil`)
        }
        else
        {
          strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_args_maybe, `#by_ptr args: struct{`, newline =false))
          for &args in method.arguments{
            Correct_Type_String(&args.type, ctx)

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
              args.type, concat_err = strings.concatenate({"GDW.", args.type}, ctx)
              //assert(concat_err==nil, args.type)
              //delete(temp)
              strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_args, args.name, args.type, newline =false))
            } else
            {
              strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_args, args.name, args.type, newline =false))
            }
            //fmt.println(args.type, variant_type)
          }
          strings.write_string(&struct_builder, class_args_close)
        }

        if method.return_value.type == ""{
          strings.write_string(&struct_builder, `, r_ret: rawptr = nil)
  },
  `)
        }
        else
        {
          //fmt.println(method.return_value.type)
          Correct_Type_String(&method.return_value.type, ctx)
          //fmt.println(method.return_value.type)
          variant_type:GDE.VariantType= Get_Variant_Type_From_String(method.return_value.type)
          if variant_type != .NIL {
            temp:=method.return_value.type
            concat_err: runtime.Allocator_Error
            method.return_value.type, concat_err = strings.concatenate({"GDW.", method.return_value.type}, ctx)
            //assert(concat_err==nil, method.return_value.type)
            //delete(temp)
          }
          strings.write_string(&struct_builder, fmt.bprintf(buffer[:], class_close, method.return_value.type, newline =true))
        }
      } else {
        if virtual_opened == false {
          //open init proc
          strings.write_string(&virtuals_builder, fmt.bprintf(buffer[:], Virtual_Proc_Sig, BUILT_FROM.name, newline =true))
          strings.write_string(&virtuals_list_builder, fmt.bprintf(buffer[:], Virtual_Struct_Sig, BUILT_FROM.name, newline =true))
          virtual_opened = true
        }
        //write the name and hash
        strings.write_string(&virtuals_builder, fmt.bprintf(buffer[:], Virtual_Listing, method.name, method.hash, newline =true))
        strings.write_string(&virtuals_list_builder, fmt.bprintf(buffer[:], Virtual_Struct_Field, method.name, newline =true))
      }
      //All virtuals SHOULD come before any other methods.
      if virtual_opened && (idx == len(BUILT_FROM.methods) - 1 || method.is_virtual == false) {
        strings.write_string(&virtuals_builder, fmt.bprintf(buffer[:], Closing, newline =true))
        strings.write_string(&virtuals_list_builder, fmt.bprintf(buffer[:], Closing, newline =true))
        virtual_opened = false
        //fmt.println(strings.to_string(virtuals_builder))
      }
    }
    }
    //pinch it off
    strings.write_string(&init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
    strings.write_string(&struct_builder, fmt.bprintf(buffer[:], Closing, newline =true))


    //Constants are just floating around
    //Constants only exist for compound types such as vec2, basis etc.
    consts:= `%s_Constants :: enum i64 {{`
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
    property_value:= `  %s_%s : struct {{
  %s: proc "c" (p_base: %s, r_value: ^GDW.%[1]s),`
    property_value_setter:=`  %s: proc "c" (p_base: %s, p_value: ^GDW.%s),`
    property_value_class:= `  %s_%s : struct {{
    %s: proc "c" (p_base: %s, r_value: ^%[1]s),`
    property_value_setter_class:=`    %s: proc "c" (p_base: %s, p_value: ^%s),`
    prop_closure:= `  },
`
    /*
OpenXRActionMap_properties :: struct {
  action_sets_OpenXRActionSet : struct {
  get_action_sets: proc "c" (p_base: OpenXRActionMap, r_value: ^OpenXRActionSet),
  set_action_sets: proc "c" (p_base: OpenXRActionMap, p_value: ^OpenXRActionSet),
  },
}*/
    property_init:= `%[0]s_init_props :: proc(%[0]s_prop: ^%[0]s_properties, loc:= #caller_location) {{`
    property_methodbind_getter_bltn:= `
  %s_prop.%s_%s.%s = cast(proc "c" (p_base: %[0]s, r_value: ^GDW.%[2]s))GDW.Get_Method_Getter(.%[4]s, "%[3]s")`
    property_methodbind_setter_bltn:= `  %s_prop.%s_%s.%s = cast(proc "c" (p_base: %[0]s, p_value: ^GDW.%[2]s))GDW.Get_Method_Setter(.%[4]s, "%[3]s")`
    property_methodbind_getter_class:= `
  %s_prop.%[1]s_%[2]s.%[3]s = cast(proc "c" (p_base: %[0]s, r_value: ^%[2]s))GDW.Get_Method_Getter(.OBJECT, "%[3]s")`
    property_methodbind_setter_class:= `  %s_prop.%s_%s.%[3]s = cast(proc "c" (p_base: %[0]s, p_value: ^%[2]s))GDW.Get_Method_Setter(.OBJECT, "%[3]s")`
/*
OpenXRActionMap_init_props :: proc(OpenXRActionMap_prop: ^OpenXRActionMap_properties, loc:= #caller_location) {

  OpenXRActionMap_prop.action_sets_OpenXRActionSet.get_action_sets = cast(proc "c" (p_base: OpenXRActionMap, r_value: ^OpenXRActionSet))GDW.Get_Method_Getter(.OBJECT, "get_action_sets")
  OpenXRActionMap_prop.action_sets_OpenXRActionSet.set_action_sets = cast(proc "c" (p_base: OpenXRActionMap, p_value: ^OpenXRActionSet))GDW.Get_Method_Setter(.OBJECT, "set_action_sets")
}
*/

/*
    if len(BUILT_FROM.properties) > 0 {
      
      strings.write_string(&props_builder, fmt.bprintf(buffer[:], propetry_header, BUILT_FROM.name, newline =true))
      strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_init, BUILT_FROM.name, newline =true))
      for &properties in BUILT_FROM.properties {
        variant_type:GDE.VariantType= Get_Variant_Type_From_String(properties.type)
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
        if strings.contains( properties.type, "typedarray") {
            delete(properties.type)
            properties.type = "Array"
            variant_type = .ARRAY
        } else
        if strings.contains( properties.type, "typeddictionary") {
            delete(properties.type)
            properties.type = "Dictionary"
            variant_type = .DICTIONARY
        } else
        if strings.contains(properties.type, "enum") {
            temp:=properties.type
            ok:bool
            properties.type, ok = strings.replace(properties.type, "enum::", "", 0, ctx)
            assert(ok, "could not allocate new string for type")
            delete(temp)
            variant_type = .INT
        } else
        if strings.contains(properties.type, "bitfield") {
            temp:=properties.type
            ok:bool
            properties.type, ok = strings.replace(properties.type, "bitfield::", "", 0, ctx)
            assert(ok, "could not allocate new string for type")
            delete(temp)
            variant_type = .INT
        }
        if strings.contains( properties.type, ",") {
          //If there's multiple options it is for certain an object type
          temp:=properties.type
          options:=strings.split(temp, ",", context.temp_allocator)
          //delete(temp)
          for &option in options{
            ok:bool
            temp, ok = strings.remove(option, "-", -1, context.temp_allocator)
            if ok {
                //fmt.println("'-' was removed", option)
                option = temp
            }
            strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_getter_class, BUILT_FROM.name, properties.name, option, properties.getter, newline =true))
            strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value_class, properties.name, option, properties.getter, BUILT_FROM.name, newline =true))
            if properties.setter != "" {
              strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_setter_class, BUILT_FROM.name, properties.name, option, properties.setter, newline =true))
              strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value_setter_class, properties.setter, BUILT_FROM.name, option, newline =true))
            }
            strings.write_string(&props_builder, prop_closure)
          }
          free_all(context.temp_allocator)
          continue
        } 
        if variant_type == .NIL {
          variant_type = .OBJECT
          strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_getter_class, BUILT_FROM.name, properties.name, properties.type, properties.getter, newline =true))
          strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value_class, properties.name, properties.type, properties.getter, BUILT_FROM.name, newline =true))
          if properties.setter != "" {
            strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_setter_class, BUILT_FROM.name, properties.name, properties.type, properties.setter, newline =true))
            strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value_setter_class, properties.setter, BUILT_FROM.name, properties.type, newline =true))
          }
          strings.write_string(&props_builder, prop_closure)
        } else {
          strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_getter_bltn, BUILT_FROM.name, properties.name, properties.type, properties.getter, variant_type, newline =true))
          strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value, properties.name, properties.type, properties.getter, BUILT_FROM.name, newline =true))
          if properties.setter != "" {
            strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], property_methodbind_setter_bltn, BUILT_FROM.name, properties.name, properties.type, properties.setter, variant_type, newline =true))
            strings.write_string(&props_builder, fmt.bprintf(buffer[:], property_value_setter, properties.setter, BUILT_FROM.name, properties.type, newline =true))
          }
          strings.write_string(&props_builder, prop_closure)
        }
        
      }
      //Close properties and prop inits
      strings.write_string(&props_builder, fmt.bprintf(buffer[:], Closing, newline =true))
      strings.write_string(&props_init_builder, fmt.bprintf(buffer[:], Closing, newline =true))
      //fmt.println(strings.to_string(props_builder))
      //fmt.println(strings.to_string(props_init_builder))
    }
*/
    //fmt.println(strings.to_string(init_builder))
    //fmt.println(strings.to_string(struct_builder))
    //fmt.println(BUILT_FROM.name)

    /////////////////////////
    // ENUMS
    ////////////////////////
    enum_name:= `
%s_%s :: enum i64 {{`
    enum_field:= `  %s = %v,`
    ebit_field:= `  %s,`
          enum_flags:= `
%s_%s_Flags :: bit_set [%[0]s_%[1]s; i64]`

    if len(BUILT_FROM.enums) > 0 {
      for constants in BUILT_FROM.enums {
        if constants.is_bitfield == true {
        strings.write_string(&enum_builder, fmt.bprintf(buffer[:], enum_flags, BUILT_FROM.name, constants.name, newline =false))
        }
        strings.write_string(&enum_builder, fmt.bprintf(buffer[:], enum_name, BUILT_FROM.name, constants.name, newline =true))
        for val in constants.values {
          if constants.is_bitfield {
            strings.write_string(&enum_builder, fmt.bprintf(buffer[:], ebit_field, val.name, newline =true))
          } else
          {
            strings.write_string(&enum_builder, fmt.bprintf(buffer[:], enum_field, val.name, val.value, newline =true))
          }
        }
        strings.write_string(&enum_builder, fmt.bprintf(buffer[:], Closing, newline =true))
      }
      //fmt.println(strings.to_string(enum_builder))
    }

    //Append all the work we did to the array of classes.
    append(&builtin_map, builtin_set{BUILT_FROM.name, strings.to_string(init_builder), strings.to_string(struct_builder), strings.to_string(consts_builder), \
      strings.to_string(enum_builder), strings.to_string(virtuals_builder), strings.to_string(virtuals_list_builder)})
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


Correct_Type_String :: proc(muh_type: ^string, ctx: runtime.Allocator) {
  ok:bool
  if muh_type^ == string("Side") do fmt.println(muh_type^)
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
      //delete(temp)
  }
  if strings.contains(muh_type^, ".") {
    temp:=muh_type^
    muh_type^, ok = strings.replace(muh_type^, ".", "_", -1, ctx)
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
    }

    return 
  }
  if strings.contains(muh_type^, "const void") {
      delete(muh_type^)
      muh_type^ = "GDW.void"
      fmt.println(muh_type^)
      return 
  }
  if muh_type^ == "Variant_Type" {
      delete(muh_type^)
      muh_type^ = "GDE.VariantType"
  }
  return
}