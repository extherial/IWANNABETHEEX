extends Node

var start_roll = false
var rolling = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_roll = true
	print("rolling... ", start_roll)
	await get_tree().create_timer(2).timeout
	start_roll = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(start_roll && $Slot/slot_delay.is_stopped()):
		$Slot/slot_delay.start()
	pass

func _on_slot_delay_timeout() -> void:
	$Slot/AnimatedSprite2D.set_frame(randi_range(0,2))
	pass # Replace with function body.
