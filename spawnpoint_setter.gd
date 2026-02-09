extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpawnManager.set_spawn(self.position, Vector2(0,0))
	print("spawn_set")
	pass # Replace with function body.
