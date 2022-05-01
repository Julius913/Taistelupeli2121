extends Node


var music = load("res://music/menu_theme_trophy.wav")

func _ready():
	play_music()
	
func play_music():
	$Music.stream = music
	$Music.play()
