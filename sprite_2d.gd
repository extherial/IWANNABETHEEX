extends Sprite2D


@onready var timer = $Flash 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hitbox_component_enemy_damaged(attack) -> void:
	print("dfgouih")
	damage_flash()
	pass # Replace with function body.


func _on_flash_timeout() -> void:
	self_modulate = Color(1, 1, 1, 1)


	pass # Replace with function body.
#
#Cool function that allows color tweening / unused but is nice
func flash_color_tween(color: Color):
	self_modulate = color
	pass

func damage_flash():
	self_modulate = Color(1.5, 1.5, 1.5, 1)
	timer.start()
	pass


func _on_flash_delay_timeout() -> void:
	#create_tween().tween_method(flash_color_tween, Color(1.5, 1.5, 1.5, 1), Color(1, 1, 1, 1), 1)
	pass # Replace with function body.
