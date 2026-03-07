package gdAPI

import GDE "gdextension"

get_Interface_Address: GDE.InterfaceGetProcAddress

loadAPI :: proc(p_get_proc_address : GDE.InterfaceGetProcAddress){
    get_Interface_Address = p_get_proc_address

    //Function_Pointer.FunctionPtr = cast(GDE.InterfaceFunctionPtr)get_Interface_Address("")
    Function_Pointer.GetProcAddress = p_get_proc_address

    GD_Version_Get.GetGodotVersion = cast(GDE.InterfaceGetGodotVersion)get_Interface_Address("get_godot_version")
    GD_Version_Get.GetGodotVersion2 = cast(GDE.InterfaceGetGodotVersion2)get_Interface_Address("get_godot_version2")

    GlobalGetSingleton = cast(GDE.InterfaceGlobalGetSingleton)get_Interface_Address("global_get_singleton")
    RegisterMainLoopCallbacks = cast(GDE.InterfaceRegisterMainLoopCallbacks)get_Interface_Address("register_main_loop_callbacks")

//*************\\
//**Threading**\\
//*************\\
    /* GDE.Interface: WorkerThreadPool Utilities */
    Threading.WorkerThreadPoolAddNativeGroupTask = cast(GDE.InterfaceWorkerThreadPoolAddNativeGroupTask)get_Interface_Address("worker_thread_pool_add_native_group_task")
    Threading.WorkerThreadPoolAddNativeTask = cast(GDE.InterfaceWorkerThreadPoolAddNativeTask)get_Interface_Address("worker_thread_pool_add_native_task")

/* GDE.Interface: Memory */
    Memory_Uils.MemAlloc = cast(GDE.InterfaceMemAlloc)get_Interface_Address("mem_alloc")
    Memory_Uils.MemRealloc = cast(GDE.InterfaceMemRealloc)get_Interface_Address("mem_realloc")
    Memory_Uils.MemFree = cast(GDE.InterfaceMemFree)get_Interface_Address("mem_free")
    Memory_Uils.MemAlloc2 = cast(GDE.InterfaceMemAlloc2)get_Interface_Address("mem_alloc2")
    Memory_Uils.MemRealloc2 = cast(GDE.InterfaceMemRealloc2)get_Interface_Address("mem_realloc2")
    Memory_Uils.MemFree2 = cast(GDE.InterfaceMemFree2)get_Interface_Address("mem_free2")
    Memory_Uils.GetNativeStructSize = cast(GDE.InterfaceGetNativeStructSize)get_Interface_Address("get_native_struct_size")


/* GDE.Interface: Godot Logging */
    Logging.PrintError = cast(GDE.InterfacePrintError)get_Interface_Address("print_error")
    Logging.PrintErrorWithMessage = cast(GDE.InterfacePrintErrorWithMessage)get_Interface_Address("print_error_with_message")
    Logging.PrintWarning = cast(GDE.InterfacePrintWarning)get_Interface_Address("print_warning")
    Logging.PrintWarningWithMessage = cast(GDE.InterfacePrintWarningWithMessage)get_Interface_Address("print_warning_with_message")
    Logging.PrintScriptError = cast(GDE.InterfacePrintScriptError)get_Interface_Address("print_script_error")
    Logging.PrintScriptErrorWithMessage = cast(GDE.InterfacePrintScriptErrorWithMessage)get_Interface_Address("print_script_error_with_message")

/* GDE.Interface: Variant */
    Variant_Utils.NewCopy = cast(GDE.InterfaceVariantNewCopy)get_Interface_Address("variant_new_copy")
    Variant_Utils.NewNil = cast(GDE.InterfaceVariantNewNil)get_Interface_Address("variant_new_nil")
    Variant_Utils.Destroy = cast(GDE.InterfaceVariantDestroy)get_Interface_Address("variant_destroy")
    Variant_Utils.Call = cast(GDE.InterfaceVariantCall)get_Interface_Address("variant_call")
    Variant_Utils.CallStatic = cast(GDE.InterfaceVariantCallStatic)get_Interface_Address("variant_call_static")
    Variant_Utils.Evaluate = cast(GDE.InterfaceVariantEvaluate)get_Interface_Address("variant_evaluate")
    Variant_Utils.Set = cast(GDE.InterfaceVariantSet)get_Interface_Address("variant_set")
    Variant_Utils.SetNamed = cast(GDE.InterfaceVariantSetNamed)get_Interface_Address("variant_set_named")
    Variant_Utils.SetKeyed = cast(GDE.InterfaceVariantSetKeyed)get_Interface_Address("variant_set_keyed")
    Variant_Utils.SetIndexed = cast(GDE.InterfaceVariantSetIndexed)get_Interface_Address("variant_set_indexed")
    Variant_Utils.Get = cast(GDE.InterfaceVariantGet)get_Interface_Address("variant_get")
    Variant_Utils.GetNamed = cast(GDE.InterfaceVariantGetNamed)get_Interface_Address("variant_get_named")
    Variant_Utils.GetKeyed = cast(GDE.InterfaceVariantGetKeyed)get_Interface_Address("variant_get_keyed")
    Variant_Utils.GetIndexed = cast(GDE.InterfaceVariantGetIndexed)get_Interface_Address("variant_get_indexed")
    Variant_Utils.IterInit = cast(GDE.InterfaceVariantIterInit)get_Interface_Address("variant_iter_init")
    Variant_Utils.IterNext = cast(GDE.InterfaceVariantIterNext)get_Interface_Address("variant_iter_next")
    Variant_Utils.IterGet = cast(GDE.InterfaceVariantIterGet)get_Interface_Address("variant_iter_get")
    Variant_Utils.Hash = cast(GDE.InterfaceVariantHash)get_Interface_Address("variant_hash")
    Variant_Utils.RecursiveHash = cast(GDE.InterfaceVariantRecursiveHash)get_Interface_Address("variant_recursive_hash")
    Variant_Utils.HashCompare = cast(GDE.InterfaceVariantHashCompare)get_Interface_Address("variant_hash_compare")
    Variant_Utils.Booleanize = cast(GDE.InterfaceVariantBooleanize)get_Interface_Address("variant_booleanize")
    Variant_Utils.Duplicate = cast(GDE.InterfaceVariantDuplicate)get_Interface_Address("variant_duplicate")
    Variant_Utils.Stringify = cast(GDE.InterfaceVariantStringify)get_Interface_Address("variant_stringify")
    Variant_Utils.GetType = cast(GDE.InterfaceVariantGetType)get_Interface_Address("variant_get_type")
    Variant_Utils.HasMethod = cast(GDE.InterfaceVariantHasMethod)get_Interface_Address("variant_has_method")
    Variant_Utils.HasMember = cast(GDE.InterfaceVariantHasMember)get_Interface_Address("variant_has_member")
    Variant_Utils.HasKey = cast(GDE.InterfaceVariantHasKey)get_Interface_Address("variant_has_key")
    Variant_Utils.GetObjectInstanceId = cast(GDE.InterfaceVariantGetObjectInstanceId)get_Interface_Address("variant_get_object_instance_id")
    Variant_Utils.GetTypeName = cast(GDE.InterfaceVariantGetTypeName)get_Interface_Address("variant_get_type_name")
    Variant_Utils.CanConvert = cast(GDE.InterfaceVariantCanConvert)get_Interface_Address("variant_can_convert")
    Variant_Utils.CanConvertStrict = cast(GDE.InterfaceVariantCanConvertStrict)get_Interface_Address("variant_can_convert_strict")
    Variant_Utils.GetVariantFromTypeConstructor = cast(GDE.InterfaceGetVariantFromTypeConstructor)get_Interface_Address("get_variant_from_type_constructor")
    Variant_Utils.GetVariantToTypeConstructor = cast(GDE.InterfaceGetVariantToTypeConstructor)get_Interface_Address("get_variant_to_type_constructor")
    Variant_Utils.GetVariantGetInternalPtrFunc = cast(GDE.InterfaceGetVariantGetInternalPtrFunc)get_Interface_Address("variant_get_ptr_internal_getter")
    Variant_Utils.GetPtrOperatorEvaluator = cast(GDE.InterfaceVariantGetPtrOperatorEvaluator)get_Interface_Address("variant_get_ptr_operator_evaluator")
    Variant_Utils.GetPtrBuiltinMethod = cast(GDE.InterfaceVariantGetPtrBuiltinMethod)get_Interface_Address("variant_get_ptr_builtin_method")
    Variant_Utils.GetPtrConstructor = cast(GDE.InterfaceVariantGetPtrConstructor)get_Interface_Address("variant_get_ptr_constructor")
    Variant_Utils.GetPtrDestructor = cast(GDE.InterfaceVariantGetPtrDestructor)get_Interface_Address("variant_get_ptr_destructor")
    Variant_Utils.Construct = cast(GDE.InterfaceVariantConstruct)get_Interface_Address("variant_construct")
    Variant_Utils.GetPtrSetter = cast(GDE.InterfaceVariantGetPtrSetter)get_Interface_Address("variant_get_ptr_setter")
    Variant_Utils.GetPtrGetter = cast(GDE.InterfaceVariantGetPtrGetter)get_Interface_Address("variant_get_ptr_getter")
    Variant_Utils.GetPtrIndexedSetter = cast(GDE.InterfaceVariantGetPtrIndexedSetter)get_Interface_Address("variant_get_ptr_indexed_setter")
    Variant_Utils.GetPtrIndexedGetter = cast(GDE.InterfaceVariantGetPtrIndexedGetter)get_Interface_Address("variant_get_ptr_indexed_getter")
    Variant_Utils.GetPtrKeyedSetter = cast(GDE.InterfaceVariantGetPtrKeyedSetter)get_Interface_Address("variant_get_ptr_keyed_setter")
    Variant_Utils.GetPtrKeyedGetter = cast(GDE.InterfaceVariantGetPtrKeyedGetter)get_Interface_Address("variant_get_ptr_keyed_getter")
    Variant_Utils.GetPtrKeyedChecker = cast(GDE.InterfaceVariantGetPtrKeyedChecker)get_Interface_Address("variant_get_ptr_keyed_checker")
    Variant_Utils.GetConstantValue = cast(GDE.InterfaceVariantGetConstantValue)get_Interface_Address("variant_get_constant_value")
    Variant_Utils.GetPtrUtilityFunction = cast(GDE.InterfaceVariantGetPtrUtilityFunction)get_Interface_Address("variant_get_ptr_utility_function")


/* GDE.Interface: String Utilities */
    Strings_Utils.NewWithLatin1Chars = cast(GDE.InterfaceStringNewWithLatin1Chars)get_Interface_Address("string_new_with_latin1_chars")
    Strings_Utils.NewWithUtf8Chars = cast(GDE.InterfaceStringNewWithUtf8Chars)get_Interface_Address("string_new_with_utf8_chars")
    Strings_Utils.NewWithUtf16Chars = cast(GDE.InterfaceStringNewWithUtf16Chars)get_Interface_Address("string_new_with_utf16_chars")
    Strings_Utils.NewWithUtf32Chars = cast(GDE.InterfaceStringNewWithUtf32Chars)get_Interface_Address("string_new_with_utf32_chars")
    Strings_Utils.NewWithWideChars = cast(GDE.InterfaceStringNewWithWideChars)get_Interface_Address("string_new_with_wide_chars")
    Strings_Utils.NewWithLatin1CharsAndLen = cast(GDE.InterfaceStringNewWithLatin1CharsAndLen)get_Interface_Address("string_new_with_latin1_chars_and_len")
    Strings_Utils.NewWithUtf8CharsAndLen = cast(GDE.InterfaceStringNewWithUtf8CharsAndLen)get_Interface_Address("string_new_with_utf8_chars_and_len")
    Strings_Utils.NewWithUtf8CharsAndLen2 = cast(GDE.InterfaceStringNewWithUtf8CharsAndLen2)get_Interface_Address("string_new_with_utf8_chars_and_len2")
    Strings_Utils.NewWithUtf16CharsAndLen = cast(GDE.InterfaceStringNewWithUtf16CharsAndLen)get_Interface_Address("string_new_with_utf16_chars_and_len")
    Strings_Utils.NewWithUtf16CharsAndLen2 = cast(GDE.InterfaceStringNewWithUtf16CharsAndLen2)get_Interface_Address("string_new_with_utf16_chars_and_len2")
    Strings_Utils.NewWithUtf32CharsAndLen = cast(GDE.InterfaceStringNewWithUtf32CharsAndLen)get_Interface_Address("string_new_with_utf32_chars_and_len")
    Strings_Utils.NewWithWideCharsAndLen = cast(GDE.InterfaceStringNewWithWideCharsAndLen)get_Interface_Address("string_new_with_wide_chars_and_len")
    Strings_Utils.ToLatin1Chars = cast(GDE.InterfaceStringToLatin1Chars)get_Interface_Address("string_to_latin1_chars")
    Strings_Utils.ToUtf8Chars = cast(GDE.InterfaceStringToUtf8Chars)get_Interface_Address("string_to_utf8_chars")
    Strings_Utils.ToUtf16Chars = cast(GDE.InterfaceStringToUtf16Chars)get_Interface_Address("string_to_utf16_chars")
    Strings_Utils.ToUtf32Chars = cast(GDE.InterfaceStringToUtf32Chars)get_Interface_Address("string_to_utf32_chars")
    Strings_Utils.ToWideChars = cast(GDE.InterfaceStringToWideChars)get_Interface_Address("string_to_wide_chars")
    Strings_Utils.OperatorIndex = cast(GDE.InterfaceStringOperatorIndex)get_Interface_Address("string_operator_index")
    Strings_Utils.OperatorIndexConst = cast(GDE.InterfaceStringOperatorIndexConst)get_Interface_Address("string_operator_index_const")
    Strings_Utils.OperatorPlusEqString = cast(GDE.InterfaceStringOperatorPlusEqString)get_Interface_Address("string_operator_plus_eq_string")
    Strings_Utils.OperatorPlusEqChar = cast(GDE.InterfaceStringOperatorPlusEqChar)get_Interface_Address("string_operator_plus_eq_char")
    Strings_Utils.OperatorPlusEqCstr = cast(GDE.InterfaceStringOperatorPlusEqCstr)get_Interface_Address("string_operator_plus_eq_cstr")
    Strings_Utils.OperatorPlusEqWcstr = cast(GDE.InterfaceStringOperatorPlusEqWcstr)get_Interface_Address("string_operator_plus_eq_wcstr")
    Strings_Utils.OperatorPlusEqC32str = cast(GDE.InterfaceStringOperatorPlusEqC32str)get_Interface_Address("string_operator_plus_eq_c32str")
    Strings_Utils.Resize = cast(GDE.InterfaceStringResize)get_Interface_Address("string_resize")


/* GDE.Interface: StringName Utilities */
    StringName_Utils.Latin1Chars = cast(GDE.InterfaceStringNameNewWithLatin1Chars)get_Interface_Address("string_name_new_with_latin1_chars")
    StringName_Utils.Utf8Chars = cast(GDE.InterfaceStringNameNewWithUtf8Chars)get_Interface_Address("string_name_new_with_utf8_chars")
    StringName_Utils.Utf8CharsAndLen = cast(GDE.InterfaceStringNameNewWithUtf8CharsAndLen)get_Interface_Address("string_name_new_with_utf8_chars_and_len")

/* GDE.Interface: XMLParser Utilities */
    XMLParse_Utils.XmlParserOpenBuffer = cast(GDE.InterfaceXmlParserOpenBuffer)get_Interface_Address("xml_parser_open_buffer")
    XMLParse_Utils.EditorHelpLoadXmlFromUtf8Chars = cast(GDE.InterfaceEditorHelpLoadXmlFromUtf8Chars)get_Interface_Address("editor_help_load_xml_from_utf8_chars")
    XMLParse_Utils.EditorHelpLoadXmlFromUtf8CharsAndLen = cast(GDE.InterfaceEditorHelpLoadXmlFromUtf8CharsAndLen)get_Interface_Address("editor_help_load_xml_from_utf8_chars_and_len")
    XMLParse_Utils.EditorRegisterGetClassesUsedCallback = cast(GDE.InterfaceEditorRegisterGetClassesUsedCallback)get_Interface_Address("editor_register_get_classes_used_callback")

/* GDE.Interface: FileAccess Utilities */
    FileAccess_Utils.StoreBuffer = cast(GDE.InterfaceFileAccessStoreBuffer)get_Interface_Address("file_access_store_buffer")
    FileAccess_Utils.GetBuffer = cast(GDE.InterfaceFileAccessGetBuffer)get_Interface_Address("file_access_get_buffer")

/* GDE.Interface: Image Utilities */
    Image_Utils.ImagePtrw = cast(GDE.InterfaceImagePtrw)get_Interface_Address("image_ptrw")
    Image_Utils.ImagePtr = cast(GDE.InterfaceImagePtr)get_Interface_Address("image_ptr")

/* GDE.Interface: Packed Array */
    Packed_Array_Utils.ByteArrayOperatorIndex = cast(GDE.InterfacePackedByteArrayOperatorIndex)get_Interface_Address("packed_byte_array_operator_index")
    Packed_Array_Utils.ByteArrayOperatorIndexConst = cast(GDE.InterfacePackedByteArrayOperatorIndexConst)get_Interface_Address("packed_byte_array_operator_index_const")
    Packed_Array_Utils.Float32ArrayOperatorIndex = cast(GDE.InterfacePackedFloat32ArrayOperatorIndex)get_Interface_Address("packed_float32_array_operator_index")
    Packed_Array_Utils.Float32ArrayOperatorIndexConst = cast(GDE.InterfacePackedFloat32ArrayOperatorIndexConst)get_Interface_Address("packed_float32_array_operator_index_const")
    Packed_Array_Utils.Float64ArrayOperatorIndex = cast(GDE.InterfacePackedFloat64ArrayOperatorIndex)get_Interface_Address("packed_float64_array_operator_index")
    Packed_Array_Utils.Float64ArrayOperatorIndexConst = cast(GDE.InterfacePackedFloat64ArrayOperatorIndexConst)get_Interface_Address("packed_float64_array_operator_index_const")
    Packed_Array_Utils.Int32ArrayOperatorIndex = cast(GDE.InterfacePackedInt32ArrayOperatorIndex)get_Interface_Address("packed_int32_array_operator_index")
    Packed_Array_Utils.Int32ArrayOperatorIndexConst = cast(GDE.InterfacePackedInt32ArrayOperatorIndexConst)get_Interface_Address("packed_int32_array_operator_index_const")
    Packed_Array_Utils.Int64ArrayOperatorIndex = cast(GDE.InterfacePackedInt64ArrayOperatorIndex)get_Interface_Address("packed_int64_array_operator_index")
    Packed_Array_Utils.Int64ArrayOperatorIndexConst = cast(GDE.InterfacePackedInt64ArrayOperatorIndexConst)get_Interface_Address("packed_int64_array_operator_index_const")
    Packed_Array_Utils.StringArrayOperatorIndex = cast(GDE.InterfacePackedStringArrayOperatorIndex)get_Interface_Address("packed_string_array_operator_index")
    Packed_Array_Utils.StringArrayOperatorIndexConst = cast(GDE.InterfacePackedStringArrayOperatorIndexConst)get_Interface_Address("packed_string_array_operator_index_const")
    Packed_Array_Utils.Vector2ArrayOperatorIndex = cast(GDE.InterfacePackedVector2ArrayOperatorIndex)get_Interface_Address("packed_vector2_array_operator_index")
    Packed_Array_Utils.Vector2ArrayOperatorIndexConst = cast(GDE.InterfacePackedVector2ArrayOperatorIndexConst)get_Interface_Address("packed_vector2_array_operator_index_const")
    Packed_Array_Utils.Vector3ArrayOperatorIndex = cast(GDE.InterfacePackedVector3ArrayOperatorIndex)get_Interface_Address("packed_vector3_array_operator_index")
    Packed_Array_Utils.Vector3ArrayOperatorIndexConst = cast(GDE.InterfacePackedVector3ArrayOperatorIndexConst)get_Interface_Address("packed_vector3_array_operator_index_const")
    Packed_Array_Utils.Vector4ArrayOperatorIndex = cast(GDE.InterfacePackedVector4ArrayOperatorIndex)get_Interface_Address("packed_vector4_array_operator_index")
    Packed_Array_Utils.Vector4ArrayOperatorIndexConst = cast(GDE.InterfacePackedVector4ArrayOperatorIndexConst)get_Interface_Address("packed_vector4_array_operator_index_const")
    Packed_Array_Utils.ColorArrayOperatorIndex = cast(GDE.InterfacePackedColorArrayOperatorIndex)get_Interface_Address("packed_color_array_operator_index")
    Packed_Array_Utils.ColorArrayOperatorIndexConst = cast(GDE.InterfacePackedColorArrayOperatorIndexConst)get_Interface_Address("packed_color_array_operator_index_const")
    Packed_Array_Utils.ArrayOperatorIndex = cast(GDE.InterfaceArrayOperatorIndex)get_Interface_Address("array_operator_index")
    Packed_Array_Utils.ArrayOperatorIndexConst = cast(GDE.InterfaceArrayOperatorIndexConst)get_Interface_Address("array_operator_index_const")
    Packed_Array_Utils.ArrayRef = cast(GDE.InterfaceArrayRef)get_Interface_Address("array_ref")
    Packed_Array_Utils.ArraySetTyped = cast(GDE.InterfaceArraySetTyped)get_Interface_Address("array_set_typed")


/* GDE.Interface: Dictionary */
    Dictionary_Utils.OperatorIndex = cast(GDE.InterfaceDictionaryOperatorIndex)get_Interface_Address("dictionary_operator_index")
    Dictionary_Utils.OperatorIndexConst = cast(GDE.InterfaceDictionaryOperatorIndexConst)get_Interface_Address("dictionary_operator_index_const")
    Dictionary_Utils.SetTyped = cast(GDE.InterfaceDictionarySetTyped)get_Interface_Address("dictionary_set_typed")


/* GDE.Interface: Object */
    Object_Utils.MethodBindCall = cast(GDE.InterfaceObjectMethodBindCall)get_Interface_Address("object_method_bind_call")
    Object_Utils.MethodBindPtrcall = cast(GDE.InterfaceObjectMethodBindPtrcall)get_Interface_Address("object_method_bind_ptrcall")
    Object_Utils.Destroy = cast(GDE.InterfaceObjectDestroy)get_Interface_Address("object_destroy")
    Object_Utils.GetInstanceBinding = cast(GDE.InterfaceObjectGetInstanceBinding)get_Interface_Address("object_get_instance_binding")
    Object_Utils.SetInstanceBinding = cast(GDE.InterfaceObjectSetInstanceBinding)get_Interface_Address("object_set_instance_binding")
    Object_Utils.FreeInstanceBinding = cast(GDE.InterfaceObjectFreeInstanceBinding)get_Interface_Address("object_free_instance_binding")
    Object_Utils.SetInstance = cast(GDE.InterfaceObjectSetInstance)get_Interface_Address("object_set_instance")
    Object_Utils.GetClassName = cast(GDE.InterfaceObjectGetClassName)get_Interface_Address("object_get_class_name")
    Object_Utils.CastTo = cast(GDE.InterfaceObjectCastTo)get_Interface_Address("object_cast_to")
    Object_Utils.GetInstanceFromId = cast(GDE.InterfaceObjectGetInstanceFromId)get_Interface_Address("object_get_instance_from_id")
    Object_Utils.GetInstanceId = cast(GDE.InterfaceObjectGetInstanceId)get_Interface_Address("object_get_instance_id")
    Object_Utils.HasScriptMethod = cast(GDE.InterfaceObjectHasScriptMethod)get_Interface_Address("object_has_script_method")
    Object_Utils.CallScriptMethod = cast(GDE.InterfaceObjectCallScriptMethod)get_Interface_Address("object_call_script_method")


/* GDE.Interface: Reference */
    Reference_Utils.RefGetObject = cast(GDE.InterfaceRefGetObject)get_Interface_Address("ref_get_object")
    Reference_Utils.RefSetObject = cast(GDE.InterfaceRefSetObject)get_Interface_Address("ref_set_object")


/* GDE.Interface: Script Instance */
    Script_Utils.ScriptInstanceCreate = cast(GDE.InterfaceScriptInstanceCreate)get_Interface_Address("script_instance_create")
    Script_Utils.ScriptInstanceCreate2 = cast(GDE.InterfaceScriptInstanceCreate2)get_Interface_Address("script_instance_create2")
    Script_Utils.ScriptInstanceCreate3 = cast(GDE.InterfaceScriptInstanceCreate3)get_Interface_Address("script_instance_create3")
    Script_Utils.PlaceHolderScriptInstanceCreate = cast(GDE.InterfacePlaceHolderScriptInstanceCreate)get_Interface_Address("placeholder_script_instance_create")
    Script_Utils.PlaceHolderScriptInstanceUpdate = cast(GDE.InterfacePlaceHolderScriptInstanceUpdate)get_Interface_Address("placeholder_script_instance_update")
    Script_Utils.ObjectGetScriptInstance = cast(GDE.InterfaceObjectGetScriptInstance)get_Interface_Address("object_get_script_instance")
    Script_Utils.ObjectSetScriptInstance = cast(GDE.InterfaceObjectSetScriptInstance)get_Interface_Address("object_set_script_instance")

/* GDE.Interface: Callable */
    Callable_Utils.CustomCreate = cast(GDE.InterfaceCallableCustomCreate)get_Interface_Address("callable_custom_create")
    Callable_Utils.CustomCreate2 = cast(GDE.InterfaceCallableCustomCreate2)get_Interface_Address("callable_custom_create2")
    Callable_Utils.CustomGetUserData = cast(GDE.InterfaceCallableCustomGetUserData)get_Interface_Address("callable_custom_get_userdata")

/* GDE.Interface: ClassDB */
    ClassDB.ConstructObject = cast(GDE.InterfaceClassdbConstructObject)get_Interface_Address("classdb_construct_object")
    ClassDB.ConstructObject2 = cast(GDE.InterfaceClassdbConstructObject2)get_Interface_Address("classdb_construct_object2")
    ClassDB.GetMethodBind = cast(GDE.InterfaceClassdbGetMethodBind)get_Interface_Address("classdb_get_method_bind")
    ClassDB.GetClassTag = cast(GDE.InterfaceClassdbGetClassTag)get_Interface_Address("classdb_get_class_tag")
    ClassDB.RegisterExtensionClass = cast(GDE.InterfaceClassdbRegisterExtensionClass)get_Interface_Address("classdb_register_extension_class")
    ClassDB.RegisterExtensionClass2 = cast(GDE.InterfaceClassdbRegisterExtensionClass2)get_Interface_Address("classdb_register_extension_class2")
    ClassDB.RegisterExtensionClass3 = cast(GDE.InterfaceClassdbRegisterExtensionClass3)get_Interface_Address("classdb_register_extension_class3")
    ClassDB.RegisterExtensionClass4 = cast(GDE.InterfaceClassdbRegisterExtensionClass4)get_Interface_Address("classdb_register_extension_class4")
    ClassDB.RegisterExtensionClass5 = cast(GDE.InterfaceClassdbRegisterExtensionClass5)get_Interface_Address("classdb_register_extension_class5")
    ClassDB.RegisterExtensionClassMethod = cast(GDE.InterfaceClassdbRegisterExtensionClassMethod)get_Interface_Address("classdb_register_extension_class_method")
    ClassDB.RegisterExtensionClassVirtualMethod = cast(GDE.InterfaceClassdbRegisterExtensionClassVirtualMethod)get_Interface_Address("classdb_register_extension_class_virtual_method")
    ClassDB.RegisterExtensionClassIntegerConstant = cast(GDE.InterfaceClassdbRegisterExtensionClassIntegerConstant)get_Interface_Address("classdb_register_extension_class_integer_constant")
    ClassDB.RegisterExtensionClassProperty = cast(GDE.InterfaceClassdbRegisterExtensionClassProperty)get_Interface_Address("classdb_register_extension_class_property")
    ClassDB.RegisterExtensionClassPropertyIndexed = cast(GDE.InterfaceClassdbRegisterExtensionClassPropertyIndexed)get_Interface_Address("classdb_register_extension_class_property_indexed")
    ClassDB.RegisterExtensionClassPropertyGroup = cast(GDE.InterfaceClassdbRegisterExtensionClassPropertyGroup)get_Interface_Address("classdb_register_extension_class_property_group")
    ClassDB.RegisterExtensionClassPropertySubgroup = cast(GDE.InterfaceClassdbRegisterExtensionClassPropertySubgroup)get_Interface_Address("classdb_register_extension_class_property_subgroup")
    ClassDB.RegisterExtensionClassSignal = cast(GDE.InterfaceClassdbRegisterExtensionClassSignal)get_Interface_Address("classdb_register_extension_class_signal")
    ClassDB.ClassdbUnregisterExtensionClass = cast(GDE.InterfaceClassdbUnregisterExtensionClass)get_Interface_Address("classdb_unregister_extension_class")
    ClassDB.GetLibraryPath = cast(GDE.InterfaceGetLibraryPath)get_Interface_Address("get_library_path")


    Plugin.EditorAddPlugin = cast(GDE.InterfaceEditorAddPlugin)get_Interface_Address("editor_add_plugin")
    Plugin.EditorRemovePlugin = cast(GDE.InterfaceEditorRemovePlugin)get_Interface_Address("editor_remove_plugin")
}