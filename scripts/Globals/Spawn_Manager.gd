extends Node
class_name Spawn_Manager

var spawn_position: Vector2
var velocity: Vector2
var cam_position: Vector2

func set_spawn(spawn: Vector2, vel: Vector2):
	spawn_position = spawn
	velocity = vel

func get_spawn():
	return spawn_position
func get_velocity():
	return velocity
	
func set_cam_spawn(spawn: Vector2):
	cam_position = spawn
func get_cam_spawn():
	return cam_position
