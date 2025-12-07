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
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
*/
Export :: proc "c" ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        where sics.type_has_field(classStruct, fieldName)
    {
    context = godotContext

    //I don't want you to have to learn the VariantType enum and pass that in. Instead, I will do a lookup based on the type.
    //If the type shown in Godot does not align with the Odin type, the order of GDE.VariantType enum and GDE.GDTypes need to be validated again.
    //get the index from the GDTypes array, this is in order of to the VariantType enum placement.
    index, ok := slice.linear_search(GDE.GDTypes[:], sics.type_field_type(classStruct, fieldName))
    if ok == false {
        panic("The type sent to makePublic was not found in GDW.GDTypes. Please check the list of valid Godot types.", loc)
    }
    
    variant_type:=GDE.VariantType(index)
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = make_property(variant_type, fieldName)
    prop_info:= Make_Property_Full(variant_type, fieldName, .NONE, "", className, property_usage)
    
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, variant_type, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

/*
* Enums. These will behave in a somewhat strange way if you are used to compiled language.
* In a pursuit of performance Godot will save the value in its final form after a user sets the value via the Editor.
* As a result, updating the enum values will not be reflected in the stored data.
* When doing this with Export_Int_As_Enum it means that you will not know which scene variables need to be updated, as the only value you see is a 1, 3, 5, etc.
* If there is a chance of enum values changing, prefer using Export_String_As_Enum which will save in its string form. You can then fetch the value from the const by using this gdstring/StringName as a key.
*/

/*
* To make an enum for Godot you need to create a property hint and make it public.
* Enums are just a fancy set of strings which are associated with an int value.
* WARNING: Godot only saves the value as an int, if you change the source enum Godot will not update the scene file to match.
* If the value is read-only this may be safe.
* Godot will save the value it chooses as an int in the scene or script file.
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
*/
Export_Int_As_Enum :: proc ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, .CLASS_IS_ENUM },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type enum.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_enum(sics.type_field_type(classStruct, fieldName)))
    {
    
    anEnum:typeid= sics.type_field_type(classStruct, fieldName)
    type_info:= type_info_of(anEnum)

    //infoNamed := type_info.variant.(runtime.Type_Info_Named)
    //infoBase:= infoNamed.base
    info:=type_info_of(anEnum).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)

    //random estimate of how long it might need to be. Based off of nothing.
    output: = make_dynamic_array_len_cap([dynamic]u8, 0, len(info.names)*16)
    
    //Loop through each entry in the enum to add their name and value to the hint string.
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

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .ENUM, string(output[:]), className, property_usage)

    //Create all necessary information and Register the information with Godot in order for the variable to be accessible.
    bind_export(classStruct, &className_SN, fieldName, .INT, GDE.Int, methodType, &prop_info, loc)

    destructProperty(&prop_info)
    delete(output)
}

/*
* Export a gdstring or StringName variable in a way which Godot will know to offer a selection of strings in the Editor panel.
* The value will be saved as a string in the scene file (tscn).
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* options: a slice containing the strings which will be options in the editor.
* Godot will save the value selected in the editor to the scene file.
* If you will not need the strings on Odin's side at runtime, the strings used for this export's init can be deleted.
* If you change the spelling of a field, you will still need to update all of the *.tscn files to update to the new value.
*/
Export_String_As_Enum :: proc($classStruct: typeid, $fieldName: string,
                        options: []string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, .CLASS_IS_ENUM },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == GDE.StringName || sics.type_field_type(classStruct, fieldName) == GDE.gdstring))
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    res, err:=strings.join(options[:], ",")
    defer(delete(res))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext
        when sics.type_field_type(classStruct, fieldName) == GDE.StringName {
            Destructors.stringNameDestructor(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
        when sics.type_field_type(classStruct, fieldName) == GDE.gdstring {
            Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)
    
    //Defines the information about the variable properties in a way Godot's editor understands
    when sics.type_field_type(classStruct, fieldName) == GDE.gdstring {
        prop_info:= Make_Property_Full(.STRING, fieldName, .ENUM, res, className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }
    when sics.type_field_type(classStruct, fieldName) == GDE.StringName {
        prop_info:= Make_Property_Full(.STRING_NAME, fieldName, .ENUM, res, className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .STRING_NAME, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }


}

//Godot stores enum info in ClassInfo as a HashMap. The fields are stored in struct EnumInfo.
//https://github.com/godotengine/godot/blob/0fdb93cde6ccb5176f96b0ddbba08d83e6c6aef2/core/object/class_db.h#L131
/*
* Register the fields of an enum so that it can be used in GDScript as a list of constants.
* classStruct: Used to get the name of your class.
* out_enum: the enum you want to export as constants.
*/
Export_Enum :: #force_inline proc($classStruct: typeid, $out_enum: typeid) \
        where(sics.type_is_enum(out_enum) && sics.type_is_struct(classStruct))
    {
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    enumName:= fmt.aprint(type_info_of(out_enum))
    defer delete(enumName)
    enumName_SN: GDE.StringName
    StringConstruct.stringNameNewString(&enumName_SN, enumName)
    defer(Destructors.stringNameDestructor(&enumName_SN))


    info:=type_info_of(out_enum).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)
    
    //Loop through each entry in the enum to add their name and value to the hint string.
    for field, ind in info.names {
        field_SN: GDE.StringName
        StringConstruct.stringNameNewString(&field_SN, field)
        gdAPI.Register_Int_const(Library, &className_SN, &enumName_SN, &field_SN, GDE.Int(info.values[ind]), false)
        Destructors.stringNameDestructor(&field_SN)
    }
}

/*
* Export a value in a way which tells Godot to limit the range in the editor UI.
* classStruct: the struct of your custom class which contains the variable to export.
* fieldName: a string of the name of the variable you want to export from the class struct
* range_info: parameters to set for the Godot editor to respect.

* SPECIAL WARNING the export functions themselves do not validate the ranges set.
* If this will be used by a function in GDScript you will need to add validation for the ranges, as GDScript does not respect this.
*/
Export_Range :: proc ($classStruct: typeid, $fieldName: string,
                        range_info: $T/Ranged_Num,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.float or GDE.Int.
                        where (sics.type_has_field(classStruct, fieldName) && ((sics.type_field_type(classStruct, fieldName) == GDE.float) || (sics.type_field_type(classStruct, fieldName) == GDE.Int)))
    {

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
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
    
    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .RANGE, output, className, property_usage)

    //Create all necessary information and Register the information with Godot in order for the variable to be accessible.
    bind_export(classStruct, &className_SN, fieldName, .INT, sics.type_field_type(classStruct, fieldName), methodType, &prop_info, loc)

    destructProperty(&prop_info)
    delete(min)
    delete(max)
    delete(output)
    delete(flag_string)
}

/*Struct to pass data for a ranged variable.
* Supports: float, int
* min: lowest value allowed by the editor.
* max: largest value allowed by the editor.
* step: by how much it should increment. 0 will be ignored.
* flags: additional usage information.
* validate: Not implemented. if Odin's callback should verify the range.
*/
Ranged_Num :: struct ($T: typeid) {
  min: T,
  max: T,
  step: T,
  flags: Range_Flags,
  //validate: bool, //Specify if you want Odin callbacks to validate the range.
}

Range_Flags :: bit_set [Range; GDE.Int]

Range :: enum {
  or_greater, //Can exceed the max limit
  or_less, //Can go lower than the min limit
  exp, //
  hide_slider, //Slider will not appear in editor
  radians_as_degrees, //will represent radian values as degrees
  degrees, //limit the range to degrees (-360 to 360)
}

//Warning untested, does not properly clear the array before being set by Godot.
//Memory leaky!!
Export_Ranged_Array :: proc ($classStruct: typeid, $fieldName: string,
                        range_info: $T/Ranged_Array,
                        loc:= #caller_location)
                        where sics.type_has_field(classStruct, fieldName)
    {
    
    methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT

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
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
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
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .RANGE, output, className, GDE.PROPERTY_USAGE_DEFAULT)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    if !rodata {
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName)}
    else {
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "")
    }
    destructProperty(&prop_info)
}

/*
* Supports: Array[int], Array[float], PackedByteArray, PackedInt32Array, PackedInt64Array, PackedFloat32Array, or PackedFloat64Array
* indexType should be one of GDE.Int or GDE.float
* min: lowest value allowed by the editor.
* max: largest value allowed by the editor.
* step: by how much it should increment. 0 will be ignored.
* flags: additional usage information.
* validate: Not implemented. if Odin's callback should verify the range.
*/
Ranged_Array :: struct ($indexType: typeid) {
  min: indexType,
  max: indexType,
  step: indexType,
  flags: Range_Flags,
  //validate: bool, //Specify if you want Odin callbacks to validate the range.
}


/*
* Export a float to the editor and specify that it is a float for the easing curve. (assumption)
* I believe that this is intended to be used with the ease() function as the curve value.
* READ THIS! : https://byteatatime.dev/posts/easings/
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* easing: The restrictions which should be applied to the easing.
*/
Export_Easing :: proc "c" ($classStruct: typeid, $fieldName: string, easing: Easing_Options,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.float.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == GDE.float))
    {
    context = godotContext
    //get the index from the GDTypes array, this is equivalent to the VariantType enum placement.
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.FLOAT, fieldName, .EXP_EASING, Easing_Type[easing], className, property_usage)
    
    //Create all necessary information and Register the information with Godot in order for the variable to be accessible.
    bind_export(classStruct, &className_SN, fieldName, .FLOAT, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}


Easing_Type: [Easing_Options]string = {
  .none = "",
  .attenuation= "attenuation",
  .positive_only = "positive_only",
}

Easing_Options :: enum {
  none,
  attenuation,
  positive_only,
}

/*
* Specify the type which should be allocated into the array when working with Godot editor/script.
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* Index: a struct containing the type [dynamic]T of the Array as well as an optional hint which can be included.
* Index is vararg in order to support multi-dimensional Arrays.
* Final string will be "%d/%d:%s" type/hint:hint_string. See Array_Type_Hint_Info for more examples.
*/
Export_Array_Type :: proc "c" ($classStruct: typeid, $fieldName: string,
                        Index: ..Array_Type_Hint_Info,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.Array.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == GDE.Array))
    {
    context = godotContext
    //get the index from the GDTypes array, this is equivalent to the VariantType enum placement.
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    if OType != GDE.Array {return}
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    hints: [dynamic]string

    for l in Index {
        if l.hint == .NONE {
            hint:= fmt.aprintf("%d:", l.type)
            append(&hints, hint)
            delete(hint)
        } else {
            hint:= fmt.aprintf("%d/%d:%s", GDE.Int(l.type), GDE.Int(l.hint), l.hint_string)
            append(&hints, hint)
            delete(hint)
        }
    }
    
    final_hint_string, ok:= strings.concatenate(hints[:])
    if ok !=nil { return }

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.ARRAY, fieldName, .ARRAY_TYPE, final_hint_string, className, property_usage)
    
    //Creates all necessary info before Registering the information with Godot in order for the variable to be accessible.
    bind_export(classStruct, &className_SN, fieldName, .ARRAY, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
    delete(final_hint_string)
}


/*
* Values provided will be formatted into a string which Godot will understand.
* Provide the string values that would make sense for the hint property included.
* Godot supports multidimensional arrays, to specify this set type as .ARRAY
* type: VariantType that should be used for this index. .OBJECT will be some sort of node.
* hint: specifies the kind of hint that the string represents.
* hint_string: the specifics that configure the hint
* {.INT, .RANGE, "1,10,1"} -> result is an Array which should contain Ints with range specified to min: 1, max: 10, step: 1
* {.ARRAY, .NONE, ""} -> a multidimensional Array of unspecified Arrays.
* {.INT, .ENUM, "Zero,One,Two"} -> an array with a hint to use named values during selection.
* {.OBJECT, .RESOURCE_TYPE, "Texture2D"} -> An Array of Texture2D
* If you want to specify the type of the Array of Arrays include two in the export proc.
* {.ARRAY, .NONE, ""}, {.STRING, .MULTILINE_TEXT, ""} -> if both are passed Godot will know this should be an Array of Array of gdstrings, which are multiline gdstrings
*/
Array_Type_Hint_Info :: struct{
  type: GDE.VariantType,
  hint: GDE.PropertyHint,
  hint_string: string,
}


/*
* Export a GDE.Int and tell Godot that it's a pointer.. I guess.
* Not sure why you'd want this, but it's here. Interop between plugins/libraries I guess?
*/
Export_Pointer :: proc "c" ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.float or GDE.Int.
                        where (sics.type_has_field(classStruct, fieldName) && ((sics.type_field_type(classStruct, fieldName) == GDE.Int) || (sics.type_is_pointer(sics.type_field_type(classStruct, fieldName)))))
    {
    context = godotContext
    //get the index from the GDTypes array, this is equivalent to the VariantType enum placement.
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.INT, fieldName, .INT_IS_POINTER, "", className, property_usage)
    
    
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    //Since I can't cast from int to a pointer I swapped to doing a transmute instead.
    set :: proc "c" (p_classData: ^classStruct, godotValue: GDE.Int) {
        context = godotContext

        (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = transmute(sics.type_field_type(classStruct, fieldName))(godotValue)
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> GDE.Int {
        context = godotContext
        return (cast(^GDE.Int)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .INT, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

/*
* Prevents the editor from allowing a user to set the Alpha channel.
*/
Export_Color_No_Alpha :: proc "c" ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.Color.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == GDE.Color))
    {
    context = godotContext
    
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    info: GDE.PropertyInfo = Make_Property_Full(.COLOR, fieldName, .COLOR_NO_ALPHA, "", className, property_usage)
    
    //Register the information with Godot in order for the variable to be accessible.
    bind_export(classStruct, &className_SN, fieldName, .FLOAT, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

/*
* Export a bit_set. Can be backed by an enum or not. If not backed by an enum will label fields as numbers from lower to upper.

*/
Export_Int_As_Flags :: proc "c" ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_bit_set(sics.type_field_type(classStruct, fieldName)))
{
    context = godotContext
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //UTF-8 array which will be used as the propertyHint's hint string.
    output:[dynamic]u8

    //Need to handle the condition when the bit_set is backed by an enum and when it isn't.
    when sics.type_is_enum((sics.type_bit_set_elem_type(sics.type_field_type(classStruct, fieldName)))) {
        flag_enum:=(type_info_of(sics.type_bit_set_elem_type(sics.type_field_type(classStruct, fieldName))).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum))


        for name,index in flag_enum.names {
            append(&output, name[:])
            append(&output, ':')
            buf:[64]u8
            //The index of an enum represents the index of the bool in a bit_set.
            //Quickest way to convert to a bit position is to bitshift an amount equal to the value.
            intermediate:[]u8= transmute([]u8)(strconv.write_int(buf[:],i64(1<<u64(flag_enum.values[index])), 10))
            append(&output, string(intermediate[:]))
            append(&output, ',')
        }
        //Defines the information about the variable properties in a way Godot's editor understands
        prop_info:= Make_Property_Full(.INT, fieldName, .FLAGS, string(output[:]), className, property_usage)
    } else {

        append(&output, fmt.tprintf("%d", type_info_of(sics.type_field_type(classStruct, fieldName)).variant.(runtime.Type_Info_Bit_Set).lower))

        //When not backed by an enum still need to provide some values to Godot.
        //Just creating a string of coma separated numbers.
        for i:= type_info_of(sics.type_field_type(classStruct, fieldName)).variant.(runtime.Type_Info_Bit_Set).lower+1; i< type_info_of(sics.type_field_type(classStruct, fieldName)).variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            append(&output, fmt.tprintf(",%v", i))
        }
        //Defines the information about the variable properties in a way Godot's editor understands
        prop_info:= Make_Property_Full(.INT, fieldName, .FLAGS, string(output[:]), className, property_usage)
    }
    set :: proc "c" (p_classData: ^classStruct, godotValue: GDE.Int) {
        context = godotContext
        ////fmt.println(godotValue)
        (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = transmute(sics.type_field_type(classStruct, fieldName))(sics.type_bit_set_underlying_type(sics.type_field_type(classStruct, fieldName))(godotValue))
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> GDE.Int {
        context = godotContext

        //fmt.println((cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^)
        return (cast(^GDE.Int)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    //bind_export(classStruct, &className_SN, fieldName, .INT, GDE.Int, methodType, &prop_info, loc)
    Bind_Property_Prop_Info(&className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName, loc)

    destructProperty(&prop_info)
    delete(output)

}


/*
* Export a bit_set to Godot for use in GDScript. namespace will be within the class this is defined in.
* Only accepts bit_sets which are 'distinct' in order for them to be named.
* classStruct: Struct of a registered class.
* name: the name of the bit_set that you will use in GDScript
* outbit_set: bit_set which you are exporting for use in Godot.
*/
Export_Flags :: proc "c" ($classStruct: typeid, $outbit_set: typeid,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_is_struct(classStruct) && sics.type_is_bit_set(outbit_set) && sics.type_is_named(outbit_set))
{
    context = godotContext
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    bsname:= fmt.aprint(type_info_of(outbit_set).variant.(runtime.Type_Info_Named).name)
    defer delete(bsname)
    bsname_SN: GDE.StringName
    StringConstruct.stringNameNewString(&bsname_SN, bsname)
    defer(Destructors.stringNameDestructor(&bsname_SN))

    //Need to handle the condition when the bit_set is backed by an enum and when it isn't.
    when sics.type_is_enum((sics.type_bit_set_elem_type(outbit_set))) {
        flag_enum:=(type_info_of(sics.type_bit_set_elem_type(outbit_set)).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum))


        for field,index in flag_enum.names {
            
            field_SN: GDE.StringName
            StringConstruct.stringNameNewString(&field_SN, field)
            
            //The index of an enum represents the index of the bool in a bit_set.
            //Quickest way to convert to a bit position is to bitshift an amount equal to the value.
            gdAPI.Register_Int_const(Library, &className_SN, &bsname_SN, &field_SN, GDE.Int(1<<u64(flag_enum.values[index])), true)
            Destructors.stringNameDestructor(&field_SN)
        }

    } else {
        for i:= type_info_of(outbit_set).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).lower; i< type_info_of(outbit_set).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            field:= fmt.aprintf("%s_%v", bsname, i)
            field_SN: GDE.StringName
            StringConstruct.stringNameNewString(&field_SN, field)
            gdAPI.Register_Int_const(Library, &className_SN, &bsname_SN, &field_SN, GDE.Int(i), true)
            delete(field)
            Destructors.stringNameDestructor(&field_SN)
        }
    }
}

/*
* Export a bitset to be used as a 'layer' mask of various types for Godot's built-in layers.
* Godot's layers are limited by the engine. The layer names are defined in the Editor's settings.
* Check below link for their values.
* https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-layer-names-2d-navigation-layer-1
* See below the procedure for pre-defined bit_sets which match the layer counts specified in above link.
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* layer: Specify the type of layer that is being exported to Godot.
*/
Export_Layers :: proc "c" ($classStruct: typeid, $fieldName: string, layer: Layer_Type,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_bit_set(sics.type_field_type(classStruct, fieldName)))
{
    context = godotContext
    OType : typeid = sics.type_field_type(classStruct, fieldName)
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    hint:GDE.PropertyHint
    switch layer {
        case .LAYERS_2D_NAVIGATION: hint = .LAYERS_2D_NAVIGATION
        case .LAYERS_2D_PHYSICS: hint = .LAYERS_2D_PHYSICS
        case .LAYERS_2D_RENDER: hint = .LAYERS_2D_RENDER
        case .LAYERS_3D_NAVIGATION: hint =.LAYERS_3D_NAVIGATION
        case .LAYERS_3D_PHYSICS: hint = .LAYERS_3D_PHYSICS
        case .LAYERS_3D_RENDER: hint = .LAYERS_3D_RENDER
        case .LAYERS_AVOIDANCE: hint = .LAYERS_AVOIDANCE
    }

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, hint, "", className, property_usage)

    set :: proc "c" (p_classData: ^classStruct, godotValue: GDE.Int) {
        context = godotContext
        ////fmt.println(godotValue)
        (cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = transmute(sics.type_field_type(classStruct, fieldName))(sics.type_bit_set_underlying_type(sics.type_field_type(classStruct, fieldName))(godotValue))
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> GDE.Int {
        context = godotContext

        //fmt.println((cast(^sics.type_field_type(classStruct, fieldName))(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^)
        return (cast(^GDE.Int)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    //bind_export(classStruct, &className_SN, fieldName, .INT, GDE.Int, methodType, &prop_info, loc)
    Bind_Property_Prop_Info(&className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName, loc)

    destructProperty(&prop_info)
}

//bit flag field for layers.
//The widget in the Inspector dock will use the layer names defined in ProjectSettings.layer_names
layers_2d_render:: bit_set[1..=20; u32]
layers_3d_render:: bit_set[1..=20; u32]

layers_2d_physics:: bit_set[1..=32; u32]
layers_3d_physics:: bit_set[1..=32; u32]

layers_2d_navigation:: distinct bit_set[1..=32; u32]
layers_3d_navigation:: bit_set[1..=32; u32]

layers_avoidance:: bit_set[1..=32; u32]

Layer_Type :: enum {
    LAYERS_2D_RENDER,
    LAYERS_3D_RENDER,
    LAYERS_2D_PHYSICS,
    LAYERS_3D_PHYSICS,
    LAYERS_2D_NAVIGATION,
    LAYERS_3D_NAVIGATION,
    LAYERS_AVOIDANCE,
}


/*
* Specify the type of path that your Path is representing.
* Godot will provide hints in the editor for available files to select from.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type GDE.gdstring.
* type: an enum (PATH_TYPES) representing the types of paths. Specify which kind of path you are exporting.
*/
Export_Path :: proc "c" ($classStruct: typeid, $fieldName: string, type: PATH_TYPES,
                        filters:string="",
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Path.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Path)
    {
    context = godotContext
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    hint: GDE.PropertyHint
    switch  type {
        case .DIR: hint = .DIR
        case .FILE: hint = .FILE
        case .FILE_PATH: hint = .FILE_PATH
        case .GLOBAL_DIR: hint = .GLOBAL_DIR
        case .GLOBAL_FILE: hint = .GLOBAL_FILE
        case .GLOBAL_SAVE_FILE: hint = .GLOBAL_SAVE_FILE
        case .SAVE_FILE: hint = .SAVE_FILE
    }

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, hint, filters, className, property_usage)
    
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext

        Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

//gdstring to a path to a file or directory.
Path:: GDE.gdstring

PATH_TYPES :: enum {
  DIR, //path to a directory
  FILE, //path to a file filters with wildcards like "*.png,*.jpg"
  FILE_PATH, //stored as raw path instead of UID
  GLOBAL_DIR, //absolute path to directory
  GLOBAL_FILE, //absolute path to file
  SAVE_FILE, //file path. can have wildcards like "*.png,*.jpg".
  GLOBAL_SAVE_FILE, //absoulte file path. can have wildcards like "*.png,*.jpg".
}


/*
* When selecting the value in the Editor you will be provided with a UI to select country and language Locale.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type GDE.gdstring.
*/
Export_Locale :: proc "c" ($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Locale_ID.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Locale_ID)
    {
    context = godotContext
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    

    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .LOCALE_ID, "", className, property_usage)
    
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext

        Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

//Specifies a locale.
//Editing will show locale dialog for picking language and country.
Locale_ID :: GDE.gdstring

/*
* Strings exported as Passwords will hint to the editor that is should mask the actual letters with * symbols.
* For some reason the editor still shows a tooltip which has all the text of the password.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type GDE.gdstring.
* property_usage: consider setting this as a secret.
*/
Export_Password :: proc "c" ($classStruct: typeid, $fieldName: string,
                        $property_usage: GDE.PropertyUsageFlagsbits,
                        placeholder_text: Placeholder_Text= "password",
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Password.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Password)
    {
    context = godotContext
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    
    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .PASSWORD, placeholder_text, className, property_usage)
    
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext

        Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

//Specifies a password
Password :: GDE.gdstring

/*
* Export a gdstring and specify what the placeholder text should be for it.
* The placeholder Text will appear in the text field before being updated by the user.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type GDE.gdstring.
* placeholder_text: Placeholder_Text(string) of the text to show as a placeholder.
*/
Export_With_Placeholder_Text :: proc "c" ($classStruct: typeid, $fieldName: string,
                        placeholder_text: Placeholder_Text,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type GDE.gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.gdstring)
    {
    context = godotContext
    
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)

    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext

        Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)
    
    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .PLACEHOLDER_TEXT, placeholder_text, className, property_usage)
    
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, sics.type_field_type(classStruct, fieldName), methodType, &info, loc)
    destructProperty(&info)
}

//gdstring with a placeholder text specified in the propertyHints
Placeholder_Text:: string


/*
* Export a gdstring or StringName variable in a way which Godot will know to offer a selection of mappings from the inputs configured.
* Version 4.5 and newer provide support for this.
* The value will be saved as a string in the scene file (tscn).
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* options: show_builtin or loose_mode
* 
*/
Export_Input_Name :: proc($classStruct: typeid, $fieldName: string,
                        options: Input_Options,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == GDE.StringName || sics.type_field_type(classStruct, fieldName) == GDE.gdstring))
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    res: [dynamic]u8
    defer(delete(res))
    
    if .loose_mode in options {
        append(&res, Input_Option_Strings[.loose_mode])
    }
    
    if .show_builtin in options {
        append(&res, ",")
        append(&res, Input_Option_Strings[.show_builtin])
    }

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext
        when sics.type_field_type(classStruct, fieldName) == GDE.StringName {
            Destructors.stringNameDestructor(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
        when sics.type_field_type(classStruct, fieldName) == GDE.gdstring {
            Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    when sics.type_field_type(classStruct, fieldName) == GDE.gdstring {
        prop_info:= Make_Property_Full(.STRING, fieldName, GDE.PropertyHint(43), string(res[:]), className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }
    when sics.type_field_type(classStruct, fieldName) == GDE.StringName {
        prop_info:= Make_Property_Full(.STRING_NAME, fieldName, GDE.PropertyHint(43), string(res[:]), className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(&className_SN, fieldName, .STRING_NAME, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }

}

Input_Options :: bit_set [Input_Options_enum; u8]

Input_Options_enum :: enum u8 {
    show_builtin,
    loose_mode,
}

Input_Option_Strings:[Input_Options_enum]string=  {
    .show_builtin = "show_builtin",
    .loose_mode = "loose_mode",
}

/*
* Export a gdstring or StringName variable in a way which Godot will know to offer a selection of mappings from the inputs configured.
Doesn't work...
* The value will be saved as a string in the scene file (tscn).
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* options: show_builtin or loose_mode
* 
*/
Export_Multiline :: proc($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.gdstring)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext
        
         Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.STRING, fieldName, .MULTILINE_TEXT, "", className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
}


/*
* Export a Node Path with the permitted type(s) permitted.
* somewhat interchangeable with Node Type seeing as it will save the value as a NodePath in the tscn.
* The value will be saved as a string in the scene file (tscn).
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* Node_Type: specifies the type of node which the editor should be allowed to assign
* 
*/
Export_Node_Path_Types :: proc($classStruct: typeid, $fieldName: string,
                        Node_Type: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.gdstring)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext
        
        Destructors.stringDestruction(rawptr(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.NODE_PATH, fieldName, .NODE_PATH_VALID_TYPES, Node_Type, className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .NODE_PATH, &prop_info, "get_"+fieldName, "set_"+fieldName)
}

/*
* Export a ????? variable in a way which Godot will know is an ID of an Object.
* version 4.5 and newer will support this as a selector in the editor.
* This is meant to be used by the debugger.
* Store this in a EncodedObjectAsID Object.
**
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* Object_Type: specifies the type of Object this represents? (unlike with Node export this hint does not affect selection in the editor)
**
* object's instance can be retrieved via instance_from_id method
* https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#class-globalscope-method-instance-from-id
**
* object's ID can be retrieved via get_instance_id method
* https://docs.godotengine.org/en/stable/classes/class_object.html#class-object-method-get-instance-id
*/
Export_Object_ID :: proc($classStruct: typeid, $fieldName: string,
                        Object_Type: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Object)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: sics.type_field_type(classStruct, fieldName)) {
        context = godotContext
        
        if (cast(^GDE.Object)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName))).proxy != nil {
            //Destructors.ObjectDestroy(cast(^GDE.Object)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
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

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.OBJECT, fieldName, .OBJECT_ID, Object_Type, className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .OBJECT, &prop_info, "get_"+fieldName, "set_"+fieldName)
}

/*
* Export a dictionary to Godot and specify what types the keys and values should have.
* The Editor will respect this restriction and only allow the use of these values during assignment.
* Godot says : Dictionaries are always passed by reference. To get a copy of a dictionary which can be modified independently of the original dictionary, use duplicate().
* TODO: Could use more testing.
**
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* Dictionary_Type: See below the Export. This is a struct in which you will declare the type of the key and value.
*/
Export_Dictionary_type :: proc($classStruct: typeid, $fieldName: string,
                        Dictionary_Type: Dictionary_Types,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Dictionary)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: GDE.Dictionary) {
        context = godotContext
        
        //Need to destroy the Dictionary each time it's set by Godot because copy on write expects other accessors to make a copy before modifying.
        if (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName))).id != nil {    
            GDDictionary.Destroy(cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
        (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = GDE.Dictionary(godotValue)
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> GDE.Dictionary {
        context = godotContext
        return (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Hint string should be formatted as "int;String"
    hint_string: string = fmt.aprint(GDE.GDTypes_strings[Dictionary_Type.key_type], GDE.GDTypes_strings[Dictionary_Type.value_type], sep=";")
    
    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.DICTIONARY, fieldName, .DICTIONARY_TYPE, hint_string, className, property_usage)
    delete(hint_string)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .DICTIONARY, &prop_info, "get_"+fieldName, "set_"+fieldName)
}

//used in the GDTypes_strings array in order to get the stringified value of the type.
//If you need a dictionary where the key is typed but not the value, use VARIANT_MAX as the TValue generic parameter of the typed dictionary.
Dictionary_Types :: distinct struct {
  key_type: GDE.VariantType,
  value_type: GDE.VariantType,
}

/*
* Export a dictionary to Godot and specify that its keys will be locales and strings will be translations.
* Godot says : Dictionaries are always passed by reference. To get a copy of a dictionary which can be modified independently of the original dictionary, use duplicate().
* TODO: Could use more testing.
**
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* Dictionary_Type: See below the Export. This is a struct in which you will declare the type of the key and value.
*/
Export_Dictionary_Localizable_String :: proc($classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Dictionary)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    set :: proc "c" (p_classData: ^classStruct, godotValue: GDE.Dictionary) {
        context = godotContext
        
        //Need to destroy the Dictionary each time it's set by Godot because copy on write expects other accessors to make a copy before modifying.
        if (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName))).id != nil {    
            GDDictionary.Destroy(cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))
        }
        (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^ = GDE.Dictionary(godotValue)
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^classStruct, valuePassedInByGodot: GDE.Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type GDE.Int
    }
    */
    
    get :: proc "c" (p_classData: ^classStruct) -> GDE.Dictionary {
        context = godotContext
        return (cast(^GDE.Dictionary)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.DICTIONARY, fieldName, .LOCALIZABLE_STRING, "", className, property_usage)
    
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .DICTIONARY, &prop_info, "get_"+fieldName, "set_"+fieldName)
}


/*
* Tells Godot to create a button which will call the Callable returned by the getter function.
* Callable needs to exist at the time the button is pressed.
* Callable needs to be returned to Godot via a getter. The getter is called at button press.
* Set the callback of the callable to one which will only need to exist when the editor is running (unless this will be used in scripting or signals as well.)
**
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
* button_props: a struct containing the display text and icon to be used with the button. See tool_Button_Info
*/
Export_Tool_Button :: proc($classStruct: typeid, $fieldName: string,
                        button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))

    get :: proc "c" (p_classData: ^classStruct) -> GDE.Callable {
        context = godotContext
        return (cast(^GDE.Callable)(cast(uintptr)p_classData+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    //bindMethod(&className_SN, ("set_"+fieldName), set, methodType, fieldName, loc = loc)
    bindMethod(&className_SN, ("get_"+fieldName), get, methodType, loc = loc)

    hint_string:string
    //Godot does not know how to handle a seperator when there's nothing after it.
    //As a result this must handle all situations seperately.
    if len(button_props.icon) > 0 {
        hint_string = fmt.aprint(button_props.text, button_props.icon, sep = ",")
    } else if len(button_props.text) > 0 {
        hint_string = fmt.aprint(button_props.text)
    } else do hint_string = ""

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.CALLABLE, fieldName, .TOOL_BUTTON, hint_string, className, property_usage)
    delete(hint_string)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
}


/*
* WARNING implementation incomplete.
* Tells Godot to create a button within the Node inspector which will call the Callable returned by the getter function.
* Callable needs to exist at the time the button is pressed.
* Callable needs to be returned to Godot via a getter. The getter is called at button press.
* Set the callback of the callable to one which will only need to exist when the editor is running (unless this will be used in scripting or signals as well.)
**
* classStruct: the class struct which holds your variable.
* fieldName: a unique name. If there is name collision Godot will replace the previous version with the newest version.
* button_props: a struct containing the display text and icon to be used with the button. See tool_Button_Info
*/
gdCallable: GDE.Callable
Export_Callable_As_Tool_Button :: proc($classStruct: typeid, $fieldName: string, callable: GDE.Callable,
                        button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        //where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    

    @(static) value: GDE.Callable
    if value.objectId == 0 {
        value = callable
    } else { 
        assert(false, "This happens when this Export is called with the same const values multiple times.")
    }

    get :: proc "c" (p_classData: ^classStruct) -> GDE.Callable {
        context = godotContext
        return value
    }
    //get(callable)
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    hint_string:string
    //Godot does not know how to handle a seperator when there's nothing after it.
    //As a result this must handle all situations seperately.
    if len(button_props.icon) > 0 {
        hint_string = fmt.aprint(button_props.text, button_props.icon, sep = ",")
    } else if len(button_props.text) > 0 {
        hint_string = fmt.aprint(button_props.text)
    } else do hint_string = ""

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.CALLABLE, fieldName, .TOOL_BUTTON, hint_string, className, property_usage)
    delete(hint_string)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
}

/*
* WARNING implementation incomplete.
* Tells Godot to create a button within the Node inspector which will call the Callable returned by the getter function.
* Callable needs to exist at the time the button is pressed.
* Callable needs to be returned to Godot via a getter. The getter is called at button press.
* Set the callback of the callable to one which will only need to exist when the editor is running (unless this will be used in scripting or signals as well.)
**
* classStruct: the class struct which holds your variable.
* fieldName: a unique name. If there is name collision Godot will replace the previous version with the newest version.
* button_props: a struct containing the display text and icon to be used with the button. See tool_Button_Info
*/
Export_proc_As_Tool_Button :: proc($classStruct: typeid, $fieldName: string, $callable: $P,
                        callback: $PP, container: ^GDE.Callable, button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) -> GDE.Callable \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        //where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == GDE.Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := fmt.aprint(type_info_of(classStruct))
    defer delete(className)
    className_SN: GDE.StringName
    StringConstruct.stringNameNewString(&className_SN, className)
    defer(Destructors.stringNameDestructor(&className_SN))
    

    //Allocating callables into my class struct.
    my_Custom_Callable: GDE.CallableCustomInfo2 = {
        token = Library,
        callable_userdata = rawptr(callable),
        call_func = callback,
    }

    gdCallable23: GDE.Callable
    
    Methods.makeCallable(container, &my_Custom_Callable)

    @(static) value: GDE.Callable
    if value.objectId == 0 {
        value = container^
    } else { 
        assert(false, "This happens when this Export is called with the same struct and name multiple times.")
    }

    get :: proc "c" (p_classData: ^classStruct) -> GDE.Callable {
        context = runtime.default_context()
        //callable()
        return value
    }
    //get(callable)
    /*
    The above creates a proc that does the following - replace GDE.Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^classStruct) -> GDE.Int {
        return yourclassstruct.someField^ //someField is of type GDE.Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(&className_SN, "get_"+fieldName, get, methodType, loc = loc)

    hint_string:string
    //Godot does not know how to handle a seperator when there's nothing after it.
    //As a result this must handle all situations seperately.
    if len(button_props.icon) > 0 {
        hint_string = fmt.aprint(button_props.text, button_props.icon, sep = ",")
    } else if len(button_props.text) > 0 {
        hint_string = fmt.aprint(button_props.text)
    } else do hint_string = ""

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.CALLABLE, fieldName, .TOOL_BUTTON, hint_string, className, property_usage)
    delete(hint_string)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(&className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
    return gdCallable
}

/*
* used for Export_Tool_Button to specify the details of the button.
* text: will be displayed in the button itself.
* icon: the icon type to be displayed alongside the button. ex. ColorRect will show the color selector icon.
*/
tool_Button_Info :: struct {
    text: string,
    icon: string,
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
bind_export :: #force_inline proc($classStruct: typeid, className_SN: ^GDE.StringName, $fieldName: string,
    variant_type: GDE.VariantType, $GDType: typeid, methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
    prop_info: ^GDE.PropertyInfo, loc:= #caller_location) {
    
    get,set:= make_getter_and_setter(classStruct, GDType, fieldName)

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(className_SN, "set_"+fieldName, set, methodType, fieldName, loc = loc)
    bindMethod(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    //bindProperty(className_SN, fieldName, variant_type, "get_"+fieldName, "set_"+fieldName)
    Bind_Property_Prop_Info(className_SN, fieldName, variant_type, prop_info, "get_"+fieldName, "set_"+fieldName, loc)
}

make_getter_and_setter :: #force_inline proc($classStruct: typeid, $field_Type: typeid, $fieldName: string) -> (getter: proc "c" (p_classData: ^classStruct) -> field_Type, setter: proc "c" (p_classData: ^classStruct, godotValue: field_Type)) {
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

make_property :: #force_inline proc "c" (type: GDE.VariantType, name: string) -> GDE.PropertyInfo {
    return makePropertyFull_string(type, name, GDE.PropertyHint.NONE, "", "", GDE.PROPERTY_USAGE_DEFAULT)
}

Make_Property_Full :: proc {
    makePropertyFull_cstring,
    makePropertyFull_string,
}

//TODO : See if I really need to malloc these variables or if that's just something for C to do.
//Odin has a bunch of memory management. If all we need is to malloc memory to heap we can do that with new().
makePropertyFull_cstring :: #force_inline proc "c" (type: GDE.VariantType, name: cstring, hint: GDE.PropertyHint, hintString: cstring, className: cstring, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {
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
        usage = usageFlags,
    }

    return info
}

makePropertyFull_string :: #force_inline proc "c" (type: GDE.VariantType, name: string, hint: GDE.PropertyHint, hintString: string, className: string, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {
    context = runtime.default_context()

    prop_name:= new(GDE.StringName)
    StringConstruct.stringNameNewUTF8andLen(prop_name, raw_data(name), i64(len(name)))

    propHintString:= new(GDE.gdstring)
    StringConstruct.stringNewUTF8_len(propHintString, raw_data(hintString), i64(len(hintString)))

    propClassName:= new(GDE.StringName)
    StringConstruct.stringNameNewUTF8andLen(propClassName, raw_data(className), i64(len(className)))
    
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
bindMethod :: #force_inline proc "c" (className: ^GDE.StringName, methodName: string,
                        function: $T,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        argNames: ..string, loc:= #caller_location
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    context = godotContext

    methodStringName: GDE.StringName
    StringConstruct.stringNameNewUTF8andLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

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
        method_flags = (methodType),
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

Bind_Property_Prop_Info :: #force_inline proc(className: ^GDE.StringName, name: string, type: GDE.VariantType, prop_hint: ^GDE.PropertyInfo, getter, setter: string, loc:=#caller_location) {

    getterName: GDE.StringName
    StringConstruct.stringNameNewUTF8andLen(&getterName, raw_data(getter[:]), i64(len(getter)))

    setterName: GDE.StringName
    StringConstruct.stringNameNewUTF8andLen(&setterName, raw_data(setter[:]), i64(len(setter)))
    
    //fmt.println("register property")
    gdAPI.classDBRegisterExtensionClassProperty(Library, className, prop_hint, &setterName, &getterName)
    
}

/*
* bindProperty is used to make your variable public.
* Prior to calling this you should have registered the get and/or set functions with Godot.
* Provide their names as cstrings. Check the makePublic function for a general workflow.
* Use makePublic to auto-gen basic get/set functions for simple variables. (I haven't tested with arrays.)
*/
bindProperty :: #force_inline proc "c" (className: ^GDE.StringName, name: string, type: GDE.VariantType, getter, setter: cstring, loc:=#caller_location) {
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
bindNoReturn2 :: #force_inline proc "c" (function: $P, loc:=#caller_location) -> (GDE.ClassMethodPtrCall, GDE.ClassMethodCall) {
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
            
            variantTypeCheck(gdTypeList[:], p_args, r_error)

            func := cast(P)method_userdata

            when sics.type_proc_return_count(P) > 0 {
                result:sics.type_proc_return_type(P, 0)= func(cast(argT0)p_instance, fromvariant(cast(GDE.VariantPtr)p_args[0], argT1))
                    variant_from(cast(^GDE.Variant)r_return, &result)
            } else {
                fmt.println(fromvariant(cast(^GDE.Variant)p_args[0], argT1))
                fmt.println((cast(^GDE.Variant)p_args[0]).data)
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

