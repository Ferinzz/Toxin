package gdextension


import "core:c"

/*
* The names on these bindings are not strict. The function names that Godot needs to fetch are in the comments as @name.
* Feel free to rename whatever you need to be shorter.
* Most pointers are either rawptr or multipointers [^]rawptr. I haven't made anything distinct as it's not necessary to be too strict.?
*/

/* VARIANT TYPES */

//VARIANT_MAX is used in Godot as a bounds value. There's some functions and arrays that use this to set/check for out of bounds settings.
////WARNING: if the order of the variantType enum changes, GDTypes needs to be updated in GDDEfs file.
VariantType :: enum {
	NIL,

	/*  atomic types */
	BOOL,
	INT,
	FLOAT,
	STRING,

	/* math types */
	VECTOR2,
	VECTOR2I,
	RECT2,
	RECT2I,
	VECTOR3,
	VECTOR3I,
	TRANSFORM2D,
	VECTOR4,
	VECTOR4I,
	PLANE,
	QUATERNION,
	AABB,
	BASIS,
	TRANSFORM3D,
	PROJECTION,

	/* misc types */
	COLOR,
	STRING_NAME,
	NODE_PATH,
	RID,
	OBJECT,
	CALLABLE,
	SIGNAL,
	DICTIONARY,
	ARRAY,

	/* typed arrays */
	PACKED_BYTE_ARRAY,
	PACKED_INT32_ARRAY,
	PACKED_INT64_ARRAY,
	PACKED_FLOAT32_ARRAY,
	PACKED_FLOAT64_ARRAY,
	PACKED_STRING_ARRAY,
	PACKED_VECTOR2_ARRAY,
	PACKED_VECTOR3_ARRAY,
	PACKED_COLOR_ARRAY,
	PACKED_VECTOR4_ARRAY,

	VARIANT_MAX
} 

VariantOperator :: enum {
	/* comparison */
	VARIANT_OP_EQUAL,
	VARIANT_OP_NOT_EQUAL,
	VARIANT_OP_LESS,
	VARIANT_OP_LESS_EQUAL,
	VARIANT_OP_GREATER,
	VARIANT_OP_GREATER_EQUAL,

	/* mathematic */
	VARIANT_OP_ADD,
	VARIANT_OP_SUBTRACT,
	VARIANT_OP_MULTIPLY,
	VARIANT_OP_DIVIDE,
	VARIANT_OP_NEGATE,
	VARIANT_OP_POSITIVE,
	VARIANT_OP_MODULE,
	VARIANT_OP_POWER,

	/* bitwise */
	VARIANT_OP_SHIFT_LEFT,
	VARIANT_OP_SHIFT_RIGHT,
	VARIANT_OP_BIT_AND,
	VARIANT_OP_BIT_OR,
	VARIANT_OP_BIT_XOR,
	VARIANT_OP_BIT_NEGATE,

	/* logic */
	VARIANT_OP_AND,
	VARIANT_OP_OR,
	VARIANT_OP_XOR,
	VARIANT_OP_NOT,

	/* containment */
	VARIANT_OP_IN,
	VARIANT_OP_MAX

}


//use as markers to know what type to expect.
//Note from Godot
// In this API there are multiple functions which expect the caller to pass a pointer
// on return value as parameter.
// In order to make it clear if the caller should initialize the return value or not
// we have two flavor of types:
// - `XXXPtr` for pointer on an initialized value
// - `UninitializedXXXPtr` for pointer on uninitialized value
//
// Notes:
// - Not respecting those requirements can seems harmless, but will lead to unexpected
//   segfault or memory leak (for instance with a specific compiler/OS, or when two
//   native extensions start doing ptrcall on each other).
// - Initialization must be done with the function pointer returned by `variant_get_ptr_constructor`,
//   zero-initializing the variable should not be considered a valid initialization method here !
// - Some types have no destructor (see `extension_gdAPI.json`'s `has_destructor` field), for
//   them it is always safe to skip the constructor for the return value if you are in a hurry ;-)


VariantPtr 							:: ^Variant
ConstVariantPtr 					:: ^Variant
ConstVariantPtrargs 				:: [^]ConstVariantPtr
UninitializedVariantPtr 			:: rawptr
StringNamePtr 						:: ^StringName
ConstStringNamePtr 					:: [^]StringName
UninitializedStringNamePtr          :: ^StringName
StringPtr 							:: ^gdstring
ConstStringPtr 						:: [^]gdstring
UninitializedStringPtr 				:: ^gdstring
ObjectPtr 							:: ^Object
ConstObjectPtr 						:: [^]Object
UninitializedObjectPtr 				:: ^Object
TypePtr 							:: rawptr
ConstTypePtr 						:: [^]rawptr
UninitializedTypePtr 				:: rawptr
MethodBindPtr 						:: distinct rawptr
GDObjectInstanceID 					:: u64

RefPtr 								:: rawptr
ConstRefPtr 						:: [^]RefPtr
ClassLibraryPtr  					:: distinct rawptr
ConstTypePtrargs					:: [^]rawptr


InitializationLevel :: enum {
	INITIALIZATION_CORE,
	INITIALIZATION_SERVERS,
	INITIALIZATION_SCENE,
	INITIALIZATION_EDITOR,
	MAX_INITIALIZATION_LEVEL,
}

/* VARIANT DATA I/O */

CallErrorType :: enum {
	CALL_OK,
	CALL_ERROR_INVALID_METHOD,
	CALL_ERROR_INVALID_ARGUMENT, // Expected a different variant type.
	CALL_ERROR_TOO_MANY_ARGUMENTS, // Expected lower number of arguments.
	CALL_ERROR_TOO_FEW_ARGUMENTS, // Expected higher number of arguments.
	CALL_ERROR_INSTANCE_IS_NULL,
	CALL_ERROR_METHOD_NOT_CONST, // Used for const call.
}

CallError :: struct {
	error: CallErrorType,
	argument: i32,
	expected: i32,
}

VariantFromTypeConstructorFunc	:: proc "c" (UninitializedVariantPtr, TypePtr);
TypeFromVariantConstructorFunc	:: proc "c" (UninitializedTypePtr, VariantPtr);
VariantGetInternalPtrFunc 		:: proc "c" (VariantPtr) -> rawptr;
PtrOperatorEvaluator 			:: proc "c" (p_left: ConstTypePtr, 		 p_right: ConstTypePtr, 	  r_result: TypePtr);
PtrBuiltInMethod 				:: proc "c" (p_base: TypePtr, 			 p_args: ConstTypePtrargs, r_return:  TypePtr, p_argument_count: i64);
PtrConstructor 					:: proc "c" (p_base: UninitializedTypePtr, p_args: ConstTypePtrargs);
PtrDestructor 					:: proc "c" (p_base: TypePtr);
PtrSetter 						:: proc "c" (p_base: TypePtr, 	 p_value: ConstTypePtr);
PtrGetter 						:: proc "c" (p_base: ConstTypePtr, r_value:  TypePtr);
PtrIndexedSetter 				:: proc "c" (p_base: TypePtr, 	 p_index: Int, 		  p_value: ConstTypePtr);
PtrIndexedGetter 				:: proc "c" (p_base: ConstTypePtr, p_index:  Int, 		  r_value: TypePtr);
PtrKeyedSetter 					:: proc "c" (p_base: TypePtr, 	 p_key: ConstTypePtr,  p_value: ConstTypePtr);
PtrKeyedGetter 					:: proc "c" (p_base: ConstTypePtr, p_key:  ConstTypePtr, r_value: TypePtr);
PtrKeyedChecker 				:: proc "c" (p_base: ConstVariantPtr, p_key:  ConstVariantPtr) -> u32;
PtrUtilityFunction 				:: proc "c" (r_return: TypePtr,    p_args: ConstTypePtrargs, p_argument_count: i64);
ClassConstructor :: proc "c" () -> ObjectPtr;

ClassCreationInfo :: struct {
	is_virtual: Bool,
	is_abstract: Bool,
	set_func: ClassSet,
	get_func: ClassGet,
	get_property_list_func: ClassGetPropertyList,
	free_property_list_func: ClassFreePropertyList,
	property_can_revert_func: ClassPropertyCanRevert,
	property_get_revert_func: ClassPropertyGetRevert,
	notification_func: ClassNotification,
	to_string_func: ClassToString,
	reference_func: ClassReference,
	unreference_func: ClassUnreference,
	create_instance_func: ClassCreateInstance, // (Default) constructor; mandatory. If the class is not instantiable, consider making it virtual or abstract.
	free_instance_func: ClassFreeInstance, // Destructor; mandatory.
	get_virtual_func: ClassGetVirtual, // Queries a virtual function by name and returns a callback to invoke the requested virtual function.
	get_rid_func: ClassGetRID,
	class_userdata: rawptr, // Per-class user data, later accessible in instance bindings.
} // Deprecated. Use ClassCreationInfo4 instead.

ClassCreationInfo2 :: struct {
	is_virtual: Bool,
	is_abstract: Bool,
	is_exposed: Bool,
	set_func: ClassSet,
	get_func: ClassGet,
	get_property_list_func: ClassGetPropertyList,
	free_property_list_func: ClassFreePropertyList,
	property_can_revert_func: ClassPropertyCanRevert,
	property_get_revert_func: ClassPropertyGetRevert,
	validate_property_func: ClassValidateProperty,
	notification_func: ClassNotification2,
	to_string_func: ClassToString,
	reference_func: ClassReference,
	unreference_func: ClassUnreference,
	create_instance_func: ClassCreateInstance, // (Default) constructor; mandatory. If the class is not instantiable, consider making it virtual or abstract,
	free_instance_func: ClassFreeInstance, // Destructor; mandatory,
	recreate_instance_func: ClassRecreateInstance,
	// Queries a virtual function by name and returns a callback to invoke the requested virtual function.
	 get_virtual_func: ClassGetVirtual,
	// Paired with `call_virtual_with_data_func`, this is an alternative to `get_virtual_func` for extensions that
	// need or benefit from extra data when calling virtual functions.
	// Returns user data that will be passed to `call_virtual_with_data_func`.
	// Returning `NULL` from this function signals to Godot that the virtual function is not overridden.
	// Data returned from this function should be managed by the extension and must be valid until the extension is deinitialized.
	// You should supply either `get_virtual_func`, or `get_virtual_call_data_func` with `call_virtual_with_data_func`.
	 get_virtual_call_data_func: ClassGetVirtualCallData,
	// Used to call virtual functions when `get_virtual_call_data_func` is not null.
	 call_virtual_with_data_func: ClassCallVirtualWithData,
	get_rid_func: ClassGetRID,
	class_userdata: rawptr, // Per-class user data, later accessible in instance bindings.
} ; // Deprecated. Use ClassCreationInfo4 instead.


ClassCreationInfo3 :: struct {
	is_virtual: Bool,
	is_abstract: Bool,
	is_exposed: Bool,
	is_runtime: Bool,
	set_func: ClassSet,
	get_func: ClassGet,
	get_property_list_func: ClassGetPropertyList,
	free_property_list_func: ClassFreePropertyList2,
	property_can_revert_func: ClassPropertyCanRevert,
	property_get_revert_func: ClassPropertyGetRevert,
	validate_property_func: ClassValidateProperty,
	notification_func: ClassNotification2,
	to_string_func: ClassToString,
	reference_func: ClassReference,
	unreference_func: ClassUnreference,
	create_instance_func: ClassCreateInstance, // (Default) constructor; mandatory. If the class is not instantiable, consider making it virtual or abstract.
	free_instance_func: ClassFreeInstance, // Destructor; mandatory.
	recreate_instance_func: ClassRecreateInstance,
	// Queries a virtual function by name and returns a callback to invoke the requested virtual function.
	get_virtual_func: ClassGetVirtual,
	// Paired with `call_virtual_with_data_func`, this is an alternative to `get_virtual_func` for extensions that
	// need or benefit from extra data when calling virtual functions.
	// Returns user data that will be passed to `call_virtual_with_data_func`.
	// Returning `NULL` from this function signals to Godot that the virtual function is not overridden.
	// Data returned from this function should be managed by the extension and must be valid until the extension is deinitialized.
	// You should supply either `get_virtual_func`, or `get_virtual_call_data_func` with `call_virtual_with_data_func`.
	get_virtual_call_data_func: ClassGetVirtualCallData,
	// Used to call virtual functions when `get_virtual_call_data_func` is not null.
	call_virtual_with_data_func: ClassCallVirtualWithData,
	get_rid_func: ClassGetRID,
	class_userdata: rawptr, // Per-class user data, later accessible in instance bindings.
} // Deprecated. Use ClassCreationInfo4 instead.

//For more information about class functions check Godot docs
//https://docs.godotengine.org/en/stable/classes/class_object.html#Methods
ClassCreationInfo4 :: struct {
	is_virtual:            Bool, //For inheritance where instantiation is not allowed.
	is_abstract:           Bool, //Can't instantiate directly.
	is_exposed:            Bool, //Will be visible in the editor true/false
	is_runtime:            Bool, //Class isn't created compiled but created at runtime.
	icon_path:             ConstStringPtr, //For some reason does not work with stringnewutf8
	//Use these if you want a general purpose callback to handle get/set of variables which you did not specify distinctly.
	set_func:             ClassSet, //Fallback function that Godot will call if it can't find the getter/setter for a registered property.
	get_func:             ClassGet, //Fallback function that Godot will call if it can't find the getter/setter for a registered property.
	get_property_list_func:ClassGetPropertyList, //Provide a list of properties to Godot so that it can know what values exist. Mostly useful for runtime info.
	free_property_list_func: ClassFreePropertyList2, //Provide the list for Godot to call into to free memory.
	property_can_revert_func: ClassPropertyCanRevert, //Create a list based on StringNames to specify if a value can be reverted in the editor.
	property_get_revert_func: ClassPropertyGetRevert, //A function to return the default value of a property when reverted.
	validate_property_func:	ClassValidateProperty, //Validates property edits?
	notification_func:     ClassNotification2, //Called when the object receives a NOTIFICATION_*. Like _notification in GDScript.
	to_string_func:        ClassToString, //Custom function to create strings. For debugging/printing/etc.
	reference_func:        ClassReference, //If the class can/should be ref counted, provide a funtion for Godot to call when it does make a reference
	unreference_func:      ClassUnreference, //Called when Godot also calls unref 
	create_instance_func:  ClassCreateInstance2, // (Default) constructor; mandatory. If the class is not instantiable, consider making it virtual or abstract.
	free_instance_func:    ClassFreeInstance, // Destructor; mandatory.
	recreate_instance_func:ClassRecreateInstance,
	// Queries a virtual function by name and returns a callback to invoke the requested virtual function.
	get_virtual_func:      ClassGetVirtual2,
	// Paired with `call_virtual_with_data_func`, this is an alternative to `get_virtual_func` for extensions that
	// need or benefit from extra data when calling virtual functions.
	// Returns user data that will be passed to `call_virtual_with_data_func`.
	// Returning `NULL` from this function signals to Godot that the virtual function is not overridden.
	// Data returned from this function should be managed by the extension and must be valid until the extension is deinitialized.
	// You should supply either `get_virtual_func`, or `get_virtual_call_data_func` with `call_virtual_with_data_func`.
	get_virtual_call_data_func:ClassGetVirtualCallData2,
	// Used to call virtual functions when `get_virtual_call_data_func` is not null.
	call_virtual_with_data_func:ClassCallVirtualWithData,
	class_userdata: rawptr, // Per-class user data, later accessible in instance bindings. //A pointer to whatever you want to pass to the functions. Godot doesn't interact directly but will add it to a bunch of functions it calls.
} 

ClassCreationInfo5 :: ClassCreationInfo4

/* Passed a pointer to a PackedStringArray that should be filled with the classes that may be used by the GDExtension. */
EditorGetClassesUsedCallback :: proc "c" (p_packed_string_array: ^PackedStringArray);

InstanceBindingCallbacks :: struct {
	create_callback: 	InstanceBindingCreateCallback,
	free_callback: 		InstanceBindingFreeCallback,
	reference_callback:	InstanceBindingReferenceCallback,
}

InstanceBindingCreateCallback 	:: proc "c" (p_token: rawptr, p_instance: rawptr) -> rawptr;
InstanceBindingFreeCallback 		:: proc "c" (p_token: rawptr, p_instance: rawptr, p_binding: rawptr);
InstanceBindingReferenceCallback :: proc "c" (p_token: rawptr, p_binding: rawptr, p_reference: Bool) -> Bool;


/* EXTENSION CLASSES */

//p_instance is a pointer to allocated memory of our custom class's struct.
ClassInstancePtr :: ObjectPtr;

ClassSet 					:: proc "c" (p_instance: ClassInstancePtr, p_name: ConstStringNamePtr, p_value: ConstVariantPtr) -> Bool
ClassGet 					:: proc "c" (p_instance: ClassInstancePtr, p_name: ConstStringNamePtr, r_ret: VariantPtr) -> Bool
ClassGetRID  				:: proc "c" (p_instance: ClassInstancePtr) -> u64

//p_instance is a pointer to allocated memory of our custom class's struct.
ClassGetPropertyList 		:: proc "c" (p_instance: ClassInstancePtr, r_count: ^u32) -> [^]PropertyInfo;
ClassFreePropertyList 		:: proc "c" (p_instance: ClassInstancePtr, p_list: ^PropertyInfo);
ClassFreePropertyList2 		:: proc "c" (p_instance: ClassInstancePtr, p_list: ^PropertyInfo , p_count: u32);
ClassPropertyCanRevert 		:: proc "c" (p_instance: ClassInstancePtr, p_name: ConstStringNamePtr) -> Bool
ClassPropertyGetRevert 		:: proc "c" (p_instance: ClassInstancePtr, p_name: ConstStringNamePtr,  r_ret: VariantPtr) -> Bool
ClassValidateProperty 		:: proc "c" (p_instance: ClassInstancePtr, p_property: ^PropertyInfo) -> Bool
ClassNotification 			:: proc "c" (p_instance: ClassInstancePtr, p_what: i32); // Deprecated. Use ClassNotification2 instead.
ClassNotification2 			:: proc "c" (p_instance: ClassInstancePtr, p_what: i32,  p_reversed: Bool);
ClassToString 				:: proc "c" (p_instance: ClassInstancePtr, r_is_valid: Bool, p_out: StringPtr);
ClassReference 				:: proc "c" (p_instance: ClassInstancePtr);
ClassUnreference 			:: proc "c" (p_instance: ClassInstancePtr);
ClassCallVirtual 			:: proc "c" (p_instance: ClassInstancePtr, p_args: ConstTypePtr ,  r_ret: TypePtr);
//p_class_userdata is a pointer to whatever you make which should live the whole lifetime of the class.
//I believe this is typically used to pass context in C.
ClassCreateInstance 		:: proc "c" (p_class_userdata: rawptr) -> ObjectPtr;
ClassCreateInstance2 		:: proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: Bool) -> ObjectPtr;
ClassFreeInstance 			:: proc "c" (p_class_userdata: rawptr, p_instance: ClassInstancePtr);
ClassRecreateInstance 		:: proc "c" (p_class_userdata: rawptr, p_object: ObjectPtr) -> ClassInstancePtr;
ClassGetVirtual 			:: proc "c" (p_class_userdata: rawptr, p_name: ConstStringNamePtr) -> ClassCallVirtual;
ClassGetVirtual2 			:: proc "c" (p_class_userdata: rawptr, p_name: ConstStringNamePtr, p_hash: u32) -> ClassCallVirtual;
ClassGetVirtualCallData 	:: proc "c" (p_class_userdata: rawptr, p_name: ConstStringNamePtr) -> rawptr;
ClassGetVirtualCallData2 	:: proc "c" (p_class_userdata: rawptr, p_name: ConstStringNamePtr, p_hash: u32) -> rawptr;
ClassCallVirtualWithData  	:: proc "c" (p_instance: ClassInstancePtr, p_name: ConstStringNamePtr, p_virtual_call_userdata: rawptr, p_args: ConstTypePtrargs, r_ret: TypePtr);


/*a custom property info to a property. The dictionary must contain
* "name": String (the property's name)
* "type": int (see Variant.Type)
* optionally "hint": int (see PropertyHint) and "hint_string": String
*/
PropertyInfo :: struct {
	type:       VariantType,
	name:       StringNamePtr,
	class_name: StringNamePtr,
	hint:       PropertyHint, // enum of `PropertyHint` (defined in `extension_gdAPI.json`). https://docs.godotengine.org/en/stable/classes/class_@globalscope.html#enum-globalscope-propertyhint
	hint_string: StringPtr, //Depends on what hint was specified.
	usage:      PropertyUsageFlagsbits, //PropertyUsageFlags, // Bitfield of `PropertyUsageFlags` (defined in `extension_gdAPI.json`). https://docs.godotengine.org/en/stable/classes/class_@globalscope.html#enum-globalscope-propertyusageflags
}


MethodInfo :: struct {
	name: StringNamePtr,
	return_value: PropertyInfo,
	flags: u32, // Bitfield of `ClassMethodFlags`.
	id: i32,

	/* Arguments: `default_arguments` is an array of size `argument_count`. */
	argument_count: u32,
	arguments: [^]PropertyInfo,

	/* Default arguments: `default_arguments` is an array of size `default_argument_count`. */
	default_argument_count: u32,
	default_arguments: ConstVariantPtrargs,
}

/* Method */
Method_Flags_DEFAULT : ClassMethodFlags : {ClassMethodFlags.NORMAL}
ClassMethodFlags :: bit_set [ClassMethodFlagNames; u32]
ClassMethodFlagNames :: enum u32 {
	NORMAL,
//Flag for a normal method.
	EDITOR,
//Flag for an editor method.
	CONST,
//Flag for a constant method.
	VIRTUAL,
//Flag for a virtual method.
	VARARG,
//Flag for a method with a variable number of arguments.
	STATIC,
//Flag for a static method. https://stackoverflow.com/questions/19078224/what-are-static-methods-how-and-when-are-they-used
	OBJECT_CORE,
//Used internally. Allows to not dump core virtual methods (such as Object._notification()) to the JSON API.
	VIRTUAL_REQUIRED,
//Flag for a virtual method that is required. In GDScript, this flag is set for abstract functions.
	
}


//In the api you'll see meta int32 or float or whatever else
//I assume this is becauase you're supposed to use those types because something else might
//need that specific type. I am feeling like I'm crazy because in the cpp code it's still an int.
//Meaning you pass in an i64 and somewhere eventually it needs it to be a different sized type.
//Also GDScript doesn't care about this and it does not appear in the docs section.
ClassMethodArgumentMetadata :: enum c.int {
	NONE = 0,
	INT_IS_INT8,
	INT_IS_INT16,
	INT_IS_INT32,
	INT_IS_INT64,
	INT_IS_UINT8,
	INT_IS_UINT16,
	INT_IS_UINT32,
	INT_IS_UINT64,
	REAL_IS_FLOAT,
	REAL_IS_DOUBLE,
	INT_IS_CHAR16,
	INT_IS_CHAR32,
}

ClassMethodCall			:: proc "c" (method_userdata: rawptr, p_instance: ClassInstancePtr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: VariantPtr, r_error: ^CallError);
/*
* Actual source code. Fun fact, there's no way to actually pass this ClassMethodValidatedCall callback to Godot meaning there is no way to even provide it.
* It's not that it's unlikely, it's that it's Impossible.
if (validated_call_func) {
  // This is added here, but it's unlikely to be provided by most extensions.
  validated_call_func
*/
ClassMethodValidatedCall :: proc "c" (method_userdata: rawptr, p_instance: ClassInstancePtr, p_args: ConstVariantPtrargs, r_return: VariantPtr);
ClassMethodPtrCall		:: proc "c" (method_userdata: rawptr, p_instance: ClassInstancePtr, p_args: ConstTypePtrargs, r_ret: TypePtr);


ClassMethodInfo :: struct {
	name: StringNamePtr,
	method_userdata: rawptr,
	call_func: ClassMethodCall,
	ptrcall_func: ClassMethodPtrCall,
	method_flags: ClassMethodFlags, // Bitfield of `ClassMethodFlags`.

	/* If `has_return_value` is false, `return_value_info` and `return_value_metadata` are ignored.
	 *
	 * @todo Consider dropping `has_return_value` and making the other two properties match `MethodInfo` and `ClassVirtualMethod` for consistency in future version of this struct.
	 */
	has_return_value: Bool,
	return_value_info: ^PropertyInfo,
	return_value_metadata: ClassMethodArgumentMetadata,

	/* Arguments: `arguments_info` and `arguments_metadata` are array of size `argument_count`.
	 * Name and hint information for the argument can be omitted in release builds. Class name should always be present if it applies.
	 *
	 * @todo Consider renaming `arguments_info` to `arguments` for consistency in future version of this struct.
	 */
	argument_count: u32,
	arguments_info: [^]PropertyInfo,
	arguments_metadata: ^ClassMethodArgumentMetadata,

	/* Default arguments: `default_arguments` is an array of size `default_argument_count`. */
	default_argument_count: u32,
	default_arguments: ^VariantPtr,
}


ClassVirtualMethodInfo :: struct {
	name: StringNamePtr,
	method_flags: u32, // Bitfield of `ClassMethodFlags`.
	return_value: PropertyInfo,
	return_value_metadata: ClassMethodArgumentMetadata,

	argument_count: u32,
	arguments: [^]PropertyInfo,
	arguments_metadata: [^]ClassMethodArgumentMetadata,
}


CallableCustomCall		:: proc "c" (callable_userdata: rawptr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: VariantPtr, r_error: ^CallError);
CallableCustomIsValid	:: proc "c" (callable_userdata: rawptr) -> Bool;
CallableCustomFree		:: proc "c" (callable_userdata: rawptr);

CallableCustomHash		:: proc "c" (callable_userdata: rawptr) -> u32;
CallableCustomEqual		:: proc "c" (callable_userdata_a: rawptr, callable_userdata_b: rawptr) -> Bool;
CallableCustomLessThan	:: proc "c" (callable_userdata_a: rawptr, callable_userdata_b: rawptr) -> Bool;

CallableCustomToString	:: proc "c" (callable_userdata: rawptr, r_is_valid: ^Bool, r_out: StringPtr);

CallableCustomGetArgumentCount :: proc "c" (callable_userdata: rawptr, r_is_valid: ^Bool) -> Int;


CallableCustomInfo :: struct {
	/* Only `call_func` and `token` are strictly required, however, `object_id` should be passed if its not a static method.
	 *
	 * `token` should point to an address that uniquely identifies the GDExtension (for example, the
	 * `ClassLibraryPtr` passed to the entry symbol function.
	 *
	 * `hash_func`, `equal_func`, and `less_than_func` are optional. If not provided both `call_func` and
	 * `callable_userdata` together are used as the identity of the callable for hashing and comparison purposes.
	 *
	 * The hash returned by `hash_func` is cached, `hash_func` will not be called more than once per callable.
	 *
	 * `is_valid_func` is necessary if the validity of the callable can change before destruction.
	 *
	 * `free_func` is necessary if `callable_userdata` needs to be cleaned up when the callable is freed.
	 */
	callable_userdata: rawptr,
	token: rawptr,
	object_id: GDObjectInstanceID,
	call_func: CallableCustomCall,
	is_valid_func: CallableCustomIsValid,
	free_func: CallableCustomFree,
	hash_func: CallableCustomHash,
	equal_func: CallableCustomEqual,
	less_than_func: CallableCustomLessThan,
	to_string_func: CallableCustomToString,
} // Deprecated. Use CallableCustomInfo2 instead.

CallableCustomInfo2 :: struct {
	/* Only `call_func` and `token` are strictly required, however, `object_id` should be passed if its not a static method.
	 *
	 * `token` should point to an address that uniquely identifies the GDExtension (for example, the
	 * `ClassLibraryPtr` passed to the entry symbol function.
	 *
	 * `hash_func`, `equal_func`, and `less_than_func` are optional. If not provided both `call_func` and
	 * `callable_userdata` together are used as the identity of the callable for hashing and comparison purposes.
	 *
	 * The hash returned by `hash_func` is cached, `hash_func` will not be called more than once per callable.
	 *
	 * `is_valid_func` is necessary if the validity of the callable can change before destruction.
	 *
	 * `free_func` is necessary if `callable_userdata` needs to be cleaned up when the callable is freed.
	 */
	callable_userdata: rawptr,
	token: ClassLibraryPtr,

	object_id: GDObjectInstanceID,
	call_func: CallableCustomCall,
	is_valid_func: CallableCustomIsValid,
	free_func: CallableCustomFree,
	hash_func: CallableCustomHash,
	equal_func: CallableCustomEqual,
	less_than_func: CallableCustomLessThan,
	to_string_func: CallableCustomToString,
	get_argument_count_func: CallableCustomGetArgumentCount,
}

/* SCRIPT INSTANCE EXTENSION */

/*
* ScriptInstanceDataPtr is a type definition for a pointer to a ScriptInstanceData object.
* It's used internally by the engine to manage script instances and their associated data.
* This pointer provides a way to access and manipulate script-related information within the engine's core functionality.
*/

ScriptInstanceDataPtr :: rawptr; // Pointer to custom ScriptInstance native implementation.

ScriptInstanceSet				:: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr, p_value: VariantPtr) -> Bool;
ScriptInstanceGet				:: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr, r_ret: VariantPtr) -> Bool;
ScriptInstanceGetPropertyList	:: proc "c" (p_instance: ScriptInstanceDataPtr, r_count: ^u32) -> PropertyInfo;
ScriptInstanceFreePropertyList	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_list: ^PropertyInfo); // Deprecated. Use ScriptInstanceFreePropertyList2 instead.
ScriptInstanceFreePropertyList2	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_list: ^PropertyInfo, p_count: u32);
ScriptInstanceGetClassCategory	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_class_category: ^PropertyInfo) -> Bool;

ScriptInstanceGetPropertyType	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr, r_is_valid: ^Bool) -> VariantType;
ScriptInstanceValidateProperty	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_property: ^PropertyInfo) -> Bool;

ScriptInstancePropertyCanRevert :: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr) -> Bool;
ScriptInstancePropertyGetRevert :: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr, r_ret: VariantPtr) -> Bool;

ScriptInstanceGetOwner			:: proc "c" (p_instance: ScriptInstanceDataPtr) -> ObjectPtr;
ScriptInstancePropertyStateAdd	:: proc "c" (p_name: ConstStringNamePtr, p_value: ConstVariantPtr, p_userdata: rawptr);
ScriptInstanceGetPropertyState	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_add_func: ScriptInstancePropertyStateAdd, p_userdata: rawptr);

ScriptInstanceGetMethodList		:: proc "c" (p_instance: ScriptInstanceDataPtr, r_count: ^u32) -> ^MethodInfo;
ScriptInstanceFreeMethodList	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_list: [^]MethodInfo); // Deprecated. Use ScriptInstanceFreeMethodList2 instead.
ScriptInstanceFreeMethodList2	:: proc "c" (p_instance: ScriptInstanceDataPtr, p_list: ^MethodInfo, p_count: u32);

ScriptInstanceHasMethod			:: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr) -> Bool;

ScriptInstanceGetMethodArgumentCount :: proc "c" (p_instance: ScriptInstanceDataPtr, p_name: ConstStringNamePtr, r_is_valid: ^Bool) -> Int;

ScriptInstanceCall				:: proc "c" (p_self: ScriptInstanceDataPtr, p_method: ConstStringNamePtr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: VariantPtr, r_error: ^CallError);
ScriptInstanceNotification		:: proc "c" (p_instance: ScriptInstanceDataPtr, p_what: i32); // Deprecated. Use ScriptInstanceNotification2 instead.
ScriptInstanceNotification2		:: proc "c" (p_instance: ScriptInstanceDataPtr, p_what: i32, p_reversed: Bool);
ScriptInstanceToString			:: proc "c" (p_instance: ScriptInstanceDataPtr, r_is_valid: ^Bool, r_out: StringPtr);

ScriptInstanceRefCountIncremented :: proc "c" (p_instance: ScriptInstanceDataPtr);
ScriptInstanceRefCountDecremented :: proc "c" (p_instance: ScriptInstanceDataPtr) -> Bool;

ScriptInstanceGetScript			:: proc "c" (p_instance: ScriptInstanceDataPtr) -> ObjectPtr;
ScriptInstanceIsPlaceholder		:: proc "c" (p_instance: ScriptInstanceDataPtr) -> Bool;

ScriptLanguagePtr :: rawptr;

ScriptInstanceGetLanguage		:: proc "c" (p_instance: ScriptInstanceDataPtr) -> ScriptLanguagePtr;

ScriptInstanceFree				:: proc "c" (p_instance: ScriptInstanceDataPtr);

ScriptInstancePtr :: rawptr; // Pointer to ScriptInstance.

ScriptInstanceInfo :: struct {
	set_func: ScriptInstanceSet,
	get_func: ScriptInstanceGet,
	get_property_list_func: ScriptInstanceGetPropertyList,
	free_property_list_func: ScriptInstanceFreePropertyList,
	property_can_revert_func: ScriptInstancePropertyCanRevert,
	property_get_revert_func: ScriptInstancePropertyGetRevert,
	get_owner_func: ScriptInstanceGetOwner,
	get_property_state_func: ScriptInstanceGetPropertyState,
	get_method_list_func: ScriptInstanceGetMethodList,
	free_method_list_func: ScriptInstanceFreeMethodList,
	get_property_type_func: ScriptInstanceGetPropertyType,
	has_method_func: ScriptInstanceHasMethod,
	call_func: ScriptInstanceCall,
	notification_func: ScriptInstanceNotification,
	to_string_func: ScriptInstanceToString,
	refcount_incremented_func: ScriptInstanceRefCountIncremented,
	refcount_decremented_func: ScriptInstanceRefCountDecremented,
	get_script_func: ScriptInstanceGetScript,
	is_placeholder_func: ScriptInstanceIsPlaceholder,
	set_fallback_func: ScriptInstanceSet,
	get_fallback_func: ScriptInstanceGet,
	get_language_func: ScriptInstanceGetLanguage,
	free_func: ScriptInstanceFree,

}  // Deprecated. Use ScriptInstanceInfo3 instead.

ScriptInstanceInfo2 :: struct {
	set_func: ScriptInstanceSet,
	get_func: ScriptInstanceGet,
	get_property_list_func: ScriptInstanceGetPropertyList,
	free_property_list_func: ScriptInstanceFreePropertyList,
	get_class_category_func: ScriptInstanceGetClassCategory, // Optional. Set to NULL for the default behavior.
	property_can_revert_func: ScriptInstancePropertyCanRevert,
	property_get_revert_func: ScriptInstancePropertyGetRevert,
	get_owner_func: ScriptInstanceGetOwner,
	get_property_state_func: ScriptInstanceGetPropertyState,
	get_method_list_func: ScriptInstanceGetMethodList,
	free_method_list_func: ScriptInstanceFreeMethodList,
	get_property_type_func: ScriptInstanceGetPropertyType,
	validate_property_func: ScriptInstanceValidateProperty,
	has_method_func: ScriptInstanceHasMethod,
	call_func: ScriptInstanceCall,
	notification_func: ScriptInstanceNotification2,
	to_string_func: ScriptInstanceToString,
	refcount_incremented_func: ScriptInstanceRefCountIncremented,
	refcount_decremented_func: ScriptInstanceRefCountDecremented,
	get_script_func: ScriptInstanceGetScript,
	is_placeholder_func: ScriptInstanceIsPlaceholder,
	set_fallback_func: ScriptInstanceSet,
	get_fallback_func: ScriptInstanceGet,
	get_language_func: ScriptInstanceGetLanguage,
	free_func: ScriptInstanceFree,

}  // Deprecated. Use ScriptInstanceInfo3 instead.

ScriptInstanceInfo3 :: struct {
	set_func: ScriptInstanceSet,
	get_func: ScriptInstanceGet,
	get_property_list_func: ScriptInstanceGetPropertyList,
	free_property_list_func: ScriptInstanceFreePropertyList2,
	get_class_category_func: ScriptInstanceGetClassCategory, // Optional. Set to NULL for the default behavior.
	property_can_revert_func: ScriptInstancePropertyCanRevert,
	property_get_revert_func: ScriptInstancePropertyGetRevert,
	get_owner_func: ScriptInstanceGetOwner,
	get_property_state_func: ScriptInstanceGetPropertyState,
	get_method_list_func: ScriptInstanceGetMethodList,
	free_method_list_func: ScriptInstanceFreeMethodList2,
	get_property_type_func: ScriptInstanceGetPropertyType,
	validate_property_func: ScriptInstanceValidateProperty,
	has_method_func: ScriptInstanceHasMethod,
	get_method_argument_count_func: ScriptInstanceGetMethodArgumentCount,
	call_func: ScriptInstanceCall,
	notification_func: ScriptInstanceNotification2,
	to_string_func: ScriptInstanceToString,
	refcount_incremented_func: ScriptInstanceRefCountIncremented,
	refcount_decremented_func: ScriptInstanceRefCountDecremented,
	get_script_func: ScriptInstanceGetScript,
	is_placeholder_func: ScriptInstanceIsPlaceholder,
	set_fallback_func: ScriptInstanceSet,
	get_fallback_func: ScriptInstanceGet,
	get_language_func: ScriptInstanceGetLanguage,
	free_func: ScriptInstanceFree,

}

//*************\\
//**Threading**\\
//*************\\

WorkerThreadPoolGroupTask :: proc "c" (unspecified: rawptr, unspecified2: u32);
GDExtensionWorkerThreadPoolTask :: proc "c" (unspecified: rawptr);


InitializeCallback :: proc "c" (p_userdata: rawptr, p_level: InitializationLevel);
DeinitializeCallback :: proc "c" (p_userdata: rawptr, p_level: InitializationLevel);

Initialization :: struct {
	    /* Minimum initialization level required.
	     * If Core or Servers, the extension needs editor or game restart to take effect */
	minimum_initialization_level: InitializationLevel,
	    /* Up to the user to supply when initializing */
	userdata: rawptr,
	    /* This function will be called multiple times for each initialization level. */
	initialize:   proc "c" (userdata: rawptr, p_level: InitializationLevel),
	deinitialize: proc "c" (userdata: rawptr, p_level: InitializationLevel),
}


InterfaceFunctionPtr	:: proc "c" ();
InterfaceGetProcAddress	:: proc "c" (p_function_name: cstring) -> InterfaceFunctionPtr

/*
 * Each GDExtension should define a C function that matches the signature of InitializationFunction,
 * and export it so that it can be loaded via dlopen() or equivalent for the given platform.
 *
 * For example:
 *
 *   Bool my_extension_init(InterfaceGetProcAddress p_get_proc_address, ClassLibraryPtr p_library, Initialization *r_initialization);
 *
 * This function's name must be specified as the 'entry_symbol' in the GDExtension.gdextension file.
 *
 * This makes it the entry point of the GDExtension and will be called on initialization.
 *
 * The GDExtension can then modify the r_initialization structure, setting the minimum initialization level,
 * and providing pointers to functions that will be called at various stages of initialization/shutdown.
 *
 * The rest of the GDExtension's interface to Godot consists of function pointers that can be loaded
 * by calling p_get_proc_address("...") with the name of the function.
 *
 * For example:
 *
 *   InterfaceGetGodotVersion get_godot_version = (InterfaceGetGodotVersion)p_get_proc_address("get_godot_version");
 *
 * (Note that snippet may cause "cast between incompatible function types" on some compilers, you can
 * silence this by adding an intermediary `void*` cast.)
 *
 * You can then call it like a normal function:
 *
 *   GodotVersion godot_version;
 *   get_godot_version(&godot_version);
 *   printf("Godot v%d.%d.%d\n", godot_version.major, godot_version.minor, godot_version.patch);
 *
 * All of these interface functions are described below, together with the name that's used to load it,
 * and the function pointer typedef that shows its signature.
 */
InitializationFunction :: proc "c" (p_get_proc_address: InterfaceGetProcAddress, p_library: ClassLibraryPtr, r_initialization: ^Initialization) -> Bool;

/* INTERFACE */

GodotVersion :: struct {
	major: u32,
	minor: u32,
	patch: u32,
	string: cstring,
}

GodotVersion2 :: struct {
	major: i32,
	minor: i32,
	patch: i32,
	/* Full version encoded as hexadecimal with one byte (2 hex digits) per number (e.g. for "3.1.12" it would be 0x03010C) */
	hex: i32,
	/* (e.g. "stable", "beta", "rc1", "rc2") */
	status: cstring,
	/* (e.g. "custom_build") */
	build: cstring,
	/* Full Git commit hash. */
	hash: cstring,
	/* Git commit date UNIX timestamp in seconds, or 0 if unavailable. */
	timestamp: i64,
	/* (e.g. "Godot v3.1.4.stable.official.mono") */
	string: cstring,
};

//*********************************\\
//******MAIN LOOP HELPERS!!!!!*****\\
//*********************************\\

/* Called when starting the main loop. */
MainLoopStartupCallback :: proc "c" ();
/* Called when shutting down the main loop. */
MainLoopShutdownCallback :: proc "c" ();
/* Called for every frame iteration of the main loop. */
MainLoopFrameCallback :: proc "c" ();

MainLoopCallbacks :: struct {
	/* Will be called after Godot is started and is fully initialized. */
	startup_func: MainLoopStartupCallback,
	/* Will be called before Godot is shutdown when it is still fully initialized. */
	shutdown_func: MainLoopShutdownCallback,
	/* Will be called for each process frame. This will run after all `_process()` methods on Node, and before `ScriptServer::frame()`.
	 * This is intended to be the equivalent of `ScriptLanguage::frame()` for GDExtension language bindings that don't use the script API.
	 */
	frame_func: MainLoopFrameCallback,
};

/**
 * @name get_godot_version
 * @since 4.1
 *
 * Gets the Godot version that the GDExtension was loaded into.
 *
 * @param r_godot_version A pointer to the structure to write the version information into.
 */
InterfaceGetGodotVersion :: proc "c" (r_godot_version: ^GodotVersion);

/**
 * @name get_godot_version2
 * @since 4.5
 *
 * Gets the Godot version that the GDExtension was loaded into.
 *
 * @param r_godot_version A pointer to the structure to write the version information into.
 */
InterfaceGetGodotVersion2 :: proc "c" (r_godot_version: ^GodotVersion2);


/* INTERFACE: Memory */

/**
 * @name mem_alloc
 * @since 4.1
 *
 * Allocates memory.
 *
 * @param p_bytes The amount of memory to allocate in bytes.
 *
 * @return A pointer to the allocated memory, or NULL if unsuccessful.
 */
InterfaceMemAlloc :: proc "c" (p_bytes: int) -> rawptr;

/**
 * @name mem_realloc
 * @since 4.1
 *
 * Reallocates memory.
 *
 * @param p_ptr A pointer to the previously allocated memory.
 * @param p_bytes The number of bytes to resize the memory block to.
 *
 * @return A pointer to the allocated memory, or NULL if unsuccessful.
 */
InterfaceMemRealloc :: proc "c" (p_ptr: rawptr, p_bytes: int) -> rawptr;

/**
 * @name mem_free
 * @since 4.1
 *
 * Frees memory.
 *
 * @param p_ptr A pointer to the previously allocated memory.
 */
InterfaceMemFree :: proc "c" (p_ptr: rawptr)

/**
 * @name mem_alloc2
 * @since 4.6
 *
 * Allocates memory.
 *
 * @param p_bytes The amount of memory to allocate in bytes.
 * @param p_pad_align If true, the returned memory will have prepadding of at least 8 bytes.
 *
 * @return A pointer to the allocated memory, or NULL if unsuccessful.
 */
InterfaceMemAlloc2 :: proc "c" (p_bytes: u64, p_pad_align: Bool) -> rawptr;

/**
 * @name mem_realloc2
 * @since 4.6
 *
 * Reallocates memory.
 *
 * @param p_ptr A pointer to the previously allocated memory.
 * @param p_bytes The number of bytes to resize the memory block to.
 * @param p_pad_align If true, the returned memory will have prepadding of at least 8 bytes.
 *
 * @return A pointer to the allocated memory, or NULL if unsuccessful.
 */
InterfaceMemRealloc2 :: proc "c" (p_ptr: rawptr, p_bytes: u64, p_pad_align: Bool) -> rawptr;

/**
 * @name mem_free2
 * @since 4.6
 *
 * Frees memory.
 *
 * @param p_ptr A pointer to the previously allocated memory.
 * @param p_pad_align If true, the given memory was allocated with prepadding.
 */
InterfaceMemFree2 :: proc "c" (p_bytes: u64, p_pad_align: Bool);


/* INTERFACE: Godot Core */

/**
 * @name print_error
 * @since 4.1
 *
 * Logs an error to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the error.
 * @param p_function The function name where the error occurred.
 * @param p_file The file where the error occurred.
 * @param p_line The line where the error occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintError :: proc "c" (p_description: cstring, p_function: cstring, p_file: cstring, p_line: i32, p_editor_notify: Bool);

/**
 * @name print_error_with_message
 * @since 4.1
 *
 * Logs an error with a message to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the error.
 * @param p_message The message to show along with the error.
 * @param p_function The function name where the error occurred.
 * @param p_file The file where the error occurred.
 * @param p_line The line where the error occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintErrorWithMessage :: proc "c" (p_description: cstring, p_message: cstring,p_function: cstring, p_file: cstring,  p_line: i32, p_editor_notify: Bool);

/**
 * @name print_warning
 * @since 4.1
 *
 * Logs a warning to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the warning.
 * @param p_function The function name where the warning occurred.
 * @param p_file The file where the warning occurred.
 * @param p_line The line where the warning occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintWarning :: proc "c" (p_description: cstring, p_function: cstring, p_file: cstring,  p_line: int,  p_editor_notify: Bool);

/**
 * @name print_warning_with_message
 * @since 4.1
 *
 * Logs a warning with a message to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the warning.
 * @param p_message The message to show along with the warning.
 * @param p_function The function name where the warning occurred.
 * @param p_file The file where the warning occurred.
 * @param p_line The line where the warning occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintWarningWithMessage :: proc "c" (p_description: cstring, p_message: cstring, p_function: cstring, p_file: cstring, p_line: i32, p_editor_notify: Bool);

/**
 * @name print_script_error
 * @since 4.1
 *
 * Logs a script error to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the error.
 * @param p_function The function name where the error occurred.
 * @param p_file The file where the error occurred.
 * @param p_line The line where the error occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintScriptError :: proc "c" (p_description: cstring, p_function: cstring, p_file: cstring, p_line: i32, p_editor_notify: Bool);

/**
 * @name print_script_error_with_message
 * @since 4.1
 *
 * Logs a script error with a message to Godot's built-in debugger and to the OS terminal.
 *
 * @param p_description The code triggering the error.
 * @param p_message The message to show along with the error.
 * @param p_function The function name where the error occurred.
 * @param p_file The file where the error occurred.
 * @param p_line The line where the error occurred.
 * @param p_editor_notify Whether or not to notify the editor.
 */
InterfacePrintScriptErrorWithMessage :: proc "c" (p_description: cstring, p_message: cstring, p_function: cstring, p_file: cstring, p_line: i32, p_editor_notify: Bool);

/**
 * @name get_native_struct_size
 * @since 4.1
 *
 * Gets the size of a native struct (ex. ObjectID) in bytes.
 *
 * @param p_name A pointer to a StringName identifying the struct name.
 *
 * @return The size in bytes.
 */
InterfaceGetNativeStructSize :: proc "c" (p_name: ConstStringNamePtr) -> i64;

/* INTERFACE: Variant */

/**
 * @name variant_new_copy
 * @since 4.1
 *
 * Copies one Variant into a another.
 *
 * @param r_dest A pointer to the destination Variant.
 * @param p_src A pointer to the source Variant.
 */
InterfaceVariantNewCopy :: proc "c" (r_dest: UninitializedVariantPtr, p_src: VariantPtr);

/**
 * @name variant_new_nil
 * @since 4.1
 *
 * Creates a new Variant containing nil.
 *
 * @param r_dest A pointer to the destination Variant.
 */
InterfaceVariantNewNil :: proc "c" (r_dest: UninitializedVariantPtr);

/**
 * @name variant_destroy
 * @since 4.1
 *
 * Destroys a Variant.
 *
 * @param p_self A pointer to the Variant to destroy.
 */
InterfaceVariantDestroy :: proc "c" (p_self: VariantPtr);

/**
 * @name variant_call
 * @since 4.1
 *
 * Calls a method on a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_method A pointer to a StringName identifying the method.
 * @param p_args A pointer to a C array of Variant.
 * @param p_argument_count The number of arguments.
 * @param r_return A pointer a Variant which will be assigned the return value.
 * @param r_error A pointer the structure which will hold error information.
 *
 * @see Variant::callp()
 */
InterfaceVariantCall :: proc "c" (p_self: VariantPtr,  p_method: StringNamePtr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: UninitializedVariantPtr, r_error: ^CallError);

/**
 * @name variant_call_static
 * @since 4.1
 *
 * Calls a static method on a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_method A pointer to a StringName identifying the method.
 * @param p_args A pointer to a C array of Variant.
 * @param p_argument_count The number of arguments.
 * @param r_return A pointer a Variant which will be assigned the return value.
 * @param r_error A pointer the structure which will be updated with error information.
 *
 * @see Variant::call_static()
 */
InterfaceVariantCallStatic :: proc "c" (p_type: VariantType, p_method: StringNamePtr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: UninitializedVariantPtr, r_error: ^CallError);

/**
 * @name variant_evaluate
 * @since 4.1
 *
 * Evaluate an operator on two Variants.
 *
 * @param p_op The operator to evaluate.
 * @param p_a The first Variant.
 * @param p_b The second Variant.
 * @param r_return A pointer a Variant which will be assigned the return value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @see Variant::evaluate()
 */
InterfaceVariantEvaluate :: proc "c" (p_op: VariantOperator, p_a: VariantPtr, p_b: ConstVariantPtr, r_return: UninitializedVariantPtr, r_valid: ^Bool);

/**
 * @name variant_set
 * @since 4.1
 *
 * Sets a key on a Variant to a value.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a Variant representing the key.
 * @param p_value A pointer to a Variant representing the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @see Variant::set()
 */
InterfaceVariantSet :: proc "c" (p_self: VariantPtr, p_key: ConstVariantPtr, p_value: ConstVariantPtr, r_valid: ^Bool);

/**
 * @name variant_set_named
 * @since 4.1
 *
 * Sets a named key on a Variant to a value.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a StringName representing the key.
 * @param p_value A pointer to a Variant representing the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @see Variant::set_named()
 */
InterfaceVariantSetNamed :: proc "c" (p_self: VariantPtr, p_key: ConstStringNamePtr, p_value: ConstVariantPtr, r_valid: ^Bool);

/**
 * @name variant_set_keyed
 * @since 4.1
 *
 * Sets a keyed property on a Variant to a value.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a Variant representing the key.
 * @param p_value A pointer to a Variant representing the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @see Variant::set_keyed()
 */
InterfaceVariantSetKeyed :: proc "c" (p_self: VariantPtr, p_key: ConstVariantPtr, p_value: ConstVariantPtr, r_valid: ^Bool);

/**
 * @name variant_set_indexed
 * @since 4.1
 *
 * Sets an index on a Variant to a value.
 *
 * @param p_self A pointer to the Variant.
 * @param p_index The index.
 * @param p_value A pointer to a Variant representing the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 * @param r_oob A pointer to a boolean which will be set to true if the index is out of bounds.
 */
InterfaceVariantSetIndexed :: proc "c" (p_self: VariantPtr, p_index: Int, p_value: ConstVariantPtr, r_valid: ^Bool, r_oob: ^Bool);

/**
 * @name variant_get
 * @since 4.1
 *
 * Gets the value of a key from a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a Variant representing the key.
 * @param r_ret A pointer to a Variant which will be assigned the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 */
InterfaceVariantGet :: proc "c" (p_self: VariantPtr, p_key: ConstVariantPtr, r_ret: UninitializedVariantPtr, r_valid: ^Bool);

/**
 * @name variant_get_named
 * @since 4.1
 *
 * Gets the value of a named key from a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a StringName representing the key.
 * @param r_ret A pointer to a Variant which will be assigned the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 */
InterfaceVariantGetNamed :: proc "c" (p_self: ConstVariantPtr, p_key: ConstStringNamePtr, r_ret: UninitializedVariantPtr, r_valid: ^Bool);

/**
 * @name variant_get_keyed
 * @since 4.1
 *
 * Gets the value of a keyed property from a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a Variant representing the key.
 * @param r_ret A pointer to a Variant which will be assigned the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 */
InterfaceVariantGetKeyed :: proc "c" (p_self: ConstVariantPtr, p_key: ConstVariantPtr, r_ret: UninitializedVariantPtr, r_valid: ^Bool);

/**
 * @name variant_get_indexed
 * @since 4.1
 *
 * Gets the value of an index from a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_index The index.
 * @param r_ret A pointer to a Variant which will be assigned the value.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 * @param r_oob A pointer to a boolean which will be set to true if the index is out of bounds.
 */
InterfaceVariantGetIndexed :: proc "c" (p_self: ConstVariantPtr, p_index: Int, r_ret: UninitializedVariantPtr, r_valid: ^Bool, r_oob: ^Bool);

/**
 * @name variant_iter_init
 * @since 4.1
 *
 * Initializes an iterator over a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param r_iter A pointer to a Variant which will be assigned the iterator.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @return true if the operation is valid; otherwise false.
 *
 * @see Variant::iter_init()
 */
InterfaceVariantIterInit :: proc "c" (p_self: ConstVariantPtr, r_iter: UninitializedVariantPtr, r_valid: ^Bool) -> Bool;

/**
 * @name variant_iter_next
 * @since 4.1
 *
 * Gets the next value for an iterator over a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param r_iter A pointer to a Variant which will be assigned the iterator.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @return true if the operation is valid; otherwise false.
 *
 * @see Variant::iter_next()
 */
InterfaceVariantIterNext :: proc "c" (p_self: ConstVariantPtr, r_iter: VariantPtr, r_valid: ^Bool) -> Bool;

/**
 * @name variant_iter_get
 * @since 4.1
 *
 * Gets the next value for an iterator over a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param r_iter A pointer to a Variant which will be assigned the iterator.
 * @param r_ret A pointer to a Variant which will be assigned false if the operation is invalid.
 * @param r_valid A pointer to a boolean which will be set to false if the operation is invalid.
 *
 * @see Variant::iter_get()
 */
InterfaceVariantIterGet :: proc "c" (p_self: ConstVariantPtr, r_iter: VariantPtr, r_ret: UninitializedVariantPtr, r_valid: ^Bool);

/**
 * @name variant_hash
 * @since 4.1
 *
 * Gets the hash of a Variant.
 *
 * @param p_self A pointer to the Variant.
 *
 * @return The hash value.
 *
 * @see Variant::hash()
 */
InterfaceVariantHash :: proc "c" (p_self: ConstVariantPtr) -> Int

/**
 * @name variant_recursive_hash
 * @since 4.1
 *
 * Gets the recursive hash of a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param p_recursion_count The number of recursive loops so far.
 *
 * @return The hash value.
 *
 * @see Variant::recursive_hash()
 */
InterfaceVariantRecursiveHash :: proc "c" (p_self: ConstVariantPtr, p_recursion_count: Int) -> Int;

/**
 * @name variant_hash_compare
 * @since 4.1
 *
 * Compares two Variants by their hash.
 *
 * @param p_self A pointer to the Variant.
 * @param p_other A pointer to the other Variant to compare it to.
 *
 * @return The hash value.
 *
 * @see Variant::hash_compare()
 */
InterfaceVariantHashCompare :: proc "c" (p_self: ConstVariantPtr, p_other: ConstVariantPtr) -> Bool;

/**
 * @name variant_booleanize
 * @since 4.1
 *
 * Converts a Variant to a boolean.
 *
 * @param p_self A pointer to the Variant.
 *
 * @return The boolean value of the Variant.
 */
InterfaceVariantBooleanize :: proc "c" (p_self: ConstVariantPtr) -> Bool;

/**
 * @name variant_duplicate
 * @since 4.1
 *
 * Duplicates a Variant.
 *
 * @param p_self A pointer to the Variant.
 * @param r_ret A pointer to a Variant to store the duplicated value.
 * @param p_deep Whether or not to duplicate deeply (when supported by the Variant type).
 */
InterfaceVariantDuplicate :: proc "c" (p_self: ConstVariantPtr, r_ret: VariantPtr, p_deep: Bool);

/**
 * @name variant_stringify
 * @since 4.1
 *
 * Converts a Variant to a string.
 *
 * @param p_self A pointer to the Variant.
 * @param r_ret A pointer to a String to store the resulting value.
 */
InterfaceVariantStringify :: proc "c" (p_self: ConstVariantPtr, r_ret: StringPtr);

/**
 * @name variant_get_type
 * @since 4.1
 *
 * Gets the type of a Variant.
 *
 * @param p_self A pointer to the Variant.
 *
 * @return The variant type.
 */
InterfaceVariantGetType :: proc "c" (p_self: ConstVariantPtr) -> VariantType;

/**
 * @name variant_has_method
 * @since 4.1
 *
 * Checks if a Variant has the given method.
 *
 * @param p_self A pointer to the Variant.
 * @param p_method A pointer to a StringName with the method name.
 *
 * @return
 */
InterfaceVariantHasMethod :: proc "c" (p_self: ConstVariantPtr, p_method: ConstStringNamePtr) -> Bool;

/**
 * @name variant_has_member
 * @since 4.1
 *
 * Checks if a type of Variant has the given member.
 *
 * @param p_type The Variant type.
 * @param p_member A pointer to a StringName with the member name.
 *
 * @return
 */
InterfaceVariantHasMember :: proc "c" (p_type: VariantType, p_member: ConstStringNamePtr) -> Bool;

/**
 * @name variant_has_key
 * @since 4.1
 *
 * Checks if a Variant has a key.
 *
 * @param p_self A pointer to the Variant.
 * @param p_key A pointer to a Variant representing the key.
 * @param r_valid A pointer to a boolean which will be set to false if the key doesn't exist.
 *
 * @return true if the key exists; otherwise false.
 */
InterfaceVariantHasKey :: proc "c" (p_self: ConstVariantPtr, p_key: ConstVariantPtr, r_valid: ^Bool) -> Bool;

/**
 * @name variant_get_object_instance_id
 * @since 4.4
 *
 * Gets the object instance ID from a variant of type GDEXTENSION_VARIANT_TYPE_OBJECT.
 *
 * If the variant isn't of type GDEXTENSION_VARIANT_TYPE_OBJECT, then zero will be returned.
 * The instance ID will be returned even if the object is no longer valid - use `object_get_instance_by_id()` to check if the object is still valid.
 *
 * @param p_self A pointer to the Variant.
 *
 * @return The instance ID for the contained object.
 */
InterfaceVariantGetObjectInstanceId :: proc "c" (p_self: ConstVariantPtr) -> GDObjectInstanceID;

/**
 * @name variant_get_type_name
 * @since 4.1
 *
 * Gets the name of a Variant type.
 *
 * @param p_type The Variant type.
 * @param r_name A pointer to a String to store the Variant type name.
 */
InterfaceVariantGetTypeName :: proc "c" (p_type: VariantType, r_name: UninitializedStringPtr);

/**
 * @name variant_can_convert
 * @since 4.1
 *
 * Checks if Variants can be converted from one type to another.
 *
 * @param p_from The Variant type to convert from.
 * @param p_to The Variant type to convert to.
 *
 * @return true if the conversion is possible; otherwise false.
 */
InterfaceVariantCanConvert :: proc "c" (p_from: VariantType, p_to: VariantType) -> Bool;

/**
 * @name variant_can_convert_strict
 * @since 4.1
 *
 * Checks if Variant can be converted from one type to another using stricter rules.
 *
 * @param p_from The Variant type to convert from.
 * @param p_to The Variant type to convert to.
 *
 * @return true if the conversion is possible; otherwise false.
 */
InterfaceVariantCanConvertStrict :: proc "c" (p_from: VariantType, p_to: VariantType) -> Bool;

/**
 * @name get_variant_from_type_constructor
 * @since 4.1
 *
 * Gets a pointer to a function that can create a Variant of the given type from a raw value.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can create a Variant of the given type from a raw value.
 */
InterfaceGetVariantFromTypeConstructor :: proc "c" (p_type: VariantType) -> VariantFromTypeConstructorFunc;

/**
 * @name get_variant_to_type_constructor
 * @since 4.1
 *
 * Gets a pointer to a function that can get the raw value from a Variant of the given type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can get the raw value from a Variant of the given type.
 */
InterfaceGetVariantToTypeConstructor :: proc "c" (p_type: VariantType) -> TypeFromVariantConstructorFunc;

/**
 * @name variant_get_ptr_internal_getter
 * @since 4.4
 *
 * Provides a function pointer for retrieving a pointer to a variant's internal value.
 * Access to a variant's internal value can be used to modify it in-place, or to retrieve its value without the overhead of variant conversion functions.
 * It is recommended to cache the getter for all variant types in a function table to avoid retrieval overhead upon use.
 *
 * @note Each function assumes the variant's type has already been determined and matches the function.
 * Invoking the function with a variant of a mismatched type has undefined behavior, and may lead to a segmentation fault.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a type-specific function that returns a pointer to the internal value of a variant. Check the implementation of this function (gdextension_variant_get_ptr_internal_getter) for pointee type info of each variant type.
 */
InterfaceGetVariantGetInternalPtrFunc :: proc "c" (p_type: VariantType) -> VariantGetInternalPtrFunc

/**
 * @name variant_get_ptr_operator_evaluator
 * @since 4.1
 *
 * Gets a pointer to a function that can evaluate the given Variant operator on the given Variant types.
 *
 * @param p_operator The variant operator.
 * @param p_type_a The type of the first Variant.
 * @param p_type_b The type of the second Variant.
 *
 * @return A pointer to a function that can evaluate the given Variant operator on the given Variant types.
 */
InterfaceVariantGetPtrOperatorEvaluator :: proc "c" (p_operator: VariantOperator, p_type_a: VariantType, p_type_b: VariantType) -> PtrOperatorEvaluator;

/**
 * @name variant_get_ptr_builtin_method
 * @since 4.1
 *
 * Gets a pointer to a function that can call a builtin method on a type of Variant.
 *
 * @param p_type The Variant type.
 * @param p_method A pointer to a StringName with the method name.
 * @param p_hash A hash representing the method signature.
 *
 * @return A pointer to a function that can call a builtin method on a type of Variant.
 */
InterfaceVariantGetPtrBuiltinMethod :: proc "c" (p_type: VariantType, p_method: ConstStringNamePtr, p_hash: Int) -> PtrBuiltInMethod;

/**
 * @name variant_get_ptr_constructor
 * @since 4.1
 *
 * Gets a pointer to a function that can call one of the constructors for a type of Variant.
 *
 * @param p_type The Variant type.
 * @param p_constructor The index of the constructor.
 *
 * @return A pointer to a function that can call one of the constructors for a type of Variant.
 */
 InterfaceVariantGetPtrConstructor :: proc "c" (p_type: VariantType, p_constructor: i32) -> PtrConstructor;

/**
 * @name variant_get_ptr_destructor
 * @since 4.1
 *
 * Gets a pointer to a function than can call the destructor for a type of Variant.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function than can call the destructor for a type of Variant.
 */
InterfaceVariantGetPtrDestructor :: proc "c" (p_type: VariantType) -> PtrDestructor;

/**
 * @name variant_construct
 * @since 4.1
 *
 * Constructs a Variant of the given type, using the first constructor that matches the given arguments.
 *
 * @param p_type The Variant type.
 * @param p_base A pointer to a Variant to store the constructed value.
 * @param p_args A pointer to a C array of Variant pointers representing the arguments for the constructor.
 * @param p_argument_count The number of arguments to pass to the constructor.
 * @param r_error A pointer the structure which will be updated with error information.
 */
InterfaceVariantConstruct :: proc "c" (p_type: VariantType, r_base: ConstVariantPtr, p_args: ConstVariantPtrargs, p_argument_count: i32, r_error: ^CallError);

/**
 * @name variant_get_ptr_setter
 * @since 4.1
 *
 * Gets a pointer to a function that can call a member's setter on the given Variant type.
 *
 * @param p_type The Variant type.
 * @param p_member A pointer to a StringName with the member name.
 *
 * @return A pointer to a function that can call a member's setter on the given Variant type.
 */
InterfaceVariantGetPtrSetter :: proc "c" (p_type: VariantType, p_member: ConstStringNamePtr) -> PtrSetter;

/**
 * @name variant_get_ptr_getter
 * @since 4.1
 *
 * Gets a pointer to a function that can call a member's getter on the given Variant type.
 *
 * @param p_type The Variant type.
 * @param p_member A pointer to a StringName with the member name.
 *
 * @return A pointer to a function that can call a member's getter on the given Variant type.
 */
InterfaceVariantGetPtrGetter :: proc "c" (p_type: VariantType, p_member: ConstStringNamePtr) -> PtrGetter;

/**
 * @name variant_get_ptr_indexed_setter
 * @since 4.1
 *
 * Gets a pointer to a function that can set an index on the given Variant type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can set an index on the given Variant type.
 */
InterfaceVariantGetPtrIndexedSetter :: proc "c" (p_type: VariantType) -> PtrIndexedSetter;

/**
 * @name variant_get_ptr_indexed_getter
 * @since 4.1
 *
 * Gets a pointer to a function that can get an index on the given Variant type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can get an index on the given Variant type.
 */
InterfaceVariantGetPtrIndexedGetter :: proc "c" (p_type: VariantType) -> PtrIndexedGetter;

/**
 * @name variant_get_ptr_keyed_setter
 * @since 4.1
 *
 * Gets a pointer to a function that can set a key on the given Variant type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can set a key on the given Variant type.
 */
InterfaceVariantGetPtrKeyedSetter :: proc "c" (p_type: VariantType) -> PtrKeyedSetter;

/**
 * @name variant_get_ptr_keyed_getter
 * @since 4.1
 *
 * Gets a pointer to a function that can get a key on the given Variant type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can get a key on the given Variant type.
 */
InterfaceVariantGetPtrKeyedGetter :: proc "c" (p_type: VariantType) -> PtrKeyedGetter;

/**
 * @name variant_get_ptr_keyed_checker
 * @since 4.1
 *
 * Gets a pointer to a function that can check a key on the given Variant type.
 *
 * @param p_type The Variant type.
 *
 * @return A pointer to a function that can check a key on the given Variant type.
 */
InterfaceVariantGetPtrKeyedChecker :: proc "c" (p_type: VariantType) -> PtrKeyedChecker;

/**
 * @name variant_get_constant_value
 * @since 4.1
 *
 * Gets the value of a constant from the given Variant type.
 *
 * @param p_type The Variant type.
 * @param p_constant A pointer to a StringName with the constant name.
 * @param r_ret A pointer to a Variant to store the value.
 */
InterfaceVariantGetConstantValue :: proc "c" (p_type: VariantType, p_constant: ConstStringNamePtr, r_ret: UninitializedVariantPtr);

/**
 * @name variant_get_ptr_utility_function
 * @since 4.1
 *
 * Gets a pointer to a function that can call a Variant utility function.
 *
 * @param p_function A pointer to a StringName with the function name.
 * @param p_hash A hash representing the function signature.
 *
 * @return A pointer to a function that can call a Variant utility function.
 */
 InterfaceVariantGetPtrUtilityFunction :: proc "c" (p_function: ConstStringNamePtr, p_hash: Int) -> PtrUtilityFunction;

/* INTERFACE: String Utilities */


/**
 * @name string_new_with_latin1_chars
 * @since 4.1
 *
 * Creates a String from a Latin-1 encoded C string.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a Latin-1 encoded C string (null terminated).
 */
InterfaceStringNewWithLatin1Chars :: proc "c" (r_dest: UninitializedVariantPtr, p_contents: cstring);

/**
 * @name string_new_with_utf8_chars
 * @since 4.1
 *
 * Creates a String from a UTF-8 encoded C string.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-8 encoded C string (null terminated).
 */
InterfaceStringNewWithUtf8Chars :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring);

/**
 * @name string_new_with_utf16_chars
 * @since 4.1
 *
 * Creates a String from a UTF-16 encoded C string.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-16 encoded C string (null terminated).
 */
InterfaceStringNewWithUtf16Chars :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring);

/**
 * @name string_new_with_utf32_chars
 * @since 4.1
 *
 * Creates a String from a UTF-32 encoded C string.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-32 encoded C string (null terminated).
 */
InterfaceStringNewWithUtf32Chars :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring)

/**
 * @name string_new_with_wide_chars
 * @since 4.1
 *
 * Creates a String from a wide C string.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a wide C string (null terminated).
 */
InterfaceStringNewWithWideChars :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring)

/**
 * @name string_new_with_latin1_chars_and_len
 * @since 4.1
 *
 * Creates a String from a Latin-1 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a Latin-1 encoded C string.
 * @param p_size The number of characters (= number of bytes).
 */
InterfaceStringNewWithLatin1CharsAndLen :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_size: Int);

/**
 * @name string_new_with_utf8_chars_and_len
 * @since 4.1
 * @deprecated in Godot 4.3. Use `string_new_with_utf8_chars_and_len2` instead.
 *
 * Creates a String from a UTF-8 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-8 encoded C string.
 * @param p_size The number of bytes (not code units).
 */
InterfaceStringNewWithUtf8CharsAndLen :: proc "c" (r_dest: UninitializedStringPtr, p_contents: [^]u8, p_size: Int);

/**
 * @name string_new_with_utf8_chars_and_len2
 * @since 4.3
 *
 * Creates a String from a UTF-8 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-8 encoded C string.
 * @param p_size The number of bytes (not code units).
 *
 * @return Error code signifying if the operation successful.
 */
InterfaceStringNewWithUtf8CharsAndLen2 :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_size: Int) -> Int;

/**
 * @name string_new_with_utf16_chars_and_len
 * @since 4.1
 * @deprecated in Godot 4.3. Use `string_new_with_utf16_chars_and_len2` instead.
 *
 * Creates a String from a UTF-16 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-16 encoded C string.
 * @param p_size The number of characters (not bytes).
 */
InterfaceStringNewWithUtf16CharsAndLen :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_char_count: Int);

/**
 * @name string_new_with_utf16_chars_and_len2
 * @since 4.3
 *
 * Creates a String from a UTF-16 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-16 encoded C string.
 * @param p_size The number of characters (not bytes).
 * @param p_default_little_endian If true, UTF-16 use little endian.
 *
 * @return Error code signifying if the operation successful.
 */
InterfaceStringNewWithUtf16CharsAndLen2 :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_char_count: Int, p_default_little_endian: Bool) -> Int;

/**
 * @name string_new_with_utf32_chars_and_len
 * @since 4.1
 *
 * Creates a String from a UTF-32 encoded C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a UTF-32 encoded C string.
 * @param p_size The number of characters (not bytes).
 */
InterfaceStringNewWithUtf32CharsAndLen :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_char_count: Int);

/**
 * @name string_new_with_wide_chars_and_len
 * @since 4.1
 *
 * Creates a String from a wide C string with the given length.
 *
 * @param r_dest A pointer to a Variant to hold the newly created String.
 * @param p_contents A pointer to a wide C string.
 * @param p_size The number of characters (not bytes).
 */
InterfaceStringNewWithWideCharsAndLen :: proc "c" (r_dest: UninitializedStringPtr, p_contents: cstring, p_char_count: Int);

/**
 * @name string_to_latin1_chars
 * @since 4.1
 *
 * Converts a String to a Latin-1 encoded C string.
 *
 * It doesn't write a null terminator.
 *
 * @param p_self A pointer to the String.
 * @param r_text A pointer to the buffer to hold the resulting data. If NULL is passed in, only the length will be computed.
 * @param p_max_write_length The maximum number of characters that can be written to r_text. It has no affect on the return value.
 *
 * @return The resulting encoded string length in characters (not bytes), not including a null terminator.
 */
InterfaceStringToLatin1Chars :: proc "c" (p_self: ConstStringPtr, r_text: [^]u8, p_max_write_length: Int) -> Int;

/**
 * @name string_to_utf8_chars
 * @since 4.1
 *
 * Converts a String to a UTF-8 encoded C string.
 *
 * It doesn't write a null terminator.
 *
 * @param p_self A pointer to the String.
 * @param r_text A pointer to the buffer to hold the resulting data. If NULL is passed in, only the length will be computed.
 * @param p_max_write_length The maximum number of characters that can be written to r_text. It has no affect on the return value.
 *
 * @return The resulting encoded string length in characters (not bytes), not including a null terminator.
 */
InterfaceStringToUtf8Chars :: proc "c" (p_self: ConstStringPtr, r_text: [^]u8, p_max_write_length: Int) -> Int;

/**
 * @name string_to_utf16_chars
 * @since 4.1
 *
 * Converts a String to a UTF-16 encoded C string.
 *
 * It doesn't write a null terminator.
 *
 * @param p_self A pointer to the String.
 * @param r_text A pointer to the buffer to hold the resulting data. If NULL is passed in, only the length will be computed.
 * @param p_max_write_length The maximum number of characters that can be written to r_text. It has no affect on the return value.
 *
 * @return The resulting encoded string length in characters (not bytes), not including a null terminator.
 */
InterfaceStringToUtf16Chars :: proc "c" (p_self: ConstStringPtr, r_text: [^]u16, p_max_write_length: Int) -> Int;

/**
 * @name string_to_utf32_chars
 * @since 4.1
 *
 * Converts a String to a UTF-32 encoded C string.
 *
 * It doesn't write a null terminator.
 *
 * @param p_self A pointer to the String.
 * @param r_text A pointer to the buffer to hold the resulting data. If NULL is passed in, only the length will be computed.
 * @param p_max_write_length The maximum number of characters that can be written to r_text. It has no affect on the return value.
 *
 * @return The resulting encoded string length in characters (not bytes), not including a null terminator.
 */
InterfaceStringToUtf32Chars :: proc "c" (p_self: ConstStringPtr, r_text: [^]u32, p_max_write_length: Int) -> Int;

/**
 * @name string_to_wide_chars
 * @since 4.1
 *
 * Converts a String to a wide C string.
 *
 * It doesn't write a null terminator.
 *
 * @param p_self A pointer to the String.
 * @param r_text A pointer to the buffer to hold the resulting data. If NULL is passed in, only the length will be computed.
 * @param p_max_write_length The maximum number of characters that can be written to r_text. It has no affect on the return value.
 *
 * @return The resulting encoded string length in characters (not bytes), not including a null terminator.
 */
InterfaceStringToWideChars :: proc "c" (p_self: ConstStringPtr, r_text: [^]c.wchar_t, p_max_write_length: Int) -> Int;

/**
 * @name string_operator_index
 * @since 4.1
 *
 * Gets a pointer to the character at the given index from a String.
 *
 * @param p_self A pointer to the String.
 * @param p_index The index.
 *
 * @return A pointer to the requested character.
 */
InterfaceStringOperatorIndex :: proc "c" (p_self: StringPtr, p_index: Int) -> ^u32;

/**
 * @name string_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to the character at the given index from a String.
 *
 * @param p_self A pointer to the String.
 * @param p_index The index.
 *
 * @return A const pointer to the requested character.
 */
InterfaceStringOperatorIndexConst :: proc "c" (p_self: StringPtr, p_index: Int) -> ^u32

/**
 * @name string_operator_plus_eq_string
 * @since 4.1
 *
 * Appends another String to a String.
 *
 * @param p_self A pointer to the String.
 * @param p_b A pointer to the other String to append.
 */
InterfaceStringOperatorPlusEqString :: proc "c" (p_self: StringPtr, p_b: ConstStringPtr);

/**
 * @name string_operator_plus_eq_char
 * @since 4.1
 *
 * Appends a character to a String.
 *
 * @param p_self A pointer to the String.
 * @param p_b A pointer to the character to append.
 */
InterfaceStringOperatorPlusEqChar :: proc "c" (p_self: StringPtr, p_b: u32);

/**
 * @name string_operator_plus_eq_cstr
 * @since 4.1
 *
 * Appends a Latin-1 encoded C string to a String.
 *
 * @param p_self A pointer to the String.
 * @param p_b A pointer to a Latin-1 encoded C string (null terminated).
 */
InterfaceStringOperatorPlusEqCstr :: proc "c" (p_self: StringPtr, p_b: cstring);

/**
 * @name string_operator_plus_eq_wcstr
 * @since 4.1
 *
 * Appends a wide C string to a String.
 *
 * @param p_self A pointer to the String.
 * @param p_b A pointer to a wide C string (null terminated).
 */
InterfaceStringOperatorPlusEqWcstr :: proc "c" (p_self: StringPtr, p_b: cstring);

/**
 * @name string_operator_plus_eq_c32str
 * @since 4.1
 *
 * Appends a UTF-32 encoded C string to a String.
 *
 * @param p_self A pointer to the String.
 * @param p_b A pointer to a UTF-32 encoded C string (null terminated).
 */
InterfaceStringOperatorPlusEqC32str :: proc "c" (p_self: StringPtr, p_b: cstring);

/**
 * @name string_resize
 * @since 4.2
 *
 * Resizes the underlying string data to the given number of characters.
 *
 * Space needs to be allocated for the null terminating character ('\0') which
 * also must be added manually, in order for all string functions to work correctly.
 *
 * Warning: This is an error-prone operation - only use it if there's no other
 * efficient way to accomplish your goal.
 *
 * @param p_self A pointer to the String.
 * @param p_resize The new length for the String.
 *
 * @return Error code signifying if the operation successful.
 */
InterfaceStringResize :: proc "c" (p_self: StringPtr, p_resize: Int) -> Int;

/* INTERFACE: StringName Utilities */

/**
 * @name string_name_new_with_latin1_chars
 * @since 4.2
 *
 * Creates a StringName from a Latin-1 encoded C string.
 *
 * If `p_is_static` is true, then:
 * - The StringName will reuse the `p_contents` buffer instead of copying it.
 *   You must guarantee that the buffer remains valid for the duration of the application (e.g. string literal).
 * - You must not call a destructor for this StringName. Incrementing the initial reference once should achieve this.
 *
 * `p_is_static` is purely an optimization and can easily introduce undefined behavior if used wrong. In case of doubt, set it to false.
 *
 * @param r_dest A pointer to uninitialized storage, into which the newly created StringName is constructed.
 * @param p_contents A pointer to a C string (null terminated and Latin-1 or ASCII encoded).
 * @param p_is_static Whether the StringName reuses the buffer directly (see above).
 */
InterfaceStringNameNewWithLatin1Chars :: proc "c" (r_dest: UninitializedStringNamePtr, p_contents: cstring, p_is_static: Bool);

/**
 * @name string_name_new_with_utf8_chars
 * @since 4.2
 *
 * Creates a StringName from a UTF-8 encoded C string.
 *
 * @param r_dest A pointer to uninitialized storage, into which the newly created StringName is constructed.
 * @param p_contents A pointer to a C string (null terminated and UTF-8 encoded).
 */
InterfaceStringNameNewWithUtf8Chars :: proc "c" (r_dest: UninitializedStringNamePtr, p_contents: cstring);

/**
 * @name string_name_new_with_utf8_chars_and_len
 * @since 4.2
 *
 * Creates a StringName from a UTF-8 encoded string with a given number of characters.
 *
 * @param r_dest A pointer to uninitialized storage, into which the newly created StringName is constructed.
 * @param p_contents A pointer to a C string (null terminated and UTF-8 encoded).
 * @param p_size The number of bytes (not UTF-8 code points).
 */
InterfaceStringNameNewWithUtf8CharsAndLen :: proc "c" (r_dest: UninitializedStringNamePtr, p_contents: [^]u8, p_size: Int);

/* INTERFACE: XMLParser Utilities */

/**
 * @name xml_parser_open_buffer
 * @since 4.1
 *
 * Opens a raw XML buffer on an XMLParser instance.
 *
 * @param p_instance A pointer to an XMLParser object.
 * @param p_buffer A pointer to the buffer.
 * @param p_size The size of the buffer.
 *
 * @return A Godot error code (ex. OK, ERR_INVALID_DATA, etc).
 *
 * @see XMLParser::open_buffer()
 */
InterfaceXmlParserOpenBuffer :: proc "c" (p_instance: ObjectPtr, p_buffer: [^]u8, p_size: Int) -> Int;

/**
 * @name editor_help_load_xml_from_utf8_chars
 * @since 4.3
 *
 * Loads new XML-formatted documentation data in the editor.
 *
 * The provided pointer can be immediately freed once the function returns.
 *
 * @param p_data A pointer to a UTF-8 encoded C string (null terminated).
 */
InterfaceEditorHelpLoadXmlFromUtf8Chars :: proc "c" (p_data: cstring);

/**
 * @name editor_help_load_xml_from_utf8_chars_and_len
 * @since 4.3
 *
 * Loads new XML-formatted documentation data in the editor.
 *
 * The provided pointer can be immediately freed once the function returns.
 *
 * @param p_data A pointer to a UTF-8 encoded C string.
 * @param p_size The number of bytes (not code units).
 */
InterfaceEditorHelpLoadXmlFromUtf8CharsAndLen :: proc "c" (p_data: cstring, p_size: Int);


/**
 * @name editor_register_get_classes_used_callback
 * @since 4.5
 *
 * Registers a callback that Godot can call to get the list of all classes (from ClassDB) that may be used by the calling GDExtension.
 *
 * This is used by the editor to generate a build profile (in "Tools" > "Engine Compilation Configuration Editor..." > "Detect from project"),
 * in order to recompile Godot with only the classes used.
 * In the provided callback, the GDExtension should provide the list of classes that _may_ be used statically, thus the time of invocation shouldn't matter.
 * If a GDExtension doesn't register a callback, Godot will assume that it could be using any classes.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_callback The callback to retrieve the list of classes used.
 */
InterfaceEditorRegisterGetClassesUsedCallback :: proc "c" (p_library: ClassLibraryPtr, p_callback: EditorGetClassesUsedCallback);

/**
 * @name register_main_loop_callbacks
 * @since 4.5
 *
 * Registers callbacks to be called at different phases of the main loop.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_callbacks A pointer to the structure that contains the callbacks.
 */
InterfaceRegisterMainLoopCallbacks :: proc "c" (p_library: ClassLibraryPtr, p_callbacks: ^MainLoopCallbacks);

/* INTERFACE: FileAccess Utilities */

/**
 * @name file_access_store_buffer
 * @since 4.1
 *
 * Stores the given buffer using an instance of FileAccess.
 *
 * @param p_instance A pointer to a FileAccess object.
 * @param p_src A pointer to the buffer.
 * @param p_length The size of the buffer.
 *
 * @see FileAccess::store_buffer()
 */
InterfaceFileAccessStoreBuffer :: proc "c" (p_instance: ObjectPtr, p_src: [^]u8, p_length: u64);

/**
 * @name file_access_get_buffer
 * @since 4.1
 *
 * Reads the next p_length bytes into the given buffer using an instance of FileAccess.
 *
 * @param p_instance A pointer to a FileAccess object.
 * @param p_dst A pointer to the buffer to store the data.
 * @param p_length The requested number of bytes to read.
 *
 * @return The actual number of bytes read (may be less than requested).
 */
InterfaceFileAccessGetBuffer :: proc "c" (p_instance: ConstObjectPtr, p_dst: [^]u8, p_length: u64) -> u64;

/* INTERFACE: Image Utilities */

/**
 * @name image_ptrw
 * @since 4.3
 *
 * Returns writable pointer to internal Image buffer.
 *
 * @param p_instance A pointer to a Image object.
 *
 * @return Pointer to internal Image buffer.
 *
 * @see Image::ptrw()
 */
InterfaceImagePtrw :: proc "c" (p_instance: ObjectPtr) -> ^u8;

/**
 * @name image_ptr
 * @since 4.3
 *
 * Returns read only pointer to internal Image buffer.
 *
 * @param p_instance A pointer to a Image object.
 *
 * @return Pointer to internal Image buffer.
 *
 * @see Image::ptr()
 */
InterfaceImagePtr :: proc "c" (p_instance: ObjectPtr) -> ^u8;

/* INTERFACE: WorkerThreadPool Utilities */

/**
 * @name worker_thread_pool_add_native_group_task
 * @since 4.1
 *
 * Adds a group task to an instance of WorkerThreadPool.
 *
 * @param p_instance A pointer to a WorkerThreadPool object.
 * @param p_func A pointer to a function to run in the thread pool.
 * @param p_userdata A pointer to arbitrary data which will be passed to p_func.
 * @param p_tasks The number of tasks needed in the group.
 * @param p_high_priority Whether or not this is a high priority task.
 * @param p_description A pointer to a String with the task description.
 *
 * @return The task group ID.
 *
 * @see WorkerThreadPool::add_group_task()
 */
InterfaceWorkerThreadPoolAddNativeGroupTask :: proc "c" (p_instance: ObjectPtr, p_func : proc "c" (rawptr, u32), p_userdata: rawptr, p_elements: Int, p_tasks: int, p_high_priority: Bool, p_description: ConstStringPtr) -> i64;

/**
 * @name worker_thread_pool_add_native_task
 * @since 4.1
 *
 * Adds a task to an instance of WorkerThreadPool.
 *
 * @param p_instance A pointer to a WorkerThreadPool object.
 * @param p_func A pointer to a function to run in the thread pool.
 * @param p_userdata A pointer to arbitrary data which will be passed to p_func.
 * @param p_high_priority Whether or not this is a high priority task.
 * @param p_description A pointer to a String with the task description.
 *
 * @return The task ID.
 */
InterfaceWorkerThreadPoolAddNativeTask :: proc "c" (p_instance: ObjectPtr, p_func : proc "c" (rawptr), p_userdata: rawptr, p_high_priority: Bool, p_description: ConstStringPtr) -> i64;

/* INTERFACE: Packed Array */

/**
 * @name packed_byte_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a byte in a PackedByteArray.
 *
 * @param p_self A pointer to a PackedByteArray object.
 * @param p_index The index of the byte to get.
 *
 * @return A pointer to the requested byte.
 */
InterfacePackedByteArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> ^u8;

/**
 * @name packed_byte_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a byte in a PackedByteArray.
 *
 * @param p_self A const pointer to a PackedByteArray object.
 * @param p_index The index of the byte to get.
 *
 * @return A const pointer to the requested byte.
 */
InterfacePackedByteArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> ^u8;

/**
 * @name packed_float32_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a 32-bit float in a PackedFloat32Array.
 *
 * @param p_self A pointer to a PackedFloat32Array object.
 * @param p_index The index of the float to get.
 *
 * @return A pointer to the requested 32-bit float.
 */
InterfacePackedFloat32ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> f32;

/**
 * @name packed_float32_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a 32-bit float in a PackedFloat32Array.
 *
 * @param p_self A const pointer to a PackedFloat32Array object.
 * @param p_index The index of the float to get.
 *
 * @return A const pointer to the requested 32-bit float.
 */
InterfacePackedFloat32ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> ^f32;

/**
 * @name packed_float64_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a 64-bit float in a PackedFloat64Array.
 *
 * @param p_self A pointer to a PackedFloat64Array object.
 * @param p_index The index of the float to get.
 *
 * @return A pointer to the requested 64-bit float.
 */
InterfacePackedFloat64ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> f64;

/**
 * @name packed_float64_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a 64-bit float in a PackedFloat64Array.
 *
 * @param p_self A const pointer to a PackedFloat64Array object.
 * @param p_index The index of the float to get.
 *
 * @return A const pointer to the requested 64-bit float.
 */
InterfacePackedFloat64ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> f64;

/**
 * @name packed_int32_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a 32-bit integer in a PackedInt32Array.
 *
 * @param p_self A pointer to a PackedInt32Array object.
 * @param p_index The index of the integer to get.
 *
 * @return A pointer to the requested 32-bit integer.
 */
InterfacePackedInt32ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> i32;

/**
 * @name packed_int32_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a 32-bit integer in a PackedInt32Array.
 *
 * @param p_self A const pointer to a PackedInt32Array object.
 * @param p_index The index of the integer to get.
 *
 * @return A const pointer to the requested 32-bit integer.
 */
InterfacePackedInt32ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> i32;

/**
 * @name packed_int64_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a 64-bit integer in a PackedInt64Array.
 *
 * @param p_self A pointer to a PackedInt64Array object.
 * @param p_index The index of the integer to get.
 *
 * @return A pointer to the requested 64-bit integer.
 */
InterfacePackedInt64ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> i64;

/**
 * @name packed_int64_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a 64-bit integer in a PackedInt64Array.
 *
 * @param p_self A const pointer to a PackedInt64Array object.
 * @param p_index The index of the integer to get.
 *
 * @return A const pointer to the requested 64-bit integer.
 */
InterfacePackedInt64ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> i64;

/**
 * @name packed_string_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a string in a PackedStringArray.
 *
 * @param p_self A pointer to a PackedStringArray object.
 * @param p_index The index of the String to get.
 *
 * @return A pointer to the requested String.
 */
InterfacePackedStringArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> StringPtr;

/**
 * @name packed_string_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a string in a PackedStringArray.
 *
 * @param p_self A const pointer to a PackedStringArray object.
 * @param p_index The index of the String to get.
 *
 * @return A const pointer to the requested String.
 */
InterfacePackedStringArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> StringPtr;

/**
 * @name packed_vector2_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a Vector2 in a PackedVector2Array.
 *
 * @param p_self A pointer to a PackedVector2Array object.
 * @param p_index The index of the Vector2 to get.
 *
 * @return A pointer to the requested Vector2.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector2ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_vector2_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a Vector2 in a PackedVector2Array.
 *
 * @param p_self A const pointer to a PackedVector2Array object.
 * @param p_index The index of the Vector2 to get.
 *
 * @return A const pointer to the requested Vector2.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector2ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_vector3_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a Vector3 in a PackedVector3Array.
 *
 * @param p_self A pointer to a PackedVector3Array object.
 * @param p_index The index of the Vector3 to get.
 *
 * @return A pointer to the requested Vector3.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector3ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_vector3_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a Vector3 in a PackedVector3Array.
 *
 * @param p_self A const pointer to a PackedVector3Array object.
 * @param p_index The index of the Vector3 to get.
 *
 * @return A const pointer to the requested Vector3.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector3ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_vector4_array_operator_index
 * @since 4.3
 *
 * Gets a pointer to a Vector4 in a PackedVector4Array.
 *
 * @param p_self A pointer to a PackedVector4Array object.
 * @param p_index The index of the Vector4 to get.
 *
 * @return A pointer to the requested Vector4.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector4ArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_vector4_array_operator_index_const
 * @since 4.3
 *
 * Gets a const pointer to a Vector4 in a PackedVector4Array.
 *
 * @param p_self A const pointer to a PackedVector4Array object.
 * @param p_index The index of the Vector4 to get.
 *
 * @return A const pointer to the requested Vector4.
 * Using typePtr because the array could be holding float or int types
 */
InterfacePackedVector4ArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> TypePtr;

/**
 * @name packed_color_array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a color in a PackedColorArray.
 *
 * @param p_self A pointer to a PackedColorArray object.
 * @param p_index The index of the Color to get.
 *
 * @return A pointer to the requested Color.
 */
InterfacePackedColorArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> ^Color;

/**
 * @name packed_color_array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a color in a PackedColorArray.
 *
 * @param p_self A const pointer to a PackedColorArray object.
 * @param p_index The index of the Color to get.
 *
 * @return A const pointer to the requested Color.
 */
InterfacePackedColorArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> ^Color;

/**
 * @name array_operator_index
 * @since 4.1
 *
 * Gets a pointer to a Variant in an Array.
 *
 * @param p_self A pointer to an Array object.
 * @param p_index The index of the Variant to get.
 *
 * @return A pointer to the requested Variant.
 */
InterfaceArrayOperatorIndex :: proc "c" (p_self: TypePtr, p_index: Int) -> ^Variant;

/**
 * @name array_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a Variant in an Array.
 *
 * @param p_self A const pointer to an Array object.
 * @param p_index The index of the Variant to get.
 *
 * @return A const pointer to the requested Variant.
 */
InterfaceArrayOperatorIndexConst :: proc "c" (p_self: TypePtr, p_index: Int) -> ^Variant;

/**
 * @name array_ref
 * @since 4.1
 *
 * Sets an Array to be a reference to another Array object.
 *
 * @param p_self A pointer to the Array object to update.
 * @param p_from A pointer to the Array object to reference.
 */
InterfaceArrayRef :: proc "c" (p_self: TypePtr, p_from: TypePtr);

/**
 * @name array_set_typed
 * @since 4.1
 *
 * Makes an Array into a typed Array.
 *
 * @param p_self A pointer to the Array.
 * @param p_type The type of Variant the Array will store.
 * @param p_class_name A pointer to a StringName with the name of the object (if p_type is GDEXTENSION_VARIANT_TYPE_OBJECT).
 * @param p_script A pointer to a Script object (if p_type is GDEXTENSION_VARIANT_TYPE_OBJECT and the base class is extended by a script).
 */
InterfaceArraySetTyped :: proc "c" (p_self: TypePtr, p_type: VariantType, p_class_name: ConstStringNamePtr, p_script: VariantPtr);

/* INTERFACE: Dictionary */

/**
 * @name dictionary_operator_index
 * @since 4.1
 *
 * Gets a pointer to a Variant in a Dictionary with the given key.
 *
 * @param p_self A pointer to a Dictionary object.
 * @param p_key A pointer to a Variant representing the key.
 *
 * @return A pointer to a Variant representing the value at the given key.
 */
InterfaceDictionaryOperatorIndex :: proc "c" (p_self: TypePtr, p_key: VariantPtr) -> VariantPtr;

/**
 * @name dictionary_operator_index_const
 * @since 4.1
 *
 * Gets a const pointer to a Variant in a Dictionary with the given key.
 *
 * @param p_self A const pointer to a Dictionary object.
 * @param p_key A pointer to a Variant representing the key.
 *
 * @return A const pointer to a Variant representing the value at the given key.
 */
InterfaceDictionaryOperatorIndexConst :: proc "c" (p_self: TypePtr, p_key: VariantPtr) -> VariantPtr;

/**
 * @name dictionary_set_typed
 * @since 4.4
 *
 * Makes a Dictionary into a typed Dictionary.
 *
 * @param p_self A pointer to the Dictionary.
 * @param p_key_type The type of Variant the Dictionary key will store.
 * @param p_key_class_name A pointer to a StringName with the name of the object (if p_key_type is GDEXTENSION_VARIANT_TYPE_OBJECT).
 * @param p_key_script A pointer to a Script object (if p_key_type is GDEXTENSION_VARIANT_TYPE_OBJECT and the base class is extended by a script).
 * @param p_value_type The type of Variant the Dictionary value will store.
 * @param p_value_class_name A pointer to a StringName with the name of the object (if p_value_type is GDEXTENSION_VARIANT_TYPE_OBJECT).
 * @param p_value_script A pointer to a Script object (if p_value_type is GDEXTENSION_VARIANT_TYPE_OBJECT and the base class is extended by a script).
 */
InterfaceDictionarySetTyped :: proc "c" (p_self: TypePtr, p_key_type: VariantType, p_key_class_name: ConstStringNamePtr, p_key_script: ConstVariantPtr, p_value_type: VariantType, p_value_class_name: StringNamePtr, p_value_script: ConstVariantPtr);

/* INTERFACE: Object */

/**
 * @name object_method_bind_call
 * @since 4.1
 *
 * Calls a method on an Object.
 *
 * @param p_method_bind A pointer to the MethodBind representing the method on the Object's class.
 * @param p_instance A pointer to the Object.
 * @param p_args A pointer to a C array of Variants representing the arguments.
 * @param p_arg_count The number of arguments.
 * @param r_ret A pointer to Variant which will receive the return value.
 * @param r_error A pointer to a CallError struct that will receive error information.
 */
InterfaceObjectMethodBindCall :: proc "c" (p_method_bind: MethodBindPtr, p_instance: ObjectPtr, p_args: ConstVariantPtrargs, p_arg_count: Int, r_ret: UninitializedVariantPtr, r_error: ^CallError);

/**
 * @name object_method_bind_ptrcall
 * @since 4.1
 *
 * Calls a method on an Object (using a "ptrcall").
 *
 * @param p_method_bind A pointer to the MethodBind representing the method on the Object's class.
 * @param p_instance A pointer to the Object.
 * @param p_args A pointer to a C array representing the arguments.
 * @param r_ret A pointer to the Object that will receive the return value.
 */
InterfaceObjectMethodBindPtrcall :: proc "c" (p_method_bind: MethodBindPtr, p_instance: ObjectPtr, p_args: ConstTypePtrargs, r_ret: TypePtr);

/**
 * @name object_destroy
 * @since 4.1
 *
 * Destroys an Object.
 *
 * @param p_o A pointer to the Object.
 */
InterfaceObjectDestroy :: proc "c" (p_o: ObjectPtr);

/**
 * @name global_get_singleton
 * @since 4.1
 *
 * Gets a global singleton by name.
 *
 * @param p_name A pointer to a StringName with the singleton name.
 *
 * @return A pointer to the singleton Object.
 */
InterfaceGlobalGetSingleton :: proc "c" (p_name: StringNamePtr) -> ObjectPtr;

/**
 * @name object_get_instance_binding
 * @since 4.1
 *
 * Gets a pointer representing an Object's instance binding.
 *
 * @param p_o A pointer to the Object.
 * @param p_library A token the library received by the GDExtension's entry point function.
 * @param p_callbacks A pointer to a InstanceBindingCallbacks struct.
 *
 * @return
 */
InterfaceObjectGetInstanceBinding :: proc "c" (p_o: ObjectPtr, p_token: rawptr, p_callbacks: ^InstanceBindingCallbacks) -> rawptr;

/**
 * @name object_set_instance_binding
 * @since 4.1
 *
 * Sets an Object's instance binding.
 *
 * @param p_o A pointer to the Object.
 * @param p_library A token the library received by the GDExtension's entry point function.
 * @param p_binding A pointer to the instance binding.
 * @param p_callbacks A pointer to a InstanceBindingCallbacks struct.
 */
InterfaceObjectSetInstanceBinding :: proc "c" (p_o: ObjectPtr, p_token: rawptr, p_binding: rawptr, p_callbacks: ^InstanceBindingCallbacks);

/**
 * @name object_free_instance_binding
 * @since 4.2
 *
 * Free an Object's instance binding.
 *
 * @param p_o A pointer to the Object.
 * @param p_library A token the library received by the GDExtension's entry point function.
 */
InterfaceObjectFreeInstanceBinding :: proc "c" (p_o: ObjectPtr, p_token: rawptr);

/**
 * @name object_set_instance
 * @since 4.1
 *
 * Sets an extension class instance on a Object.
 *
 * @param p_o A pointer to the Object.
 * @param p_classname A pointer to a StringName with the registered extension class's name.
 * @param p_instance A pointer to the extension class instance.
 */
InterfaceObjectSetInstance :: proc "c" (p_o: ObjectPtr, p_classname: ConstStringNamePtr, p_instance: ClassInstancePtr); /* p_classname should be a registered extension class and should extend the p_o object's class. */

/**
 * @name object_get_class_name
 * @since 4.1
 *
 * Gets the class name of an Object.
 *
 * If the GDExtension wraps the Godot object in an abstraction specific to its class, this is the
 * function that should be used to determine which wrapper to use.
 *
 * @param p_object A pointer to the Object.
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param r_class_name A pointer to a String to receive the class name.
 *
 * @return true if successful in getting the class name; otherwise false.
 */
InterfaceObjectGetClassName :: proc "c" (p_object: ConstObjectPtr, p_library: ClassLibraryPtr, r_class_name: UninitializedStringNamePtr) -> Bool;

/**
 * @name object_cast_to
 * @since 4.1
 *
 * Casts an Object to a different type.
 *
 * @param p_object A pointer to the Object.
 * @param p_class_tag A pointer uniquely identifying a built-in class in the ClassDB.
 *
 * @return Returns a pointer to the Object, or NULL if it can't be cast to the requested type.
 */
InterfaceObjectCastTo :: proc "c" (p_object: ConstObjectPtr, p_class_tag: rawptr) -> ObjectPtr;

/**
 * @name object_get_instance_from_id
 * @since 4.1
 *
 * Gets an Object by its instance ID.
 *
 * @param p_instance_id The instance ID.
 *
 * @return A pointer to the Object.
 */
InterfaceObjectGetInstanceFromId :: proc "c" (p_instance_id: GDObjectInstanceID) -> ObjectPtr;

/**
 * @name object_get_instance_id
 * @since 4.1
 *
 * Gets the instance ID from an Object.
 *
 * @param p_object A pointer to the Object.
 *
 * @return The instance ID.
 */
InterfaceObjectGetInstanceId :: proc "c" (p_object: ConstObjectPtr) -> GDObjectInstanceID;

/**
 * @name object_has_script_method
 * @since 4.3
 *
 * Checks if this object has a script with the given method.
 *
 * @param p_object A pointer to the Object.
 * @param p_method A pointer to a StringName identifying the method.
 *
 * @returns true if the object has a script and that script has a method with the given name. Returns false if the object has no script.
 */
InterfaceObjectHasScriptMethod :: proc "c" (p_object: ConstObjectPtr, p_method: ConstStringNamePtr) -> Bool;

/**
 * @name object_call_script_method
 * @since 4.3
 *
 * Call the given script method on this object.
 *
 * @param p_object A pointer to the Object.
 * @param p_method A pointer to a StringName identifying the method.
 * @param p_args A pointer to a C array of Variant.
 * @param p_argument_count The number of arguments.
 * @param r_return A pointer a Variant which will be assigned the return value.
 * @param r_error A pointer the structure which will hold error information.
 */
InterfaceObjectCallScriptMethod :: proc "c" (p_object: ObjectPtr, p_method: ConstStringNamePtr, p_args: ConstVariantPtrargs, p_argument_count: Int, r_return: UninitializedVariantPtr, r_error: ^CallError);

/* INTERFACE: Reference */

/**
 * @name ref_get_object
 * @since 4.1
 *
 * Gets the Object from a reference.
 *
 * @param p_ref A pointer to the reference.
 *
 * @return A pointer to the Object from the reference or NULL.
 */
InterfaceRefGetObject :: proc "c" (p_ref: ConstRefPtr) -> ObjectPtr;

/**
 * @name ref_set_object
 * @since 4.1
 *
 * Sets the Object referred to by a reference.
 *
 * @param p_ref A pointer to the reference.
 * @param p_object A pointer to the Object to refer to.
 */
InterfaceRefSetObject :: proc "c" (p_ref: RefPtr, p_object: ObjectPtr);

/* INTERFACE: Script Instance */

/**
 * @name script_instance_create
 * @since 4.1
 * @deprecated in Godot 4.2. Use `script_instance_create3` instead.
 *
 * Creates a script instance that contains the given info and instance data.
 *
 * @param p_info A pointer to a ScriptInstanceInfo struct.
 * @param p_instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on p_info.
 *
 * @return A pointer to a ScriptInstanceExtension object.
 */
InterfaceScriptInstanceCreate :: proc "c" (p_info: ^ScriptInstanceInfo, p_instance_data: ScriptInstanceDataPtr) -> ScriptInstancePtr;

/**
 * @name script_instance_create2
 * @since 4.2
 * @deprecated in Godot 4.3. Use `script_instance_create3` instead.
 *
 * Creates a script instance that contains the given info and instance data.
 *
 * @param p_info A pointer to a ScriptInstanceInfo2 struct.
 * @param p_instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on p_info.
 *
 * @return A pointer to a ScriptInstanceExtension object.
 */
InterfaceScriptInstanceCreate2 :: proc "c" (p_info: ^ScriptInstanceInfo2, p_instance_data: ScriptInstanceDataPtr) -> ScriptInstancePtr;

/**
 * @name script_instance_create3
 * @since 4.3
 *
 * Creates a script instance that contains the given info and instance data.
 *
 * @param p_info A pointer to a ScriptInstanceInfo3 struct.
 * @param p_instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on p_info.
 *
 * @return A pointer to a ScriptInstanceExtension object.
 */
InterfaceScriptInstanceCreate3 :: proc "c" (p_info: ScriptInstanceInfo3, p_instance_data: ScriptInstanceDataPtr) -> ScriptInstancePtr;

/**
 * @name placeholder_script_instance_create
 * @since 4.2
 *
 * Creates a placeholder script instance for a given script and instance.
 *
 * This interface is optional as a custom placeholder could also be created with script_instance_create().
 *
 * @param p_language A pointer to a ScriptLanguage.
 * @param p_script A pointer to a Script.
 * @param p_owner A pointer to an Object.
 *
 * @return A pointer to a PlaceHolderScriptInstance object.
 */
InterfacePlaceHolderScriptInstanceCreate :: proc "c" (p_language: ObjectPtr, p_script: ObjectPtr, p_owner: ObjectPtr) -> ScriptInstancePtr;

/**
 * @name placeholder_script_instance_update
 * @since 4.2
 *
 * Updates a placeholder script instance with the given properties and values.
 *
 * The passed in placeholder must be an instance of PlaceHolderScriptInstance
 * such as the one returned by placeholder_script_instance_create().
 *
 * @param p_placeholder A pointer to a PlaceHolderScriptInstance.
 * @param p_properties A pointer to an Array of Dictionary representing PropertyInfo.
 * @param p_values A pointer to a Dictionary mapping StringName to Variant values.
 */
InterfacePlaceHolderScriptInstanceUpdate :: proc "c" (p_placeholder: ScriptInstancePtr, p_properties: TypePtr, p_values: TypePtr);

/**
 * @name object_get_script_instance
 * @since 4.2
 *
 * Get the script instance data attached to this object.
 *
 * @param p_object A pointer to the Object.
 * @param p_language A pointer to the language expected for this script instance.
 *
 * @return A ScriptInstanceDataPtr that was attached to this object as part of script_instance_create.
 */
InterfaceObjectGetScriptInstance :: proc "c" (p_object: ObjectPtr, p_language: ObjectPtr) -> ScriptInstanceDataPtr;


/**
 * @name object_set_script_instance
 * @since 4.5
 *
 * Set the script instance data attached to this object.
 *
 * @param p_object A pointer to the Object.
 * @param p_script_instance A pointer to the script instance data to attach to this object.
 */
InterfaceObjectSetScriptInstance :: proc "c" (p_object: ObjectPtr, p_script_instance: ScriptInstanceDataPtr);


/* INTERFACE: Callable */

/**
 * @name callable_custom_create
 * @since 4.2
 * @deprecated in Godot 4.3. Use `callable_custom_create2` instead.
 *
 * Creates a custom Callable object from a function pointer.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param r_callable A pointer that will receive the new Callable.
 * @param p_callable_custom_info The info required to construct a Callable.
 */
InterfaceCallableCustomCreate :: proc "c" (r_callable: UninitializedTypePtr, p_callable_custom_info: CallableCustomInfo);

/**
 * @name callable_custom_create2
 * @since 4.3
 *
 * Creates a custom Callable object from a function pointer.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param r_callable A pointer that will receive the new Callable.
 * @param p_callable_custom_info The info required to construct a Callable.
 */
InterfaceCallableCustomCreate2 :: proc "c" (r_callable: UninitializedTypePtr, p_callable_custom_info: ^CallableCustomInfo2);

/**
 * @name callable_custom_get_userdata
 * @since 4.2
 *
 * Retrieves the userdata pointer from a custom Callable.
 *
 * If the Callable is not a custom Callable or the token does not match the one provided to callable_custom_create() via CallableCustomInfo then NULL will be returned.
 *
 * @param p_callable A pointer to a Callable.
 * @param p_token A pointer to an address that uniquely identifies the GDExtension.
 */
InterfaceCallableCustomGetUserData :: proc "c" (p_callable: ConstTypePtr, p_token: rawptr) -> rawptr;

/* INTERFACE: ClassDB */

/**
 * @name classdb_construct_object
 * @since 4.1
 * @deprecated in Godot 4.4. Use `classdb_construct_object2` instead.
 *
 * Constructs an Object of the requested class.
 *
 * The passed class must be a built-in godot class, or an already-registered extension class. In both cases, object_set_instance() should be called to fully initialize the object.
 *
 * @param p_classname A pointer to a StringName with the class name.
 *
 * @return A pointer to the newly created Object.
 */
InterfaceClassdbConstructObject :: proc "c" (p_classname: ConstStringNamePtr) -> ObjectPtr;

/**
 * @name classdb_construct_object2
 * @since 4.4
 *
 * Constructs an Object of the requested class.
 *
 * The passed class must be a built-in godot class, or an already-registered extension class. In both cases, object_set_instance() should be called to fully initialize the object.
 *
 * "NOTIFICATION_POSTINITIALIZE" must be sent after construction.
 *
 * @param p_classname A pointer to a StringName with the class name.
 *
 * @return A pointer to the newly created Object.
 */
InterfaceClassdbConstructObject2 :: proc "c" (p_classname: ConstStringNamePtr) -> ObjectPtr;

/**
 * @name classdb_get_method_bind
 * @since 4.1
 *
 * Gets a pointer to the MethodBind in ClassDB for the given class, method and hash.
 *
 * @param p_classname A pointer to a StringName with the class name.
 * @param p_methodname A pointer to a StringName with the method name.
 * @param p_hash A hash representing the function signature.
 *
 * @return A pointer to the MethodBind from ClassDB.
 */
InterfaceClassdbGetMethodBind :: proc "c" (p_classname: ConstStringNamePtr, p_methodname: ConstStringNamePtr, p_hash: Int) -> MethodBindPtr;

/**
 * @name classdb_get_class_tag
 * @since 4.1
 *
 * Gets a pointer uniquely identifying the given built-in class in the ClassDB.
 *
 * @param p_classname A pointer to a StringName with the class name.
 *
 * @return A pointer uniquely identifying the built-in class in the ClassDB.
 */
InterfaceClassdbGetClassTag :: proc "c" (p_classname: ConstStringNamePtr) -> rawptr;

/* INTERFACE: ClassDB Extension */

/**
 * @name classdb_register_extension_class
 * @since 4.1
 * @deprecated in Godot 4.2. Use `classdb_register_extension_class4` instead.
 *
 * Registers an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_parent_class_name A pointer to a StringName with the parent class name.
 * @param p_extension_funcs A pointer to a ClassCreationInfo struct.
 */
InterfaceClassdbRegisterExtensionClass :: proc "c" (p_library: ClassLibraryPtr,  p_class_name: ConstStringNamePtr, p_parent_class_name: ConstStringNamePtr, p_extension_funcs: [^]ClassCreationInfo);

/**
 * @name classdb_register_extension_class2
 * @since 4.2
 * @deprecated in Godot 4.3. Use `classdb_register_extension_class4` instead.
 *
 * Registers an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_parent_class_name A pointer to a StringName with the parent class name.
 * @param p_extension_funcs A pointer to a ClassCreationInfo2 struct.
 */
InterfaceClassdbRegisterExtensionClass2 :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_parent_class_name: ConstStringNamePtr, p_extension_funcs: [^]ClassCreationInfo2);

/**
 * @name classdb_register_extension_class3
 * @since 4.3
 * @deprecated in Godot 4.4. Use `classdb_register_extension_class4` instead.
 *
 * Registers an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_parent_class_name A pointer to a StringName with the parent class name.
 * @param p_extension_funcs A pointer to a ClassCreationInfo2 struct.
 */
InterfaceClassdbRegisterExtensionClass3 :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_parent_class_name: ConstStringNamePtr, p_extension_funcs: [^]ClassCreationInfo3);

/**
 * @name classdb_register_extension_class4
 * @since 4.4
 * @deprecated in Godot 4.5. Use `classdb_register_extension_class5` instead.
 *
 * Registers an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_parent_class_name A pointer to a StringName with the parent class name.
 * @param p_extension_funcs A pointer to a ClassCreationInfo2 struct.
 */
InterfaceClassdbRegisterExtensionClass4 :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_parent_class_name: ConstStringNamePtr, p_extension_funcs: [^]ClassCreationInfo4);

/**
 * @name classdb_register_extension_class5
 * @since 4.5
 *
 * Registers an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_parent_class_name A pointer to a StringName with the parent class name.
 * @param p_extension_funcs A pointer to a ClassCreationInfo2 struct.
 */
InterfaceClassdbRegisterExtensionClass5 :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_parent_class_name: ConstStringNamePtr, p_extension_funcs: [^]ClassCreationInfo5);

/**
 * @name classdb_register_extension_class_method
 * @since 4.1
 *
 * Registers a method on an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_method_info A pointer to a ClassMethodInfo struct.
 */
InterfaceClassdbRegisterExtensionClassMethod :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_method_info: [^]ClassMethodInfo);

/**
 * @name classdb_register_extension_class_virtual_method
 * @since 4.3
 *
 * Registers a virtual method on an extension class in ClassDB, that can be implemented by scripts or other extensions.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_method_info A pointer to a ClassMethodInfo struct.
 */
InterfaceClassdbRegisterExtensionClassVirtualMethod :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_method_info: [^]ClassVirtualMethodInfo);

/**
 * @name classdb_register_extension_class_integer_constant
 * @since 4.1
 *
 * Registers an integer constant on an extension class in the ClassDB.
 *
 * Note about registering bitfield values (if p_is_bitfield is true): even though p_constant_value is signed, language bindings are
 * advised to treat bitfields as uint64_t, since this is generally clearer and can prevent mistakes like using -1 for setting all bits.
 * Language APIs should thus provide an abstraction that registers bitfields (uint64_t) separately from regular constants (int64_t).
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_enum_name A pointer to a StringName with the enum name.
 * @param p_constant_name A pointer to a StringName with the constant name.
 * @param p_constant_value The constant value.
 * @param p_is_bitfield Whether or not this constant is part of a bitfield.
 */
InterfaceClassdbRegisterExtensionClassIntegerConstant :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_enum_name: ConstStringNamePtr, p_constant_name: ConstStringNamePtr, p_constant_value: Int, p_is_bitfield: Bool);

/**
 * @name classdb_register_extension_class_property
 * @since 4.1
 *
 * Registers a property on an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_info A pointer to a PropertyInfo struct.
 * @param p_setter A pointer to a StringName with the name of the setter method.
 * @param p_getter A pointer to a StringName with the name of the getter method.
 */
InterfaceClassdbRegisterExtensionClassProperty :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_info: ^PropertyInfo, p_setter: ConstStringNamePtr, p_getter: ConstStringNamePtr);

/**
 * @name classdb_register_extension_class_property_indexed
 * @since 4.2
 *
 * Registers an indexed property on an extension class in the ClassDB.
 *
 * Provided struct can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_info A pointer to a PropertyInfo struct.
 * @param p_setter A pointer to a StringName with the name of the setter method.
 * @param p_getter A pointer to a StringName with the name of the getter method.
 * @param p_index The index to pass as the first argument to the getter and setter methods.
 */
InterfaceClassdbRegisterExtensionClassPropertyIndexed :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_info: ^PropertyInfo, p_setter: ConstStringNamePtr, p_getter: ConstStringNamePtr, p_index: Int);

/**
 * @name classdb_register_extension_class_property_group
 * @since 4.1
 *
 * Registers a property group on an extension class in the ClassDB.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_group_name A pointer to a String with the group name.
 * @param p_prefix A pointer to a String with the prefix used by properties in this group.
 */
InterfaceClassdbRegisterExtensionClassPropertyGroup :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_group_name: ConstStringPtr, p_prefix: ConstStringPtr);

/**
 * @name classdb_register_extension_class_property_subgroup
 * @since 4.1
 *
 * Registers a property subgroup on an extension class in the ClassDB.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_subgroup_name A pointer to a String with the subgroup name.
 * @param p_prefix A pointer to a String with the prefix used by properties in this subgroup.
 */
InterfaceClassdbRegisterExtensionClassPropertySubgroup :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_subgroup_name: ConstStringPtr, p_prefix: ConstStringPtr);

/**
 * @name classdb_register_extension_class_signal
 * @since 4.1
 *
 * Registers a signal on an extension class in the ClassDB.
 *
 * Provided structs can be safely freed once the function returns.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 * @param p_signal_name A pointer to a StringName with the signal name.
 * @param p_argument_info A pointer to a PropertyInfo struct.
 * @param p_argument_count The number of arguments the signal receives.
 */
InterfaceClassdbRegisterExtensionClassSignal :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr, p_signal_name: ConstStringNamePtr, p_argument_info: ^PropertyInfo, p_argument_count: Int);

/**
 * @name classdb_unregister_extension_class
 * @since 4.1
 *
 * Unregisters an extension class in the ClassDB.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param p_class_name A pointer to a StringName with the class name.
 */
InterfaceClassdbUnregisterExtensionClass :: proc "c" (p_library: ClassLibraryPtr, p_class_name: ConstStringNamePtr); /* Unregistering a parent class before a class that inherits it will result in failure. Inheritors must be unregistered first. */

/**
 * @name get_library_path
 * @since 4.1
 *
 * Gets the path to the current GDExtension library.
 *
 * @param p_library A pointer the library received by the GDExtension's entry point function.
 * @param r_path A pointer to a String which will receive the path.
 */
InterfaceGetLibraryPath :: proc "c" (p_library: ClassLibraryPtr, r_path: UninitializedStringPtr);

/**
 * @name editor_add_plugin
 * @since 4.1
 *
 * Adds an editor plugin.
 *
 * It's safe to call during initialization.
 *
 * @param p_class_name A pointer to a StringName with the name of a class (descending from EditorPlugin) which is already registered with ClassDB.
 */
InterfaceEditorAddPlugin :: proc "c" (p_class_name: ConstStringNamePtr);

/**
 * @name editor_remove_plugin
 * @since 4.1
 *
 * Removes an editor plugin.
 *
 * @param p_class_name A pointer to a StringName with the name of a class that was previously added as an editor plugin.
 */
InterfaceEditorRemovePlugin :: proc "c" (p_class_name: ConstStringNamePtr);