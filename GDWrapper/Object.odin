package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"


Object_get_ptr: proc "c" (base: ^Variant) -> ^Object

init_Object_Methods :: proc "c" () {
    Object_get_ptr = cast(type_of(Object_get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.OBJECT)
}