extends Node2D

@export var cutscene_length: float
@export var hitbox_size: float

var cutscene_started = false
func _ready() -> void:
	var handler = get_tree().get_first_node_in_group("Reset_Handler")
	handler.connect("RESET", _screen_update)
	if(CameraBounds.is_in_bounds(self)):
		cutscene_started = false
		show()


func _on_timer_timeout() -> void:
	$HitboxComponent.set_monitorable(false)
	$HitboxComponent.set_monitoring(false)
	pass # Replace with function body.

func _on_hitbox_component_area_entered(area) -> void:
	if area.get_parent() is Player && cutscene_started == false:
		CutsceneHandler.set_cutscene("hamster")
		$HitboxComponent.set_monitorable(true)
		$HitboxComponent.set_monitoring(true)
		cutscene_started = true
		$Timer.start(cutscene_length)
	pass # Replace with function body.

func _screen_update():
	cutscene_started = false
	$HitboxComponent.set_monitorable(true)
	$HitboxComponent.set_monitoring(true)
	pass
