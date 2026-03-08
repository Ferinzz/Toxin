Oh dear lordy lord...

A few mistakes to avoid. Resource is not a RID. It's an object. Meaning you cannot unload it with the freeRID used for other objects created in the bulletshower example. I've used get_rid followed by the free_rid method. Don't forget to offset the image. image origin is not the center but shape is.

removing something from the sceneTree does not automatically destroy it. This might be a good way to manage active/inactive entities. Effectively a 'pause' if you make them to rely on the built-in phys/process virtual methods. If you want it to be destroyed on removal you should call the destroy off of the _exit_tree function.

If you have not loaded the editor in between adding some resource to the game folder you cannot use resource -> load to load the file. It seems you would need to use image -> load(?) to get an image to load in. Maybe using a path that isn't res:: could solve this? I'm assuming that the engine does some lookup shortcuts to make finding files faster. Perhaps even some preprocessing? Benefit of the doubt. Would be nice to explore how to avoid the need to load the editor just to package the import. Maybe ResourceImporter could be a way to do this as well. Run this on the folder when building.

Despite some methods having the same name, hash and details; if you use the wrong parent name it will not provide you with the correct mapping to the method. I found this out when I tried reusing the same method ptr for free_rid of physicsserver2d to free from renderserver2d.

For verifying the input events received. It's an odd way to work things, but the best way to type check a class and thus be able to check the type of event which you're receiving is to try to case the object to the specific object you want it to be. This is for if event is InputEventMouseMotion: in the player.gd script. If you don't do a cast check you'll have to use the Object.is_class method which is a STRING COMPARE! You can't use the stringname compare because events don't seem to have names.

Oh Right! For some reason the Node class does not exist at the time that our class is being created. Managing when this should be called is gonna be a nightmare. Not sure how to do this without asking the user to generate 5000 generic functions with (@static)someFunctionPtr in all of them. :ded:

Wound up just setting up some basic movements for the Player class and then did the rest in Godot. Felt weird going into the editor floundering as I didn't know how to find what I wanted in a ui environment.

For this project you should copy the
--player.tscn
--node_2d.tscn
--bullet.png
--project.godot

The bullets class is loaded automatically by the treeHook class during creation. If you want you can use the default SceneTree but you will need to add the Bullets class yourself.

Steps to setup a physics object.
Create a shape resource : circleShapeCreate
: setShapeData WARNING careful about updating this. It is what caused a MASSIVE slowdown to the load speed. Like crazy. If you want to see that add that proc to the for loop.
For future storage get the space that you'll be adding the phys objects to : getSpace
Get the world2d you will be adding the phys objects to : getViewport -> getWorld2D
Create a body object for the phys object : bodyCreate
Set the space that the body will be inhabiting: bodySetSpace
Add a shape to the object you created : bodyAddShape
Set the collision mask that it other objects should collide into it with (check GDW for more details about masks and doc link) : bodySetCollisionMask
Update the state of th ephys object to be in the same pos as the image will be : bodySetState

Not gonna be any good way to setup the location of the phys object and the sprite. sprite only needs vec2 but physics needs a full Transform2D. Opted for Transform2D after having first implemented it as vec2.

Additional notes... Turns out Godot is row_major for their vectors. That really screwed things up for me.

