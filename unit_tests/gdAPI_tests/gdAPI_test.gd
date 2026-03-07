extends SceneTree

func _init():
    var manager = Engine.get_singleton("GDExtensionManager")
    if manager == null:
        print("GDExtensionManager not available")
        quit()
        return

    var path = "C:/Odin_programs/Toxin_new_pull/unit_tests/gdAPI_tests/gdexample.gdextension"

    var err = manager.load_extension(path)
    if err == OK:
        print("Extension loaded")
    else:
        print("Failed to load extension: ", err)
    
    quit(0)