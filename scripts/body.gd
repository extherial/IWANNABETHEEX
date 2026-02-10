extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var move = true
func _ready() -> void:
	
	
	velocity = Vector2(randf_range(0,1000), randf_range(0,1000))
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if(move):
		move_and_slide()
	var collision = move_and_collide(velocity)
	var collider
	if collision:
		collider = PhysicsServer2D.body_get_collision_mask(collision.get_collider_rid())
		if(collider == 4 || collider == 5 || collider == 6 || collider == 1):
			move = false
		pass
