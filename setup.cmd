
::Dump the details about Godot's API. This only needs to be done once.
::gdextension-interface is the C header file.
::extension-api is a massive json file with all the classes and method info.
godot --headless --dump-gdextension-interface
godot --headless --dump-extension-api

odin run classes_parser
odin run wrapper_parser