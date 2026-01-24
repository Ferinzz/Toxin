//#+ignore
package GDWrapper

import GDE "gdextension"
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
    
init_ref :: proc "c" (RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    context = runtime.default_context()
    @(static)INIT_REF: GDE.MethodBindPtr
    if INIT_REF == nil do INIT_REF = classDBGetMethodBind("RefCounted", "init_ref", 2240911060)
    assert(RefCounted != nil)
    gdAPI.objectMethodBindPtrCall(INIT_REF, RefCounted, nil, r_ret)
}

reference :: proc "c" (RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    context = runtime.default_context()
    @(static)REFERENCE: GDE.MethodBindPtr
    if REFERENCE == nil do REFERENCE = classDBGetMethodBind("RefCounted", "reference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.objectMethodBindPtrCall(REFERENCE, RefCounted, nil, r_ret)
}

unreference :: proc "c" (RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Bool){
    context = runtime.default_context()
    @(static)UNREFERENCE: GDE.MethodBindPtr
    if UNREFERENCE == nil do UNREFERENCE = classDBGetMethodBind("RefCounted", "unreference", 2240911060)
    assert(RefCounted != nil)
    gdAPI.objectMethodBindPtrCall(UNREFERENCE, RefCounted, nil, r_ret)
}

//r_ret max_size is i32.
get_reference_count :: proc "c" (RefCounted: GDE.ObjectPtr, r_ret: ^GDE.Int){
    context = runtime.default_context()
    @(static)GET_REF_COUNT: GDE.MethodBindPtr
    if GET_REF_COUNT == nil do GET_REF_COUNT = classDBGetMethodBind("RefCounted", "get_reference_count", 3905245786)
    assert(RefCounted != nil)
    gdAPI.objectMethodBindPtrCall(GET_REF_COUNT, RefCounted, nil, r_ret)
}