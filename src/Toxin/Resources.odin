package Toxin

import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"
//import Classes "shared:Godot_Odin_Binds/GD_Classes"
import Classes "../../GD_Classes"

resource_M: Classes.ResourceLoader_MethodBind_List
//WARNING DO NOT USE WITH RANDOM PNG ETC.
//The Resource only works with files that have already been imported into the engine.
//If you just have a file sitting in the directory and haven't interacted with the editor to import it 
//use Image->load() instead. Jesus fucking christ it took a while to find confirmation about this.
loadResource :: proc(path, hint: cstring, cacheMode: ^cache_mode) -> GDE.ObjectPtr{
    @(static)load: GDE.MethodBindPtr

    
    Classes.ResourceLoader_Init_(&resource_M)
    
    pathS: GDE.gdstring
    hintS: GDE.gdstring
    gdAPI.Strings_Utils.NewWithLatin1Chars(&pathS, path)
    //defer(Destructors.stringDestruction(&pathS))

    gdAPI.Strings_Utils.NewWithLatin1Chars(&hintS, hint)
    defer(GDW.gdstring_M_List.Destroy(&hintS))

    args_res:= [?]rawptr {&pathS, &hintS, cacheMode}
    r_resource: GDE.ObjectPtr

    gdAPI.Object_Utils.MethodBindPtrcall(cast(GDE.MethodBindPtr)resource_M.load, GDW.getMainLoop(), raw_data(args_res[:]), &r_resource)
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