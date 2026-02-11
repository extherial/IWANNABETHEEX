extends Area2D
var handler
@export var track_title: String
func _ready() -> void:
	handler = get_tree().get_first_node_in_group("Music_Handler")
func _on_area_entered(area) -> void:
	if area.get_parent() is Player:
		handler.set_song(track_title)
	pass # Replace with function body.
