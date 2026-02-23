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

Package imports are expected to be in Odin's shared folder.

Github Commit
Toxin/GDWrapper: 9b4652e
GD_Classes: 958d411

# Run
Benchmarks were performed by running the following commands to export to a project called TopDown and run from Godot's exectuable. Adjust as needed.
Build time should be no more than 5 seconds.

```
odin build stress-test/spritebench_Odin -build-mode:dll -o:speed  -out:TopDown/bin/libgdexample.dll

C:\\Godot\\Godot_v4.6-release.exe --path ./TopDown
```
(Or whatever your Path call to Godot is)