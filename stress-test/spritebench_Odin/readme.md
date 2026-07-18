# spritebench_Odin

## Goal
Test how impactful the FFI is on a basic set parameter and virtual callback.

## Dependencies
Are contained within Toxin itself. Be sure to run the parsers before attempting to build this code. 

## Run
Benchmarks were performed by running the following commands. Adjust godot path as needed.
Build time should be no more than 5 seconds.

```
#cd into the spritebench_Odin directory
odin build . -build-mode:dll -out:spritebench_Odin.dll -o:aggressive
C:\\Godot\\Godot_v4.6-release.exe --path . -s node.gd
```
node.gd will import the gdextension which will add all the children to the root.
The path to godot is a direct path to my .exe; can replace with your godot path. For performance testing be sure to use a release build of godot and not a debug build. 

## Observation
On a Intel a770 Intel 13700k the benchmark runs at an average of 0.0058 to 0.0061 which is ~172 fps.
