extends Node2D
@export var vertical_power := -50

func _on_jump_pad_area_area_entered(area) -> void:
	var parent = area.get_parent() 
	if parent is Player:
		print("found")
		parent.velocity.y = vertical_power
	pass # Replace with function body.
	
