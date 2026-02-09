extends Node

@export var enemy: PackedScene
@export var spawn_on_ready := true
signal player_death
var enemy_array := []

func spawn_all():
	for i in enemy_array.size():
		if(enemy_array.get(i) != null):
			enemy_array.get(i).queue_free()
		enemy_array.remove_at(i)
	if(enemy == null):
		push_warning("EnemySpawner has no enemy scene assigned in it")
		return
	for child in get_children():
		if child is Marker2D:
			if(CameraBounds.is_in_bounds(child)):
				spawn_enemy(child.global_position)
	pass
	
func spawn_enemy(pos: Vector2):
	var spawn = enemy.instantiate()
	get_parent().add_child.call_deferred(spawn)
	spawn.global_position = pos
	player_death.connect(spawn.death)
	enemy_array.append(spawn)
	pass

func death():
	pass
