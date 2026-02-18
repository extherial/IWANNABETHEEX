extends Node
signal set_spawn
@export var bullet: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func setspawn():
	var spawn = get_parent().position
	var vel = get_parent().velocity
	SpawnManager.set_spawn(spawn, vel)
	emit_signal("set_spawn")
	pass
func shoot(direction: int):
	var shot = bullet.instantiate()
	add_child(shot)
	shot.global_position = Vector2(get_parent().global_position.x + (5 * direction), get_parent().global_position.y + 5.5)
	shot.dir = direction
	pass
