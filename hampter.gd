extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Main/Node2D/Player")
var SPEED = 35

var random_direction
var fly_bx = false
var tracking_bx = false
var spawn_bx = false
var kill_bx = false
var one_shot = true
var rotating_at_player_bx = false
var move_toward_player_bx = false
var spawn_started = false
var player_alive = true

var tween
var color_tween
func _ready() -> void:
	var handler = get_tree().get_first_node_in_group("Reset_Handler")
	handler.connect("DEATH", death)
	hide()
func spawn() -> void:
	show()
	random_direction = randi_range(0,360)
	self.rotation_degrees = -90
	modulate = Color(1,1,1,0)
	$AudioStreamPlayer2D.play(96)
	$AnimatedSprite2D.play()
	spawn_bx = true
	one_shot = true
	await get_tree().create_timer(6).timeout
	if(player_alive):
		reset_behaviors()
		rotating_at_player_bx = true
	await get_tree().create_timer(2).timeout
	if(player_alive):
		reset_behaviors()
		move_toward_player_bx = true
		tracking_bx = true
func _physics_process(delta: float) -> void:
	if(CutsceneHandler.get_cutscene() == "hamster") && !spawn_started:
		spawn()
		spawn_started = true
	if player != null:
		if(spawn_bx):
			var final_position = position
			if(one_shot):
				color_tween = get_tree().create_tween()
				color_tween.bind_node(self)
				color_tween.tween_property(self, "modulate", Color(1,1,1,1), 3).set_trans(color_tween.EASE_IN_OUT)
				position.x += 50
				position.y -= 50
				one_shot = false
				tween = get_tree().create_tween()
				tween.bind_node(self)
				tween.tween_property(self, "position", final_position, 5).set_trans(tween.EASE_IN_OUT)
		
		if (rotating_at_player_bx):
			rotation += get_angle_to(player.position) * 1 * delta
		
		if(tracking_bx):
			#SPEED += 5 * delta --- nerfed because it was too fast
			rotation += get_angle_to(player.position) * 5 * delta
		
		if(fly_bx):
			rotation = random_direction
		
		if(kill_bx):
			rotation += 20 * delta
		if(move_toward_player_bx):
			velocity = transform.x * SPEED
			move_and_slide()

pass

func reset_behaviors():
	tracking_bx = false
	move_toward_player_bx = false
	rotating_at_player_bx = false
	fly_bx = false
	spawn_bx = false
	kill_bx = false

func death():
	player_alive = false
	if(tween != null):
		tween.kill()
	reset_behaviors()
	kill_bx = true
	await get_tree().create_timer(1).timeout
	reset_behaviors()
	fly_bx = true
	move_toward_player_bx = true
	SPEED = 150
pass # Replace with function body.
