Oh dear lordy lord...

A few mistakes to avoid. Resource is not a RID. It's an object. Meaning you cannot unload it with the freeID used for other objects created in the bulletshower example. I've used get_rid followed by the free_rid method.

removing something from the sceneTree does not automatically destroy it. This might be a good way to manage active/inactive entities. Effectively a 'pause' if you allow them to rely on the built-in phys/process ticks. If you want it to be destroyed on removal you should call the destroy off of the _exit_tree function.

If you have not loaded the editor in between adding something to the folder you cannot use resource -> load to load the file. It seems you would need to use image -> load(?) to get an image to load in. Maybe using a path that isn't res:: could solve this? I'm assuming that the engine does some lookup shortcuts to make finding files faster. Perhaps even some preprocessing? Benefit of the doubt. Would be nice to explore how to avoid the need to load the editor just to package the import. Maybe ResourceImporter could be a way to do this as well. Run this on the folder when building.

Despite some methods having the same name, hash and details; if you use the wrong parent name it will not provide you with the correct mapping to the method. I found this out when I tried reusing the same method ptr for free_rid of physicsserver2d to free from renderserver2d.