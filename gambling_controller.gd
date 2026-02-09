extends Node

@export var slot_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(Input.is_action_just_pressed("spin")):
		#var slot = slot_scene.instantiate()
		#slot.get_node("Slot").position = Vector2(get_parent().get_node("Node2D/Player").position.x + 600, get_parent().get_node("Node2D/Player").position.y + 20)
		#add_child(slot)
		#var slot2 = slot_scene.instantiate()
		#slot2.get_node("Slot").position = Vector2(get_parent().get_node("Node2D/Player").position.x + 632, get_parent().get_node("Node2D/Player").position.y + 20)
		#add_child(slot2)
		#var slot3 = slot_scene.instantiate()
		#slot3.get_node("Slot").position = Vector2(get_parent().get_node("Node2D/Player").position.x + 664, get_parent().get_node("Node2D/Player").position.y + 20)
		#add_child(slot3)
	pass
