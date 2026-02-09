extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.x += -100 * delta
	pass


func _on_hitbox_component_enemy_damaged(attack: Attack) -> void:
	print("OW DONT SHOOT CATS MEANIE")
	pass # Replace with function body.
