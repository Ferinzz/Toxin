#+ignore
package Toxin

//import GDE "GDWrapper/gdAPI/gdextension"
import GDW "GDWrapper"

ClassNameString :: string

SN_Error :: enum {
    ALREADY_NIL,
    BAD_INDEX,
}

GDClass_StringName_get :: proc(classname_index: GDW.ClassName_Index) -> ^StringName {
    //ClassName_StringNames[classname_index]
    if GDW.ClassName_StringNames[classname_index].ptr == nil {
        GDW.StringConstruct.stringNameNewString(&ClassName_StringNames[classname_index], reflect.enum_field_names(ClassName_Index)[classname_index])
    }
    return &ClassName_StringNames[classname_index]
}

ClassName_StringName_Del :: proc(classname_index: GDW.ClassName_Index) -> SN_Error {
    when ODIN_DEBUG {
        if int(classname_index) > len(ClassName_Index) {
            return .BAD_INDEX
        }
        if ClassName_StringNames[classname_index].ptr == nil {
            return .ALREADY_NIL
        }
    }

    GDW.StringName_Methods.Destroy(&GDW.ClassName_StringNames[classname_index])

    return nil
}