* This example shows one of the ways you can hook into the scentTree's loop.
* This method creates a sceneTree custom class and sets a connection to its own physics_frame signal.
* WARNING :: This does require overriding the mainLoop value in Godot's project settings. Project Settings -> Run -> Replace the SceneTree with treeHook. (Or whatever you name your sceneTree class)
* Key points.
* 1) Extensions load before the mainloop and scenetree get setup. Make sure to fetch mainLoop after it has been set by Godot.
* 2) Fetching the sceneTree with the Node's method returns a refCount object. Still not sure how to resolve this to the objectPtr itself.
* 3) Overriding the _process function will screw up Godot's logic. Do not do this unless you're replacing all the logic it would have.
* 4) Careful about versioning. I was pulling an older version of the api at first, then found out the connect method changed significantly with the new version I'm using.
* 5) There will be no success message when registering a Singleton, but there will be a warning when you register the same one twice.
* 6) Singletons are basically just a way to create globals. If you have some values you want to make public to GDScript, this would be the way. (variable and methods)
* 7) You won't see it printing from the callback unless you run the game directly from CLI. This is why there is "args": [ "--path ./TopDown"], in the .launch.json
* Main's init process is (in an abreviated description)
* Check what main_loop_type is specified in the setting.
* If no type is specified, use SceneTree.
* Checks if script isn't empty -> If not, will use the specifed script as the mainLoop
* Set mainLoop to class specified in main_loop_type.
* Check if class exists in classDB.
* If it does -> Instantiate (This is why we don't need to create it ourselves at any specific time.)
* Cast type to mainLoop.
* Set as singleton.
* Cast to SceneTree type.