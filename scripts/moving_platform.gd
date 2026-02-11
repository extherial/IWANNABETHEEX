extends Path2D
class_name MovingPlatform

@export var path_time = 1.0
@export var looping = false
@export var path_follow_2D : PathFollow2D
@export var easing : Tween.EaseType
@export var trans : Tween.TransitionType


func _ready() -> void:
	move_tween()
	pass # Replace with function body.

func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(easing).set_trans(trans)
	if(looping):
		tween.tween_property(path_follow_2D, "progress_ratio", 0, path_time).set_ease(easing).set_trans(trans)
	else: 
		tween.tween_property(path_follow_2D, "progress_ratio", 0, 0.0).set_ease(easing).set_trans(trans)
