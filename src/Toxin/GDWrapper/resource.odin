package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

//**************************\\
//*****Resource Methods*****\\
//**************************\\

//https://docs.godotengine.org/en/stable/classes/class_resourceloader.html#enum-resourceloader-cachemode
//default is 0
cache_mode :: enum Int {
    CACHE_MODE_IGNORE,
    CACHE_MODE_REUSE,
    CACHE_MODE_REPLACE,
    CACHE_MODE_IGNORE_DEEP,
    CACHE_MODE_REPLACE_DEEP,
}

//WARNING DO NOT USE WITH RANDOM PNG ETC.
//The Resource only works with files that have already been imported into the engine.
//If you just have a file sitting in the directory and haven't interacted with the editor to import it 
//use Image->load() instead. Jesus fucking christ it took a while to find confirmation about this.
loadResource :: proc(path, hint: cstring, cacheMode: ^cache_mode) -> ^Object{
    @(static)load: GDE.MethodBindPtr

    if load == nil {
        load = classDBGetMethodBind3(.ResourceLoader, "load", 3358495409)
    }

    pathS: gdstring
    hintS: gdstring
    gdAPI.Strings_Utils.NewWithLatin1Chars(&pathS, path)
    defer(String_Methods.Destroy(&pathS))

    gdAPI.Strings_Utils.NewWithLatin1Chars(&hintS, hint)
    defer(String_Methods.Destroy(&hintS))

    args_res:= [?]rawptr {&pathS, &hintS, cacheMode}
    r_resource: ^Object

    gdAPI.Object_Utils.MethodBindPtrcall(load, getMainLoop(), raw_data(args_res[:]), &r_resource)
    return r_resource
}

getRid :: proc(ref: ^Object, r_ret: ^RID) {
    @(static)GetRID: GDE.MethodBindPtr
    if GetRID == nil do GetRID = classDBGetMethodBind3(.Resource, "get_rid", 2944877500)
    
    gdAPI.Object_Utils.MethodBindPtrcall(GetRID, ref, nil, r_ret)
}




freeRID :: proc(body: ^RID) {
    @(static)FreeRID: GDE.MethodBindPtr
    if FreeRID == nil do FreeRID = classDBGetMethodBind3(.PhysicsServer2D, "free_rid", 2722037293)

    assert(body.id != 0 && PhysServer2dObj != nil)
    args:= [1]rawptr {body}
    gdAPI.Object_Utils.MethodBindPtrcall(FreeRID, PhysServer2dObj, raw_data(args[:]), nil)
}

