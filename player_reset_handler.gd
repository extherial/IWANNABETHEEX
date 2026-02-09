extends Node
class_name Reset_Handler


signal PRE_RESET
signal RESET
signal POST_RESET

signal PRE_DEATH
signal DEATH
signal POST_DEATH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerDeathSignal.connect("player_death", _player_death)
	PlayerDeathSignal.connect("screen_update", _update_screen)
	pass # Replace with function body.
	

func _player_death():
	PRE_DEATH.emit()
	DEATH.emit()
	POST_DEATH.emit()
	pass

func _update_screen():
	PRE_RESET.emit()
	RESET.emit()
	POST_RESET.emit()
	pass
