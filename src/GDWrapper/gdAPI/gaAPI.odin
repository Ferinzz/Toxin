package gdAPI

import GDE "gdextension"


//*****************************\\
//******Pointers to Godot******\\
//******Utility Functions******\\
//*****************************\\

Function_Pointer : struct {
    FunctionPtr: GDE.InterfaceFunctionPtr,
    GetProcAddress: GDE.InterfaceGetProcAddress,
}

GD_Version_Get : struct {
    GetGodotVersion: GDE.InterfaceGetGodotVersion,
    GetGodotVersion2: GDE.InterfaceGetGodotVersion2,
}

GlobalGetSingleton: GDE.InterfaceGlobalGetSingleton
RegisterMainLoopCallbacks: GDE.InterfaceRegisterMainLoopCallbacks

//*************\\
//**Threading**\\
//*************\\

Threading : struct {
    WorkerThreadPoolGroupTask: GDE.WorkerThreadPoolGroupTask,
    WorkerThreadPoolTask: GDE.WorkerThreadPoolTask,

    /* INTERFACE: WorkerThreadPool Utilities */
    WorkerThreadPoolAddNativeGroupTask: GDE.InterfaceWorkerThreadPoolAddNativeGroupTask,
    WorkerThreadPoolAddNativeTask: GDE.InterfaceWorkerThreadPoolAddNativeTask,
}

/* INTERFACE: Memory */
Memory_Uils : struct {
    MemAlloc: GDE.InterfaceMemAlloc,
    MemRealloc: GDE.InterfaceMemRealloc,
    MemFree: GDE.InterfaceMemFree,
    MemAlloc2: GDE.InterfaceMemAlloc2,
    MemRealloc2: GDE.InterfaceMemRealloc2,
    MemFree2: GDE.InterfaceMemFree2,
    GetNativeStructSize: GDE.InterfaceGetNativeStructSize,
}

/* INTERFACE: Godot Logging */
Logging : struct {
    PrintError: GDE.InterfacePrintError,
    PrintErrorWithMessage: GDE.InterfacePrintErrorWithMessage,
    PrintWarning: GDE.InterfacePrintWarning,
    PrintWarningWithMessage: GDE.InterfacePrintWarningWithMessage,
    PrintScriptError: GDE.InterfacePrintScriptError,
    PrintScriptErrorWithMessage: GDE.InterfacePrintScriptErrorWithMessage,
}

/* INTERFACE: Variant */
Variant_Utils : struct {
    NewCopy: GDE.InterfaceVariantNewCopy,
    NewNil: GDE.InterfaceVariantNewNil,
    Destroy: GDE.InterfaceVariantDestroy,
    Call: GDE.InterfaceVariantCall,
    CallStatic: GDE.InterfaceVariantCallStatic,
    Evaluate: GDE.InterfaceVariantEvaluate,
    Set: GDE.InterfaceVariantSet,
    SetNamed: GDE.InterfaceVariantSetNamed,
    SetKeyed: GDE.InterfaceVariantSetKeyed,
    SetIndexed: GDE.InterfaceVariantSetIndexed,
    Get: GDE.InterfaceVariantGet,
    GetNamed: GDE.InterfaceVariantGetNamed,
    GetKeyed: GDE.InterfaceVariantGetKeyed,
    GetIndexed: GDE.InterfaceVariantGetIndexed,
    IterInit: GDE.InterfaceVariantIterInit,
    IterNext: GDE.InterfaceVariantIterNext,
    IterGet: GDE.InterfaceVariantIterGet,
    Hash: GDE.InterfaceVariantHash,
    RecursiveHash: GDE.InterfaceVariantRecursiveHash,
    HashCompare: GDE.InterfaceVariantHashCompare,
    Booleanize: GDE.InterfaceVariantBooleanize,
    Duplicate: GDE.InterfaceVariantDuplicate,
    Stringify: GDE.InterfaceVariantStringify,
    GetType: GDE.InterfaceVariantGetType,
    HasMethod: GDE.InterfaceVariantHasMethod,
    HasMember: GDE.InterfaceVariantHasMember,
    HasKey: GDE.InterfaceVariantHasKey,
    GetObjectInstanceId: GDE.InterfaceVariantGetObjectInstanceId,
    GetTypeName: GDE.InterfaceVariantGetTypeName,
    CanConvert: GDE.InterfaceVariantCanConvert,
    CanConvertStrict: GDE.InterfaceVariantCanConvertStrict,
    GetVariantFromTypeConstructor: GDE.InterfaceGetVariantFromTypeConstructor,
    GetVariantToTypeConstructor: GDE.InterfaceGetVariantToTypeConstructor,
    GetVariantGetInternalPtrFunc: GDE.InterfaceGetVariantGetInternalPtrFunc,
    GetPtrOperatorEvaluator: GDE.InterfaceVariantGetPtrOperatorEvaluator,
    GetPtrBuiltinMethod: GDE.InterfaceVariantGetPtrBuiltinMethod,
    GetPtrConstructor: GDE.InterfaceVariantGetPtrConstructor,
    GetPtrDestructor: GDE.InterfaceVariantGetPtrDestructor,
    Construct: GDE.InterfaceVariantConstruct,
    GetPtrSetter: GDE.InterfaceVariantGetPtrSetter,
    GetPtrGetter: GDE.InterfaceVariantGetPtrGetter,
    GetPtrIndexedSetter: GDE.InterfaceVariantGetPtrIndexedSetter,
    GetPtrIndexedGetter: GDE.InterfaceVariantGetPtrIndexedGetter,
    GetPtrKeyedSetter: GDE.InterfaceVariantGetPtrKeyedSetter,
    GetPtrKeyedGetter: GDE.InterfaceVariantGetPtrKeyedGetter,
    GetPtrKeyedChecker: GDE.InterfaceVariantGetPtrKeyedChecker,
    GetConstantValue: GDE.InterfaceVariantGetConstantValue,
    GetPtrUtilityFunction: GDE.InterfaceVariantGetPtrUtilityFunction,
}

/* INTERFACE: String Utilities */
Strings_Utils : struct {
    NewWithLatin1Chars: GDE.InterfaceStringNewWithLatin1Chars,
    NewWithUtf8Chars: GDE.InterfaceStringNewWithUtf8Chars,
    NewWithUtf16Chars: GDE.InterfaceStringNewWithUtf16Chars,
    NewWithUtf32Chars: GDE.InterfaceStringNewWithUtf32Chars,
    NewWithWideChars: GDE.InterfaceStringNewWithWideChars,
    NewWithLatin1CharsAndLen: GDE.InterfaceStringNewWithLatin1CharsAndLen,
    NewWithUtf8CharsAndLen: GDE.InterfaceStringNewWithUtf8CharsAndLen,
    NewWithUtf8CharsAndLen2: GDE.InterfaceStringNewWithUtf8CharsAndLen2,
    NewWithUtf16CharsAndLen: GDE.InterfaceStringNewWithUtf16CharsAndLen,
    NewWithUtf16CharsAndLen2: GDE.InterfaceStringNewWithUtf16CharsAndLen2,
    NewWithUtf32CharsAndLen: GDE.InterfaceStringNewWithUtf32CharsAndLen,
    NewWithWideCharsAndLen: GDE.InterfaceStringNewWithWideCharsAndLen,
    ToLatin1Chars: GDE.InterfaceStringToLatin1Chars,
    ToUtf8Chars: GDE.InterfaceStringToUtf8Chars,
    ToUtf16Chars: GDE.InterfaceStringToUtf16Chars,
    ToUtf32Chars: GDE.InterfaceStringToUtf32Chars,
    ToWideChars: GDE.InterfaceStringToWideChars,
    OperatorIndex: GDE.InterfaceStringOperatorIndex,
    OperatorIndexConst: GDE.InterfaceStringOperatorIndexConst,
    OperatorPlusEqString: GDE.InterfaceStringOperatorPlusEqString,
    OperatorPlusEqChar: GDE.InterfaceStringOperatorPlusEqChar,
    OperatorPlusEqCstr: GDE.InterfaceStringOperatorPlusEqCstr,
    OperatorPlusEqWcstr: GDE.InterfaceStringOperatorPlusEqWcstr,
    OperatorPlusEqC32str: GDE.InterfaceStringOperatorPlusEqC32str,
    Resize: GDE.InterfaceStringResize,
}

/* INTERFACE: StringName Utilities */
StringName_Utils : struct {
    Latin1Chars: GDE.InterfaceStringNameNewWithLatin1Chars,
    Utf8Chars: GDE.InterfaceStringNameNewWithUtf8Chars,
    Utf8CharsAndLen: GDE.InterfaceStringNameNewWithUtf8CharsAndLen,
}

/* INTERFACE: XMLParser Utilities */
XMLParse_Utils : struct {
    XmlParserOpenBuffer: GDE.InterfaceXmlParserOpenBuffer,
    EditorHelpLoadXmlFromUtf8Chars: GDE.InterfaceEditorHelpLoadXmlFromUtf8Chars,
    EditorHelpLoadXmlFromUtf8CharsAndLen: GDE.InterfaceEditorHelpLoadXmlFromUtf8CharsAndLen,
    EditorRegisterGetClassesUsedCallback: GDE.InterfaceEditorRegisterGetClassesUsedCallback,
}

/* INTERFACE: FileAccess Utilities */
FileAccess_Utils : struct {
    StoreBuffer: GDE.InterfaceFileAccessStoreBuffer,
    GetBuffer: GDE.InterfaceFileAccessGetBuffer,
}
/* INTERFACE: Image Utilities */
Image_Utils : struct {
    ImagePtrw: GDE.InterfaceImagePtrw,
    ImagePtr: GDE.InterfaceImagePtr,
}
/* INTERFACE: Packed Array */
Packed_Array_Utils : struct {
    ByteArrayOperatorIndex: GDE.InterfacePackedByteArrayOperatorIndex,
    ByteArrayOperatorIndexConst: GDE.InterfacePackedByteArrayOperatorIndexConst,
    Float32ArrayOperatorIndex: GDE.InterfacePackedFloat32ArrayOperatorIndex,
    Float32ArrayOperatorIndexConst: GDE.InterfacePackedFloat32ArrayOperatorIndexConst,
    Float64ArrayOperatorIndex: GDE.InterfacePackedFloat64ArrayOperatorIndex,
    Float64ArrayOperatorIndexConst: GDE.InterfacePackedFloat64ArrayOperatorIndexConst,
    Int32ArrayOperatorIndex: GDE.InterfacePackedInt32ArrayOperatorIndex,
    Int32ArrayOperatorIndexConst: GDE.InterfacePackedInt32ArrayOperatorIndexConst,
    Int64ArrayOperatorIndex: GDE.InterfacePackedInt64ArrayOperatorIndex,
    Int64ArrayOperatorIndexConst: GDE.InterfacePackedInt64ArrayOperatorIndexConst,
    StringArrayOperatorIndex: GDE.InterfacePackedStringArrayOperatorIndex,
    StringArrayOperatorIndexConst: GDE.InterfacePackedStringArrayOperatorIndexConst,
    Vector2ArrayOperatorIndex: GDE.InterfacePackedVector2ArrayOperatorIndex,
    Vector2ArrayOperatorIndexConst: GDE.InterfacePackedVector2ArrayOperatorIndexConst,
    Vector3ArrayOperatorIndex: GDE.InterfacePackedVector3ArrayOperatorIndex,
    Vector3ArrayOperatorIndexConst: GDE.InterfacePackedVector3ArrayOperatorIndexConst,
    Vector4ArrayOperatorIndex: GDE.InterfacePackedVector4ArrayOperatorIndex,
    Vector4ArrayOperatorIndexConst: GDE.InterfacePackedVector4ArrayOperatorIndexConst,
    ColorArrayOperatorIndex: GDE.InterfacePackedColorArrayOperatorIndex,
    ColorArrayOperatorIndexConst: GDE.InterfacePackedColorArrayOperatorIndexConst,
    ArrayOperatorIndex: GDE.InterfaceArrayOperatorIndex,
    ArrayOperatorIndexConst: GDE.InterfaceArrayOperatorIndexConst,
    ArrayRef: GDE.InterfaceArrayRef,
    ArraySetTyped: GDE.InterfaceArraySetTyped,
}

/* INTERFACE: Dictionary */
Dictionary_Utils : struct {
    OperatorIndex: GDE.InterfaceDictionaryOperatorIndex,
    OperatorIndexConst: GDE.InterfaceDictionaryOperatorIndexConst,
    SetTyped: GDE.InterfaceDictionarySetTyped,
}

/* INTERFACE: Object */
Object_Utils : struct {
    MethodBindCall: GDE.InterfaceObjectMethodBindCall,
    MethodBindPtrcall: GDE.InterfaceObjectMethodBindPtrcall,
    Destroy: GDE.InterfaceObjectDestroy,
    GetInstanceBinding: GDE.InterfaceObjectGetInstanceBinding,
    SetInstanceBinding: GDE.InterfaceObjectSetInstanceBinding,
    FreeInstanceBinding: GDE.InterfaceObjectFreeInstanceBinding,
    SetInstance: GDE.InterfaceObjectSetInstance,
    GetClassName: GDE.InterfaceObjectGetClassName,
    CastTo: GDE.InterfaceObjectCastTo,
    GetInstanceFromId: GDE.InterfaceObjectGetInstanceFromId,
    GetInstanceId: GDE.InterfaceObjectGetInstanceId,
    HasScriptMethod: GDE.InterfaceObjectHasScriptMethod,
    CallScriptMethod: GDE.InterfaceObjectCallScriptMethod,
}

/* INTERFACE: Reference */
Reference_Utils : struct {
    RefGetObject: GDE.InterfaceRefGetObject,
    RefSetObject: GDE.InterfaceRefSetObject,
}

/* INTERFACE: Script Instance */
Script_Utils : struct {
    ScriptInstanceCreate: GDE.InterfaceScriptInstanceCreate,
    ScriptInstanceCreate2: GDE.InterfaceScriptInstanceCreate2,
    ScriptInstanceCreate3: GDE.InterfaceScriptInstanceCreate3,
    PlaceHolderScriptInstanceCreate: GDE.InterfacePlaceHolderScriptInstanceCreate,
    PlaceHolderScriptInstanceUpdate: GDE.InterfacePlaceHolderScriptInstanceUpdate,
    ObjectGetScriptInstance: GDE.InterfaceObjectGetScriptInstance,
    ObjectSetScriptInstance: GDE.InterfaceObjectSetScriptInstance,
}

/* INTERFACE: Callable */
Callable_Utils : struct {
    CustomCreate: GDE.InterfaceCallableCustomCreate,
    CustomCreate2: GDE.InterfaceCallableCustomCreate2,
    CustomGetUserData: GDE.InterfaceCallableCustomGetUserData,
}

/* INTERFACE: ClassDB */
ClassDB : struct {
    ConstructObject: GDE.InterfaceClassdbConstructObject,
    ConstructObject2: GDE.InterfaceClassdbConstructObject2,
    GetMethodBind: GDE.InterfaceClassdbGetMethodBind,
    GetClassTag: GDE.InterfaceClassdbGetClassTag,
    RegisterExtensionClass: GDE.InterfaceClassdbRegisterExtensionClass,
    RegisterExtensionClass2: GDE.InterfaceClassdbRegisterExtensionClass2,
    RegisterExtensionClass3: GDE.InterfaceClassdbRegisterExtensionClass3,
    RegisterExtensionClass4: GDE.InterfaceClassdbRegisterExtensionClass4,
    RegisterExtensionClass5: GDE.InterfaceClassdbRegisterExtensionClass5,
    RegisterExtensionClassMethod: GDE.InterfaceClassdbRegisterExtensionClassMethod,
    RegisterExtensionClassVirtualMethod: GDE.InterfaceClassdbRegisterExtensionClassVirtualMethod,
    RegisterExtensionClassIntegerConstant: GDE.InterfaceClassdbRegisterExtensionClassIntegerConstant,
    RegisterExtensionClassProperty: GDE.InterfaceClassdbRegisterExtensionClassProperty,
    RegisterExtensionClassPropertyIndexed: GDE.InterfaceClassdbRegisterExtensionClassPropertyIndexed,
    RegisterExtensionClassPropertyGroup: GDE.InterfaceClassdbRegisterExtensionClassPropertyGroup,
    RegisterExtensionClassPropertySubgroup: GDE.InterfaceClassdbRegisterExtensionClassPropertySubgroup,
    RegisterExtensionClassSignal: GDE.InterfaceClassdbRegisterExtensionClassSignal,
    ClassdbUnregisterExtensionClass: GDE.InterfaceClassdbUnregisterExtensionClass,
    GetLibraryPath: GDE.InterfaceGetLibraryPath,
}

Plugin : struct {
    EditorAddPlugin: GDE.InterfaceEditorAddPlugin,
    EditorRemovePlugin: GDE.InterfaceEditorRemovePlugin,
}