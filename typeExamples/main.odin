package main

import "core:fmt"
import sics "base:intrinsics"
import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import str "core:strings"
import s "core:slice"
import "core:unicode/utf8"

@export
godot_entry_init :: proc "c" (p_get_proc_address : GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, r_initialization: ^GDE.Initialization) {
    context = runtime.default_context()
    
    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    r_initialization.initialize     = initialize_gdexample_module
    r_initialization.deinitialize   = deinitialize_gdexample_module

}


//*************************\\
//*****Class Variables*****\\
//*************************\\

//Struct to hold node data.
//This struct should hold the class variables. (following the C guide)
GDExample :: struct{
    //REQUIRED
    object: GDE.ObjectPtr,
    amplitude: f64,
}

//****************************\\
//******Functions/Methods*****\\
//****************************\\

//TODO: make these functions automatically.
ClassSetAmplitude :: proc "c" (self: ^GDExample, amplitude: f64) {
    self.amplitude = amplitude
}

ClassGetAmplitude :: proc "c" (self: ^GDExample) -> f64 {
    return self.amplitude
}

//required fields. 
//classname
//parentname
//creationinfo4 - I feel like this should be defined by the user. Not going to be able to assume much.
//Create instance and Free instance should be written by the user. Can't assume how they want to handle the memory.
//Can we create an allocator dynamically? Allow for us to free all at once when the instanc needs to be culled.
initialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level:  GDE.InitializationLevel){

    if p_level != .INITIALIZATION_SCENE{
        return
    }
    
    context = runtime.default_context()

    fmt.println("AAAAAAAAAaaaaaaahhhh")

    
    // Get ClassDB methods here because the classes we need are all properly registered now.
    // See extension_api.json for hashes.
    native_class_name: GDE.StringName;
    method_name: GDE.StringName;

    types := [3]typeid{int, f64, GDE.Vector2}

    fmt.println(s.linear_search(types[:], typeid_of(GDE.Vector2)))

    fmt.println(types)

    //GDW.methods.objectEmitSignal = GDW.classDBGetMethodBind("Object", "emit_signal", 4047867050)
    //GDW.methods.node2dGetPos = GDW.classDBGetMethodBind("Node2D", "get_position", 3341600327)
    //GDW.methods.node2dSetPosition = GDW.classDBGetMethodBind("Node2D", "set_position", 743155724)


    //I'm not 100% sure what is easier. "force" the user to use the Godot types,
    //or ask them to correctly pass the enum type each time.
    //Since Godot has overlapping types, I'm not sure if it matters.
    variant: GDE.Variant
    variant2: GDE.Variant
    value: f64 = 32
    value2: f64 = 32

    GDW.variantfrom.FloatToVariant(&variant, &value)
    fmt.printfln("THEVARIANT: %b", variant)
    fmt.printfln("THEVALUE: %b", transmute([1]u64)value)

    fmt.println("~~~~f64~~~~")
    rValue:f64
    GDW.variant_from(&variant, &value)
    fmt.printfln("THEVARIANT: ", variant)
    fmt.printfln("THEVALUE: ", value)

    GDW.variant_to(&variant, &rValue)
    fmt.printfln("THEVARIANT: ", variant)
    fmt.printfln("THEVALUE: ", rValue)

    //will know what to do whether passed as a struct or as an array.
    //^^^^Referencing the default Godot functions as used below
    fmt.println("~~~~vec2 v2~~~~")
    vec2:= [2]f32 {1, 2}
    GDW.variantfrom.Vec2ToVariant(&variant, &vec2)
    fmt.printfln("THEVARIANT: %b", transmute([2]f32)variant.data[0])
    fmt.printfln("THEVALUE: %b", vec2[:])
    
    GDW.variant_from(&variant, cast(^GDE.Vector2)(&vec2))
    fmt.printfln("THEVARIANT: %b", transmute([2]f32)variant.data[0])
    fmt.printfln("THEVALUE: %b", vec2[:])
    
    //Even if the source is longer than what it fits it will only take what fits.
    fmt.println("~~~~rec2 f32~~~~")
    rec2:GDE.Rec2
    rec2 = {1, 2,3,4}
    GDW.variant_from(&variant, &rec2)
    fmt.printfln("THEVARIANTrec2: %b", transmute([4]f32)variant.data)
    fmt.printfln("THEVALUErec2: %b", rec2[:])
    
    GDW.variant_to(&variant, &rec2)
    fmt.printfln("THEVARIANTrec2: %b", transmute([4]f32)variant.data)
    fmt.printfln("THEVALUErec2: %b", rec2[:])
    
    fmt.println("~~~~transform2d~~~~")
    trans2:GDE.Transform2d
    trans2 = {1, 2, 3, 4, 5, 6}
    GDW.variant_from(&variant, &trans2)
    fmt.printfln("THEVARIANTtrans2: %b", (transmute(^GDE.Transform2d)variant.data[0])^)
    fmt.printfln("THEVALUEtrans2: %b", trans2)
    fmt.printfln("THEVALUEtrans2: %p", &trans2)
    fmt.printfln("THEVALUEtrans2: %p", variant.data[0])
    
    //Remember, Transform2d copies to a memory bucket in Godot, so need to destroy it.
    GDW.destructors.variantDestroy(&variant)
    
    fmt.println("~~~~Bool~~~~")
    bools:GDE.Bool=false
    GDW.variant_from(&variant, &bools)
    fmt.println("The variant: ", cast(b8)variant.data[0])
    bools = true
    GDW.variant_from(&variant, &bools)
    fmt.println("The variant: ", cast(b8)variant.data[0])

    fmt.println("~~~~String~~~~")
    myString: GDE.gdstring
    GDW.stringconstruct.stringNewUTF8(&myString, "This is my string")
    //fmt.println(str.string_from_ptr(transmute([^]u8)variant.data[0], 17))
    GDW.variant_from(&variant, &myString)
    fmt.println("String in Variant (it's unicode) : ", (cstring(transmute(rawptr)variant.data[0])))
    //fmt.println("String data? : ", cstring(transmute(rawptr)variant.data[0]))
    destString: GDE.gdstring
    GDW.variant_to(&variant, &destString)
    //Shows that Godot creates strings that are Unicode.
    fmt.printfln("Final string: ", (transmute([^]u8)destString[0])[:17])
    buff:[20]u8
    returnedSize:GDE.Int
    returnedSize = GDW.stringconstruct.utf8FromString(&destString, raw_data(buff[:]), 20)
    fmt.println("GDString back to utf8", string(buff[:returnedSize]))

    //Don't forget to destroy your strings.
    GDW.destructors.stringDestruction(&myString)
    GDW.destructors.stringDestruction(&destString)
    GDW.destructors.variantDestroy(&variant)

    fmt.println("~~~~Vector2i~~~~")
    vec2i: GDE.Vector2i = {3, 4}
    fmt.println("Original Vector2i", vec2i)
    GDW.variant_from(&variant, &vec2i)
    fmt.println("Value stored in Variant: ", transmute(GDE.Vector2i)(variant.data[0]))
    r_vec2i: GDE.Vector2i
    GDW.variant_to(&variant, &r_vec2i)
    fmt.println("Value returned from Variant: ", r_vec2i)
    
    //variant3: GDE.Variant

    fmt.println("~~~~Rec2i~~~~")
    rec2i: GDE.Rec2i
    rec2i= {3, 4, 9, 10}
    fmt.println("Original Rec2i", rec2i)
    GDW.variant_from(&variant, &rec2i)
    fmt.println("Value stored in reci Variant: ", transmute([4]i32)variant.data)
    r_rec2i: GDE.Rec2i
    GDW.variant_to(&variant, &r_rec2i)
    fmt.println("Value returned from reci Variant: ", r_rec2i)

    fmt.println("~~~~vec3~~~~")
    vec3: GDE.Vector3 = {3,4,5}
    fmt.println("Original vec3: ", vec3)
    GDW.variant_from(&variant, &vec3)
    //fmt.println("Value stored in vec3 variant: ", transmute([4]f32)variant.data)
    fmt.println("Value stored in vec3 variant: ", (cast(^[3]f32)(&variant.data))^)
    r_vec3: GDE.Vector3
    GDW.variant_to(&variant, &r_vec3)
    fmt.println("Returned vec3 from variant: ", r_vec3)

    aPlane: GDE.Plane = {1,2,3,4}
    fmt.println("~~~~Plane~~~~")
    fmt.println("Original Plane values: ", aPlane)
    GDW.variant_from(&variant, &aPlane)
    fmt.println("Value stored in Plane variant: ", (cast(^GDE.Plane)(&variant.data))^)
    r_Plane: GDE.Plane
    GDW.variant_to(&variant, &r_Plane)
    fmt.println("Value returned from variant: ", r_Plane)

    fmt.println("~~~~Quaternion~~~~")
    aQuat: GDE.Quaternion = quaternion(w=1, x=2, y=3, z=4)
    fmt.println("Original Quaternion: ", aQuat)
    GDW.variant_from(&variant, &aQuat)
    fmt.println("Value stored in quaternion variant: ", (cast(^GDE.Quaternion)(&variant.data))^)
    r_Quat:GDE.Quaternion
    GDW.variant_to(&variant, &r_Quat)
    fmt.println("Quaternion value returned from variant: ", r_Quat)

    fmt.println("~~~~AABB~~~~")
    someAABB: GDE.AABB = {4,5,6,7,8,9}
    fmt.println("Original AABB value: ", someAABB)
    GDW.variant_from(&variant, &someAABB)
    fmt.println("Value stored in AABB variant: ", (cast(^^GDE.AABB)&variant.data)^^)
    r_AABB: GDE.AABB
    GDW.variant_to(&variant, &r_AABB)
    fmt.println("Value returned from AABB variant: ", r_AABB)

    fmt.println("AABB doesn't fit in 128b. Don't forget to destroy.")
    fmt.println("GDW.destructors.variantDestroy(&variant)")
    GDW.destructors.variantDestroy(&variant)

    fmt.println("~~~~Basis~~~~")
    someBasis: GDE.Basis = {0,1,2,
                            3,4,5,
                            6,7,8}
    fmt.println("Value stored in Basis: ", someBasis)
    GDW.variant_from(&variant, &someBasis)
    fmt.println("Value stored in Basis variant: ", (cast(^^GDE.Basis)&variant.data)^^)
    r_Basis: GDE.Basis
    GDW.variant_to(&variant, &r_Basis)
    fmt.println("Value returned from variant: ", r_Basis)

    
    fmt.println("Basis doesn't fit in 128b. Don't forget to destroy.")
    fmt.println("GDW.destructors.variantDestroy(&variant)")
    GDW.destructors.variantDestroy(&variant)

    fmt.println("~~~~Transform3d~~~~")
    someTrans3d: GDE.Transform3D
    fmt.println("Original value of Transform3d: ", someTrans3d)
    GDW.variant_from(&variant, &someTrans3d)
    fmt.println("Value stored in trans3d variant: ", (cast(^^GDE.Transform3D)&variant.data)^^)
    r_trans3d: GDE.Transform3D
    GDW.variant_to(&variant, &r_trans3d)
    fmt.println("Valure returned from variant: ", r_trans3d)
    
    fmt.println("Tranform3d doesn't fit in 128b. Don't forget to destroy.")
    fmt.println("GDW.destructors.variantDestroy(&variant)")
    GDW.destructors.variantDestroy(&variant)


    fmt.println("~~~~Projection~~~~")
    someProjection: GDE.Projection  =  {1,2,3,4,
                                        5,6,7,8,
                                        9,10,11,12,
                                        13,14,15,16}
    fmt.println("Original value in Projection: ", someProjection)
    GDW.variant_from(&variant, &someProjection)
    fmt.println("Value stored in projection variant: ", (cast(^^GDE.Projection)&variant.data)^^)
    r_projection: GDE.Projection
    GDW.variant_to(&variant, &r_projection)
    fmt.println("Value returned from projection variant: ", r_projection)
    
    fmt.println("Projection doesn't fit in 128b. Don't forget to destroy.")
    fmt.println("GDW.destructors.variantDestroy(&variant)")
    GDW.destructors.variantDestroy(&variant)

    fmt.println("~~~~Color~~~~")
    someColor: GDE.Color = {4,5,6,7}
    fmt.println("Original value in color: ")
    GDW.variant_from(&variant, &someColor)
    fmt.println("Value stored in color variant: ", (cast(^GDE.Color)&variant.data)^)
    r_color: GDE.Color
    GDW.variant_to(&variant, &r_color)
    fmt.println("Value returned from color variant: ", r_color)


    fmt.println("~~~~StringName~~~~")
    fmt.println("StringNames need to be created via Godot built-ins.")
    aStringName: GDE.StringName
    GDW.stringconstruct.stringNameNewLatin(&aStringName, "Node2D", false)
    fmt.println("StringNames are pointers to a hashed value in Godot's StringName memory pool.")
    fmt.println("If you want to compare StringNames you can simply check if they're pointing to the same address.")
    fmt.println("Original StringName address: ", aStringName)
    GDW.variant_from(&variant, &aStringName)
    fmt.println("Pointer stored in StringName variant: ", transmute(rawptr)variant.data[0])
    r_stringname: GDE.StringName
    GDW.variant_to(&variant, &r_stringname)
    fmt.println("Returned StringName: ", r_stringname)

    fmt.println("You don't always need to destroy stringnames, but if you don't need to use it again you should.")
    GDW.destructors.stringNameDestructor(&aStringName)
    GDW.destructors.variantDestroy(&variant)


    fmt.println("~~~~NodePath~~~~")
    fmt.println("NodePaths are strings representing the path to a Node in a tree much like a filesystem representations.")
    fmt.println("A/B")
    GDW.stringconstruct.stringNewUTF8(&myString, "A/B")
    GDW.variant_from(&variant, &myString)
    fmt.println("Strings just hold pointers to things, so hope I hope this worked.")

    GDW.destructors.stringDestruction(&myString)


    fmt.println("~~~~RID~~~~")
    fmt.println("RIDs aren't going to be something we build ourselves.")
    
    fmt.println("~~~~Object~~~~")
    fmt.println("Object aren't going to be something we build ourselves.")
    
    fmt.println("~~~~Callable~~~~")
    fmt.println("Callable aren't going to be something we build ourselves.")
    
    fmt.println("~~~~Signal~~~~")
    fmt.println("I think Signal aren't going to be something we build ourselves.")
    fmt.println("I haven't had to use this, so not certain how this is used. When we receive signals? Or share signals?")


    fmt.println("~~~~PackedArray~~~~")

    
    fmt.println("~~~~int operation~~~~")
    value3:f64=64
    value4:f64=64
    fmt.println("Comparing values: ", value3, value4)
    GDW.variant_from(&variant, &value3)
    fmt.printfln("THEVARIANT: ", variant)
    fmt.printfln("THEVALUE: ", value)
    GDW.variant_from(&variant2, &value4)
    GDW.variant_from(&variant, &value3)
    GDW.variant_from(&variant2, &value4)
    fmt.printfln("%b", transmute([3]u64)variant2)
    fmt.printfln("%b", transmute([3]u64)variant)

    opReturn:GDE.Bool
    GDW.variantOperator(.VARIANT_OP_EQUAL, &variant, &variant2, &opReturn)

    fmt.println(opReturn)
    value3=64
    value4=94
    fmt.println("Comparing values: ", value3, value4)
    GDW.variant_from(&variant, &value3)
    fmt.printfln("THEVARIANT: ", variant)
    fmt.printfln("THEVALUE: ", value)
    GDW.variant_from(&variant2, &value4)
    GDW.variant_from(&variant, &value3)
    GDW.variant_from(&variant2, &value4)
    fmt.printfln("%b", transmute([3]u64)variant2)
    fmt.printfln("%b", transmute([3]u64)variant)

    GDW.variantOperator(.VARIANT_OP_EQUAL, &variant, &variant2, &opReturn)

    fmt.println(opReturn)

    /*
    //Not sure it's breaking if not in the create. Might look into this later.
    //Either way, will need to expand the array helper accordingly.
    uninitptr: GDE.Variant
    godotMake: GDE.PackedVector2Array
    myArray:= make([dynamic]f32)
    append_elem(&myArray, 563)
    storage:rawptr
    

    multiray:= [?]rawptr {raw_data(myArray)}

    //fmt.println(godotMake)
    //GDW.arrayhelp.packedf32create0(&godotMake, nil)
    fmt.println(godotMake)

    
    //Need to setup a dynamic(?) array with the first u64 containing the size.
    sizeIncluded:=make([dynamic]i64)
    resize(&sizeIncluded, 5)
    //defer delete(sizeIncluded)

    sizeIncluded[0] = 0
    sizeIncluded[1] = 0
    sizeIncluded[2] = 1
    sizeIncluded[3] = 1
    sizeIncluded[4] = max(i64)
    //sizeIncluded[5] = 4

    fmt.println("size value: ", (transmute([dynamic]u32)sizeIncluded)[:1])
    fmt.println("value: ", sizeIncluded[2])
    godotMake[1] = transmute(u64)(raw_data(transmute([dynamic]f32)sizeIncluded))

    //godotMake:= GDW.api.mem_alloc(size_of(GDE.PackedVector2Array))
    //fmt.println((cast(^GDE.PackedVector2Array)godotMake)^)
    ray:=[?]rawptr{&godotMake}
    fmt.println(uninitptr)
    newSize: u64 = 1
    newValue: i64 = 97
    args:= [?]rawptr {&newSize}
    args2:= [?]rawptr {&newValue}
    index:u64=0
    set:= [?]rawptr {&index, &newValue}
    

    newpackedmake:= [?]rawptr{storage, &sizeIncluded[4]}
    fmt.println("address of 1: ", &sizeIncluded[4])
    fmt.println("address of 1: (size)", &sizeIncluded[3])
    fmt.println("My array data: ", newpackedmake)
    
    from:= []rawptr {&newpackedmake}

    testCreate:= [?]rawptr{storage, nil}
    fmt.println("maybe ref count: ", sizeIncluded[2])
    //GDW.variantfrom.packedf32arrayToVariant(&uninitptr, nil)
    fmt.println("My Godot Type: ", testCreate)
    fmt.println("My Godot Type: ", uninitptr)

    //Does this even do anything? When everything is a null pointer or 0 it returns nothing and skips over mem allocs
    //Eventually it even goes through the destructors for the vector and cowdata.
    GDW.arrayhelp.packedi32create0(&testCreate, nil)
    
    //Resize or append locks in the memory for the array. Also sets the ref count.
    appended:=false
    GDW.arrayhelp.packedi32Append(&testCreate, raw_data(args2[:]), &appended, 1)
    //Resize is supposed to size to 97
    GDW.arrayhelp.packedi32REsize(&testCreate, raw_data(args2[:]), &returnedSize, 1)
    fmt.println(returnedSize)
    GDW.arrayhelp.packedi32size(&testCreate, nil, &returnedSize, 0)
    fmt.println(returnedSize)
    fmt.println("My Godot Type: ", testCreate)

    //set index 0, value 97
    GDW.arrayhelp.packedi32Set(&testCreate, raw_data(set[:]), nil, 2)
    GDW.arrayhelp.packedi32Get(&testCreate, raw_data(set[:]), &returnedSize, 1)
    fmt.println(returnedSize)
    GDW.arrayhelp.packedi32Append(&testCreate, raw_data(args2[:]), &appended, 1)
    GDW.arrayhelp.packedi32size(&testCreate, nil, &returnedSize, 0)
    fmt.println(returnedSize)
    fmt.println((cast(^[98]i64)testCreate[1])^)
    GDW.arrayhelp.packedi32Destroy(&testCreate)*/


    /*
    Vec3itoVariant,
    Vec4toVariant,
    Vec4itoVariant,
    
    RidtoVariant,
    ObjecttoVariant,
    CallabletoVariant,
    SignaltoVariant,

    //All these need built-in methods found in the json file.
    DictionarytoVariant,

    ArraytoVariant,
    PackedByteArraytoVariant,
    Packedi32ArraytoVariant,
    Packedi64ArraytoVariant,
    Packedf32ArraytoVariant,
    Packedf64ArraytoVariant,
    PackedStringArraytoVariant,
    PackedVec2ArraytoVariant,
    PackedColorArraytoVariant,
    PackedVec4ArraytoVariant,*/


    class_name: GDE.StringName
    parent_class_name: GDE.StringName
    //Name for my own class.
    //fmt.println("AAAAAAAAAaaaaaaahhhh")
    GDW.stringconstruct.stringNameNewLatin(&class_name, "GDExample", false)
    //fmt.println("AAAAAAAAAaaaaaaahhhh")
    //Name of the class that I'm inheritting from.
    GDW.stringconstruct.stringNameNewLatin(&parent_class_name, "Sprite2D", false)

    stringptr:GDE.gdstring
    //fmt.println("AAAAAAAAAfter methodBind")

    
    GDW.variantfrom.StringNameToVariant(&variant, &parent_class_name)
    fmt.printfln("THEVARIANT: %b", variant)
    fmt.printfln("THEVALUE: %b", parent_class_name[:])
    //fmt.println(variant.data[1] == parent_class_name[0])

    fmt.println("ENUM MAX: ", i32(GDE.VariantType.VARIANT_MAX))

    GDW.destructors.variantDestroy(&variant)

    
    iconString: GDE.gdstring
    icon:= "res://icon.svg"
    mystring:=str.clone_to_cstring(icon)
    //^^^^^There is a string maker that takes lenght, so might not need to be cloning these.
    
    //Does indeed create a string in some kind of memory.
    GDW.stringconstruct.stringNewLatin(&iconString, mystring)
    //Pointers just need to be packed data of the correct bit length. The type gdstring was declared above.
    //Though maybe Godot expects a struct format for their templates.
    //stringgd: gdstring
    //GDW.stringconstruct.stringNewLatin(&stringgd, "res://icon.svg")
    //But odin takes care of sizing based on 32 or 64 bit, so just us rawptr.
    
    //fmt.println("AAAAAAAAAfter string")
    //To get access to the string you need to cast it to another pointer type then dereference.
    //To properly handle this directly we'd need to be able to know the underlying memory setup of a C++ string.
    //fmt.println((cast(^i8)stringraw)^)

    //Will need to get more info about how these settings affect classes. Ex runtime?
    class_info: GDE.ClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &iconString, //For some reason does not work with UTF8 strings??
        set_func = nil,
        get_func = nil,
        get_property_list_func = nil,
        free_property_list_func = nil,
        property_can_revert_func = nil,
        property_get_revert_func = nil,
        validate_property_func = nil,
        notification_func = nil,
        to_string_func = nil,
        reference_func = nil,
        unreference_func = nil,
        create_instance_func = gdexampleClassCreateInstance,
        free_instance_func = gdexampleClassFreeInstance,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func = nil,
        call_virtual_with_data_func = nil,
        class_userdata = nil, 
    }
    //fmt.println("AAAAAAAAAaafter struct")


    //Register Class
    GDW.api.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //fmt.println("AAAAAAAAAaaaaaaahhhh", &GDW.Library, &class_name, &parent_class_name, &class_info)
    
    gdexample_class_bind_method()
    //fmt.println("binding completed")


    GDW.destructors.stringNameDestructor(&class_name)
    GDW.destructors.stringNameDestructor(&parent_class_name)
    GDW.destructors.stringDestruction(&iconString)

}

deinitialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level: GDE.InitializationLevel){

}


gdexample_class_bind_method :: proc "c" () {
    context = runtime.default_context()
    //fmt.println("bind methods")

    arrayClass:= new(GDE.StringName)
    GDW.stringconstruct.stringNameNewLatin(&arrayClass, "PackedInt64Array", false)
    arraySize:= new(GDE.StringName)
    GDW.stringconstruct.stringNameNewLatin(&arraySize, "size", false)
    GDW.arrayhelp.packedi32size = GDW.api.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 3173160232)

    GDW.stringconstruct.stringNameNewLatin(&arraySize, "resize", false)
    GDW.arrayhelp.packedi32REsize = GDW.api.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 848867239)
    
    GDW.stringconstruct.stringNameNewLatin(&arraySize, "append", false)
    GDW.arrayhelp.packedi32Append = GDW.api.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 694024632)

    GDW.stringconstruct.stringNameNewLatin(&arraySize, "get", false)
    GDW.arrayhelp.packedi32Get = GDW.api.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 4103005248)

    GDW.stringconstruct.stringNameNewLatin(&arraySize, "set", false)
    GDW.arrayhelp.packedi32Set = GDW.api.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 3638975848)

    
    //GDW.arrayhelp.packedf32Get(&uninitptr.data[1], raw_data(args[:]), &newValue, 1)
    //fmt.println("value at index: ",newValue)
    //fmt.println("original arrat: ", mypacked)
    //fmt.println("arrat pointer: ", packed.unsafe_data[0])
    //GDW.bindMethod0r("GDExample", "get_amplitude", ClassGetAmplitude, .FLOAT)
    //GDW.bindMethod1("GDExample", "set_amplitude", ClassSetAmplitude, "amplitude", .FLOAT)
}


//Create instance will always run on program launch regardless if it's in the scene or not.
//This will also run when the scene starts. Once for each instance of the Node present in the tree.
gdexampleClassCreateInstance :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    //fmt.println("2222222222")
    
    //create native Godot object.
    //Here we create an object that is part of Godot core library.
    class_name : GDE.StringName
    GDW.stringconstruct.stringNameNewLatin(&class_name, "Sprite2D", false)
    object: GDE.ObjectPtr = GDW.api.classDBConstructObj(&class_name)
    GDW.destructors.stringNameDestructor(&class_name)

    //Create extension object.
    //Can replace mem_alloc with new(). Just need to create the struct and pass a pointer.
    //self: ^GDExample = cast(^GDExample)GDW.api.mem_alloc(size_of(GDExample))
    self: ^GDExample = new(GDExample)

    //constructor is called after creation. Sets the defaults.
    //Pretty sure the doc info about defaults uses this.
    class_constructor(self)
    self.object = object

    //Set extension instance in the native Godot object.
    GDW.stringconstruct.stringNameNewLatin(&class_name, "GDExample", false)
    GDW.api.object_set_instance(object, &class_name, self)
    GDW.api.object_set_instance_binding(object, GDW.Library, self, classBindingCallbacks)

    //Heap cleanup.
    GDW.destructors.stringNameDestructor(&class_name)

    //uninitptr: GDE.Variant

    return object
}

//WARNING : Free any heap memory allocated within this context.
//There's also a destructor, so what's the difference?
//Does destructor just clear the variable data and this is supposed to clear the class itself?
//Maybe it's so that destructor can be run when making editor changes like reset?
gdexampleClassFreeInstance :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^GDExample = cast(^GDExample)p_instance
    class_destructor(self)
    free(self)
}


//This is where you would set your defaults.
class_constructor :: proc "c" (self: ^GDExample) {
    context = runtime.default_context()
    //fmt.println("class constructor")
    self.amplitude = 10

    
    uninitptr: GDE.Variant
    godotMake: GDE.PackedVector2Array
    myArray:= make([dynamic]f32)
    append_elem(&myArray, 563)
    storage:rawptr
    

    multiray:= [?]rawptr {raw_data(myArray)}

    //fmt.println(godotMake)
    //GDW.arrayhelp.packedf32create0(&godotMake, nil)
    fmt.println(godotMake)

    
    //Need to setup a dynamic(?) array with the first u64 containing the size.
    sizeIncluded:=make([dynamic]i64)
    resize(&sizeIncluded, 5)
    //defer delete(sizeIncluded)

    sizeIncluded[0] = 0
    sizeIncluded[1] = 0
    sizeIncluded[2] = 1
    sizeIncluded[3] = 1
    sizeIncluded[4] = max(i64)
    //sizeIncluded[5] = 4

    fmt.println("size value: ", (transmute([dynamic]u32)sizeIncluded)[:1])
    fmt.println("value: ", sizeIncluded[2])
    godotMake[1] = transmute(u64)(raw_data(transmute([dynamic]f32)sizeIncluded))

    //godotMake:= GDW.api.mem_alloc(size_of(GDE.PackedVector2Array))
    //fmt.println((cast(^GDE.PackedVector2Array)godotMake)^)
    ray:=[?]rawptr{&godotMake}
    fmt.println(uninitptr)
    newSize: u64 = 1
    newValue: i64 = 97
    args:= [?]rawptr {&newSize}
    args2:= [?]rawptr {&newValue}
    index:u64=0
    set:= [?]rawptr {&index, &newValue}
    returnedSize: u64
    

    newpackedmake:= [?]rawptr{storage, &sizeIncluded[4]}
    fmt.println("address of 1: ", &sizeIncluded[4])
    fmt.println("address of 1: (size)", &sizeIncluded[3])
    fmt.println("My array data: ", newpackedmake)
    
    from:= []rawptr {&newpackedmake}

    testCreate:= [?]rawptr{storage, nil}
    fmt.println("maybe ref count: ", sizeIncluded[2])
    //GDW.variantfrom.packedf32arrayToVariant(&uninitptr, nil)
    fmt.println("My Godot Type: ", testCreate)
    fmt.println("My Godot Type: ", uninitptr)

    //Does this even do anything? When everything is a null pointer or 0 it returns nothing and skips over mem allocs
    //Eventually it even goes through the destructors for the vector and cowdata.
    GDW.arrayhelp.packedi32create0(&testCreate, nil)
    
    //Resize or append locks in the memory for the array. Also sets the ref count.
    appenderr:=false
    GDW.arrayhelp.packedi32Append(&testCreate, raw_data(args2[:]), &appenderr, 1)
    //Resize is supposed to size to 97
    GDW.arrayhelp.packedi32REsize(&testCreate, raw_data(args2[:]), &returnedSize, 1)
    fmt.println(returnedSize)
    GDW.arrayhelp.packedi32size(&testCreate, nil, &returnedSize, 0)
    fmt.println(returnedSize)
    fmt.println("My Godot Type: ", testCreate)

    //set index 0, value 97
    GDW.arrayhelp.packedi32Set(&testCreate, raw_data(set[:]), nil, 2)
    GDW.arrayhelp.packedi32Get(&testCreate, raw_data(set[:]), &returnedSize, 1)
    fmt.println(returnedSize)
    GDW.arrayhelp.packedi32Append(&testCreate, raw_data(args2[:]), &appenderr, 1)
    GDW.arrayhelp.packedi32size(&testCreate, nil, &returnedSize, 0)
    fmt.println(returnedSize)
    fmt.println((cast(^[98]i64)testCreate[1])^)
    GDW.arrayhelp.packedi32Destroy(&testCreate)
    
    
    

}

class_destructor  :: proc  "c" (self: ^GDExample) {
    context = runtime.default_context()

   //GDW.destructors.stringNameDestructor(&self.position_changed)
}


classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}