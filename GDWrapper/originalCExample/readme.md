This is a small project just to test making my own bindings.
The goal is to complete the gdextension C tutorial to get a minimum functioning godot extension compiled through Odin.

There's one dependency on core:c so that you can get a c.int for memory alignment. Though even that might not be completely necessary. Need to figure out where Godin got the info to set the enum sizes so I can know what to do myself in the future.

After going through the tutorial a few things stand out to me.
1. Most likely due to C's limited standards around a lot of types and function pointers it assumes you need to make a ton of wrappers on everything instead of just passing a function pointer.
2. With Odin's polymorhpism I can likely create a bunch of functions at compilation based on the criteria of the function.
3. 95% of their pointer types are just rawpointers. But their names help ident if it's used as a return value, setter, getter, source. At least that's the theory with the uninit keyword.
4. There's some things that are created and then immediately deleted. Mainly when working with the binding operators. As this is the case I can likely use a temp allocator.
-Exception would be if I set the buffer for the string as static.
5. It doesn't specify if the mem_alloc and string creation is being done on the Godot side or if it's created in the memory of our shared lib.
-how safe is it to destroy those c++ strings via my own temp allocator?
-Does Godot rely on those string pointers, or is it just for the library side?
-based on latest implementation I can replace it with Odin's new/free in the cases I've used so far.
-If I set it as static it means that I can own the memory.
6. Things really start to get mixed up when there's a ton of 'nonsense' functions. There's several individual steps to create and bind stuff to Godot as well as REQUIRED get and set functions.
7. 'public' variables cannot be set in the editor without getters and setters. Maybe for some more exotic custom types it can feel right, but for basic types it feels weird.
-They have no control of the compiler that the extension uses, so it makes sense to require that this be handled on the dest side.
8. When you're setting the package name on every variable it feels very very redundent to have GDExtension pre-pended to every single everything.
-I get it if in other languages the default is not to require package/header names.
9. The names... Duuuuude. Even without the prepended GDExtension the names are just insane. This makes typing very error prone and some keywords get lost in the sauce.
-GDExtensionInterfaceStringNewWithLatin1Chars
-GDExtensionInterfaceStringWithLatin1Chars
-This is an actual thing that you might have to write at least once.
--variantGetPtrOperatorEvaluator: GDE.GDExtensionInterfaceVariantGetPtrOperatorEvaluator = cast(GDE.GDExtensionInterfaceVariantGetPtrOperatorEvaluator)p_get_proc_address("variant_get_ptr_operator_evaluator")
10. Variants are a custom type that Godot uses. The docs express pride in the fact that all their variables can fit in 24Byte of data but... That's a significant portion of a lane of CPU cache. Avoid at all cost?
11. Since so much needs to be passed to Godot via pointers I need to be careful about leaving any dangling pointers around. They could cause a segfault or point to memory used by something else. Preferrable keep pointers within specific scope on a stack so that they can be destroyed.
-Usual pointer caution should be performed.
--Do not point to arrays longterm
--Do not point to something when you don't know the lifetime
--Careful not to take a pointer of something passed by copy (Odin default is pass by immutable reference. Phew.)
12. Only a few of the string_creating functions gets the optimization option to re-use the same cstring source. Weird.
13. Error messages are lacking if the library causes the crash. Maybe a build option in Odin could provide more verbose debugging.
-Will need to build Godot from source to be able to add breakpoints that can go into the engine code.
14. Should consider adding more debug flags from the beginning when writing these things. So many println, and it's not all that difficult to mark this stuff in Odin.
15. some of the naming is a bit too specific. There's only GDExtensionClassMethodArgumentMetadata for classes. Arguments would only be part of methods? So just argsMetadata would be enough. Maybe helps searchability? Look for classmethod to get all the related api optoins. But then just add it as a comment or group it based on that.
16. StringName is not exactly a string. It's the conversion of a string to what is effectively a unique pointer to an object. So maybe we can't have a single function which creates stuff via polymorphism. Not without generating the unique StringNames for them as well.
-would like to know how this formats the string into something unique. Does it add some class specific denommers? (Wait denommer is a uniquely French word? Huh.)
17. Personal skill issue? I hate using the term self. As much as 'this'. It feels confusing. I know it's supposed to mean the thing in this scope, but why does it always have to be so generic? If I'm 50 lines deep I feel like I lose track of what "self" is. When you start nesting this with that with the other thing, how do you keep track which this you're talking about? GDexampleptr: ^GDExample. ClassObjPtr: ^pointerToYourClass.
18. There are 4!!! different build modes for Godot that can have different type sizes for the base types and the special Godot types.
-float_32
-float_64
-double_32
-double_64
Fucking fuck fuck. Bloody fuck.
If you need to lood for type size info in the json you're looking for the line "name": "StringName", otherwise you're gonna get the type as an argument from methods.
19. Methods have their hash value in the json. If you don't want to deal with the allocation cost of StringName you canmaybe use the hash value passed in the V2 version GDExtensionClassGetVirtualCallData2. Worth testing.
-Could have a preprocessor go through and update a bunch of stuff in the source files based on the json before compiling? Not sure if there's some compiler time way to insert those things based on the json info. This thing needs ANYTHING to save time on tedious comparisons.
20. Should assert that stringnames are correct. Somehow. Godot will silently pass over the ERROR: Parameter "mb" is null. and still run. Happened because of an incorrect cstring.
-yet another reason to have this filled in programatically when possible.
21. Every single time you interact with Godot variable you're converting variants to or from normal types. A simple get function has you converting your f64 to a variant. I guess this is why it doesn't know how to simply read from a pointer.
22. Odin is a strongly typed language. So if you don't make a version of your proc to handle all the different variations of types that Godot could use your program may crash the second a different build mode is used. "Well it runs on my system!"


It seems like to best utilize this system it may be beneficial to focus on making specific extensions which focus on handling specific aspects of the game. Will also need to be careful about when it actually runs its functions since the editor itself is the engine and will load/run everything from the extensions on its own.

Hopefully in the engine docs it will provide a bit more details about the memory usage of things. I needed to lookup some details in the godin repo for a specific struct because that caused a crash when memory wasn't aligned.

A ton of work could be done simply with building tests to ensure the memory used remains aligned and to parse throught the massive json file that's meant to be used as a reference for that.

All in all, once you get through the tutorial you at least have the minimum wrappers in C to setup a class with variables, getters, setters, signals and able to run on each tick.

Odin strong points
1. All proc declarations are pointers.
2. You can cast anything to and from a rawptr.
3. Slices. They're already helpful to change to a multi-pointer. I feel like I'm still getting it a bit wrong on a few attempts.
4. VERY easy to take everything out of a main column and separate it into packages.
5. Cast to a specific proc is as easy as copying the same declaration as a cast. function: proc "c" (rawptr, f64) = cast(proc "c" (rawptr, f64))method_userdata
6. OLS and compiler errors are very good at telling you what's wrong with the types.
7. There are a bunch of procs to handle vector math and matrices. But they require specific types... So if Godot build changes the type of Vect2 we need the function on Odin's side to adapt.
8. You can start with everything in a single file if you want to. That's how I started it.

----------------------------------------------

How Godot bindings need to be done. I've left a bunch of console prints in the code, so you can reference where those are. Recommend checking the build.cmd to see how to run Godot via console and modify as needed. There's a few simple steps that get tedious after a while. Will also generate the original header and json files.
Keep in mind there are custom types for Godot. Not 100% certain it is always required to use the, but always best to ensure memory is aligned between our code and Godot
So far there has been their own String, StringName. Create these in a Definition file to keep it safely tucked away.


Name of entry point declared in the gdextension file. The entry name needs to match exactly. Set as export so that it's visible.
In theory if the file allowed us to declare variable they could have a way to pickup those variables through the gdextension file. See any dlib docs.

On startup Godot's editor will attempt to run that function and pass in a few pointers : p_get_proc_address : GDE.InterfaceGetProcAddress, p_library: GDE.GDExtensionClassLibraryPtr, r_initialization: ^GDE.GDExtensionInitialization
-library needs to be stored in the dlib that's being loaded.
-r_init.. needs to receive function pointers to init and deinit functions as well as receive declaration of when it is expected to run.
-proc_address is a pointer into Godot that allows you to get the function pointers in Godot runtime. Used to bind all the API functions for the wrapper.

Godot will run the init function assigned to r_init once when the editor runs.

init function (not to be confused with the entry point function) is where you declare all our class information. Name, parent, inheritance, icon etc.
-This is not where you are likely going to spell out all the 'public' class variables and functions (methods)
--You will undersand why I have 'public' in quotes later on.
-You will need to pass a create and a free function pointer in the struct. Lucky for us Odin procs are pointers by default.
--more about the create later.

Once the class is registered you should see it in the Godot docs. Even if it's not searchable in the node section it is likely present in the docs.
//While it's not in the order of functionality, having the create function before adding all the methods is probs best. I'd recommend following the Docs order on this and add the create function Right Now.
//Probably should also make the constructor and destructor functions as well.


Now you can start all the binding of methods and properties. (still not 100% if you can't expose a variable directly. Pointers isn't a type in GDscript.)

Before doing that, set some variables you'll want to use.
YOU MUST CREATE A GETTER AND A SETTER FUNCTION IF YOU WANT TO USE IT IN THE EDITOR.

In the example there's just two variables and a signal (not set at the time of writing)
So two variables will spawn 4 functions. Ew.
For each function signature you will need to create a pointer to a call function and a call function respectively.
-based on logging, the call function is sent by the editor.
-I haven't seen print from the pointer call work yet. Might be for use across classes?
-GDsript from within the gdexample node uses the call and not the point call.

Once you've written the Odin code variable + getter + setter and setup some wrappers to handle both types of function signatures start the binding process.

For the following keep in mind that propertyinfo is used to hold variable data and methodinfo holds information useful for the method signature and the method pointer itself

Start with the Method, then once the getter and setter are bound bind the property. (haven't tested the reverse error, but there is an error thrown if you tell Godot to use a getter/setter that does not exist.)
To bind a method you will likely need a different method bind per argument numbers. Mainly because of the need to create specifically sized arrays, which can't be done at runtime in Odin unless they're dynamic.
Anyways. If there are arguments you must first create the property info for those arguments. (Yay, yet another wrapper)


Then you build a methodinfo struct. The template has a ton of fields, but at least in the example you only care about a few.
-name //StringName
-method_userdata //pointer to the function you're binding
-call_func //cast the call func proc to rawptr or use the GD name, which is a rawptr
-ptrcall_func //cast the pointer call func proc to rawptr or use the GD name, which is a rawptr
-method_flags
-has_return_value //if there's a return
-return_value_info //if there's a return ^propertyInfo
-return_value_metadata //if there's a return enum
-argument_count //required
arguments_info //pointer to the first value of a [^]propertyinfo array
arguments_metadata //pointer to the first value of a [^]metadata enum

Careful of the difference between StringName and String when building those.
Once the struct is built use another StringName for the class name and then use this and the StringName of the function to register it.
If done correctly you'll see the functions in Godot editor when looking at the docs info.

Once you're done binding anything you can delete all the memory that was used to bind it. I guess try to init your libraries upfront as much as possible?

Then destroy everything because all of this was to pass the method information to Godot.

Once you've created the getters and setters you can bind the variable itself. Wew! No no, you can't just pass the pointer there's more steps than that.
Make a property info for the variable
Make StringName for getter and setter variables which match the previously used names.
Register.

So this is where Godot is interesting. You can omit either names of the getter or setter functions but if you do you won't be able to modify the value in the editor.
Because you can't make changes to a variable directly. Godot will call the getters whenever it needs the information for the editer, then call the setters once you make updates in the editor.
I'm not sure what the refresh rate of the editor itself is, but it seems like when any variable is available for modification it's calling the getter every time it refreshes the UI.

FINALLY the create function is called to create it for the editor and for each time it is present in the scene. This does a lot
-allocates memory for the object pointer
-specifies the object type
-set the instance
-bind the instance
If you have it in the scene 3 times this will be called 3 times.
Class constructor will be called after this as well. Generally this is where you would set your defaults.

VIRTUALS
Setting up the _process will function will teach you how to setup signals. Signals are essentially unique int values that are passed through the node tree. If something with that same unique int value is listening it means that there is a process available to run from that.

Once you get to this point it's pretty simple. You already have the functions to handle calling the function so you just need to give Godot the pointers and then handle the function when Godot tells you to run it.
Two new properties need to be filled in for your class_info struct.
-call_virtual_with_data_func
-get_virtual_call_data_func

First setup the getter function. In the tutorial it details how to setup for the _process function.
This runs after all the constructors are done. This is run once for each virtual function in the inheritance.
You will need to do a StringName comparison to tell Godot if you have a function that corresponds to that virtual.
You can probably do this directly yourself by fetching the data info from the StringName struct. Otherwise you can rely on Godot's helper function. In either case you have to create a string name for this. It's only once, so temp_allocator is likely good.
left:  [192, 39, 74, 75, 42, 2, 0, 0] right:  [192, 39, 74, 75, 42, 2, 0, 0]
true
if true, pass the pointer to your function.

If Godot finds a virtual which is true it will store the pointer info. When it is time to use the virtual function that you said exists it will use the call function, send you the function pointer and then you handle calling the correct function based on that.
Do a compare of the pointers to figure out which is the correct function.
If true you need to run the corresponding helper function.

If you did everything as the tutorial suggests you'll have this class running the process function on each tick of the editor. Provided you have the node in a scene.

Signals are weird man.
I think it's the fact that it ends in a Bindcall, which feels like a misleading name.
Signals require creating and passing Variants between functions, which means translation of large arrays. Avoid too many?
Add the variables that will be relevant to the signal to your constructor.
-what is going to trigger it
-what is going to be sent
-a StringName that other nodes will use to listen for the signal. $GDExample.position_changed.connect(on_position_changed)

You'll need a few new constructors and a destructor because you're gonna be building a Variant string on Godot side?

A new value API wrapper method struct. object_method_bind_call

The correct kind of helper function. In the case of the tutorial it is one that will receive 2 arguments and return nothing. But is also specifically for handling variants.
The helper function will take arguments from a multipointer, convert them to variants, then pas them to Godot via the objectMethodBindCall.
This requires 6 memory allocations? ._.
This is going to use the object_method_bind_call to send signal's info to whatever is listening.(?)
You will call this every time the signal needs to be sent.

Similar to how we bound ourselves to the set_quad_size (743155724) function for the vec2 update we will bind ourselves to a function called emit_signal (4047867050). Check the json.
We need to ask it for the method that is emit_signal by passing it the associated class and method name. Btw, hash isn't unique, there's a function called rpc that has the same hash.

Now when it is time we can pass this method signature that we just fetched to the call_2_args_stringname_vector2_no_ret_variant function which assigns all the values we want to variants which are put into a [^]array and passed to the API that calls the emit_signal function.

If everything was done right you'll be able to connect to the signal and use the new_position value.
extends Node2D

func _ready():
	$GDExample.position_changed.connect(on_position_changed)

func on_position_changed(new_position):
	prints("New position:", new_position)

So now finally I think I get it. To interact with Godot's API you need to 