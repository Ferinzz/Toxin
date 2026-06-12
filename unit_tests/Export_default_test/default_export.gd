extends SceneTree

func _init():
    var manager = Engine.get_singleton("GDExtensionManager")
    if manager == null:
        print("GDExtensionManager not available")
        quit()
        return

    var path = ".\\gdexample.gdextension"

    var err = manager.load_extension(path)
    if err == OK:
        print("Extension loaded")
    else:
        print("Failed to load extension: ", err)
        quit(1)
    #var script = load(".//type_test.gd")
    #var obj = script.new()
    #root.add_child(obj)
    #quit(0)