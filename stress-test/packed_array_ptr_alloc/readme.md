# thousands of children

## Dependencies
Godot Class details.
import Classes "shared:Godot_Odin_Binds/GD_Classes"
[text](https://github.com/Ferinzz/Godot_Odin_Binds)

Basic API, helper procedures, and builtin types
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
[text](https://github.com/Ferinzz/Toxin/tree/testing_new_hierarchy/src/GDWrapper)

Entry, Class Exporter, etc
import "shared:Toxin"
[text](https://github.com/Ferinzz/Toxin/tree/testing_new_hierarchy/src/Toxin)

The current version is written based on an in-progress branch.
Package imports are expected to be in Odin's shared folder.

Benchmarks were performed by running the following commands to export to a project called TopDown and run from Godot's exectuable.
odin build stress-test/packed_array_ptr_alloc -build-mode:dll -o:speed  -out:TopDown/bin/libgdexample.dll

C:\\Godot\\Godot_v4.6-release.exe --path ./TopDown
(Or whatever your Path call to Godto is)