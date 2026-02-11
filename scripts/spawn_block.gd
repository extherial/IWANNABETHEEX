extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_modulate = Color(1,1,1,1)
	pass # Replace with function body.

func _on_spawn_block_hit_box_area_entered(area) -> void:
	if(area.is_in_group("bullet")):
		$AudioStreamPlayer2D.play()
		$Sprite2D.self_modulate = Color(1.8,1.8,1.8, 1)
		$Timer.start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	$Sprite2D.self_modulate = Color(1,1,1,1)
	pass # Replace with function body.
