extends Control

var selected_map = null


func _on_Select_pressed():
	$CanvasLayer2/ColorRect/AnimationPlayer.play("fade_out")
	selected_map = "res://Fighting_Stage.tscn"

func _on_Button_pressed():
	$CanvasLayer2/ColorRect/AnimationPlayer.play("fade_out")
	selected_map = "res://ColorPickerTest.tscn"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene(selected_map)
		
		
