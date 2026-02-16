
package Toxin

import "base:runtime"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import sics "base:intrinsics"
import "core:fmt"
import "core:slice"
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

/*
* Godot will need a getter and setter to be able to handle variables 'made public'
* This function will generate basic get and set functions for you. Register their callbacks, register them for use in the editor or GDScripts.
* Assumption: you are setting all the information in a struct. You will provide the name of the field as you've declared it.
* classStruct: the class struct which holds your variable.
* fieldName: the name that matches the field in the struct as you've named it.
*/
Export :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        where sics.type_has_field(classStruct, fieldName)
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //I don't want you to have to learn the VariantType enum and pass that in. Instead, I will do a lookup based on the type.
    //If the type shown in Godot does not align with the Odin type, the order of GDE.VariantType enum and GDTypes need to be validated again.
    //get the index from the GDTypes array, this is in order of to the VariantType enum placement.
    index, ok := slice.linear_search(GDW.GDTypes[:], Field_Type)
    if ok == false {
        panic("The type sent to makePublic was not found in GDW.GDTypes. Please check the list of valid Godot types.", loc)
    }

    variant_type:=GDE.VariantType(index)

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = make_property(variant_type, fieldName)
    //prop_info:= Make_Property_Full(variant_type, fieldName, .NONE, "", className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, variant_type, &info, "get_"+fieldName, "set_"+fieldName)
    //bind_export(classStruct, &className_SN, fieldName, variant_type, Field_Type, methodType, &info, loc)
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
Export_Int_As_Enum :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, .CLASS_IS_ENUM },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type enum.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_enum(sics.type_field_type(classStruct, fieldName)))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    anEnum:typeid= Field_Type
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
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .ENUM, string(output[:]), className, property_usage)

    //Create all necessary information and Register the information with Godot in order for the variable to be accessible.
    //bind_export(classStruct, &className_SN, fieldName, .INT, Int, methodType, &prop_info, loc)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Int)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .INT, &info, "get_"+fieldName, "set_"+fieldName)
    
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
Export_String_As_Enum :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        options: []string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, .CLASS_IS_ENUM },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == StringName || sics.type_field_type(classStruct, fieldName) == gdstring))
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    res, err:=strings.join(options[:], ",")
    defer(delete(res))
    
    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    when Field_Type == gdstring {
        prop_info:= Make_Property_Full(.STRING, fieldName, .ENUM, res, className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }
    when Field_Type == StringName {
        prop_info:= Make_Property_Full(.STRING_NAME, fieldName, .ENUM, res, className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .STRING_NAME, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }


}

//Godot stores enum info in ClassInfo as a HashMap. The fields are stored in struct EnumInfo.
//https://github.com/godotengine/godot/blob/0fdb93cde6ccb5176f96b0ddbba08d83e6c6aef2/core/object/class_db.h#L131
/*
* Register the fields of an enum so that it can be used in GDScript as a list of constants.
* classStruct: Used to get the name of your class.
* out_enum: the enum you want to export as constants.
*/
Export_Enum :: #force_inline proc(className_SN: ^StringName, $classStruct: typeid, $out_enum: typeid) \
        where(sics.type_is_enum(out_enum) && sics.type_is_struct(classStruct))
    {
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    
    enumName:= type_info_of(out_enum).variant.(runtime.Type_Info_Named).name
    defer delete(enumName)
    enumName_SN: StringName
    GDW.StringConstruct(&enumName_SN, enumName)
    defer(GDW.StringName_M_List.Destroy(&enumName_SN))


    info:=type_info_of(out_enum).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum)
    
    //Loop through each entry in the enum to add their name and value to the hint string.
    for field, ind in info.names {
        field_SN: StringName
        GDW.StringConstruct(&field_SN, field)
        gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(GDW.Library, className_SN, &enumName_SN, &field_SN, Int(info.values[ind]), false)
        GDW.StringName_M_List.Destroy(&field_SN)
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
Export_Range :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        range_info: $T/Ranged_Num,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type float or Int.
                        where (sics.type_has_field(classStruct, fieldName) && ((sics.type_field_type(classStruct, fieldName) == float) || (sics.type_field_type(classStruct, fieldName) == Int)))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

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
    if Field_Type == Int {
        field_type = .INT
    }
    else if Field_Type == float {
        field_type = .FLOAT
    } else {
        GDW.failureProc("", "unsupported type in Export_Range", loc)
    }
    if len(flag_string) > 0{
        output = strings.concatenate({min,",",max,",",step,",",string(flag_string[:])})
    } else {
        output = strings.concatenate({min,",",max,",",step})
    }
    
    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .RANGE, output, className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    Bind_Property(className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName)

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

Range_Flags :: bit_set [Range; Int]

Range :: enum {
  or_greater, //Can exceed the max limit
  or_less, //Can go lower than the min limit
  exp, //
  hide_slider, //Slider will not appear in editor
  radians_as_degrees, //will represent radian values as degrees
  degrees, //limit the range to degrees (-360 to 360)
}

//Warning untested!!
Export_Ranged_Array :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        range_info: $T/Ranged_Array,
                        loc:= #caller_location)
                        where sics.type_has_field(classStruct, fieldName)
    {
    methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name


    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

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
    if Field_Type == Int {
        field_type = .INT
    }
    else if Field_Type == float {
        field_type = .FLOAT
    } else {
        GDW.failureProc("", "unsupported type in Export_Range", loc)
        
    }
    if len(flag_string) > 0{
        output = strings.concatenate({min,",",max,",",step,",",string(flag_string[:])})
    } else {
        output = strings.concatenate({min,",",max,",",step})
    }
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.INT, fieldName, .RANGE, output, className, GDE.PROPERTY_USAGE_DEFAULT)

    //This registers the get and set functions to the field so that Godot knows what to call when changing the value is editor.
    if !rodata {
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName)}
    else {
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "")
    }
    destructProperty(&prop_info)
}

/*
* Supports: Array[int], Array[float], PackedByteArray, PackedInt32Array, PackedInt64Array, PackedFloat32Array, or PackedFloat64Array
* indexType should be one of Int or float
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
Export_Easing :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string, easing: Easing_Options,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type float.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == float))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.FLOAT, fieldName, .EXP_EASING, Easing_Type[easing], className, property_usage)
    
    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    Bind_Property(className_SN, fieldName, .FLOAT, &info, "get_"+fieldName, "set_"+fieldName)

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
Export_Array_Type :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        Index: ..Array_Type_Hint_Info,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Array.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == Array))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    if OType != Array {return}

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name


    hints: [dynamic]string

    for l in Index {
        if l.hint == .NONE {
            hint:= fmt.aprintf("%d:", l.type)
            append(&hints, hint)
            delete(hint)
        } else {
            hint:= fmt.aprintf("%d/%d:%s", Int(l.type), Int(l.hint), l.hint_string)
            append(&hints, hint)
            delete(hint)
        }
    }

    final_hint_string, ok:= strings.concatenate(hints[:])
    if ok !=nil { return }

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.ARRAY, fieldName, .ARRAY_TYPE, final_hint_string, className, property_usage)
    
    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    Bind_Property(className_SN, fieldName, .ARRAY, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
* Export a Int and tell Godot that it's a pointer.. I guess.
* Not sure why you'd want this, but it's here. Interop between plugins/libraries I guess?
*/
Export_Pointer :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type float or Int.
                        where (sics.type_has_field(classStruct, fieldName) && ((sics.type_field_type(classStruct, fieldName) == Int) || (sics.type_is_pointer(sics.type_field_type(classStruct, fieldName)))))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = Make_Property_Full(.INT, fieldName, .INT_IS_POINTER, "", className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Int)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .INT, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

/*
* Prevents the editor from allowing a user to set the Alpha channel.
*/
Export_Color_No_Alpha :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Color.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == Color))
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    info: GDE.PropertyInfo = Make_Property_Full(.COLOR, fieldName, .COLOR_NO_ALPHA, "", className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .FLOAT, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

/*
* Export a bit_set. Can be backed by an enum or not. If not backed by an enum will label fields as numbers from lower to upper.

*/
Export_Int_As_Flags :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_bit_set(sics.type_field_type(classStruct, fieldName)))
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name


    //UTF-8 array which will be used as the propertyHint's hint string.
    output:[dynamic]u8

    //Need to handle the condition when the bit_set is backed by an enum and when it isn't.
    when sics.type_is_enum((sics.type_bit_set_elem_type(Field_Type))) {
        flag_enum:=(type_info_of(sics.type_bit_set_elem_type(Field_Type)).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum))


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

        append(&output, fmt.tprintf("%d", type_info_of(Field_Type).variant.(runtime.Type_Info_Bit_Set).lower))

        //When not backed by an enum still need to provide some values to Godot.
        //Just creating a string of coma separated numbers.
        for i:= type_info_of(Field_Type).variant.(runtime.Type_Info_Bit_Set).lower+1; i< type_info_of(Field_Type).variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            append(&output, fmt.tprintf(",%v", i))
        }
        //Defines the information about the variable properties in a way Godot's editor understands
        prop_info:= Make_Property_Full(.INT, fieldName, .FLAGS, string(output[:]), className, property_usage)
    }

    get,set:= make_getter_and_setter2(classStruct, fieldName, Int)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property_Prop_Info(className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName, loc)

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
Export_Flags :: proc(className_SN: ^StringName, $classStruct: typeid, $outbit_set: typeid,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_is_struct(classStruct) && sics.type_is_bit_set(outbit_set) && sics.type_is_named(outbit_set))
{
    
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name


    bsname:= fmt.aprint(type_info_of(outbit_set).variant.(runtime.Type_Info_Named).name)
    defer delete(bsname)
    bsname_SN: StringName
    GDW.StringConstruct(&bsname_SN, bsname)
    defer(GDW.StringName_M_List.Destroy(&bsname_SN))

    //Need to handle the condition when the bit_set is backed by an enum and when it isn't.
    when sics.type_is_enum((sics.type_bit_set_elem_type(outbit_set))) {
        flag_enum:=(type_info_of(sics.type_bit_set_elem_type(outbit_set)).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Enum))


        for field,index in flag_enum.names {
            
            field_SN: StringName
            GDW.StringConstruct(&field_SN, field)
            
            //The index of an enum represents the index of the bool in a bit_set.
            //Quickest way to convert to a bit position is to bitshift an amount equal to the value.
            gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(GDW.Library, className_SN, &bsname_SN, &field_SN, Int(1<<u64(flag_enum.values[index])), true)
            GDW.StringName_M_List.Destroy(&field_SN)
        }

    } else {
        for i:= type_info_of(outbit_set).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).lower; i< type_info_of(outbit_set).variant.(runtime.Type_Info_Named).base.variant.(runtime.Type_Info_Bit_Set).upper+1; i+=1 {
            field:= fmt.aprintf("%s_%v", bsname, i)
            field_SN: StringName
            GDW.StringConstruct(&field_SN, field)
            gdAPI.ClassDB.RegisterExtensionClassIntegerConstant(GDW.Library, className_SN, &bsname_SN, &field_SN, Int(i), true)
            delete(field)
            GDW.StringName_M_List.Destroy(&field_SN)
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
Export_Layers :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string, layer: Layer_Type,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type bit_set.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_is_bit_set(sics.type_field_type(classStruct, fieldName)))
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)

    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    
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

    get,set:= make_getter_and_setter2(classStruct, fieldName, Int)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property_Prop_Info(className_SN, fieldName, .INT, &prop_info, "get_"+fieldName, "set_"+fieldName, loc)

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
* fieldName: string of the name of the field which is being exported. Should be of type gdstring.
* type: an enum (PATH_TYPES) representing the types of paths. Specify which kind of path you are exporting.
*/
Export_Path :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string, type: PATH_TYPES,
                        filters:string="",
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Path.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Path)
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    
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

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

//gdstring to a path to a file or directory.
Path:: gdstring

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
* fieldName: string of the name of the field which is being exported. Should be of type gdstring.
*/
Export_Locale :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Locale_ID.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Locale_ID)
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .LOCALE_ID, "", className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

//Specifies a locale.
//Editing will show locale dialog for picking language and country.
Locale_ID :: gdstring

/*
* Strings exported as Passwords will hint to the editor that is should mask the actual letters with * symbols.
* For some reason the editor still shows a tooltip which has all the text of the password.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type gdstring.
* property_usage: consider setting this as a secret.
*/
Export_Password :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        $property_usage: GDE.PropertyUsageFlagsbits,
                        placeholder_text: Placeholder_Text= "password",
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type Password.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Password)
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    
    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .PASSWORD, placeholder_text, className, property_usage)

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
    destructProperty(&info)
}

//Specifies a password
Password :: gdstring

/*
* Export a gdstring and specify what the placeholder text should be for it.
* The placeholder Text will appear in the text field before being updated by the user.
* classStruct: struct representing the class that has the property being exported
* fieldName: string of the name of the field which is being exported. Should be of type gdstring.
* placeholder_text: Placeholder_Text(string) of the text to show as a placeholder.
*/
Export_With_Placeholder_Text :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        placeholder_text: Placeholder_Text,
                        property_usage: GDE.PropertyUsageFlagsbits = GDE.PROPERTY_USAGE_DEFAULT,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == gdstring)
    {
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    info: GDE.PropertyInfo = makePropertyFull_string(.STRING, fieldName, .PLACEHOLDER_TEXT, placeholder_text, className, property_usage)

    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, string(fieldName), .STRING, &info, "get_"+fieldName, "set_"+fieldName)
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
Export_Input_Name :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        options: Input_Options,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && (sics.type_field_type(classStruct, fieldName) == StringName || sics.type_field_type(classStruct, fieldName) == gdstring))
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    res: [dynamic]u8
    defer(delete(res))
    
    if .loose_mode in options {
        append(&res, Input_Option_Strings[.loose_mode])
    }
    
    if .show_builtin in options {
        append(&res, ",")
        append(&res, Input_Option_Strings[.show_builtin])
    }

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    when Field_Type == gdstring {
        prop_info:= Make_Property_Full(.STRING, fieldName, GDE.PropertyHint(43), string(res[:]), className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
    }
    when Field_Type == StringName {
        prop_info:= Make_Property_Full(.STRING_NAME, fieldName, GDE.PropertyHint(43), string(res[:]), className, property_usage)
        //Register the information with Godot in order for the variable to be accessible.
        Bind_Property(className_SN, fieldName, .STRING_NAME, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Multiline :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == gdstring)
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.STRING, fieldName, .MULTILINE_TEXT, "", className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .STRING, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Node_Path_Types :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        Node_Type: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == gdstring)
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.NODE_PATH, fieldName, .NODE_PATH_VALID_TYPES, Node_Type, className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .NODE_PATH, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Object_ID :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        Object_Type: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Object)
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.OBJECT, fieldName, .OBJECT_ID, Object_Type, className, property_usage)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .OBJECT, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Dictionary_type :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        Dictionary_Type: Dictionary_Types,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Dictionary)
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Hint string should be formatted as "int;String"
    hint_string: string = fmt.aprint(GDTypes_strings[Dictionary_Type.key_type], GDTypes_strings[Dictionary_Type.value_type], sep=";")
    
    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.DICTIONARY, fieldName, .DICTIONARY_TYPE, hint_string, className, property_usage)
    delete(hint_string)
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .DICTIONARY, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Dictionary_Localizable_String :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        property_usage: GDE.PropertyUsageFlagsbits = { .STORAGE, .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Dictionary)
{
    Field_Type:: sics.type_field_type(classStruct, fieldName)
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get,set:= make_getter_and_setter2(classStruct, fieldName, Field_Type)
    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    Bind_Set(className_SN, "set_"+fieldName, set, fieldName, methodType = methodType, loc = loc)
    Bind_Get(className_SN, "get_"+fieldName, get, methodType, loc = loc)

    //Defines the information about the variable properties in a way Godot's editor understands
    prop_info:= Make_Property_Full(.DICTIONARY, fieldName, .LOCALIZABLE_STRING, "", className, property_usage)
    
    //Register the information with Godot in order for the variable to be accessible.
    Bind_Property(className_SN, fieldName, .DICTIONARY, &prop_info, "get_"+fieldName, "set_"+fieldName)
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
Export_Tool_Button :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string,
                        button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name

    get :: proc "c" (p_classData: ^Class_Container(classStruct)) -> Callable {
        context = runtime.default_context()
        return (cast(^Callable)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^
    }
    /*
    The above creates a proc that does the following - replace Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^Class_Container(classStruct)) -> Int {
        return yourclassstruct.someField^ //someField is of type Int
    }
    */

    //This function handles the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(className_SN, ("get_"+fieldName), get, methodType, loc = loc)

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
    Bind_Property(className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
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
gdCallable: Callable
Export_Callable_As_Tool_Button :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string, callable: Callable,
                        button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        //where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name
    

    @(static) value: Callable
    if value.objectId == 0 {
        value = callable
    } else { 
        assert(false, "This happens when this Export is called with the same const values multiple times.")
    }

    get :: proc "c" (p_classData: ^Class_Container(classStruct)) -> Callable {
        context = runtime.default_context()
        return value
    }
    /*
    The above creates a proc that does the following - replace Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^Class_Container(classStruct)) -> Int {
        return yourclassstruct.someField^ //someField is of type Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(className_SN, "get_"+fieldName, get, methodType, loc = loc)

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
    Bind_Property(className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
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
Export_proc_As_Tool_Button :: proc(className_SN: ^StringName, $classStruct: typeid, $fieldName: string, $callable: $P,
                        callback: $PP, container: ^Callable, button_props: tool_Button_Info = {},
                        property_usage: GDE.PropertyUsageFlagsbits = { .EDITOR, },
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT,
                        loc:= #caller_location) -> Callable \
                        //Catch whether the struct field exists at compile-time. No point trying anything else if the field doesn't exist.
                        //This field should only be of type gdstring.
                        //where (sics.type_has_field(classStruct, fieldName) && sics.type_field_type(classStruct, fieldName) == Callable)
{
    //Creates a string of your classStruct. Godot uses StringName values to reference a lot of things.
    //In this case, this stringName is used to recognize this class in their classDB.
    className := type_info_of(classStruct).variant.(runtime.Type_Info_Named).name
    

    //Allocating callables into my class struct.
    my_Custom_Callable: CallableCustomInfo2 = {
        token = Library,
        callable_userdata = rawptr(callable),
        call_func = callback,
    }

    gdCallable23: Callable
    
    gdAPI.Callable_Utils.CustomCreate2(container, &my_Custom_Callable)

    @(static) value: Callable
    if value.objectId == 0 {
        value = container^
    } else { 
        assert(false, "This happens when this Export is called with the same struct and name multiple times.")
    }

    get :: proc "c" (p_classData: ^Class_Container(classStruct)) -> Callable {
        context = runtime.default_context()
        //callable()
        return value
    }
    //get(callable)
    /*
    The above creates a proc that does the following - replace Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^Class_Container(classStruct)) -> Int {
        return yourclassstruct.someField^ //someField is of type Int
    }
    */

    //These functions handle the creation and export of the getter and setter functions which Godot will call.
    //Godot doesn't call our procedures directly, so we need to pass through this.
    bindMethod(className_SN, "get_"+fieldName, get, methodType, loc = loc)

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
    Bind_Property(className_SN, fieldName, .CALLABLE, &prop_info, "get_"+fieldName, "")
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
bind_export :: #force_inline proc($classStruct: typeid, className_SN: ^StringName, $fieldName: string,
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

make_property :: #force_inline proc(type: GDE.VariantType, name: string) -> GDE.PropertyInfo {
    return makePropertyFull_string(type, name, GDE.PropertyHint.NONE, "", "", GDE.PROPERTY_USAGE_DEFAULT)
}

Make_Property_Full :: proc {
    makePropertyFull_cstring,
    makePropertyFull_string,
}

//TODO : See if I really need to malloc these variables or if that's just something for C to do.
//Odin has a bunch of memory management. If all we need is to malloc memory to heap we can do that with new().
makePropertyFull_cstring :: #force_inline proc(type: GDE.VariantType, name: cstring, hint: GDE.PropertyHint, hintString: cstring, className: cstring, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {
    

    prop_name:= new(StringName)
    gdAPI.StringName_Utils.Latin1Chars(prop_name, name, false)

    propHintString:= new(gdstring)
    gdAPI.Strings_Utils.NewWithUtf8Chars(propHintString, hintString)

    propClassName:= new(StringName)
    gdAPI.StringName_Utils.Latin1Chars(propClassName, className, false)
    
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

makePropertyFull_string :: #force_inline proc(type: GDE.VariantType, name: string, hint: GDE.PropertyHint, hintString: string, className: string, usageFlags: GDE.PropertyUsageFlagsbits) -> GDE.PropertyInfo {

    prop_name:= new(StringName)
    gdAPI.StringName_Utils.Utf8CharsAndLen(prop_name, raw_data(name), i64(len(name)))

    propHintString:= new(gdstring)
    gdAPI.Strings_Utils.NewWithUtf8CharsAndLen(propHintString, raw_data(hintString), i64(len(hintString)))

    propClassName:= new(StringName)
    gdAPI.StringName_Utils.Utf8CharsAndLen(propClassName, raw_data(className), i64(len(className)))
    
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

//MUST have these types initialized before attempting to access them. Godot will panic otherwise (Yay RAII..)
Verify_Heap_Init :: proc {
    Verify_Array_Init,
    Verify_Dictionary_Init,
}

_Heap_Not_Init :: proc(classStruct: typeid, fieldName: string, var_type: string) -> string {
    return fmt.tprintf("Error: %s should be initialized in Create proc. %[2]s :: struct {{{{ %[1]s: %[0]s}", var_type, fieldName, type_info_of(classStruct).variant.(runtime.Type_Info_Named).name)
}

Verify_Array_Init :: proc(p_classData: ^Array, classStruct: typeid, fieldName: string) {
if nil == p_classData.id {
    GDW.Array_M_List.Create0(p_classData, nil)
    when ODIN_DEBUG {
        fmt.panicf(_Heap_Not_Init(classStruct, fieldName, "Array"))
    }
}
};

Verify_Dictionary_Init :: proc(p_classData: ^Dictionary, classStruct: typeid, fieldName: string) {
if nil == p_classData.id {
    GDW.Dictionary_M_List.Create0(p_classData, nil)
    when ODIN_DEBUG {
            fmt.panicf(_Heap_Not_Init(classStruct, fieldName, "Dictionary"))
    }
}
};


Bind_Property :: proc {
    bindProperty,
    Bind_Property_Prop_Info,
}

Bind_Property_Prop_Info :: #force_inline proc(className: ^StringName, name: string, type: GDE.VariantType, prop_hint: ^GDE.PropertyInfo, getter, setter: string, loc:=#caller_location) {

    getterName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&getterName, raw_data(getter[:]), i64(len(getter)))
    setterName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&setterName, raw_data(setter[:]), i64(len(setter)))
    gdAPI.ClassDB.RegisterExtensionClassProperty(GDW.Library, className, prop_hint, &setterName, &getterName)
    
}

/*
* bindProperty is used to make your variable public.
* Prior to calling this you should have registered the get and/or set functions with Godot.
* Provide their names as cstrings. Check the makePublic function for a general workflow.
* Use makePublic to auto-gen basic get/set functions for simple variables. (I haven't tested with arrays.)
*/
bindProperty :: #force_inline proc(className: ^StringName, name: string, type: GDE.VariantType, getter, setter: cstring, loc:=#caller_location) {
    
    info: GDE.PropertyInfo = make_property(type, name)

    getterName: StringName
    gdAPI.StringName_Utils.Latin1Chars(&getterName, getter, false)
    setterName: StringName
    gdAPI.StringName_Utils.Latin1Chars(&setterName, setter, false)
    gdAPI.ClassDB.RegisterExtensionClassProperty(GDW.Library, className, &info, &setterName, &getterName)

    //Destructor stuff
    destructProperty(&info)
}

destructProperty :: proc(info: ^GDE.PropertyInfo) {
    
    if info.name != nil{
        GDW.StringName_M_List.Destroy(info.name)
    }
    if info.class_name != nil {
        GDW.StringName_M_List.Destroy(info.class_name)
    }
    if info.hint_string != nil {
        GDW.gdstring_M_List.Destroy(info.hint_string)
    }
    
    //See above TODO. If malloc is not needed, wouldn't need to free.
    if info.name != nil{
    free(info.name)}
    if info.hint_string != nil {
    free(info.class_name)}
    if info.class_name != nil {
    free(info.hint_string)}
}

/*
* TODO: update to only pass the pointers to the getter/setter in order to simplify some of this.
** Return will still need specific types.
** Variant type validation would still need type validation.
*/
//This is messy. I dunno if this is better or worse than having 7 individual functions... Lots of casting. Eh.
//This is also using some really old functions for the variant conversion since they provide a return instead of needing an empty pointer.
Gen_Variant_Setter ::  proc(function: $P, loc:=#caller_location) -> (GDE.ClassMethodCall) {
    field_type::sics.type_field_type(sics.type_proc_parameter_type(P, 2), "self")
    godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: GDE.VariantPtr, r_error: ^GDE.CallError) {
        context= runtime.default_context()
        if p_argument_count != 1 {
            r_error^= {
                error=.CALL_ERROR_TOO_MANY_ARGUMENTS,
                argument= i32(p_argument_count),
                expected = 1,
            }
        }

        //gdTypeList:= [1]GDE.VariantType {.INT}
        //variantTypeCheck(gdTypeList[:], p_args, r_error)
        val: sics.type_elem_type(field_type)
        call:=cast(proc(rawptr, rawptr, rawptr, rawptr))method_userdata
        copy_from_variant(&val, p_args[0])
        vars:=[1]rawptr{&val}
        call(method_userdata, p_instance, &vars, r_return)
        r_error^={}
    }
    return godotVariantCallback
}

Gen_Variant_Getter ::  proc(function: $P, loc:=#caller_location) -> (GDE.ClassMethodCall) {//, GDE.ClassMethodPtrCall) {

    godotVariantCallback :: proc "c" (method_userdata: rawptr, p_instance: GDE.ClassInstancePtr,
            p_args: GDE.ConstVariantPtrargs, p_argument_count: Int, r_return: ^GDE.Variant, r_error: ^GDE.CallError) {
        context= runtime.default_context()
        if p_argument_count != 0 {
            r_error^= {
                error=.CALL_ERROR_TOO_MANY_ARGUMENTS,
                argument= i32(p_argument_count),
                expected = 1,
            }
        }
        call:=cast(proc(rawptr, rawptr, rawptr, rawptr))method_userdata
        tr_return: sics.type_elem_type(sics.type_proc_parameter_type(P, 3))
        call(method_userdata, p_instance, nil, &tr_return)
        //TODO: why does Godot not receive the values correctly?
        r_error.error = .CALL_OK
        r_error.expected = 12
        r_error.argument = 1
        GDW.new_variant_from_methods(r_return, &tr_return)
    }
    return godotVariantCallback
}

Bind_Set :: #force_inline proc(className: ^StringName, methodName: string,
                        function: $T,
                        argNames: string,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    callFunc:= Gen_Variant_Setter(function, loc=loc)

        argsInfo: [1]GDE.PropertyInfo

        index:int
        index, _ = slice.linear_search(GDW.GDTypes[:], sics.type_elem_type(sics.type_field_type(sics.type_proc_parameter_type(T, 2), "self")))
        argsInfo[0] = make_property(GDE.VariantType(index), argNames)

        args_metadata: [1]GDE.ClassMethodArgumentMetadata
        args_metadata[0]= GDE.ClassMethodArgumentMetadata.NONE


    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = callFunc,
        ptrcall_func = GDE.ClassMethodPtrCall(function),
        method_flags = (methodType),
    }
    
        methodInfo.argument_count = 1
        methodInfo.arguments_info = &argsInfo[0]
        methodInfo.arguments_metadata = &args_metadata[0]


    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
}

Bind_Get :: #force_inline proc(className: ^StringName, methodName: string,
                        function: $T,
                        methodType: GDE.ClassMethodFlags = GDE.Method_Flags_DEFAULT, loc:= #caller_location
                        )
                        where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 8)
    {
    methodStringName: StringName
    gdAPI.StringName_Utils.Utf8CharsAndLen(&methodStringName, raw_data(methodName), i64(len(methodName)))

    callFunc:= Gen_Variant_Getter(function, loc=loc)

        index:int
        index, _ = slice.linear_search(GDW.GDTypes[:], sics.type_elem_type(sics.type_proc_parameter_type(T, 3)))
        returnInfo: GDE.PropertyInfo =  make_property(GDE.VariantType(index), "")

    //only necessary to have a specific string when the export type is not default.
    //returnInfo: GDE.PropertyInfo = make_property(.NIL, "")

    methodInfo : GDE.ClassMethodInfo = {
        name = &methodStringName,
        method_userdata = cast(rawptr)function,

        call_func = callFunc,
        ptrcall_func = GDE.ClassMethodPtrCall(function),
        method_flags = (methodType),
    }
    
        methodInfo.argument_count = 0
        methodInfo.return_value_info = &returnInfo
        methodInfo.has_return_value = true
        methodInfo.arguments_info = nil
        methodInfo.arguments_metadata = nil


    gdAPI.ClassDB.RegisterExtensionClassMethod(GDW.Library, className, &methodInfo)
    
    //Destructor things.
    GDW.StringName_M_List.Destroy(&methodStringName)
    destructProperty(&returnInfo)
}

ObjSize::size_of(^Object)

make_getter_and_setter2 :: proc($classStruct: typeid, $fieldName: string, $field_Type: typeid) -> (getter: proc "c" (method_userdata: rawptr, p_classData: ^Class_Container(classStruct), godotValue: rawptr, r_ret: ^field_Type), setter: proc "c" (method_userdata: rawptr, p_classData: ^Class_Container(classStruct), godotValue: ^struct{self:^field_Type}, r_ret: GDE.TypePtr)) {
    
    field_type:: sics.type_field_type(classStruct, fieldName)
    //Getting to a field in a struct is not immediately available via intrinsics. Relying on built-in offset_of_by_string to get the pointer.
    //This makes a really long line, but that's how generics go.
    setterr :: proc "c" (method_userdata: rawptr, p_classData: ^Class_Container(classStruct), godotValue: ^struct{self:^field_Type}, r_ret: GDE.TypePtr){
        context = runtime.default_context()

        when  field_type == Array ||
        sics.type_is_specialization_of(field_type, GDW.packedArray) ||
        field_type == Dictionary {
            Verify_Heap_Init(((^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName))),\
            classStruct, fieldName)
        }
        //If it is a type which needs to be destroyed, Ref_count new source then destroy old.
        when field_type == Array ||
        sics.type_is_specialization_of(field_type, GDW.packedArray) ||
        field_type == Dictionary ||
        field_type == StringName ||
        field_type == gdstring ||
        field_type == NodePath ||
        field_type == Callable ||
        field_type == Signal 
        {
            r_sn: field_type
            Ref_Count(godotValue.self, &r_sn)
            Destroy_Builtin((^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))
            (cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^ = (r_sn)
        } else {
            when sics.type_is_bit_set(field_type) {
                bit_underlying:: sics.type_bit_set_underlying_type(field_type)
                (cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^ = transmute(field_type)(bit_underlying(godotValue.self^))
            } else when field_type == rawptr {
                (cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^ = rawptr(uintptr(godotValue.self^))
            } else {
                (cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^ = field_type(godotValue.self^)
            }
        }
    }
    /*
    The above creates a proc that does the following - replace Int with whatever the field's type is.
    set :: proc "c" (yourclassstruct: ^Class_Container(classStruct), valuePassedInByGodot: Int) {
        yourclassstruct.someField^ = valuePassedInByGodot //someField is of type Int
    }
    */

    getterr :: proc "c" (method_userdata: rawptr, p_classData: ^Class_Container(classStruct), godotValue: rawptr, r_ret: ^field_Type){
        context = runtime.default_context()
        when field_type == Array ||
        sics.type_is_specialization_of(field_type, GDW.packedArray) ||
        field_type == Signal ||
        field_type == Callable ||
        field_type == Dictionary {
            Verify_Heap_Init((cast(^field_type)(rawptr(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))),\
            classStruct, fieldName)
        }
        when sics.type_is_bit_set(field_type) {
            bit_underlying:: sics.type_bit_set_underlying_type(field_type)
            val:=transmute(bit_underlying)((cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^)
            r_ret^ = Int(val)

        } else when field_type == rawptr {
            r_ret^ = Int((cast(^uintptr)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^)
        } else {
            r_ret^ = (cast(^field_type)(cast(uintptr)p_classData+ObjSize+offset_of_by_string(classStruct, fieldName)))^
        }
    }
    /*
    The above creates a proc that does the following - replace Int with whatever the field's type is.
    get :: proc "c" (yourclassstruct: ^Class_Container(classStruct)) -> Int {
        return yourclassstruct.someField^ //someField is of type Int
    }
    */
    return getterr, setterr
}