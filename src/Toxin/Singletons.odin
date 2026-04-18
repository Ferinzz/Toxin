package Toxin

import "../GDWrapper/gdAPI"
import GDW "../GDWrapper"
import Classes "../GD_Classes"

PhysServer2dObj: Classes.PhysicsServer2D
Engine: Classes.Engine
Engine_M_List: Classes.Engine_MethodBind_List
//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
getPhysServer2dObj :: proc() -> Classes.PhysicsServer2D {
    if PhysServer2dObj == nil do PhysServer2dObj = gdAPI.GlobalGetSingleton(GDClass_StringName_get(.PhysicsServer2D))
    return PhysServer2dObj
}
//Yes... It's a single line function because it doesn't exist at API startup.
//You will need to call this at some point 
EngineObj :: proc() -> Classes.Engine {
    if Engine == nil do Engine = gdAPI.GlobalGetSingleton(GDClass_StringName_get(.Engine))
    return Engine
}