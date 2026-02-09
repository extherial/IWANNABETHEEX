extends Node2D
var already_hit = false
var dir = 1
@export var speed := 1000
var attack_damage := 1
var knockback_force := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += (speed * dir) * delta
	pass
#convert to move_and_collide so the collisions are dealt with extremely fast!


func _on_area_2d_area_entered(area) -> void:
	if area is HitboxComponent && already_hit == false && area.is_in_group("enemy"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		area.damage(attack)
		already_hit = true
		queue_free()
	if area is SpawnBlockHitBox && already_hit == false:
		get_parent().setspawn()
		already_hit = true
		queue_free()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group("ground")):
		already_hit = true
		queue_free()
	pass # Replace with function body.
