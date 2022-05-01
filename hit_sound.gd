extends Node2D

var hit_sound1 = load("res://jalmari_hurt_sound1.wav")
var hit_sound2 = load("res://jalmari_hurt_sound2.wav")
var hit_sound3 = load("res://jalmari_hurt_sound3.wav")

var random_sound = null
var rng = RandomNumberGenerator.new()

func _on_Timer_timeout():
	random_sound = rng.randf_range(0, 3)

func play_sound():
	random_sound = rng.randf_range(0, 3)
	if random_sound <= 1:
		$hit_sound.stream = hit_sound2
		$hit_sound.play()
	elif random_sound <= 2:
		$hit_sound.stream = hit_sound1
		$hit_sound.play()
	elif random_sound <= 3:
		$hit_sound.stream = hit_sound3
		$hit_sound.play()
