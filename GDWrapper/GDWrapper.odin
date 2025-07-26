package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:slice"

Library : GDE.ClassLibraryPtr = nil


//*****************************\\
//******Pointers to Godot******\\
//******Utility Functions******\\
//*****************************\\

//You're going to use the p_get_proc_address a lot to get most of the default Godot interface functions.
gdAPI : struct  {
    p_get_proc_address: GDE.InterfaceGetProcAddress,
    classDBRegisterExtClass: GDE.InterfaceClassdbRegisterExtensionClass4,
    classDBConstructObj: GDE.InterfaceClassdbConstructObject,
    object_set_instance: GDE.InterfaceObjectSetInstance,
    object_set_instance_binding: GDE.InterfaceObjectSetInstanceBinding,
    mem_alloc: GDE.InterfaceMemAlloc,
    mem_free: GDE.InterfaceMemFree,

    //Variant related function pointers.
    classdbRegisterExtensionClassMethod: GDE.InterfaceClassdbRegisterExtensionClassMethod,

    //Custom properties.
    classDBRegisterExtensionClassProperty: GDE.InterfaceClassdbRegisterExtensionClassProperty,
    classBDRegistClassSignal: GDE.InterfaceClassdbRegisterExtensionClassSignal,


    //Use to get the method pointers for Godot's objects. ie : get the set_position function from Node2D
    classDBGetMethodBind: GDE.InterfaceClassdbGetMethodBind,

    //Functions related to method bindings on Godot side.
    objectMethodBindCall: GDE.InterfaceObjectMethodBindCall,
    objectMethodBindPtrCall: GDE.InterfaceObjectMethodBindPtrcall,
    builtinMethodBindCall: GDE.InterfaceVariantGetPtrBuiltinMethod,
    indexGetBind: GDE.InterfaceVariantGetPtrIndexedGetter,
    indexSetBind: GDE.InterfaceVariantGetPtrIndexedSetter,
    variantGetPtrOperatorEvaluator: GDE.InterfaceVariantGetPtrOperatorEvaluator,

    regGetObj: GDE.InterfaceRefGetObject
}



//Use these to build a C++ String or StringName that Godot can use.
StringConstruct : struct {
    stringNameNewLatin: GDE.InterfaceStringNameNewWithLatin1Chars,
    stringNewUTF8: GDE.InterfaceStringNewWithUtf8Chars,
    stringNewLatin: GDE.InterfaceStringNewWithLatin1Chars,
    utf8FromString: GDE.InterfaceStringToUtf8Chars,
}



//Destructors :: struct {
Destructors: struct {
    stringNameDestructor: GDE.PtrDestructor,
    stringDestruction: GDE.PtrDestructor,
    variantDestroy: GDE.InterfaceVariantDestroy
} 

//: Destructors

Methods: struct {
    node2dSetPosition: GDE.MethodBindPtr,
    node2dGetPos: GDE.MethodBindPtr,
    objectEmitSignal: GDE.MethodBindPtr,
    getMainLoop: GDE.MethodBindPtr,
    getSingleton: GDE.InterfaceGlobalGetSingleton,
    makeCallable: GDE.InterfaceCallableCustomCreate2,
    ObjGetClassName: GDE.InterfaceObjectGetClassName,
    checkCast: GDE.InterfaceObjectCastTo,
}



loadAPI :: proc(p_get_proc_address : GDE.InterfaceGetProcAddress){

    // Get helper functions first.
    //Gets a pointer to the function that will return the pointer to the function that destroys the specific variable type.
    variant_get_ptr_destructor: GDE.InterfaceVariantGetPtrDestructor  = cast(GDE.InterfaceVariantGetPtrDestructor)p_get_proc_address("variant_get_ptr_destructor")
    //Gets a pointer to the function that will return the pointer to the function that will evaluate the variable types under the specified condition.
    gdAPI.variantGetPtrOperatorEvaluator = cast(GDE.InterfaceVariantGetPtrOperatorEvaluator)p_get_proc_address("variant_get_ptr_operator_evaluator")
    variantGetPtrConstructor: GDE.InterfaceVariantGetPtrConstructor = cast(GDE.InterfaceVariantGetPtrConstructor)p_get_proc_address("variant_get_ptr_constructor")

    //Operators
    //Do not get confused with the function that we run on our end that will return whether a StringName is equal. This just runs the compare on Godot Side.
    //operator.stringNameEqual = variantGetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .STRING_NAME, .STRING_NAME)

    //API.
    gdAPI.p_get_proc_address = p_get_proc_address
    gdAPI.classDBRegisterExtClass = cast(GDE.InterfaceClassdbRegisterExtensionClass4)p_get_proc_address("classdb_register_extension_class4")
    gdAPI.classDBConstructObj = cast(GDE.InterfaceClassdbConstructObject)p_get_proc_address("classdb_construct_object")
    gdAPI.object_set_instance = cast(GDE.InterfaceObjectSetInstance)p_get_proc_address("object_set_instance")
    gdAPI.object_set_instance_binding = cast(GDE.InterfaceObjectSetInstanceBinding)p_get_proc_address("object_set_instance_binding")
    gdAPI.mem_alloc = cast(GDE.InterfaceMemAlloc)p_get_proc_address("mem_alloc")
    gdAPI.mem_free = cast(GDE.InterfaceMemFree)p_get_proc_address("mem_free")
    gdAPI.classdbRegisterExtensionClassMethod = cast(GDE.InterfaceClassdbRegisterExtensionClassMethod)p_get_proc_address("classdb_register_extension_class_method")
    gdAPI.classDBRegisterExtensionClassProperty = cast(GDE.InterfaceClassdbRegisterExtensionClassProperty)p_get_proc_address("classdb_register_extension_class_property")
    //Really nice that you can (hopefully) just cast the pointer to the function's proc type. Signature?
    gdAPI.classDBGetMethodBind = cast(GDE.InterfaceClassdbGetMethodBind)p_get_proc_address("classdb_get_method_bind")
    //gdAPI.objectMethodBindPtrCall = cast(proc(p_method_bind: GDE.MethodBindPtr, p_instance: GDE.ObjectPtr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr))p_get_proc_address("object_method_bind_ptrcall")
    gdAPI.objectMethodBindPtrCall = cast(GDE.InterfaceObjectMethodBindPtrcall)p_get_proc_address("object_method_bind_ptrcall")
    gdAPI.classBDRegistClassSignal = cast(GDE.InterfaceClassdbRegisterExtensionClassSignal)p_get_proc_address("classdb_register_extension_class_signal")
    gdAPI.objectMethodBindCall = cast(GDE.InterfaceObjectMethodBindCall)p_get_proc_address("object_method_bind_call")
    gdAPI.builtinMethodBindCall = cast(GDE.InterfaceVariantGetPtrBuiltinMethod)p_get_proc_address("variant_get_ptr_builtin_method")

    //constructors.
    StringConstruct.stringNameNewLatin = cast(GDE.InterfaceStringNameNewWithLatin1Chars)p_get_proc_address("string_name_new_with_latin1_chars")
    StringConstruct.stringNewUTF8 = cast(GDE.InterfaceStringNewWithUtf8Chars)gdAPI.p_get_proc_address("string_new_with_utf8_chars")
    StringConstruct.stringNewLatin = cast(GDE.InterfaceStringNewWithLatin1Chars)gdAPI.p_get_proc_address("string_new_with_latin1_chars")
    StringConstruct.utf8FromString = cast(GDE.InterfaceStringToUtf8Chars)gdAPI.p_get_proc_address("string_to_utf8_chars")


    VariantGetters.getVariantFromTypeConstructor = cast(GDE.InterfaceGetVariantFromTypeConstructor)p_get_proc_address("get_variant_from_type_constructor")
    VariantGetters.getVariantToTypeConstuctor = cast(GDE.InterfaceGetVariantToTypeConstructor)p_get_proc_address("get_variant_to_type_constructor")
    VariantGetters.variantGetType = cast(GDE.InterfaceVariantGetType)p_get_proc_address("variant_get_type")
    VariantFrom.FloatToVariant = VariantGetters.getVariantFromTypeConstructor(.FLOAT)
    variantto.floatFromVariant = VariantGetters.getVariantToTypeConstuctor(.FLOAT)
    variantto.intFromVariant = VariantGetters.getVariantToTypeConstuctor(.INT)
    variantto.packedf32arrayFromVariant = VariantGetters.getVariantToTypeConstuctor(.PACKED_INT64_ARRAY)
    
    //constructor.vector2ConstructorXY = variantGetPtrConstructor(.VECTOR2, 3) // See extension_gdAPI.json for indices. ??? So... a Vector2 isn't generic like it is in Raylib. It has specific names for each use case. Madness.
    //What happens if you don't use the correct index? Does Godot throw a fit because the names aren't exactly the same?
    //Is this what a dynamic language ends up being?
    VariantFrom.StringNameToVariant = VariantGetters.getVariantFromTypeConstructor(.STRING_NAME)
    VariantFrom.Vec2ToVariant = VariantGetters.getVariantFromTypeConstructor(.VECTOR2)
    VariantFrom.boolToVariant = VariantGetters.getVariantFromTypeConstructor(.BOOL)
    VariantFrom.rec2ToVariant = VariantGetters.getVariantFromTypeConstructor(.RECT2)
    VariantFrom.Transform2dToVariant = VariantGetters.getVariantFromTypeConstructor(.TRANSFORM2D)
    VariantFrom.packedf32arrayToVariant = VariantGetters.getVariantFromTypeConstructor(.PACKED_INT64_ARRAY)

    gdAPI.indexGetBind = cast(GDE.InterfaceVariantGetPtrIndexedGetter)p_get_proc_address("variant_get_ptr_indexed_getter")
    gdAPI.indexSetBind = cast(GDE.InterfaceVariantGetPtrIndexedSetter)p_get_proc_address("variant_get_ptr_indexed_setter")
    
    ArrayHelp.packedi32GetIndex = gdAPI.indexGetBind(.PACKED_INT64_ARRAY)
    ArrayHelp.packedi32SetIndex = gdAPI.indexSetBind(.PACKED_INT64_ARRAY)
    ArrayHelp.packedi32create0 = variantGetPtrConstructor(.PACKED_INT64_ARRAY, 0)
    ArrayHelp.packedi32create1 = variantGetPtrConstructor(.PACKED_INT64_ARRAY, 1)
    
    arrayClass: GDE.StringName
    StringConstruct.stringNameNewLatin(&arrayClass, "PackedInt64Array", false)
    arraySize: GDE.StringName
    StringConstruct.stringNameNewLatin(&arraySize, "size", false)
    ArrayHelp.packedi32size = gdAPI.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 3173160232)

    StringConstruct.stringNameNewLatin(&arraySize, "resize", false)
    ArrayHelp.packedi32REsize = gdAPI.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 848867239)
    
    StringConstruct.stringNameNewLatin(&arraySize, "append", false)
    ArrayHelp.packedi32Append = gdAPI.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 694024632)

    StringConstruct.stringNameNewLatin(&arraySize, "get", false)
    ArrayHelp.packedi32Get = gdAPI.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 4103005248)

    StringConstruct.stringNameNewLatin(&arraySize, "set", false)
    ArrayHelp.packedi32Set = gdAPI.builtinMethodBindCall(.PACKED_INT64_ARRAY, &arraySize, 3638975848)
    
    //constructor.variantNil = cast(GDE.InterfaceVariantNewNil)gdAPI.p_get_proc_address("variant_new_nil")
    //constructor.variantToVec2Constructor = cast(GDE.TypeFromVariantConstructorFunc)gdAPI.getVariantToTypeConstuctor(.VECTOR2)

    //Destructors.
    Destructors.stringNameDestructor = cast(GDE.PtrDestructor)variant_get_ptr_destructor(.STRING_NAME)
    Destructors.stringDestruction = cast(GDE.PtrDestructor)variant_get_ptr_destructor(.STRING)
    Destructors.variantDestroy = cast(GDE.InterfaceVariantDestroy)p_get_proc_address("variant_destroy")
    ArrayHelp.packedi32Destroy = cast(GDE.PtrDestructor)variant_get_ptr_destructor(.PACKED_INT64_ARRAY)

    //Destructors.stringNameDestructor(arraySize)
    //Destructors.stringNameDestructor(arrayClass)

    Methods.objectEmitSignal = classDBGetMethodBind("Object", "emit_signal", 4047867050)
    Methods.getSingleton = cast(GDE.InterfaceGlobalGetSingleton)gdAPI.p_get_proc_address("global_get_singleton")
    Methods.makeCallable = cast(GDE.InterfaceCallableCustomCreate2)gdAPI.p_get_proc_address("callable_custom_create2")
    Methods.ObjGetClassName = cast(GDE.InterfaceObjectGetClassName)gdAPI.p_get_proc_address("object_get_class_name")
    Methods.checkCast = cast(GDE.InterfaceObjectCastTo)gdAPI.p_get_proc_address("object_cast_to")
    //Methods.node2dSetPosition = classDBGetMethodBind("Node2D", "set_position", 743155724)


    gdAPI.regGetObj = cast(GDE.InterfaceRefGetObject)gdAPI.p_get_proc_address("ref_get_object")

    
    StringConstruct.stringNameNewLatin(&PhysicsServer2D_SN, "PhysicsServer2D", false)
    StringConstruct.stringNameNewLatin(&RenderServer_SN, "RenderingServer", false)
    
}

/* Get a binding to a method from Godot's class DB.
* Pass in the class and method name as strings. The function will convert Odin strings to Godot's StringName.
* 
* className : a string with the name of the Godot class
* methodName : a string with the name of a method in the Godot class
* hash : the hash of the method. find it in the json. Careful of buildmode it's under.
* 
*/
classDBGetMethodBind :: proc(className, methodName: cstring, hash: int, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {
    //context = runtime.default_context()

    native_class_name: GDE.StringName;
    method_name: GDE.StringName;
    
    StringConstruct.stringNameNewLatin(&native_class_name, className, false)
    StringConstruct.stringNameNewLatin(&method_name, methodName, false)
    
    methodBind = gdAPI.classDBGetMethodBind(&native_class_name, &method_name, hash)
    assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)
    
    Destructors.stringNameDestructor(&native_class_name)
    Destructors.stringNameDestructor(&method_name)

    return methodBind
}
classDBGetMethodBind2 :: proc(className: ^GDE.StringName, methodName: cstring, hash: int, loc := #caller_location) -> (methodBind: GDE.MethodBindPtr) {
    //context = runtime.default_context()

    method_name: GDE.StringName;
    
    StringConstruct.stringNameNewLatin(&method_name, methodName, false)
    
    methodBind = gdAPI.classDBGetMethodBind(className, &method_name, hash)
    assert(methodBind != nil, "Oh no. Looks like Godot couldn't find your method. \nThis could be because it doesn't exist or doesn't exist at the time it was requested.", loc)
    
    
    Destructors.stringNameDestructor(&method_name)

    return methodBind
}


make_property :: proc "c" (type: GDE.VariantType, name: cstring) -> GDE.PropertyInfo {
    
    return makePropertyFull(type, name, u32(GDE.PropertyHint.PROPERTY_HINT_NONE), "", "", u32(GDE.PropertyUsageFlags.PROPERTY_USAGE_DEFAULT))
}

//Odin has a bunch of memory management. If all we need is to malloc memory to heap we can do that with new().
makePropertyFull :: proc "c" (type: GDE.VariantType, name: cstring, hint: u32, hintString: cstring, className: cstring, usageFlags: u32) -> GDE.PropertyInfo {
    context = runtime.default_context()

    prop_name:= new(GDE.StringName)
    StringConstruct.stringNameNewLatin(prop_name, name, false)

    propHintString:= new(GDE.gdstring) 
    StringConstruct.stringNewUTF8(propHintString, hintString)

    propClassName:= new(GDE.StringName) 
    StringConstruct.stringNameNewLatin(propClassName, className, false)
    
    info: GDE.PropertyInfo = {
        name = prop_name,
        type = type, //is an enum specifying type. Meh.
        hint = hint, //Not certain what the hints do :thinking:
        hint_string = propHintString,
        class_name = propClassName,
        usage = usageFlags
    }

    return info
}

destructProperty :: proc "c" (info: ^GDE.PropertyInfo) {
    context = runtime.default_context()
    //fmt.println("destruct property ", info^)
    if info.name != nil{
    Destructors.stringNameDestructor(info.name)}
    if info.class_name != nil {
    Destructors.stringNameDestructor(info.class_name)}
    if info.hint_string != nil {
    Destructors.stringDestruction(info.hint_string)}
    
    //fmt.println("destruct property ", info^)
    
    if info.name != nil{
    free(info.name)}
    if info.hint_string != nil {
    free(info.hint_string)}
    if info.class_name != nil {
    free(info.class_name)}
    //fmt.println("property destroyed")
}



/*
* Use to check the type that Godot provides from its side.
* Returns early with ok or an error.
*/
variantTypeCheck :: proc(typeList: []GDE.VariantType, argList: [^]rawptr, r_error: ^GDE.CallError) {
    
    for type, index in typeList {
        if type != VariantGetters.variantGetType(argList[index]) {
            r_error.error = .CALL_ERROR_INVALID_ARGUMENT
            r_error.expected = i32(type)
            return
        }
    }
    
}

//TODO: make a proc group for stringName compare
//stringName::stringName; stringName::cstring; cstring::cstring
stringNameCompare :: proc "c" (l_value: GDE.ConstStringNamePtr, r_value: cstring) -> bool {
    r_name: GDE.StringName
    StringConstruct.stringNameNewLatin(&r_name, r_value, false)
    defer(Destructors.stringNameDestructor(&r_name))
    return r_name.ptr == (cast(^GDE.StringName)l_value).ptr
}

/*
* MainLoop is a class that Godot uses to tick through the program logic.
* This function returns a pointer to the object. If SceneTree is your mainLoop (or your own version of it) call
* this to get the object instead of Node's get_tree which would provide a ref to SceneTree instead.
*/
getMainLoop :: proc "c" () -> (gdLoop: GDE.ObjectPtr) {
    @(static)getMainLoop:GDE.MethodBindPtr

    ClassDB:GDE.StringName
    StringConstruct.stringNameNewLatin(&ClassDB, "Engine", false)
    defer(Destructors.stringNameDestructor(&ClassDB))
    myEngine:= Methods.getSingleton(&ClassDB)
    
    if getMainLoop == nil {
    
        loopMain: GDE.StringName
        StringConstruct.stringNameNewLatin(&loopMain, "get_main_loop", false)
        defer(Destructors.stringNameDestructor(&loopMain))
        getMainLoop = gdAPI.classDBGetMethodBind(&ClassDB, &loopMain, 1016888095)
    }

    gdAPI.objectMethodBindPtrCall(getMainLoop, myEngine, nil, &gdLoop)
    return
}

getRoot :: proc "c" () -> GDE.ObjectPtr {
    @(static)getRoot: GDE.MethodBindPtr
    if getRoot == nil {
        ClassNamegr:GDE.StringName
        StringConstruct.stringNameNewLatin(&ClassNamegr, "SceneTree", false)
        defer(Destructors.stringNameDestructor(&ClassNamegr))
        
        methodNamegr: GDE.StringName
        StringConstruct.stringNameNewLatin(&methodNamegr, "get_root", false)
        defer(Destructors.stringNameDestructor(&methodNamegr))
        getRoot = gdAPI.classDBGetMethodBind(&ClassNamegr, &methodNamegr, 1757182445)
    }
    mySceneTree:= getMainLoop()
    r_ret:GDE.ObjectPtr
    gdAPI.objectMethodBindPtrCall(getRoot, mySceneTree, nil, &r_ret)
    return r_ret
}

//**************************\\
//*****Resource Methods*****\\
//**************************\\


//https://docs.godotengine.org/en/stable/classes/class_resourceloader.html#enum-resourceloader-cachemode
//default is 0
cache_mode :: enum GDE.Int {
    CACHE_MODE_IGNORE,
    CACHE_MODE_REUSE,
    CACHE_MODE_REPLACE,
    CACHE_MODE_IGNORE_DEEP,
    CACHE_MODE_REPLACE_DEEP,
}

//WARNING DO NOT USE WITH RANDOM PNG ETC.
//The Resource only works with files that have already been imported into the engine.
//If you just have a file sitting in the directory and haven't interacted with the editor to import it 
//use Image->load() instead. Jesus fucking christ.
loadResource :: proc "c" (path, hint: cstring, cacheMode: ^cache_mode) -> GDE.ObjectPtr{
    @(static)load: GDE.MethodBindPtr

    if load == nil {
        ClassNameres:GDE.StringName
        StringConstruct.stringNameNewLatin(&ClassNameres, "ResourceLoader", false)
        defer(Destructors.stringNameDestructor(&ClassNameres))
        
        methodNameres: GDE.StringName
        StringConstruct.stringNameNewLatin(&methodNameres, "load", false)
        defer(Destructors.stringNameDestructor(&methodNameres))
        load = gdAPI.classDBGetMethodBind(&ClassNameres, &methodNameres, 3358495409)
    }
    
    pathS: GDE.gdstring
    hintS: GDE.gdstring
    StringConstruct.stringNewLatin(&pathS, path)
    defer(Destructors.stringDestruction(&pathS))

    StringConstruct.stringNewLatin(&hintS, hint)
    defer(Destructors.stringDestruction(&hintS))

    args_res:= [?]rawptr {&pathS, &hintS, cacheMode}
    r_resource: GDE.ObjectPtr

    gdAPI.objectMethodBindPtrCall(load, getMainLoop(), raw_data(args_res[:]), &r_resource)
    return r_resource
}

getRid :: proc(ref: GDE.ObjectPtr, r_ret: ^GDE.RID) {
    @(static)GetRID: GDE.MethodBindPtr
    if GetRID == nil do GetRID = classDBGetMethodBind("Resource", "get_rid", 2944877500)
    
    gdAPI.objectMethodBindPtrCall(GetRID, ref, nil, r_ret)
}
    



freeRID :: proc(body: ^GDE.RID) {
    @(static)FreeRID: GDE.MethodBindPtr
    if FreeRID == nil do FreeRID = classDBGetMethodBind("PhysicsServer2D", "free_rid", 2722037293)

    assert(body.id != 0 && PhysServer2dObj != nil)
    args:= [1]rawptr {body}
    gdAPI.objectMethodBindPtrCall(FreeRID, PhysServer2dObj, raw_data(args[:]), nil)
}




//*************************\\
//*****PhysicsServer2D*****\\
//*************************\\


queueRedraw :: proc(object: GDE.ObjectPtr) {
    @(static)QueueRedraw: GDE.MethodBindPtr
    if QueueRedraw == nil do QueueRedraw = classDBGetMethodBind("CanvasItem", "queue_redraw", 3218959716)
    
    //dummyReturn: GDE.TypePtr

    //Acutal code starts here.
    gdAPI.objectMethodBindPtrCall(QueueRedraw, object, nil, nil)
}

//**************************\\
//******Canvas Item******\\
//**************************\\

drawTexture2D :: proc(object: GDE.ObjectPtr, image: ^GDE.ObjectPtr, position: ^GDE.Vector2, color: ^GDE.Color) {
    @(static)DrawTexture: GDE.MethodBindPtr
    if DrawTexture == nil do DrawTexture = classDBGetMethodBind("CanvasItem", "draw_texture", 520200117)

    args :=  [3]rawptr{image, position, color}
    gdAPI.objectMethodBindPtrCall(DrawTexture, object, raw_data(args[:]), nil)
}


//**************************\\
//*********Viewport*********\\
//**************************\\

getWorld2D :: proc(viewport: GDE.TypePtr, r_world: ^GDE.TypePtr) {
    @(static)GetWorld2D: GDE.MethodBindPtr
    if GetWorld2D == nil do GetWorld2D = classDBGetMethodBind("Viewport", "get_world_2d", 2339128592)
    
    
    gdAPI.objectMethodBindPtrCall(GetWorld2D, cast(GDE.ObjectPtr)viewport, nil, r_world)
}

//**************************\\
//*******Canvas Group*******\\
//**************************\\

getViewpRect :: proc(object: GDE.ObjectPtr, r_rect: ^GDE.Rec2) {
    @(static)GetViewpRect: GDE.MethodBindPtr
    if GetViewpRect == nil do GetViewpRect = classDBGetMethodBind("CanvasGroup", "get_viewport_rect", 1639390495)

    gdAPI.objectMethodBindPtrCall(GetViewpRect, object, nil, r_rect)
}


//**************************\\
//******Sprite Methods******\\
//**************************\\
//Use Resource->loadResource to get the texture in the correct format. Remember to specify Texture as a hint when fetching.
setTexture :: proc "c" (dest: GDE.ObjectPtr, texture: ^GDE.ObjectPtr) {    
    @(static)set_texture: GDE.MethodBindPtr
    if set_texture == nil {
        ClassNamespr:GDE.StringName
        StringConstruct.stringNameNewLatin(&ClassNamespr, "Sprite2D", false)
        defer(Destructors.stringNameDestructor(&ClassNamespr))
        
        methodNamespr: GDE.StringName
        StringConstruct.stringNameNewLatin(&methodNamespr, "set_texture", false)
        defer(Destructors.stringNameDestructor(&methodNamespr))
        set_texture = gdAPI.classDBGetMethodBind(&ClassNamespr, &methodNamespr, 4051416890)
    }
    
    args_spr:= [?]rawptr {texture}
    dummyReturn:rawptr
    gdAPI.objectMethodBindPtrCall(set_texture, dest, raw_data(args_spr[:]), &dummyReturn)
}


//**************************\\
//*******Tree Methods*******\\
//**************************\\


InternalMode :: enum GDE.Int {
    INTERNAL_MODE_DISABLED,
    INTERNAL_MODE_FRONT,
    INTERNAL_MODE_BACK,
}

//**************************\\
//***********Node***********\\
//**************************\\

getViewport :: proc(object: GDE.ObjectPtr, r_viewport: ^GDE.TypePtr) {
    @(static)GetViewport: GDE.MethodBindPtr
    if GetViewport == nil do GetViewport = classDBGetMethodBind("Node", "get_viewport", 3596683776)
    
    viewport: GDE.TypePtr
    gdAPI.objectMethodBindPtrCall(GetViewport, object, nil, r_viewport)
}

/*
* https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-add-child
* Force_readable_name default should be false if you care about performance. True if you really want a name to be visible to the user.
* Use internalMode to hide children from the user. But make sure to set include_internal to true when calling get_children.
*/
addChild :: proc "c" (parent: GDE.ObjectPtr, child: ^GDE.ObjectPtr, force_readable_name: GDE.Bool = false, internalMode: InternalMode = .INTERNAL_MODE_DISABLED) {
    context = runtime.default_context()

    force_readable_name:= force_readable_name
    internalMode:= internalMode

    @(static)addChild: GDE.MethodBindPtr
    if addChild == nil {
        ClassName:GDE.StringName
        StringConstruct.stringNameNewLatin(&ClassName, "Node", false)
        defer(Destructors.stringNameDestructor(&ClassName))
        
        methodName: GDE.StringName
        StringConstruct.stringNameNewLatin(&methodName, "add_child", false)
        defer(Destructors.stringNameDestructor(&methodName))
        addChild = gdAPI.classDBGetMethodBind(&ClassName, &methodName, 3863233950)
    }
    

    internal: GDE.Int = 0
    args:= [?]rawptr {child, &force_readable_name, &internalMode}
    
    dummyReturn:rawptr
    gdAPI.objectMethodBindPtrCall(addChild, parent, raw_data(args[:]), dummyReturn)
}


//*************************\\
//****Rendering Server*****\\
//*************************\\

RenderServerObj: GDE.ObjectPtr //Warning: not populated by default. Call getPhysServer2dObj to get its singleton.
RenderServer_SN: GDE.StringName


//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getRenderServer2dObj :: proc() -> GDE.ObjectPtr {
    if RenderServerObj == nil do RenderServerObj = Methods.getSingleton(&RenderServer_SN)
    return RenderServerObj
}

/*If RenerServerObj is nil Godot will throw a memory access issue.
* Make sure that you have called/set getRenderServer2dObj at
* least once before using this function.
*/
freeRenderRID :: proc(resourceId: ^GDE.RID, renderServer: GDE.ObjectPtr = RenderServerObj) {
    @(static)FreeRenderRID: GDE.MethodBindPtr
    if FreeRenderRID ==nil do FreeRenderRID = classDBGetMethodBind("RenderingServer", "free_rid", 2722037293)
    
    assert(resourceId.id != 0)
    args :=[?]rawptr {resourceId}
    gdAPI.objectMethodBindPtrCall(FreeRenderRID, renderServer, raw_data(args[:]), nil)}

//*************************\\
//*****PhysicsServer2D*****\\
//*************************\\

PhysServer2dObj: GDE.ObjectPtr //Warning: not populated by default. Call getPhysServer2dObj to get its singleton.
PhysicsServer2D_SN: GDE.StringName

BodyState :: enum u32 {
    BODY_STATE_TRANSFORM,
    BODY_STATE_LINEAR_VELOCITY,
    BODY_STATE_ANGULAR_VELOCITY,
    BODY_STATE_SLEEPING,
    BODY_STATE_CAN_SLEEP,
}

//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getPhysServer2dObj :: proc() -> GDE.ObjectPtr {
    if PhysServer2dObj == nil do PhysServer2dObj = Methods.getSingleton(&PhysicsServer2D_SN)
    return PhysServer2dObj
}

circleShapeCreate :: proc(r_shape: ^GDE.RID, physServer := PhysServer2dObj) {
    @(static)CircleShapeCreate: GDE.MethodBindPtr
    assert(PhysServer2dObj != nil)
    if CircleShapeCreate == nil do CircleShapeCreate = classDBGetMethodBind2(&PhysicsServer2D_SN, "circle_shape_create", 529393457)
    
    
    gdAPI.objectMethodBindPtrCall(CircleShapeCreate, PhysServer2dObj, nil, r_shape)
}
 
getSpace :: proc(world2d: GDE.TypePtr, r_space: ^GDE.TypePtr) {
    @(static)GetSpace: GDE.MethodBindPtr
    if GetSpace == nil do GetSpace = classDBGetMethodBind("World2D", "get_space", 2944877500)
    
    gdAPI.objectMethodBindPtrCall(GetSpace, cast(GDE.ObjectPtr)world2d, nil, r_space)
}

bodySetSpace :: proc(body: ^GDE.RID, space: ^GDE.TypePtr, physServer := PhysServer2dObj) {
    @(static)SetSpace:GDE.MethodBindPtr
    if SetSpace == nil do SetSpace = classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_space", 395945892)

    assert(physServer != nil )
    assert(body.id != 0)
    assert(space != nil)

    args:= [2]rawptr {body, space}

    gdAPI.objectMethodBindPtrCall(SetSpace, physServer, raw_data(args[:]), nil)
}

bodyAddShape :: proc(body: ^GDE.RID, shape: ^GDE.RID, trans2d: GDE.Transform2d = {1,0,0,1,0,0}, disabled: ^GDE.Bool, physServer := PhysServer2dObj){
    @(static)BodyAddShape: GDE.MethodBindPtr
    if BodyAddShape == nil do BodyAddShape = classDBGetMethodBind2(&PhysicsServer2D_SN, "body_add_shape", 339056240)
    assert(physServer != nil && body.id != 0 && shape.id != 0)

    trans2d:=trans2d
    args:= [?]rawptr {body, shape, &trans2d, disabled}

    gdAPI.objectMethodBindPtrCall(BodyAddShape, physServer, raw_data(args[:]), nil)
}

shapeSetData :: proc(shape: ^GDE.RID, data: ^GDE.Int, physServer := PhysServer2dObj){
    @(static)ShapeSetData: GDE.MethodBindPtr
    if ShapeSetData == nil do ShapeSetData = classDBGetMethodBind2(&PhysicsServer2D_SN, "shape_set_data", 3175752987)

    
    shapedata: GDE.Variant
    variant_from(&shapedata, data)
    shape_data:= [?]rawptr {shape, &shapedata}
    
    gdAPI.objectMethodBindPtrCall(ShapeSetData, physServer, raw_data(shape_data[:]), nil)
}

bodyCreate :: proc(r_body: ^GDE.RID, physServer := PhysServer2dObj) {
    @(static)BodyCreate: GDE.MethodBindPtr
    if BodyCreate == nil do BodyCreate = classDBGetMethodBind2(&PhysicsServer2D_SN, "body_create", 529393457)

    assert(physServer != nil)

    gdAPI.objectMethodBindPtrCall(BodyCreate, physServer, nil, r_body)

}

/*Mask sets which layers this body checks against for collisions received.
* Default is 1.
* Set to 0 to ignore collision from other entities.
* mask is a bitfield. 1, 2, 4, 8, 16 etc for each layer.
* Use layer to specify where this body collides into.
*/
bodySetCollisionMask :: proc(body: ^GDE.RID, mask: ^u32, physServer:= PhysServer2dObj) {
    @(static)BodySetCollisionMask: GDE.MethodBindPtr
    if BodySetCollisionMask == nil do BodySetCollisionMask = classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_collision_mask", 3411492887)

    assert(physServer != nil && body.id != 0 && mask^ >= 0)

    args:= [2]rawptr {body, mask}

    gdAPI.objectMethodBindPtrCall(BodySetCollisionMask, physServer, raw_data(args[:]), nil)
}

bodySetState :: proc(body: ^GDE.RID, bodyState: ^BodyState, trans_v: ^GDE.Variant, physServer:= PhysServer2dObj) {
    @(static)BodySetState: GDE.MethodBindPtr
    if BodySetState == nil do BodySetState = classDBGetMethodBind2(&PhysicsServer2D_SN, "body_set_state", 1706355209)

    assert(physServer != nil && body.id != 0 && trans_v.VType == .TRANSFORM2D)
    
    args:= [?]rawptr {body, bodyState, trans_v}

    gdAPI.objectMethodBindPtrCall(BodySetState, physServer, raw_data(args[:]), nil)
}


/*
* Use this function to generate a ptr call for your virutal functions.
* Can have up to 10 variables + the classInstancePointer.
* First variable of your procPointer should always be a pointer to your class struct. p_instance will be used there.
* procPointer : The proc to your variable. Passed from your callVirtualFunctionWithData
* p_instance : The instance pointer that Godot included in callVirtualFunctionWithData
* p_args : An array of args sent by Godot in callVirtualFunctionWithData
* r_ret : A pointer to hold the return value of your function
*/
virtualProcCall :: proc "c" (procPointer: $T, p_instance: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr)
                            where (sics.type_is_proc(T) && sics.type_proc_parameter_count(T) <= 11){
    context = runtime.default_context()
    argT0::sics.type_proc_parameter_type(T, 0)

    argcount :: sics.type_proc_parameter_count(T)

    when argcount == 1 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance)
        } else {
        procPointer(cast(argT0)p_instance)}
    }
    else do when argcount > 1 do  argT1::sics.type_proc_parameter_type(T, 1)
    when argcount == 2 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
        }
    }
    else do when argcount > 2 do argT2 :: sics.type_proc_parameter_type(T, 2)
    when argcount == 3 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^)
        }
    }
    else do when argcount > 3 do argT3 :: sics.type_proc_parameter_type(T, 3)
    when argcount == 4 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^)
        }
    }
    else do when argcount > 4 do argT4 :: sics.type_proc_parameter_type(T, 4)
    when argcount == 5 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^)
        }
    }
    else do when argcount > 5 do argT5 :: sics.type_proc_parameter_type(T, 5)
    when argcount == 6 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, ))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT2)p_args[1])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^)
        }
    }
    else do when argcount > 6 do argT6 :: sics.type_proc_parameter_type(T, 6)
    when argcount == 7 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance, cast(argT6)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^)
        }
    }
    else do when argcount > 7 do argT7 :: sics.type_proc_parameter_type(T, 7)
    when argcount == 8 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance, cast(argT6)p_instance,
                    cast(argT7)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^)
        }
    }
    else do when argcount > 8 do argT8 :: sics.type_proc_parameter_type(T, 8)
    when argcount == 9 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance, cast(argT6)p_instance,
                    cast(argT7)p_instance, cast(argT8)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^,
                        (cast(^argT8)p_args[7])^)
        }
    }
    else do when argcount > 9 do argT9 :: sics.type_proc_parameter_type(T, 9)
    when argcount == 10 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance, cast(argT6)p_instance,
                    cast(argT7)p_instance, cast(argT8)p_instance, cast(argT9)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^, (cast(^argT3)p_args[2])^,
                        (cast(^argT4)p_args[3])^, (cast(^argT5)p_args[4])^, (cast(^argT6)p_args[5])^, (cast(^argT7)p_args[6])^,
                        (cast(^argT8)p_args[7])^, (cast(^argT9)p_args[8])^)
        }
    }
    else do when argcount > 10 do argT10 :: sics.type_proc_parameter_type(T, 10)
    when argcount == 11 {
        when sics.type_proc_return_count(T) > 0 {
            (cast(sics.type_proc_return_type(T, 0))r_ret)^ = procPointer(cast(argT0)p_instance, cast(argT1)p_instance,
                    cast(argT2)p_instance, cast(argT3)p_instance, cast(argT4)p_instance, cast(argT5)p_instance, cast(argT6)p_instance,
                    cast(argT7)p_instance, cast(argT8)p_instance, cast(argT9)p_instance, cast(argT10)p_instance)
        } else {
            procPointer(cast(argT0)p_instance, (cast(^argT1)p_args[0])^)
        }
    }
}