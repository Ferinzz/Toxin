package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"
import "core:log"
import "core:reflect"
import "core:strings"
import "core:strconv"


/*
* Example to make the processes only run during the game instead of during the editor: 
* https://github.com/godotengine/godot/blob/662d0b188dc2bd6ca50ea0c3b3b9accb8255acfc/scene/2d/camera_2d.cpp#L67-L78
* Discussion
* https://godotforums.org/d/36709-life-cycle-of-gdextension-nodes-in-the-editor/5
*/

//Need to pass in the following and if it isn't passed in use default settings skip to the binding.
//Runtime true/false. Default false
//Exposed true/false. Default true

//Create a hints struct.
//Specific to make Public add an extra layer for hingts
//Metadata seems useless?

/*
* Godot will need a getter and setter to be able to handle variables 'made public'
* This function will generate basic get and set functions for you. Register their callbacks, register them for use in the editor or GDScripts.
* Assumption: you are setting all the information in a struct. You will provide the name of the field as you've declared it.
* P: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
*/
Export :: proc "c" ($classStruct: typeid, $fieldName: cstring,
                        methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
                        loc:= #caller_location)
                        where sics.type_has_field(classStruct, fieldName) //No point trying if the field doesn't exist. Typo safety.
    {
    context = godotContext
    //get the index from the GDTypes array, this is equivalent to the VariantType enum placement.
    index, ok := slice.linear_search(GDE.GDTypes[:], sics.type_field_type(classStruct, fieldName))
    if ok == false {
        panic("The type sent to makePublic was not found in GDW.GDTypes. Please check the list of valid Godot types.", loc)
    }
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    className := fmt.caprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewLatin(&className_SN, className, false)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    variant_type:=GDE.VariantType(index)
    info: GDE.PropertyInfo = make_property(variant_type, fieldName)
    
    bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

//To make an enum for Godot you need to create a property hint and make it public.
//Enums are just a fancy set of strings which are associated with an int value.
//Public_Enum :: proc($anEmun: typeid, class: string, allocator := context.allocator) where sics.type_is_enum(anEmun) {
Export_Enum :: proc ($classStruct: typeid, $fieldName: cstring,
                        methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
                        loc:= #caller_location) {
    
    anEnum:typeid= sics.type_field_type(classStruct, fieldName)
    type_info:= type_info_of(anEnum)

    infoNamed := type_info.variant.(runtime.Type_Info_Named)
    infoBase:= infoNamed.base
    info:=infoBase.variant.(runtime.Type_Info_Enum)

    //random estimate of how long it might need to be. Based off of nothing.
    output: = make_dynamic_array_len_cap([dynamic]u8, 0, len(info.names)*16)
    
    //Loop through each to add the enum value to the hint string.
    for field, ind in info.names {
        if ind > 0 do append(&output, ',')
        buf:[30]u8
        //strconv.write_int(buf[:], i64(info.values[ind]), 10)
        group:[3][]u8
        group[0] = transmute([]u8)field
        group[1] = []u8 {':'}
        //allocated the string into the buffer, so the slice is a slice into the buffer.
        //No need to delete.?
        group[2] = transmute([]u8)(strconv.write_int(buf[:], i64(info.values[ind]), 10))
        final:= slice.concatenate(group[:])
        //fmt.println(string(final))
        append(&output, string(final[:]))
        delete(final)
    }
    
    className := fmt.caprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewLatin(&className_SN, className, false)
    defer(Destructors.stringNameDestructor(&className_SN))

    prop_info:= Make_Property_Full(.INT, string(fieldName), .ENUM, string(output[:]), "game", GDE.PROPERTY_USAGE_DEFAULT)
    /*
    get,set:= make_getter_and_setter(classStruct, GDE.Int, (fieldName))

    //These functions create the callbacks Godot will used to call set and get.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    Bind_Property(&className_SN, string(fieldName), .INT, &prop_info, "get_"+fieldName, "set_"+fieldName)
    */
    bind_export(classStruct, &className_SN, fieldName, .INT, GDE.Int, methodType, &prop_info, loc)

    destructProperty(&prop_info)
    delete(output)
}

/*
* Export a value in a way which tells Godot to limit the range in the editor UI.
* classStruct: the struct of your custom class which contains the variable to export.
* fieldName: a string of the name of the variable you want to export from the class struct
* range_info: parameters to set for the Godot editor to respect.

* SPECIAL WARNING the export functions themselves do not validate the ranges set.
* If this will be used by a function in GDScript you will need to add validation for the ranges, as GDScript does not respect this.
*/
Export_Range :: proc ($classStruct: typeid, $fieldName: cstring,
                        range_info: $T/GDE.Ranged_Num,
                        loc:= #caller_location)
                        where sics.type_has_field(classStruct, fieldName)
    {
    
    methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL

    className := fmt.caprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewLatin(&className_SN, className, false)
    defer(Destructors.stringNameDestructor(&className_SN))

    output: string

    min:= fmt.aprint(range_info.min)
    max:= fmt.aprint(range_info.max)
    step:string 
    if range_info.step !=0 {
        step = fmt.aprint(range_info.step)
    }
    flag_string: [dynamic]u8
    prev_true:bool=false
    switch range_info.flags {
        case {.or_greater}:
            append(&flag_string, "or_greater")
            prev_true = true
            fallthrough
        case {.or_less}:
            append(&flag_string, "or_less")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.exp}:
            append(&flag_string, "exp")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.hide_slider}:
            append(&flag_string, "hide_slider")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.radians_as_degrees}:
            append(&flag_string, "radians_as_degrees")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.degrees}:
            append(&flag_string, "degrees")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
    }

    field_type:GDE.VariantType
    if sics.type_field_type(classStruct, fieldName) == GDE.Int {
        field_type = .INT
    }
    else if sics.type_field_type(classStruct, fieldName) == GDE.float {
        field_type = .FLOAT
    } else {
        failureProc("", "unsupported type in Export_Range", loc)
        
    }
    if len(flag_string) > 0{
        output = strings.concatenate({min,",",max,",",step,",",string(flag_string[:])})
    } else {
        output = strings.concatenate({min,",",max,",",step})
    }
    prop_info:= Make_Property_Full(.INT, string(fieldName), .RANGE, output, "game", GDE.PROPERTY_USAGE_DEFAULT)

    bind_export(classStruct, &className_SN, fieldName, .INT, sics.type_field_type(classStruct, fieldName), methodType, &prop_info, loc)

    destructProperty(&prop_info)
    delete(min)
    delete(max)
    delete(output)
    delete(flag_string)
}

//Warning untested, does not properly clear the array before being set by Godot.
//Memory leaky!!
Export_Ranged_Array :: proc ($classStruct: typeid, $fieldName: cstring,
                        range_info: $T/GDE.Ranged_Array,
                        loc:= #caller_location)
                        where sics.type_has_field(classStruct, fieldName)
    {
    
    methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext

        (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = sics.type_field_type(classStruct, fieldName)(godotValue)
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> sics.type_field_type(classStruct, fieldName) {
        context = godotContext
        return (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */
    
    className := fmt.caprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewLatin(&className_SN, className, false)
    defer(Destructors.stringNameDestructor(&className_SN))

    //These functions create the callbacks Godot will used to call set and get.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    output: string

    min:= fmt.aprint(range_info.min)
    max:= fmt.aprint(range_info.max)
    step:string 
    if range_info.step !=0 {
        step = fmt.aprint(range_info.step)
    }
    flag_string: [dynamic]u8
    prev_true:bool=false
    switch range_info.flags {
        case {.or_greater}:
            append(&flag_string, "or_greater")
            prev_true = true
            fallthrough
        case {.or_less}:
            append(&flag_string, "or_less")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.exp}:
            append(&flag_string, "exp")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.hide_slider}:
            append(&flag_string, "hide_slider")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.radians_as_degrees}:
            append(&flag_string, "radians_as_degrees")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
        case {.degrees}:
            append(&flag_string, "degrees")
            if prev_true == true do append(&flag_string,",")
            prev_true = true
            fallthrough
    }

    field_type:GDE.VariantType
    if sics.type_field_type(classStruct, fieldName) == GDE.Int {
        field_type = .INT
    }
    else if sics.type_field_type(classStruct, fieldName) == GDE.float {
        field_type = .FLOAT
    } else {
        failureProc("", "unsupported type in Export_Range", loc)
        
    }
    if len(flag_string) > 0{
        output = strings.concatenate({min,",",max,",",step,",",string(flag_string[:])})
    } else {
        output = strings.concatenate({min,",",max,",",step})
    }
    prop_info:= Make_Property_Full(.INT, string(fieldName), .RANGE, output, "game", GDE.PROPERTY_USAGE_DEFAULT)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    if !rodata {
        Bind_Property(&className_SN, string(fieldName), .INT, &prop_info, "get_"+fieldName, "set_"+fieldName)}
    else {
        Bind_Property(&className_SN, string(fieldName), .INT, &prop_info, "get_"+fieldName, "")
    }
    destructProperty(&prop_info)
}



/*
* Helper function to run the standard functions needed to create getter, setter, and bind them to Godot.
* classStruct: struct of the custom class.
* className: StringName of the custom class.
* fieldName: cstring of the field's name which is being exported to Godot.
* variant_type: GDE.VariantType the type of the variant which is being used. Important because it may be different from the field's type,
* GDType: type to pass to/from Godot in the getter/setter. It may be different from the Odin type specified in the class struct (enums)
* methodType: How the method can be used.
* prop_info: the property information to be passed to Godot. Used for the editor to properly manage the type.
* loc: location this proc was called from.
*/
bind_export :: proc($classStruct: typeid, className_SN: ^GDE.StringName, $fieldName: cstring,
    variant_type: GDE.VariantType, $GDType: typeid, methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
    prop_info: ^GDE.PropertyInfo, loc:= #caller_location) {
    
    get,set:= make_getter_and_setter(classStruct, GDType, (fieldName))

    //These functions create the callbacks Godot will used to call set and get.
    bindMethod(className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    //bindProperty(className_SN, fieldName, variant_type, "get_"+fieldName, "set_"+fieldName)
    Bind_Property_Prop_Info(className_SN, string(fieldName), variant_type, prop_info, "get_"+fieldName, "set_"+fieldName, loc)
}

make_getter_and_setter :: proc ($classStruct: typeid, $field_Type: typeid, $fieldName: cstring) -> (getter: proc "c" (p_classData: ^classStruct) -> field_Type, setter: proc "c" (p_classData: ^classStruct, godotValue: field_Type)) {
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: field_Type) {
        context = godotContext
        ////fmt.println(godotValue)
        (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = sics.type_field_type(classStruct, fieldName)(godotValue)
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> field_Type {
        context = godotContext

        //fmt.println((cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^)
        return (cast(^field_Type)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */
    return get, set
}

make_property :: proc "c" (type: GDE.VariantType, name: cstring) -> GDE.PropertyInfo {
    
    return makePropertyFull_cstring(type, name, GDE.PropertyHint.NONE, "", "", GDE.PROPERTY_USAGE_DEFAULT)
}

//TODO : See if I really need to malloc these variables or if that's just something for C to do.
//Odin has a bunch of memory management. If all we need is to malloc memory to heap we can do that with new().
makePropertyFull_cstring :: proc "c" (type: GDE.VariantType, name: cstring, hint: GDE.PropertyHint, hintString: cstring, className: cstring, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {
    context = runtime.default_context()

    prop_name:= new(GDE.StringName)
    StringConstruct.stringNameNewLatin(prop_name, name, false)

    propHintString:= new(GDE.gdstring)
    StringConstruct.stringNewUTF8(propHintString, hintString)

    propClassName:= new(GDE.StringName)
    StringConstruct.stringNameNewLatin(propClassName, className, false)
    
    info: GDE.PropertyInfo = {
        name = prop_name,
        type = type, //is an enum specifying type. Meh.
        hint = hint, //Hints are hints for the Editor. GDScript doesn't always respect them.
        hint_string = propHintString,
        class_name = propClassName,
        usage = usageFlags
    }

    return info
}

makePropertyFull_string :: proc "c" (type: GDE.VariantType, name: string, hint: GDE.PropertyHint, hintString: string, className: string, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {
    context = runtime.default_context()

    prop_name:= new(GDE.StringName)
    StringConstruct.stringNameNewUTF8andLen(prop_name, raw_data(name), len(name))

    propHintString:= new(GDE.gdstring)
    StringConstruct.stringNewUTF8_len(propHintString, raw_data(hintString), len(hintString))

    propClassName:= new(GDE.StringName)
    StringConstruct.stringNameNewUTF8andLen(propClassName, raw_data(className), len(className))
    
    info: GDE.PropertyInfo = {
        name = prop_name,
        type = type, //is an enum specifying type. Meh.
        hint = hint, //Hints are hints for the Editor. GDScript doesn't always respect them.
        hint_string = propHintString,
        class_name = propClassName,
        usage = usageFlags
    }

    return info
}

Make_Property_Full :: proc {
    makePropertyFull_cstring,
    makePropertyFull_string,
}

/*
* Will call bindNoReturn2 to create callback functions for Godot to call your function with.
* Once callbacks are created will supply all information in methodInfo so that your function can be bound to Godot.
* Once bound these should be available in GDScript.
* Godot only supports one return value per function.
*
* className: Name that holds the method.
* methodName: Name of the method you're binding; shown in the editor
* function: Pointer to the function you are binding to Godot
* argNames: Names of the arguments; shown in the Editor
* This creates 2 functions.
*/
bindMethod :: proc "c" (className: ^GDE.StringName, methodName: cstring,
                        function: $T,
                        methodType: GDE.ClassMethodFlags = GDE.ClassMethodFlags.NORMAL,
                        argNames: ..cstring, loc:= #caller_location
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    context = godotContext

    methodStringName: GDE.StringName
    StringConstruct.stringNameNewLatin(&methodStringName, methodName, false)

    argcount:: sics.type_proc_parameter_count(T) - 1

    if argcount != len(argNames){
        panic("Number of args in function does not match number of argNames provided", loc)
    }
    

    ptrcallFunc, callFunc:= bindNoReturn2(function, loc=loc)
    when argcount > 0 {
        argsInfo: [argcount]GDE.PropertyInfo
        
        index:int
        index, _ = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 1))
        argsInfo[0] = make_property(GDE.VariantType(index), argNames[0])

        when argcount > 1 
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 2))
        argsInfo[1] = make_property(GDE.VariantType(index), argNames[1])}
        
        when argcount > 2 
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 3))
        argsInfo[2] = make_property(GDE.VariantType(index), argNames[2])}
        
        when argcount > 3
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 4))
        argsInfo[3] = make_property(GDE.VariantType(index), argNames[3])}
        
        when argcount > 4
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 5))
         argsInfo[4] = make_property(GDE.VariantType(index), argNames[4])}
        
        when argcount > 5
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 6))
        argsInfo[5] = make_property(GDE.VariantType(index), argNames[5])}
        
        when argcount > 6
        {index, _  = slice.linear_search(GDE.GDTypes[:], sics.type_proc_parameter_type(T, 7))
        argsInfo[6] = make_property(GDE.VariantType(index), argNames[6])}
    }
    else do argsInfo:= 0
    

    //These would allow us to use types other than f64 and i64 all the time. But is it worth the complication
    //considering it would be casting it back and forth all over again?
    when sics.type_proc_parameter_count(T) - 1 > 0 {
        
        args_metadata: [argcount]GDE.ClassMethodArgumentMetadata
        args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE

        when argcount > 1 do args_metadata[1] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 2 do args_metadata[2] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 3 do args_metadata[3] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 4 do args_metadata[4] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 5 do args_metadata[5] = GDE.ClassMethodArgumentMetadata.NONE
        when argcount > 6 do args_metadata[6] = GDE.ClassMethodArgumentMetadata.NONE
    }
    else do args_metadata:= 0

    //Check if there's a return at compile-time. If there is, search the array for the corresponding type.
    //Else set 0.
    when sics.type_proc_return_count(T) > 0 {
    returnType, ok:= slice.linear_search(GDE.GDTypes[:], sics.type_proc_return_type(T, 0))
    if !ok {
        panic("Type is not a part of the GDE.GDTypes. Please verify the list in GDE.GDEfs.", loc)
    }}
    else
    {returnType:= 0 }

    //string passed doesn't show up in Editor Documentation.? Leaving as something random for now.
    returnInfo: GDE.PropertyInfo = make_property(GDE.VariantType(returnType), "123")

    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = callFunc,
        ptrcall_func = ptrcallFunc,
        method_flags = u32(methodType),
    }

    
    when sics.type_proc_return_count(T) > 0 {
    
        methodInfo.has_return_value = returnType != 0
        methodInfo.return_value_info = &returnInfo
        methodInfo.return_value_metadata = GDE.ClassMethodArgumentMetadata.NONE
    }

    when sics.type_proc_parameter_count(T) - 1 > 0{
    
        methodInfo.argument_count = u32(argcount)
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]
    }

    gdAPI.classdbRegisterExtensionClassMethod(Library, className, &methodInfo)
    
    //Destructor things.
    Destructors.stringNameDestructor(&methodStringName)
    //Destructors.stringNameDestructor(&classNameString)
    destructProperty(&returnInfo)

}

Bind_Property :: proc {
    bindProperty,
    Bind_Property_Prop_Info,
}

Bind_Property_Prop_Info :: proc(className: ^GDE.StringName, name: string, type: GDE.VariantType, prop_hint: ^GDE.PropertyInfo, getter, setter: cstring, loc:=#caller_location) {

    getterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&getterName, getter, false)

    setterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&setterName, setter, false)
    
    //fmt.println("register property")
    gdAPI.classDBRegisterExtensionClassProperty(Library, className, prop_hint, &setterName, &getterName)
    
}

/*
* bindProperty is used to make your variable public.
* Prior to calling this you should have registered the get and/or set functions with Godot.
* Provide their names as cstrings. Check the makePublic function for a general workflow.
* Use makePublic to auto-gen basic get/set functions for simple variables. (I haven't tested with arrays.)
*/
bindProperty :: proc "c" (className: ^GDE.StringName, name: cstring, type: GDE.VariantType, getter, setter: cstring, loc:=#caller_location) {
    //context = godotContext
    
    info: GDE.PropertyInfo = make_property(type, name)

    getterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&getterName, getter, false)

    setterName: GDE.StringName
    StringConstruct.stringNameNewLatin(&setterName, setter, false)
    
    //fmt.println("register property")
    gdAPI.classDBRegisterExtensionClassProperty(Library, className, &info, &setterName, &getterName)
    //fmt.println("register property complete")

    //Destructor stuff
    destructProperty(&info)
}



//This is messy. I dunno if this is better or worse than having 7 individual functions... Lots of casting. Eh.
//This is also using some really old functions for the variant conversion since they provide a return instead of needing an empty pointer.
bindNoReturn2 :: proc "c" (function: $P, loc:=#caller_location) -> (GDE.ClassMethodPtrCall, GDE.ClassMethodCall) {
    context = godotContext
    argcount:: sics.type_proc_parameter_count(P)
    argT0 :: sics.type_proc_parameter_type(P, 0)
    

    when argcount == 1 {
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance)
            } else {
                func(cast(argT0)p_instance)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small o args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance)
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance)
            }
        }
    return godotPtrCallback, godotVariantCallback

    } else {
        argT1 :: sics.type_proc_parameter_type(P, 1)
        when argcount == 2 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1))
                    variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT2 :: sics.type_proc_parameter_type(P, 2)
        when argcount == 3 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                            fromvariant(cast(GDE.VariantPtr)p_args[1], argT2))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT3 :: sics.type_proc_parameter_type(P, 3)
        when argcount == 4 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2), fromvariant(cast(^GDE.Variant)p_args[2], argT3))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT4 :: sics.type_proc_parameter_type(P, 4)
        when argcount == 5 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2), fromvariant(cast(^GDE.Variant)p_args[2], argT3),
                    fromvariant(cast(^GDE.Variant)p_args[3], argT4))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT5 :: sics.type_proc_parameter_type(P, 5)
        when argcount == 6 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
                
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2), fromvariant(cast(^GDE.Variant)p_args[2], argT3),
                    fromvariant(cast(^GDE.Variant)p_args[3], argT4), fromvariant(cast(^GDE.Variant)p_args[4], argT5))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT6 :: sics.type_proc_parameter_type(P, 6)
        when argcount == 7 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT6)p_args[5])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5),
                    fromvariant(cast(GDE.VariantPtr)p_args[5], argT6))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2), fromvariant(cast(^GDE.Variant)p_args[2], argT3),
                    fromvariant(cast(^GDE.Variant)p_args[3], argT4), fromvariant(cast(^GDE.Variant)p_args[4], argT5), fromvariant(cast(^GDE.Variant)p_args[5], argT6))
            }
        }
    return godotPtrCallback, godotVariantCallback
    }else {
        argT7 :: sics.type_proc_parameter_type(P, 7)
        when argcount == 8 {
        
        godotPtrCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr){
            context = godotContext

            func := cast(P)method_userdata
            when sics.type_proc_return_count(P) > 0 {
                (cast(^(sics.type_proc_return_type(P, 0)))r_ret)^ = func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^,
                            (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^)
            } else {
                func(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^, (cast(^argT4)p_args[3])^,
                    (cast(^argT4)p_args[3])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^)
            }
        }
        godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: GDE.Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
    
            context = godotContext
            if p_argument_count < argcount-1 {
                r_error.error = .CALL_ERROR_TOO_FEW_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error small 1 args")
                return
            }
            if p_argument_count > argcount-1 {
                r_error.error = .CALL_ERROR_TOO_MANY_ARGUMENTS
                r_error.expected = argcount
                fmt.println("error big")
                return
            }
            
            gdTypeList:= [argcount-1]GDE.VariantType {typetoenum(argT1), typetoenum(argT2), typetoenum(argT3), typetoenum(argT4), typetoenum(argT5),
                    typetoenum(argT6), typetoenum(argT7)}
            
            variantTypeCheck(gdTypeList[:], p_args[:], r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1),
                    fromvariant(cast(GDE.VariantPtr)p_args[1], argT2), fromvariant(cast(GDE.VariantPtr)p_args[2], argT3),
                    fromvariant(cast(GDE.VariantPtr)p_args[3], argT4), fromvariant(cast(GDE.VariantPtr)p_args[4], argT5),
                    fromvariant(cast(GDE.VariantPtr)p_args[5], argT6), fromvariant(cast(GDE.VariantPtr)p_args[6], argT7))
                variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                func(cast(argT0)p_instance, fromvariant(cast(^GDE.Variant)p_args[0], argT1), fromvariant(cast(^GDE.Variant)p_args[1], argT2), fromvariant(cast(^GDE.Variant)p_args[2], argT3),
                    fromvariant(cast(^GDE.Variant)p_args[3], argT4), fromvariant(cast(^GDE.Variant)p_args[4], argT5), fromvariant(cast(^GDE.Variant)p_args[5], argT6), fromvariant(cast(^GDE.Variant)p_args[6], argT7))
            }
        }
    return godotPtrCallback, godotVariantCallback
    } else {
        panic("yikes")
    }
}}}}}}}}

