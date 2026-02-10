extends Node


@onready var spawn_position = get_parent().get_node("Player_Spawn_Position")
var dev_toggle = false
var current_save = Vector2(0,0)
var spawn_velocity = Vector2(0,0)
var current_cam_pos: Vector2 = Vector2(0,0)
@export var camera: Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var handler = get_tree().get_first_node_in_group("Reset_Handler")
	handler.connect("POST_RESET", _screen_update)
	
	grab_spawn_locations()
	go_to_save(current_save, spawn_velocity)
	$CanvasLayer/VELOCITY.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("dev")):
		if(!dev_toggle):
			$CanvasLayer/VELOCITY.show()
			dev_toggle = true
		else:
			$CanvasLayer/VELOCITY.hide()
			dev_toggle = false
	$CanvasLayer/VELOCITY.text = str(
	"Hortizontal Velocity: ", $Node2D/Player.velocity.x, 
	"\nVertical Velocity: ", $Node2D/Player.velocity.y,
	"\nposition", $Node2D/Player.position,
	"\ncam position", (((camera.get_viewport().size.x / 0.9) / 2) + 8)
	
	
	
	)
	pass


# this is all logic for grabbing the locations of spawners! :D
func grab_spawn_locations():
	for child in get_children():
		if(child.is_in_group("spawn_point")):
			current_save = child.position
			SpawnManager.set_spawn(current_save, Vector2(0,0))
		if(child.is_in_group("cam")):
			current_cam_pos = child.position
			SpawnManager.set_cam_spawn(current_cam_pos)
			camera._reposition(current_cam_pos)
			pass
	pass

func go_to_save(save: Vector2, vel: Vector2):
	if(save != null):
		$Node2D/Player.position = save
		$Node2D/Player.velocity = vel
	else:
		$Node2D/Player.position = Vector2(0,0)
	pass # Replace with function body.

func _screen_update():
	var spawner_array = get_tree().get_nodes_in_group("enemy_spawner")
	for i in spawner_array:
		i.spawn_all()
	pass # Replace with function body.
