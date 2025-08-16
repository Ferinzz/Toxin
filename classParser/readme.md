Yes the code in this is pretty bad. It's okay I was learning a lot about how to develop an json parser. Also continued to add more conditions to handle for the method -> proc writing. Third times a charm?

With the Excuses out of the way, what's important to know about classes?
CONSTANTS
*Constants for any class which is not a built-in type (rect, vec2 etc) will be exclusively enums of size i64 or u64. This can be seen more explicitely by the fact that C# uses long as the constants instead of a i32. Yes, C# does use those specific types.
META
*Something which I have not seen in any docs or conversations or anything else is what the meta tag is for. Looking at some Rust code it doesn't seem like they pay much mind to it. In practice, C# does respect the use of i32 u64 etc. This means that despite gdscript using specifically 64 bit size, in the back it recognizes multiple sizes for types. Use the correct type based on the meta tag specified in comments. TODO: Add logic in the parser to transmute from i32 or whatever to the larger size int. If necessary. May not be necessary for pointer method calls instead of variant calls. :thinking:
DEFAULT
*Do not be mistaken. Default value does not mean that Godot will use a default value but that we should provide a default value to the function if it is not being supplied. Due to the use of pointers I cannot set a default value in the procedure declaration... Perhaps could check for nil and add default if necessary, but this would mean an if statement all the time.


Warnings:

ENUMS
Enums can be present in more than one class. Odin should catch the duplicate names and provide a compilation error.

Methods
There will be methods with the same name as those in other classes. The name, the hash, eveything will be the same. You may not notice the problem until you attempt to use it and it provides the wrong data. This is why everything is pre-pended with the class name. It's not a choice I like, but otherwise... I'm not sure what else there could be to differentiate them.