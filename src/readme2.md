### RefCount
Pretty cool. The reference is counted in scope of the script. If it is referenced outside of a function then the reference increment will last as long as the node lasts. If the reference is within a function then the reference will last as long as the scope of the function.

This means that if I were to create Slices they would behave similar to Odin slices. ie with the scope of where they were declared.

When you're creating a ref counted object you get to have a virtual on the ref and unref methods. I assume this is to handle dependencies or whaterver else. It's neat, but in our use case we only need the destruction. Maybe could be used for tracking handles more specifically in a configuration which works reverse to this?

### Multiargs
Godot itself says it is a bug. Multi-arg functions can't be used with the method pointer :/ Will need to adjust the class parser accordingly.

As a result we need to do extra allocations from our base types to variant types and count out how many arguments will be sent along with it.

Seeing as vararg only applies to the last variable a different helper function from Godot would likely be the better way to treat these. ie, send a Array of something instead of [^]rawptr.

