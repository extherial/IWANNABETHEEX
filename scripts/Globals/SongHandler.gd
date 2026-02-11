extends Node

var song := ""
signal change_song


func _set_song(name: String):
	if(name != null):
		song = name
		change_song.emit(song)

func _get_song():
	return song
