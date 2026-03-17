extends SceneTree

func _init():
    var manager = Engine.get_singleton("GDExtensionManager")
    if manager == null:
        print("GDExtensionManager not available")
        quit()
        return

    var path = "res://gdexample.gdextension"

    var err = manager.load_extension(path)
    if err == OK:
        print("Extension loaded")
    else:
        print("Failed to load extension: ", err)
    var script = load("res://defaults.gd")
    var obj = script.new()
    root.add_child(obj)
    #quit(0)