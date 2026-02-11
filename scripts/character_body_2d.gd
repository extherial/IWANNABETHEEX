extends CharacterBody2D

class_name Player





#region Movement
const SPEED = 120.0
var facing = 1
#endregion

#region Jump Variables
var gravity_force = 0
const JUMP_VELOCITY = -263
const LOW_GRAVITY = 900
const HIGH_GRAVITY = 1300
const FALLING_GRAVITY = 1100
var able_to_jump
var double_jump = false
@export var max_falling_speed := 1200
#endregion

#region Health and Death
const PLAYERHEALTH = 10
var health
var already_dead = false
@export var blood_scene: PackedScene
#endregion

var in_cutscene = false






#called on start
func _ready() -> void:
	$AnimationPlayer.speed_scale = 1.5
	health = PLAYERHEALTH
	show()
	pass
#makes jumping consistent and not janky
func can_jump():
	if(is_on_floor()):
		double_jump = true
		able_to_jump = true
		$Coyote_Time.start()
	if(Input.is_action_just_pressed("shoot") && !already_dead):
		$Gun_Controller.shoot(facing)

#checks for basic inputs
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Respawn")):
		respawn()
	if(event.is_action_pressed("down")):
		set_collision_mask_value(5, false)
		print("false")
	elif(event.is_action_released("down")):
		print("true")
		set_collision_mask_value(5, true)
	pass


func _physics_process(delta: float) -> void:
	can_jump()
	if(!already_dead):
#region Jump Logic + Gravity
		if(!is_on_floor() && double_jump && Input.is_action_just_pressed("jump") && !able_to_jump):
				$Audio/jump_1.play()
				print("double jump")
				velocity.y = JUMP_VELOCITY / 1.2
				double_jump = false
		if Input.is_action_just_pressed("jump"):
			if(able_to_jump):
				$Audio/jump_2.play()
				velocity.y = JUMP_VELOCITY
				able_to_jump = false
		#MAIN FUNCTIONALITY OF GRAVITY AND ITS RELATION TO JUMPING
		if (velocity.y < 0):
			if(Input.is_action_pressed("jump")):
				$AnimationPlayer.play("jump")
				gravity_force = LOW_GRAVITY
			else: #when you let go of jump
				gravity_force = HIGH_GRAVITY #sets gravity to a sharp high
		else:
			gravity_force = FALLING_GRAVITY
			if(not is_on_floor()):
				$AnimationPlayer.play("fall")
		if(velocity.y < max_falling_speed):
			velocity.y += gravity_force * delta
#endregion

#region Moevement and Directionality
		var direction := Input.get_axis("left", "right")
		if is_on_floor():
			if direction:
				$AnimationPlayer.play("walk")
			else:
				$AnimationPlayer.play("idle")
		if direction == -1:
			#$animation.rotation_degrees = 180
			$animation.flip_h = true
			facing = -1
		if direction == 1:
			facing = 1
			$animation.flip_h = false
		if direction:
			velocity.x = direction * SPEED 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
#endregion

#region Outside interactions: checking for spikes, jump pads, etc
		if(!in_cutscene):
			move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			#Spike Layer 6
			if(PhysicsServer2D.body_get_collision_mask(collision.get_collider_rid()) == 32):
				death()
#endregion

#handles logic for when player hits "R" to respawn
func respawn():
	CutsceneHandler.set_cutscene("none")
	position = SpawnManager.get_spawn()
	velocity = SpawnManager.get_velocity()
	double_jump = true
	already_dead = false
	$HitboxComponent.set_monitoring(true)
	$HitboxComponent.set_monitorable(true)
	show()
	PlayerDeathSignal.emit_signal("screen_update")

#handles the logic immediately after dying
func death():
	$Audio/death_sound.play()
	PlayerDeathSignal.emit_signal("player_death")
	CutsceneHandler.set_cutscene("none")
	$HitboxComponent.set_monitoring(false)
	$HitboxComponent.set_monitorable(false)
	if(!already_dead):
		self.hide()
		var blood = blood_scene.instantiate()
		get_parent().add_child(blood)
		blood.global_position = self.position
		blood.one_shot = true
		blood.restart()
		already_dead = true
	
	
	#particle explosion of blood
	#sound effect
	pass

#handles all the collision check logic for enemies and cutscenes
func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") || area.is_in_group("spike") :
		if(!already_dead):
			death()
	if area.is_in_group("cutscene_trigger"):
		in_cutscene = true
		self.modulate = Color(0.232, 0.27, 0.287, 1.0)
	pass # Replace with function body.

#end of cutscene logic (JANKY and should be CHANGED)
func _on_hitbox_component_area_exited(area: Area2D) -> void:
	if area.is_in_group("cutscene_trigger"):
		in_cutscene = false
		self.modulate = Color(1, 1, 1, 1.0)
	pass # Replace with function body.

#Handles Coyote Time
func _on_coyote_time_timeout() -> void:
	able_to_jump = false
	pass # Replace with function body.

#jump pad timer and falloff to avoid LAUNCHING you; 
#should probably look into a better implementation
