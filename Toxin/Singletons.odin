package Toxin

import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"
import Classes "shared:Godot_Odin_Binds/GD_Classes"

PhysServer2dObj: Classes.PhysicsServer2D
//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getPhysServer2dObj :: proc() -> Classes.PhysicsServer2D {
    if PhysServer2dObj == nil do PhysServer2dObj = gdAPI.GlobalGetSingleton(GDW.GDClass_StringName_get(.PhysicsServer2D))
    return PhysServer2dObj
}