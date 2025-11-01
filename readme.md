This repo is to provide a wrapper for Godot's API.

Current features include :
* Create custom class
* Create Signals
* Connect to Signals
* Convert to-from Godot's variants
* Define Godot's custom types
* Export variables as Godot base types

Not yet implemented or needs more work
* String helpers
* More array helper functions
* More object methods
* Review the memory system more closely
* Add allocator variables to communicate allocs instead of using default alloc everwhere
~change cstring types to string types~

Feel free to make suggestions


There are examples for various stages of an implementation using this wrapper. The examples are provided as-is from when I first got them setup. Often times there will be additional work after the fact to pull the necessary methods into the wrapper. Some of the older code may not work, I havent tested them since the most recent major changes.

# Setup

## -Pre-req-
1) Godot.
* Ideally compiled for debug mode to allow you to step through the code. (Godot only takes 5-10 minutes to compile.)
    - Building Godot will require Python and scons...
* Set the path for Godot in your environment pointing to the compiled executable. In my build script I point to the exe itself because I have 2 versions of Godot...
2) Odin-lang

Import the GDWrapper folder into your code as you would any other package.
I recommend also exproting the API json file from Godot. godot --headless --dump-extension-api

Make sure that the version you use is up to date with the version you want to method bind to. I have setup the method binds based on version 4.4.0
* The methods DO change on version changes. If you see a message from Godot stating that there is no fallback method it means that the method's hashid does not match what Godot expects it to be.
You will need to provide Godot with the name of a proc that it will use as an entry point and set that proc as @(export).
* This you specified in the .gdextension file provided to Godot.
* https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_file.html
Compile your Odin code as a dynamic library. Place it somewhere in the Godot project's folder.
* Make sure the name matches what you specify in the .gdextension file. My build script changes the name and then copies it to the correct godot project folder.

# Building
GDExtensions are a shared library with a single exported procedure. Godot will call that procedure and you should provide the pointers to references to the init procedures as well as save the ClassLibrary pointer which Godot shares with you.

In addition to the shared lib which you will compile, you will also need to provide Godot with the information about your shared lib in the form of a *.gdextension file. This can (apparently) be placed anywhere in the project file and must include the file name of your GDExtension lib; the procedure name of the exported procedure; the types of builds that this extension should be loaded for.\
For more details on the *.gdextension file please check the official docs.\
https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_file.html

If you are trying to understand what methods are needed in Godot I recommend checking their documentation on the topic and looking at the C# code in the examples. It's not a perfect match but it's better than C++ code examples which use there version of GDExtension. C++'s extension seems to do a lot of work processing files to add the necessary extra bindings that Godot needs. C# is a bit more direct.

Sometimes it's difficult to find the exact correct page of Godot Docs you want/need so I've done my best to include links to those pages when I remember to. (for example render server doesn't find the page I want but renderingserver does.)

## Templates
There is a templates folder which contains the barebones configs to get an extension up and running with a custom class. (excluding the GDWrapper package)


# Debugger
DEFINITELY get this setup. Stepping through what Godot does is a lot easier to figure out than trying to piece together the five different c++ files required to init one class or variable. Also helps when matching pointer mem locations.

VSCode Setup instructions. Requires building from source : https://godotforums.org/d/32073-debug-c-gdextension/16 (Sia2005's comment adds more context)
https://www.reddit.com/r/godot/comments/11d56t1/gdextension_how_to_get_debugger_working_when/

The project includes a .vscode folder which has the current debug launch configs I'm using. There is also build.cmd which has the compilation steps as well as the steps to rename and move the built shared lib to a corresponding project folder which would be the Godot game project folder.

# Why is there GDWrapper and GDExtension?
There is both GDWrapper and the sub package GDExtension. This is to communicate a distinction between what is directly pulling from Godot's C API or Godot defined types vs what has been built on top of it. It felt like the right thing to do.\
If you only the minimum core Godot references to build  your own wrapper you can use only the GDExtension package and build on top of it as you see fit.

# Terminology
Variant. A c++ class which represents a type. Examples are Float, Array, String.\
PropertyHint. A combo of enum and string which tells Godot's editor how to handle a property. This does not affect behaviour in the Script.\
Node. A 'thing' which can be included in a tree-like structure of inheritance.\
Class. An encapsulation of data and procedures. A class exported to Godot to be 'exposed' will be available as a Node in Godot's editor and scripts.\
Object. The most rudimentary Class in Godot.\
Method. A method will refer to a function which is associated with one of Godot's C++ classes.\
Bind. The act of importing or exporting something between the GDExtension library and Godot's.\
Extend. Include an additional class into the one you are working with. This will provide access to all the public variables and methods.\
Virtual. A Class method which can include additional method calls when a class is extended.\
Signal. An event driven notification system to communicate an event between Nodes.\
Connect. The act which sets a Node to listen for an event from a specific Signal.\
Reference Count (RefCount). A Class which wraps around another Class in order to count the amount of times the Class has been passed to another Class as a pointer. Once RefCount hits 0 the Class and RefCounter are destroyed. Initializes at 1.\
Singleton. A globally available class. Examples are RenderServer, Input, Engine.\
Resource. A Class which contains and knows how to manage specific data. This could be a resource from disk or an engine resource such as the body of a physics object.\
Resource ID. A runtime identifier to a Resource. This is not a pointer.\
Callable. A method or procedure packaged in a struct which can be shared with other Classes at runtime. These callables are most often associated with Signals.\
Server. A system which controls a type of event such as rendering, sound, etc.\
MainLoop. The core loop which will call the servers and trigger the SceneTree.\
SceneTree. The main structure which Scenes are typically attached to.\
GDScript. A set of instructions which can be called to execute at runtime. These are not compiled until you turn them into tools.\
StringName. A specially hashed string which is refCounted and stored in a special bucket of memory. Often used as an identifier for unique entities such as classes or constants. Often abreviated to SN in this package.\

# Tests
Toxin is not yet in a stable enough state to build tests for it. Current confirmation of implementations working as expected depend on exporting values to Godot and validating that they function as expected.


# What examples to look at?
Warning! There has been a lot of changes since the examples were last built. This often won't be truly representative of the current state of the package.

(Some of these will require adding classes to a scene in the editor or making settings changes. Be sure to check the readme of the associated example to see what interesting behaviours Godot adds.)

* I recommend checking the original C Example implementation in the originalCExample folder. This is a direct port of the C example from Godot's docs. This does quite a few things such as extending the Sprite2D class. Makes a few properties public to the Editor and GDScript. And details each steps of the process of binding to Godot's methods as well as binding your own methods to Godot. Don't spend TOO much time on it because

* second I would compare the difference with the simplifiedCExample. This was after I had done a lot of work to reduce the amount of code needed to generate the Godot side of things. More compile-time settings added to simplify a lot of it.

* Use typeExamples as a reference to how you can convert types to and from Godot's variant system. It also has a readme providing information about the backing data of most types. aka my slow descent into madness.

* loadTextureToSceneTree shows how to setup a sprite from code. create, set texture, add to sceneTree's root.

* sceneTreeHook shows how I managed to set my own class as the mainLoop as a sceneTree type. I could then hook into Godot's physics_frame signal which fires every tick without adding any classes to the sceneTree itself.

* bulletshowerexample takes the GD script example of the same name and converts it to Odin code. Most interesting part is the bullet. Shows off some object pooling so that you don't need to create a node for every single entity you will be showing on the screen.~

src is the latest thing I am working on.