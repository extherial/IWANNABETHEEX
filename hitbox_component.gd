extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
signal enemy_damaged


func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
		enemy_damaged.emit(attack)
