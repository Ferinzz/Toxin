#+ignore
package Toxin

//import GDE "GDWrapper/gdAPI/gdextension"
import GDW "../GDWrapper"
import Classes "../GD_Classes"
import "core:reflect"

ClassNameString :: string

SN_Error :: enum {
    ALREADY_NIL,
    BAD_INDEX,
}

GDClass_StringName_get :: proc(classname_index: Classes.ClassName_Index) -> ^StringName {
    //ClassName_StringNames[classname_index]
    if Classes.ClassName_StringNames[classname_index].ptr == nil {
        GDW.StringConstruct(&Classes.ClassName_StringNames[classname_index], reflect.enum_field_names(Classes.ClassName_Index)[classname_index])
    }
    return &Classes.ClassName_StringNames[classname_index]
}

ClassName_StringName_Del :: proc(classname_index: Classes.ClassName_Index) -> SN_Error {
    when ODIN_DEBUG {
        if int(classname_index) > len(Classes.ClassName_Index) {
            return .BAD_INDEX
        }
        if Classes.ClassName_StringNames[classname_index].ptr == nil {
            return .ALREADY_NIL
        }
    }

    GDW.StringName_M_List.Destroy(&Classes.ClassName_StringNames[classname_index])

    return nil
}