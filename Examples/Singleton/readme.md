This is a terrible example code ._. Also outdated.
Singleton declaration is done in this code snippet which runs during the extension init process.

```Odin
    this_class= THIS_CLASS_NAME_deets.create(&THIS_CLASS_NAME_deets,true)
    fmt.println(myEngine)
    name_copy:Toxin.StringName
    GDW.StringConstruct(&name_copy, "muhsingle")
    Engine_Class.register_singleton->m_call(myEngine, {&name_copy, &this_class})
```

singletons are... odd.

If you want to be able to use them inline on a script you should give it a name different from the class name. Otherwise it will assume you're calling the class itself.
Best practice will be to Always use a name different from the class itself.

If you load the extension at during or after sceneTree init the singleton will not be known to GDscript and will fail parsing of your script.
Best practice will be to use Engine.get_singleton("singleton_name") to ensure the singleton was indeed instantiated by the Godot engine.