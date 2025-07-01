In this example you can see how a second custom Class can be registered, specifying Sprite2D as the parent class naming it mySprite. (optional for our ultimate goal.) We then use the signal setup in our custom SceneTree to create the custom Sprite2D class, use the resource load function to load the Godot icon.svg as a texture, then set the texture.

Useful reference docs : https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html

Regarding rendering in general.
All objects which should be drawn should be included into a canvasItem. (Ref : https://docs.godotengine.org/en/stable/classes/class_canvasitem.html#class-canvasitem)
By default the SceneTree takes care of adding whatever needs to be included in the rendering process based on the objects in the scene.
The renderingServer will step through the canvas items to make the buffer for the GPU. The renderingServer is also responsible for rending the particles after the other objects are handled.

The simplest rendering and logic solution is to utilize the SceneTree as it provides a simple enough structure to rendering order while also maintaining the same order of logic. For a more direct approach check renderingServer. This is supposed to allow for more optimization.