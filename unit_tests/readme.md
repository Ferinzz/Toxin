

## Gotchas

1) you can run a script on its own, but unless there's a project attached Godot will launch the project selector.
* solution. Have a _tiny_ project.godot file with only the line ``config_version=5``
2) once you have a project, all paths in the cli need to be relative to the project. Can't even do a full path
* ``C:\\Godot\\Godot_v4.6-release.exe --headless --path C:\Odin_programs\Toxin_new_pull\unit_tests\ -s .\gdAPI_tests\gdAPI_test.gd``
* notice that the -s starts from a folder below unit_tests
3) ``--headless`` will never exit cleanly without a quit command from Godot.
* include a quit() call in the scenetree/mainloop
* simplest way of doing this is to have your script ``extends SceneTree``
4) unless there's multiple process times a test can likely run in just the ``_init`` function
5) ``GDExtensionManager`` is a singleton. Need to fetch it before being able to use it.
6) If the Godot program is not shutdown cleanly, the GDE dll is not closed cleanly, making subsequent builds fail as it cannot be overwritten.