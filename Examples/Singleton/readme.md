singletons are... odd.

If you want to be able to use them inline on a script you should give it a name different from the class name. Otherwise it will assume you're calling the class itself.
Best practice will be to Always use a name different from the class itself.

If you load the extension at during or after sceneTree init the singleton will not be known and will fail parsing of your script.
Best practice will be to use Engine.get_singleton("singleton_name")