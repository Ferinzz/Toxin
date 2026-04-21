package Toxin

import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import GDE "../GDWrapper/gdAPI/gdextension"
import Classes "../GD_Classes"

resource_M: Classes.ResourceLoader_MethodBind_List

//WARNING DO NOT USE WITH RANDOM PNG ETC.
//The Resource only works with files that have already been imported into the engine.
//If you just have a file sitting in the directory and haven't interacted with the editor to import it 
//use Image->load() instead. Jesus fucking christ it took a while to find confirmation about this.
//This also fetches methods and singletons at every call. Prefer making your own version using the singletons directly based on the calls used.
loadResource :: proc(path, hint: string, cacheMode: ^Classes.ResourceLoader_CacheMode, load_proc: ^Classes.ResourceLoader_MethodBind_List) -> GDE.ObjectPtr{
    @(static)load: GDE.MethodBindPtr
    
    pathS: GDE.gdstring
    hintS: GDE.gdstring
    gdAPI.Strings_Utils.NewWithLatin1CharsAndLen(&pathS, cstring(raw_data(path)), i64(len(path)))
    defer(GDW.gdstring_M_List.Destroy(&pathS))

    gdAPI.Strings_Utils.NewWithLatin1CharsAndLen(&hintS, cstring(raw_data(hint)), i64(len(hint)))
    defer(GDW.gdstring_M_List.Destroy(&hintS))


    return loadResource_GDS(&pathS, &hintS, cacheMode, load_proc)
}

loadResource_GDS :: proc(path, hint: ^gdstring, cacheMode: ^Classes.ResourceLoader_CacheMode, load_proc: ^Classes.ResourceLoader_MethodBind_List) -> GDE.ObjectPtr{
    r_resource: GDE.ObjectPtr
    load_proc.load->m_call(nil, {path, hint, cacheMode}, &r_resource)
    return r_resource
}



//https://docs.godotengine.org/en/stable/classes/class_resourceloader.html#enum-resourceloader-cachemode
//default is 0
cache_mode :: enum GDE.Int {
    CACHE_MODE_IGNORE,
    CACHE_MODE_REUSE,
    CACHE_MODE_REPLACE,
    CACHE_MODE_IGNORE_DEEP,
    CACHE_MODE_REPLACE_DEEP,
}