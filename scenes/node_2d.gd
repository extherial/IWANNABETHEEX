extends Node2D

var song_list := []
var current_song: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SongHandler.connect("change_song", set_song)
	
	for i in get_children():
		song_list.append(i.name)
	pass # Replace with function body.

func update_screen():
	SongHandler.set_song(SongHandler._get_song())
	global_position = CameraBounds.get_cam_position()

func set_song(song_name: String):
	print(current_song, "   ", song_name)
	if(song_name != current_song):
		for i in song_list.size():
			if(song_list.get(i) == current_song):
				get_node(current_song).stop()
			if(song_list.get(i) == song_name):
				print("found and playing: ", song_name)
				get_node(song_name).play()
				current_song = song_list.get(i)
				
	pass
