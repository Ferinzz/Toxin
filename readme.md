<<<<<<< HEAD
This repo is to provide a wrapper for Godot's API.
Current features include :
Create custom class
Create Signals
Connect to Signals
Convert to-from Godot's variants
Define Godot's custom types

Not yet implemented or needs more work
String helpers
More array helper functions
More object methods
Review the memory system more closely
Add allocator variables to communicate allocs instead of using default alloc everwhere
change cstring types to string types
Feel free to make suggestions


There are examples for various stages of an implementation using this wrapper. The examples are provided as-is from when I first got them setup. Often times there will be additional work after the fact to pull the necessary methods into the wrapper. Some of the older code may not work, I havent tested them since the most recent major changes.

~Setup~

-Pre-req-
1) Godot.
* Ideally compiled for debug mode to allow you to step through the code. (Godot only takes 5-10 minutes to compile.)
** This will require Python and scons...
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

-Debugger-
DEFINITELY get this setup. Stepping through what Godot does is a lot easier to figure out than trying to piece together the five different files required to do one task. Also helps when matching pointer mem locations.
VSCode Setup instructions. Requires building from source : https://godotforums.org/d/32073-debug-c-gdextension/16 (Sia2005's comment adds more context)
https://www.reddit.com/r/godot/comments/11d56t1/gdextension_how_to_get_debugger_working_when/


If you are trying to understand what methods are needed in Godot I recommend checking their documentation on the topic and looking at the C# code in the examples. It's not a perfect match but it's better than C++ code examples which use GDExtension. C++'s extension seems to do a lot of work processing files to add the necessary extra bindings that Godot needs. C# is a bit more direct.
Sometimes it's difficult to find the exact correct page you want/need so I've done my best to include links to those pages when I remember to. (for example render server doesn't find the page I want but renderingserver does.)

-Why is there GDWrapper and GDExtension?-
There is both GDWrapper and the sub package GDExtension. This is to communicate a distinction between what is directly pulling from Godot's C API vs what has been built on top of it. It felt like the right thing to do.

-What examples to start with?-
(Some of these will require adding classes to a scene in the editor or making settings changes)
I recommend checking the original C Example implementation in the originalCExample folder. This does quite a few things such as extending the Sprite2D class. Makes a few properties public to the Editor and GDScript. And details each steps of the process of binding to Godot's methods as well as binding your own methods to Godot. Don't spend TOO much time on it because

second I would compare the difference with the simplifiedCExample. This was after I had done a lot of work to reduce the amount of code needed to generate the Godot side of things. More compile-time settings added to simplify a lot of it.

Use typeExamples as a reference to how you can convert types to and from Godot's variant system. It also has a readme providing information about the backing data of most types. aka my slow descent into madness.

sceneTreeHook shows how I managed to set my own class as the mainLoop as a sceneTree type. I could then hook into Godot's physics_frame signal which fires every tick without adding any classes to the sceneTree itself.

loadTextureToSceneTree shows how to setup a sprite from code. create, set texture, add to sceneTree's root.

=======
This repo is to provide a wrapper for Godot's API.
Current features include :
Create custom class
Create Signals
Connect to Signals
Convert to-from Godot's variants
Define Godot's custom types

Not yet implemented or needs more work
String helpers
More array helper functions
More object methods
Review the memory system more closely
Add allocator variables to communicate allocs instead of using default alloc everwhere
change cstring types to string types
Feel free to make suggestions


There are examples for various stages of an implementation using this wrapper. The examples are provided as-is from when I first got them setup. Often times there will be additional work after the fact to pull the necessary methods into the wrapper. Some of the older code may not work, I havent tested them since the most recent major changes.

~Setup~

-Pre-req-
1) Godot.
* Ideally compiled for debug mode to allow you to step through the code. (Godot only takes 5-10 minutes to compile.)
** This will require Python and scons...
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

-Debugger-
DEFINITELY get this setup. Stepping through what Godot does is a lot easier to figure out than trying to piece together the five different files required to do one task. Also helps when matching pointer mem locations.
VSCode Setup instructions. Requires building from source : https://godotforums.org/d/32073-debug-c-gdextension/16 (Sia2005's comment adds more context)
https://www.reddit.com/r/godot/comments/11d56t1/gdextension_how_to_get_debugger_working_when/


If you are trying to understand what methods are needed in Godot I recommend checking their documentation on the topic and looking at the C# code in the examples. It's not a perfect match but it's better than C++ code examples which use GDExtension. C++'s extension seems to do a lot of work processing files to add the necessary extra bindings that Godot needs. C# is a bit more direct.
Sometimes it's difficult to find the exact correct page you want/need so I've done my best to include links to those pages when I remember to. (for example render server doesn't find the page I want but renderingserver does.)

-Why is there GDWrapper and GDExtension?-
There is both GDWrapper and the sub package GDExtension. This is to communicate a distinction between what is directly pulling from Godot's C API vs what has been built on top of it. It felt like the right thing to do.

-What examples to start with?-
(Some of these will require adding classes to a scene in the editor or making settings changes)
I recommend checking the original C Example implementation in the originalCExample folder. This does quite a few things such as extending the Sprite2D class. Makes a few properties public to the Editor and GDScript. And details each steps of the process of binding to Godot's methods as well as binding your own methods to Godot. Don't spend TOO much time on it because

second I would compare the difference with the simplifiedCExample. This was after I had done a lot of work to reduce the amount of code needed to generate the Godot side of things. More compile-time settings added to simplify a lot of it.

Use typeExamples as a reference to how you can convert types to and from Godot's variant system. It also has a readme providing information about the backing data of most types. aka my slow descent into madness.

sceneTreeHook shows how I managed to set my own class as the mainLoop as a sceneTree type. I could then hook into Godot's physics_frame signal which fires every tick without adding any classes to the sceneTree itself.

loadTextureToSceneTree shows how to setup a sprite from code. create, set texture, add to sceneTree's root.

>>>>>>> 1337e34b72ff576fef4c66c7aee17524cffce0c5
src is the latest thing I am working on.