::@echo off
::echo on

::This build setup assumes that vscode's project is a folder containing a
::src folder for the Odin gdextension code as well as a godot project folder.

::Main
::|_godot_project/bin - put your dll and .gdextension here.
::|_src - Odin extension code here.
::::|_GDWrapper/gdextension - Don't forget to include the GDWrapper and gdextension packages in your Odin folder or as a shared library.

::Dump the details about Godot's API. This only needs to be done once.
::gdextension-interface is the C header file.
::extension-api is a massive json file with all the classes and method info.
::C:\GodotSrc\godot\bin\godot.windows.editor.dev.x86_64.exe --headless --dump-gdextension-interface
::C:\GodotSrc\godot\bin\godot.windows.editor.dev.x86_64.exe --headless --dump-extension-api

::builds whatever odin main package there is in the folder you're in.
::Currently set to target a src folder, as that's what I currently work out of.
odin build src -build-mode:dll -debug

::rename src.dll to libgdexample.dll as this is what I specified in the .gdextension file.
rename src.dll libgdexample.dll

::copy/paste the dll into the correct project folder.
::Don't forget to put the gdexample.gdextension file somewhere in the project. Not sure if it matters where.
::Change this to a folder in the project you're planning on using.
xcopy /v /i /Y libgdexample.dll .\TopDown\bin\
::Delete the leftover. Above copy should fail when compilation fails.
del libgdexample.dll

::Change this to where you have your Godot Project file. Ignore if you're launching the debugger elsewhere.
::godot .\testextension\gdwrapperproject\project.godot