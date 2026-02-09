extends CharacterBody2D
class_name Enemy

@onready var sprite = Sprite2D

var direction = -1
@export var speed = 10

@export var gravity = 9.81
var falling_gravity = 100

var moving_right = false

func _ready() -> void:
	$AnimatedSprite2D.play("walk")

func death():
	pass



func _physics_process(delta: float) -> void:
	if(is_on_floor()):
		falling_gravity = 100
	else:
		velocity.y += (gravity * falling_gravity) * delta
	
	if(Input.is_action_just_pressed("dev")):
		velocity.y = -500
		
		
	if(moving_right):
		velocity.x = 50
		#$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = -50
		#$AnimatedSprite2D.flip_h = false
	
	move_and_slide()
	pass



func _on_hitbox_component_body_entered(body: Node2D) -> void:
	if(body.is_in_group("ground")):
		
		moving_right = !moving_right
	pass # Replace with function body.
