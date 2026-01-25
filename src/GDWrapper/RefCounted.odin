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
    
init_ref :: proc(RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    @(static)INIT_REF: GDE.MethodBindPtr
    if INIT_REF == nil do INIT_REF = classDBGetMethodBind("RefCounted", "init_ref", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(INIT_REF, RefCounted, nil, r_ret)
}

reference :: proc(RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    @(static)REFERENCE: GDE.MethodBindPtr
    if REFERENCE == nil do REFERENCE = classDBGetMethodBind("RefCounted", "reference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(REFERENCE, RefCounted, nil, r_ret)
}

unreference :: proc(RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    @(static)UNREFERENCE: GDE.MethodBindPtr
    if UNREFERENCE == nil do UNREFERENCE = classDBGetMethodBind("RefCounted", "unreference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(UNREFERENCE, RefCounted, nil, r_ret)
}

//r_ret max_size is i32.
get_reference_count :: proc(RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Int){
    @(static)GET_REF_COUNT: GDE.MethodBindPtr
    if GET_REF_COUNT == nil do GET_REF_COUNT = classDBGetMethodBind("RefCounted", "get_reference_count", 3905245786)
    assert(RefCounted != nil)
    gdAPI.Object_Utils.MethodBindPtrcall(GET_REF_COUNT, RefCounted, nil, r_ret)
}