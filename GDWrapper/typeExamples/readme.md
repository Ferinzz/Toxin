Trying to reverse engineer the type system for variants. 

For all of the types which are not dynamically allocated you can more or less freely convert these to and from variant. These aren't ref counted, but to/from variant is thread safe through Godot.

	/*  atomic types */
	BOOL,
	INT,
	FLOAT,

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

	/* misc types */
	COLOR,

These are not ref counted and don't have a destructor but since they don't fit in 128bits Godot will allocate memory to a bucket. Use the variant_to variant_from functions for these and DESTROY WHEN DONE.
	PLANE,
	QUATERNION,
	AABB,
	BASIS,
	TRANSFORM3D,
	PROJECTION,
	NODE_PATH,
	RID,
	OBJECT,

If you have allocated memory left IN BUCKETS at exit it will log a warning about this. See type list here -> https://github.com/godotengine/godot/blob/45fc515ae3574e9c1f9deacaa6960dec68a7d38b/core/variant/variant.cpp#L1385

Anything less than 128 bits will fit directly into the variant's memory. Anything larger will be a pointer to the memory bucket that Godot Manages. (There is a spinlock on this, so would signify thread safety needed.)
For float you can get it by doing cast(f64)variant.data[0]
For rect2 all the data fits in 128, so you just transmute to the correct layout transmute([4]f32)variant.data[:]
For TRANSFORM2D do not get the data directly. Use the variant_to function to copy it into your scope.


The variant types which will need to be created/destroyed by Godot itself are below. Use the correct Godot constructor for them or there will be issues..`
	/* others */
	STRING_NAME,
	STRING,
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

Get the constructor when loading the API via InterfaceVariantGetPtrConstructor. Specify the index, because the constructors are often overloaded. See arrayhelper for examples.

Don't do this. This isn't thread safe.
You can actually get the pointer to the array if you look into variant.data[1] as if it were an array of pointers. should be something that looks a bit messy (((cast(^[4]^[x]T)uninitptr.data[1]))[3])

It also doesn't provide the array length as it passes it via a variant. Meaning you'll need to bind to a built-in method to get that information. Best do this than do any kind of pointer arithmatic since that wouldn't be thread safe.

Make yourself a variable to hold the pointer
packedf32size: GDE.PtrBuiltInMethod,
At runtime you'll need to bind it by specifying the built-in name, the method name, and method hash.
    arrayClass:= new(GDE.StringName)
    GDW.stringconstruct.stringNameNewLatin(&arrayClass, "PackedFloat32Array", false)
    arraySize:= new(GDE.StringName)
    GDW.stringconstruct.stringNameNewLatin(&arraySize, "size", false)
    GDW.arrayhelp.packedf32size = GDW.api.builtinMethodBindCall(.PACKED_FLOAT32_ARRAY, &arraySize, 3173160232)

Then you can use it.
GDW.arrayhelp.packedf32size(&uninitptr.data, nil, &returnedSize, 0)
(Don't forget to delete the stringName)

Debug mode :
Shows that when using create0 it initializes to 0x0000 for everything.
Seemingly goes through allocation steps before immediately destroying the vector and cowdata because the ref count is at 0... Everything which reaches ref count 0 is deallocated.
Beginning with append seems to work fine.

Godot being Copy on Write means that you probably don't need to worry about updating an array and it affecting other places which are reading it.. But it also means that memory will be fragmented based on various lifetimes.

If you try to allocate something with ref count 0 it will just break... Don't build your own arrays!! When Godot deallocates memory it will do this on its own. If it tries to deallocate memory assigned by our Odin code there will be issues in the heap.

The variant doesn't hold the array directly, it holds a pointer to the ref count class for it. Which itself holds a pointer to the array data.

Below is my descent into madness as I attempted to understand the memory layout and where it could be keeping that size value.


When you do a type to variant it takes those two values, casts the p_value to a variant??? starts the memnew_placement method. Then somehow reaches 
variant.cpp line 2555
Variant::Variant(const PackedFloat32Array &p_float32_array) :
		type(PACKED_FLOAT32_ARRAY) {
	_data.packed_array = PackedArrayRef<float>::create(p_float32_array);
}
p_float_array is a type with the size of the array as the first argument and the array raw data continuing it.
Seems like to address the size issue we will need our array format to be 
ref count at [0]u64
size at [1]u64
rawdata begins at [2]T
with 1 being offset based on the type. If <64b will need to offset by one additional location.
"This" at this point is the dest variant.

But this is actually supposed to use a packedarrayref<T> so my rawdata array gets mangled at the memnew step??? It's supposed to take a size and const char *p_description.
p_description is mangled size becomes 32. Which is size of the struct we're in? Probably?

malloc does some stuff and returns a new address.

Confirmed pretty much everything I think.

The address that you should give to Godot's array methods is 2xu64 to the right of where the array begins. The first 128bits of the memory should be reserved for ref count and size.

Use the packed*array type with the helper methods. Get, set, resize etc. Don't modify it directly.

The pointer that Godot will provide to you is set at the beginning of the data, which is 64bits to the right of where you can get the size.

Godot does multiple size checks for a single simple change. Try to avoid relying on Godot too much if you won't want that. It isn't technically thread safe to read directly, but also because of CoW nothing should be writing into an array, only reading.

The variant doesn't hold the array directly. It will hold a pointer to a struct that manages the ref count which also holds the array pointer.

Keep in mind that Godot expects arrays to be copy on write. The moment you make any change to the array it will cause a malloc and the variant within that instance will be pointing to the new memory address? Meaning once you make a change to the array you should consider all other references to the array you received out of sync. (This sounds like a mess which could cause a bunch of weird out of sync bugs? o.O)
I should see if the same variant is passed through different instances.. Maybe if one is updated to the new array address they can all be updated? Though I assume each variant is created uniquely, which is why you need the ref count to begin with.

If it needs to delete previous iterations of the arrays, how does it know to delete the original when using built-in methods? :thinking: Might need to document what the create functions actually do.
--Testing : Use Create0 to build a i64 array.
--Result : For some reason goes from create immediately to destroy. Likely be because there is no refCount and it starts with a count of 0.

--Testing : Use create 1 to build a i64 array. This takes the destination pointer and a source array to populate our struct with a pointer to the prev array.
--Result : It needs to check the refCounter to increment. As this was not initialized it will take a "random" point in memory.

Conclusion : DO NOT use the built-ins' create functions to create arrays from empty types. They will not update the required refCounter and as a result create an array ref 0, which is immediately deleted.

cowData shows a memory layout with
refcounter u64 :: size u64 :: data [^]T
Have I just been lucky that the ref count is 0? Though I feel like I've seen it get messed up before. Meaning the array I should be building needs another X in size to make sure it doesn't accidentally get random memory? No, because part of the process to make a variant os to make the ref count. Meaning Godot expects the original array's memory to be owned by the source creator.

You can't work with Varirants directly to do set actions because the method for that requires the packed*array type. The struct with the poitner to the array data as the second variable.

So the ref counter is to track the specific variant itself.?

Theory : A side effect of forced copy on write is that if you make updates through a variant and want to send that back you'd end up needing to make two copies.

If you have allocated memory left IN BUCKETS at exit it will log a warning about this. See type list here -> https://github.com/godotengine/godot/blob/45fc515ae3574e9c1f9deacaa6960dec68a7d38b/core/variant/variant.cpp#L1385

Packed arrays don't get a warning though.

2690185007928
    2725B859338

2725B859328
2690185007912

	16

address of 1:  0x219CF52C618
address of 1: (size) 0x219CF52C5F8
 0x000000225c7fbee0

location of data? 0x00000190928f6258 ??

returned ref count 0x00000190928f6248

long long?

sizeincluded array 0x0000015dbbf41cb8

address of 1:  0x15DBBF41CD8
address of 1: ([0]) 0x15DBBF41CB8

p_value changed when arriving to the memnew function?
0x0000004ce1ffc290

new set of malloc memory for the ref struct? 0x0000015dbbf42470

ptr used in the ref count is from the data pointer 0x15DBBF41CD8

ref returns 15dbbf41cc8

ref count is 16 bytes to the left of data?

This is in CoWdata... This is what I was missing.

	// Alignment:  ↓ max_align_t           ↓ USize          ↓ max_align_t
	//             ┌────────────────────┬──┬─────────────┬──┬───────────...
	//             │ SafeNumeric<USize> │░░│ USize       │░░│ T[]
	//             │ ref. count         │░░│ data size   │░░│ data
	//             └────────────────────┴──┴─────────────┴──┴───────────...
	// Offset:     ↑ REF_COUNT_OFFSET      ↑ SIZE_OFFSET    ↑ DATA_OFFS

	static constexpr size_t REF_COUNT_OFFSET = 0;
	static constexpr size_t SIZE_OFFSET = ((REF_COUNT_OFFSET + sizeof(SafeNumeric<USize>)) % alignof(USize) == 0) ? (REF_COUNT_OFFSET + sizeof(SafeNumeric<USize>)) : ((REF_COUNT_OFFSET + sizeof(SafeNumeric<USize>)) + alignof(USize) - ((REF_COUNT_OFFSET + sizeof(SafeNumeric<USize>)) % alignof(USize)));
	static constexpr size_t DATA_OFFSET = ((SIZE_OFFSET + sizeof(USize)) % alignof(max_align_t) == 0) ? (SIZE_OFFSET + sizeof(USize)) : ((SIZE_OFFSET + sizeof(USize)) + alignof(max_align_t) - ((SIZE_OFFSET + sizeof(USize)) % alignof(max_align_t)));


(SafeNumeric<USize> *)((uint8_t *)_ptr - DATA_OFFSET + REF_COUNT_OFFSET);