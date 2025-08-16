::@echo off
::echo on
C:\GodotSrc\godot\bin\godot.windows.editor.dev.x86_64.exe --headless --dump-gdextension-interface
::C:\GodotSrc\godot\bin\godot.windows.editor.dev.x86_64.exe --headless --dump-extension-api

::runs whatever odin main package there is in the folder you're in.
::probably better to have the main file in a src directory or something, but I wasn't planning on having more than one file at the start.
::odin build src -build-mode:dll -debug
odin build src -build-mode:dll -debug

::rename src.dll libgdexample.dll
rename src.dll libgdexample.dll

::Change this to a folder in the project you're running.
::Don't forget to put the gdexample.gdextension file somewhere in the project. Not sure if it matters where.
xcopy /v /i /Y libgdexample.dll .\TopDown\bin\
del libgdexample.dll

::Change this to where you have your Godot Project file.
::godot .\testextension\gdwrapperproject\project.godot