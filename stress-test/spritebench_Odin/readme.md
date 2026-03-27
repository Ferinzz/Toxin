## spritebench_Odin

# Goal
Test how impactful the FFI is on a basic parameter and redraw update.

# Dependencies
Godot Class details.
import Classes "shared:Godot_Odin_Binds/GD_Classes"
[GD_Classes](https://github.com/Ferinzz/Godot_Odin_Binds)

Basic API, helper procedures, and builtin types
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
[GDWrapper](https://github.com/Ferinzz/Toxin/GDWrapper)

Entry, Class Exporter, etc
import "shared:Toxin"
[Toxin](https://github.com/Ferinzz/Toxin/Toxin)

Package imports are expected to be in Odin's shared folder. Import headers are already setup in this package's headers.

Github Commit
Toxin/GDWrapper: 9b4652e
GD_Classes: 958d411

# Run
Benchmarks were performed by running the following commands to export to a project called TopDown and run from Godot's exectuable. Adjust as needed.
Build time should be no more than 5 seconds.

```
#cd into the spritebench_Odin director
odin build . -build-mode:dll -out:libgdexample.dll -o:speed
C:\\Godot\\Godot_v4.6-release.exe --path . -s node.gd
```
node.gd will import the gdextension which will add all the children to the root.
(Or whatever your Path call to Godot is)

# Observation
On a Intel a770 Intel 13700k the benchmark runs at an average of 0.0058 to 0.0061 which is ~172 fps.