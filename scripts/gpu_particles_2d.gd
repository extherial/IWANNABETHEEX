extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var handler = get_tree().get_first_node_in_group("Reset_Handler")
	handler.connect("RESET", update_position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_position():
	self.global_position = CameraBounds.get_cam_position()
	
	pass
