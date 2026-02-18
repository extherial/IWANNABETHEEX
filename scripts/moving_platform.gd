extends Path2D
class_name MovingPlatform

@export var path_time = 1.0
@export var looping = false
@export var path_follow_2D : PathFollow2D
@export var easing : Tween.EaseType
@export var trans : Tween.TransitionType
@export var one_way := true

func _ready() -> void:
	move_tween()
	if(one_way == true):
		$AnimatableBody2D.set_collision_layer_value(5, true)
		$AnimatableBody2D.set_collision_layer_value(4, false)
		$AnimatableBody2D/CollisionShape2D.one_way_collision = true
	else:
		$AnimatableBody2D.set_collision_layer_value(5, false)
		$AnimatableBody2D.set_collision_layer_value(4, true)
		$AnimatableBody2D/CollisionShape2D.one_way_collision = false
	pass # Replace with function body.

func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(easing).set_trans(trans)
	if(looping):
		tween.tween_property(path_follow_2D, "progress_ratio", 0, path_time).set_ease(easing).set_trans(trans)
	else: 
		tween.tween_property(path_follow_2D, "progress_ratio", 0, 0.0).set_ease(easing).set_trans(trans)
