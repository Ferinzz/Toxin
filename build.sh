#!/bin/bash
# filepath: build.sh

# This build setup assumes that vscode's project is a folder containing a
# src folder for the Odin gdextension code as well as a godot project folder.

# Main
# |_godot_project/bin - put your dll and .gdextension here.
# |_src - Odin extension code here.
# ::|_GDWrapper/gdextension - Don't forget to include the GDWrapper and gdextension packages in your Odin folder or as a shared library.

# Dump the details about Godot's API. This only needs to be done once.
# gdextension-interface is the C header file.
# extension-api is a massive json file with all the classes and method info.
# /path/to/godot --headless --dump-gdextension-interface
# /path/to/godot --headless --dump-extension-api

# Builds whatever odin main package there is in the folder you're in.
# Currently set to target a src folder, as that's what I currently work out of.
odin build 4_5_new_interfaces -build-mode:dll -debug

# On macOS, the output will be src.dylib instead of src.dll
# Rename to libgdexample.dylib (or .so on Linux)
if [ -f "4_5_new_interfaces.dylib" ]; then
    mv 4_5_new_interfaces.dylib libgdexample.dylib
    LIB_FILE="libgdexample.dylib"
elif [ -f "4_5_new_interfaces.so" ]; then
    mv 4_5_new_interfaces.so libgdexample.so
    LIB_FILE="libgdexample.so"
else
    echo "Build failed: library file not found"
    exit 1
fi

# Copy the library into the correct project folder.
# Don't forget to put the gdexample.gdextension file somewhere in the project.
mkdir -p ./TopDown/bin/
cp -v "$LIB_FILE" ./TopDown/bin/

# Delete the leftover (only if copy succeeded)
if [ $? -eq 0 ]; then
    rm "$LIB_FILE"
fi

# Launch Godot with your project (optional)
# godot ./testextension/gdwrapperproject/project.godot