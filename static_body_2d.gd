extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_collision_layer_value(5, true)


func _on_area_2d_broken() -> void:
	set_collision_layer_value(5, false)
