## Empty_Process

# Goal
Test how impactful is the _process callback on performance of 50k Nodes even when used.

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
odin build stress-test/Empty_Process -build-mode:dll -o:speed  -out:TopDown/bin/libgdexample.dll

C:\\Godot\\Godot_v4.6-release.exe --path ./TopDown
```
(Or whatever your Path call to Godot is)

To show that this is working remove the comments from the _ready callback. This will add the texture to the Sprite2D.
```
Texture_Class.set_texture->m_call(self.self, {&texture}, nil)
```

# Observations
50k empty _process callbacks have a frametime of 0.0044s
50k children with no _process callback have a frametime of 0.0020s
If you don't use it, don't include it.
