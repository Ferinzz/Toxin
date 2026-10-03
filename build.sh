#!/bin/bash
# filepath: build.sh

# This build setup assumes that vscode's project is a folder containing a
# src folder for the Odin gdextension code as well as a godot project folder.

# Project
# |_godot_project/bin - output your dll and .gdextension here.
# |_src - Odin project code here.
# Odin
# |_shared
#   |_Toxin

# Builds whatever odin main package there is in the folder you're in.
# Currently set to target a src folder, as that's what I currently work out of.
odin build src -build-mode:dll -debug -out:./TopDown/bin/TopDown.dylib

# Launch Godot with your project (optional)
# godot ./TopDown/project.godot