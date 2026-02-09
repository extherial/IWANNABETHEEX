extends Node2D
class_name HealthComponent

var health
@export var MAX_HEALTH := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH
	pass # Replace with function body.

func damage(attack: Attack):
	health -= attack.attack_damage
	print (health)
	if(health <= 0):
		get_parent().queue_free()
