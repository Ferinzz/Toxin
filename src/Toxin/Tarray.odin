package Toxin

import GDE "../GDWrapper/gdAPI/gdextension"
import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"

/*
* val: the array which will be set to a specific type
* _type: the type to use for the array
* class: optional. Specify the class if _type is Object.
* script: optional. specify the scipt if class is extended.
*/
array_set_type :: #force_inline proc(arr: ^Array, _type: GDE.VariantType, class: ^StringName = nil, script: ^Variant = nil){
    gdAPI.Packed_Array_Utils.ArraySetTyped(arr, _type, class, script)
}

dictionary_set_type :: #force_inline proc(dic: ^Dictionary, key: GDE.VariantType, value: GDE.VariantType, key_class: ^StringName = nil, key_script: ^Variant = nil, val_class: ^StringName = nil, val_script: ^Variant = nil) {
    gdAPI.Dictionary_Utils.SetTyped(dic, key, key_class, key_script, value, val_class, val_script)
}

set_typed :: proc{
    dictionary_set_type,
    array_set_type,
}

append :: proc{
    array_append,
    array_append_p,
}

array_append :: proc(dest: ^Array, arg: Variant) {
    arg:= arg
    GDW.Array_M_List.append(dest, {&arg})
}
array_append_p :: proc(dest: ^Array, arg: ^Variant) {
    GDW.Array_M_List.append(dest, {arg})
}

//Ensure destination has not been initialized before calling.
typed_Dictionary_setter :: proc(dest: ^$D/typed_Dictionary($K,$V), key: ^K, value: ^V) {
    //assert(dest.id != nil, "Cannot assign to dictionary which has not been initialized.")
    if dest.id == nil {

    }
    GDW.Dictionary_M_List.KeyedSetter(dest, key, value)
}

//ensure dest has not been initialized before calling.
make_typed_dictionary :: proc(dest: ^$T/typed_Dictionary($K, $V), base: ^T = nil,
                              key_class: ^StringName = nil, key_script: ^Variant = nil,
                              val_class: ^StringName = nil, val_script: ^Variant = nil) {
    key_type:= variant_index(K)
    value_type:= variant_index(V)
    GDW.Dictionary_M_List.Create2(dest, {base, &key_type, key_class, key_script, &value_type, val_class, val_script})
}