//#+ignore
package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"
import "base:runtime"

/*
{
	"name": "RefCounted",
	"is_refcounted": true,
	"is_instantiable": true,
	"inherits": "Object",
	"api_type": "core",
	"methods": [
*/


    //*****************\\
    //*****Methods*****\\
    //*****************\\

init_ref :: proc(RefCounted: ^Object, r_ret: ^Bool){
    @(static)INIT_REF: GDE.MethodBindPtr
    if INIT_REF == nil do INIT_REF = classDBGetMethodBind3(.RefCounted, "init_ref", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(INIT_REF, RefCounted, nil, r_ret)
}

reference :: proc(RefCounted: ^Object, r_ret: ^Bool){
    @(static)REFERENCE: GDE.MethodBindPtr
    if REFERENCE == nil do REFERENCE = classDBGetMethodBind3(.RefCounted, "reference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(REFERENCE, RefCounted, nil, r_ret)
}

unreference :: proc(RefCounted: ^Object, r_ret: ^Bool){
    @(static)UNREFERENCE: GDE.MethodBindPtr
    if UNREFERENCE == nil do UNREFERENCE = classDBGetMethodBind3(.RefCounted, "unreference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(UNREFERENCE, RefCounted, nil, r_ret)
}

//r_ret max_size is i32.
get_reference_count :: proc(RefCounted: ^Object, r_ret: ^Int){
    @(static)GET_REF_COUNT: GDE.MethodBindPtr
    if GET_REF_COUNT == nil do GET_REF_COUNT = classDBGetMethodBind3(.RefCounted, "get_reference_count", 3905245786)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_REF_COUNT, RefCounted, nil, r_ret)
}