### RefCount
Pretty cool. The reference is counted in scope of the script. If it is referenced outside of a function then the reference increment will last as long as the node lasts. If the reference is within a function then the reference will last as long as the scope of the function.

This means that if I were to create Slices they would behave similar to Odin slices. ie with the scope of where they were declared.

When you're creating a ref counted object you get to have a virtual on the ref and unref methods. I assume this is to handle dependencies or whaterver else. It's neat, but in our use case we only need the destruction. Maybe could be used for tracking handles more specifically in a configuration which works reverse to this?

### Multiargs
Godot itself says it is a bug. Multi-arg functions can't be used with the method pointer :/ Will need to adjust the class parser accordingly.

As a result we need to do extra allocations from our base types to variant types and count out how many arguments will be sent along with it.

Seeing as vararg only applies to the last variable a different helper function from Godot would likely be the better way to treat these. ie, send a Array of something instead of [^]rawptr.

### Odin Arrays in Godot
Actually shouldn't be too difficult? Thanks Rat for reminding me about the parapoly. Not sure why I was blanking on that so hard.

Testing takes time to make sure that things work as I expect and figure out the best way to do this.

Originally thought of making a singleton that has a bunch of functions but in the end there's little point. Just make a RefCounted class which takes care of each individual array type. KISS design.

So far it seems rather reliable to create and destroy the arrays based on the scope of things which have referenced them. Could include a 'DESTROY' function to delete the array data, but can't deref everything or else Godot will yell when it goes negative.

Slices I might go with the Go method where they increment the ref count of the original array. Though this could lead to hidden memory holds instead of obvious broken memory lifetimes. I do prefer the latter.

This is an interesting benchmark for working with this though. Checking lifetimes, making things hoepfully more ergonomic with the class creation?? Can add in some debug compile specific settings which would keep track of what Node is allocating it for maybe some easier debugging. Every time it's reference take the node name and when dereffed remove it. If something doesn't go right you can know exactly who is owning it at what time. (mostly)

Printing should be rather straight forward. I can set a specific to_string function in the classinfostruct itself which should simply return the correct string to Godot. Simply use our own fmt function to create a cstring.