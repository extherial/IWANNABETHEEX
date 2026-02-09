extends Node2D

func destroy_enemy():
	get_parent().queue_free()
