package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"


AudioFrame :: struct {
left: float,
right: float,
}

CaretInfo :: struct {
leading_caret: Rect2,
trailing_caret: Rect2,
//leading_direction: TextServer_Direction,
//trailing_direction: TextServer_Direction,
}

Glyph :: struct {
start: Int,
end: Int,
count: u8,
repeat: u8,
flags: u16,
x_off: float,
y_off: float,
advance: float,
font_rid: RID,
font_size: Int,
index: i32,
}

ObjectID :: struct {
id: i64,
}

PhysicsServer2DExtensionMotionResult :: struct {
travel: Vector2,
remainder: Vector2,
collision_point: Vector2,
collision_normal: Vector2,
collider_velocity: Vector2,
collision_depth: f64,
collision_safe_fraction: f64,
collision_unsafe_fraction: f64,
collision_local_shape: Int,
collider_id: ObjectID,
collider: RID,
collider_shape: Int,
}

PhysicsServer2DExtensionRayResult :: struct {
position: Vector2,
normal: Vector2,
rid: RID,
collider_id: ObjectID,
collider: ^Object,
shape: Int,
}

PhysicsServer2DExtensionShapeRestInfo :: struct {
point: Vector2,
normal: Vector2,
rid: RID,
collider_id: ObjectID,
shape: Int,
linear_velocity: Vector2,
}

PhysicsServer2DExtensionShapeResult :: struct {
rid: RID,
collider_id: ObjectID,
collider: ^Object,
shape: Int,
}

PhysicsServer3DExtensionMotionCollision :: struct {
position: Vector3,
normal: Vector3,
collider_velocity: Vector3,
collider_angular_velocity: Vector3,
depth: f64,
local_shape: Int,
collider_id: ObjectID,
collider: RID,
collider_shape: Int,
}

PhysicsServer3DExtensionMotionResult :: struct {
travel: Vector3,
remainder: Vector3,
collision_depth: f64,
collision_safe_fraction: f64,
collision_unsafe_fraction: f64,
collisions: [32]PhysicsServer3DExtensionMotionCollision,
collision_count: Int,
}

PhysicsServer3DExtensionRayResult :: struct {
position: Vector3,
normal: Vector3,
rid: RID,
collider_id: ObjectID,
collider: ^Object,
shape: Int,
face_index: Int,
}

PhysicsServer3DExtensionShapeRestInfo :: struct {
point: Vector3,
normal: Vector3,
rid: RID,
collider_id: ObjectID,
shape: Int,
linear_velocity: Vector3,
}

PhysicsServer3DExtensionShapeResult :: struct {
rid: RID,
collider_id: ObjectID,
collider: ^Object,
shape: Int,
}

ScriptLanguageExtensionProfilingInfo :: struct {
signature: StringName,
call_count: u64,
total_time: u64,
self_time: u64,
}