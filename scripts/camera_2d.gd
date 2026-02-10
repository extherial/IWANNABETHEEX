extends Camera2D

@export var player: Player
@onready var sizex: int = get_viewport().size.x
@onready var sizey: int = get_viewport().size.y
@onready var current_position = SpawnManager.get_cam_spawn()

func _ready() -> void:
	var handler = get_tree().get_first_node_in_group("Reset_Handler")
	handler.connect("PRE_RESET", update_position)
	update_position()
	
func _reposition(pos: Vector2):
	global_position = pos
	update_position()

func _process(delta: float) -> void:
	if (player.position.x >= global_position.x + (sizex / 2)):
		global_position.x += sizex
		PlayerDeathSignal.emit_signal("screen_update")
	if (player.position.x <= global_position.x - (sizex / 2)):
		global_position.x -= sizex
		PlayerDeathSignal.emit_signal("screen_update")
	if (player.position.y >= global_position.y + (sizey / 2)):
		global_position.y += sizey
		PlayerDeathSignal.emit_signal("screen_update")
	if (player.position.y <= global_position.y - (sizey / 2)):
		global_position.y -= sizey
		PlayerDeathSignal.emit_signal("screen_update")
	pass
func update_position():
	CameraBounds.set_cam_position(global_position)
	CameraBounds.set_bounds(
	global_position.x - (sizex / 2), 
	global_position.x + (sizex / 2), 
	global_position.y + (sizey / 2), 
	global_position.y - (sizey / 2)
	)
	pass


func _on_gun_controller_set_spawn() -> void:
	SpawnManager.set_cam_spawn(global_position)
	pass # Replace with function body.


func _screen_update():
	global_position = SpawnManager.get_cam_spawn()
	update_position()
	pass # Replace with function body.
