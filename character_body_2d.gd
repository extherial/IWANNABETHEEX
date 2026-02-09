extends CharacterBody2D

class_name Player

const SPEED = 120.0
const JUMP_VELOCITY = -263
const LOW_GRAVITY = 900
const HIGH_GRAVITY = 1300
const FALLING_GRAVITY = 1100
var able_to_jump
var gravity_force = 0

var can_dash = false
var sprint_speed = 0
const PLAYERHEALTH = 10
var health
var facing = 1
var double_jump = false
var already_dead = false
@export var blood_scene: PackedScene
@export var max_falling_speed := 1200


var in_cutscene = false


func _ready() -> void:
	$AnimationPlayer.speed_scale = 1.5
	health = PLAYERHEALTH
	show()
	pass

func can_jump():
	if(is_on_floor()):
		able_to_jump = true
	else:
		await get_tree().create_timer(0.1).timeout
		able_to_jump = false

func _physics_process(delta: float) -> void:
	can_jump()
	if(Input.is_action_just_pressed("Respawn")):
		respawn()
	
	if(!already_dead):
		if(Input.is_action_just_pressed("shoot")):
			$Gun_Controller.shoot(facing)
		
		if(sprint_speed > 0):
			sprint_speed -= 3500 * delta
			velocity.y = 0
			
		if(sprint_speed < 0):
			sprint_speed = 0
		if(sprint_speed == 0 && is_on_floor()):
			can_dash = true
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			if(able_to_jump):
				$Audio/jump_2.play()
				double_jump = true
				velocity.y = JUMP_VELOCITY
			elif(double_jump):
				$Audio/jump_1.play()
				velocity.y = JUMP_VELOCITY / 1.2
				double_jump = false
				
		if (velocity.y < 0):
			if(Input.is_action_pressed("jump")):
				$AnimationPlayer.play("jump")
				gravity_force = LOW_GRAVITY
			else: #when you let go of jump
				gravity_force = HIGH_GRAVITY #sets gravity to a sharp high
	#stops setting gravity to high when your upward velocity is 0
		else:
			gravity_force = FALLING_GRAVITY
			
			if(not is_on_floor()):
				$AnimationPlayer.play("fall")
		 
		
		if(velocity.y < max_falling_speed):
			velocity.y += gravity_force * delta
		
		
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
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
			velocity.x = direction * SPEED + (sprint_speed * direction)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED + sprint_speed)
		if(!in_cutscene):
			move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if(PhysicsServer2D.body_get_collision_mask(collision.get_collider_rid()) == 32):
				death()
			
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


func death():
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
func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") || area.is_in_group("spike") :
		if(!already_dead):
			death()
	if area.is_in_group("cutscene_trigger"):
		in_cutscene = true
		self.modulate = Color(0.232, 0.27, 0.287, 1.0)
	pass # Replace with function body.

func _on_hitbox_component_area_exited(area: Area2D) -> void:
	if area.is_in_group("cutscene_trigger"):
		in_cutscene = false
		self.modulate = Color(1, 1, 1, 1.0)
	pass # Replace with function body.
