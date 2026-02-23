## thousands of children

# Goal
Test the performance of the physics engine with a basic shape moving across the scene.

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
[tToxint](https://github.com/Ferinzz/Toxin/Toxin)

Package imports are expected to be in Odin's shared folder.

# Run
Adjust frames spent counting via frame_count_amout
Update value BULLET_COUNT in order to adjust the amount of objects rendered.

Benchmarks were performed by running the following commands to export to a project called TopDown and run from Godot's exectuable.
```
odin build stress-test/BulletShower -build-mode:dll -o:speed  -out:TopDown/bin/libgdexample.dll

C:\\Godot\\Godot_v4.6-release.exe --path ./TopDown
```
(Or whatever your Path call to Godot is)

# Observations
On a Intel a770 Intel 13700k BULLET_COUNT set to 17500 seems to be the limit for physics objects single threaded. Beyond this the diminishing returns are massive as going from 17500 to 18000 drops frames from 58 to 43; at 18500 the frame rate was 28.

Draw time is nearly negligible in comparison to the physics limit.