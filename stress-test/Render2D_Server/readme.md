## RenderServer2D Stress Test

# Goal
Test the performance of the Render2DServer with a basic Texture2D moving across the scene.

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

# Run
Adjust frames spent counting via frame_count_amout
Update value BULLET_COUNT in order to adjust the amount of objects rendered.

Benchmarks were performed by running the following commands to export to a project called TopDown and run from Godot's exectuable.
```
odin build stress-test/Render2D_Server -build-mode:dll -o:speed  -out:TopDown/bin/libgdexample.dll

C:\\Godot\\Godot_v4.6-release.exe --path ./TopDown
```
(Or whatever your Path call to Godot is)

Frame times and average frame time will be output to terminal.

# Observations
100k textures at 150fps
Using a single CanvasItem to draw and using the RenderServer2D directly has greater performance than individual Sprite2D by a significant margin. Although Sprite2D is convenient for prototyping in the Editor, avoid using it wherever possible.