extends Control

onready var c_rect = get_node("ColorRect")
onready var rect_anim = get_node("ColorRect/AnimationPlayer")

var change_scene_to = null

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		c_rect.hide()
	elif anim_name == "fade_out":
		get_tree().change_scene(change_scene_to)


func _on_START_pressed():
	change_scene_to = "res://ColorPickerTest.tscn"
	c_rect.show()
	rect_anim.play("fade_out")


func _on_OPTIONS_pressed():
	c_rect.show()
	rect_anim.play("fade_out")
	change_scene_to = "res://Test_World.tscn"

func _on_QUIT_pressed():
	get_tree().quit()
