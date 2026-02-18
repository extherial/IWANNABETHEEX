extends Area2D

@export var break_delay := 0.3
signal broken
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("im alive!")
	set_monitoring(true)
	set_monitorable(true)
	$platform_sprite.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area) -> void:
	if area.get_parent() is Player:
		set_monitoring(false)
		set_monitorable(false)
		$platform_sprite.play("shaking")
		await get_tree().create_timer(break_delay).timeout
		$platform_sprite.stop()
		$platform_sprite.hide()
		$GPUParticles2D.restart(true)
		broken.emit()
	pass # Replace with function body.


func _on_gpu_particles_2d_finished() -> void:
	queue_free()
	pass # Replace with function body.
