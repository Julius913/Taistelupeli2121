extends Control


var player = 1

func _ready():
		$CanvasLayer2/ColorRect.visible
		$Player1/AnimatedSprite.modulate = Theworld.player1_color
		$Player1/ColorPickerButton.color = Theworld.player1_color
		
		$Player2/AnimatedSprite2.modulate = Theworld.player1_color
		$Player2/ColorPickerButton2.color = Theworld.player1_color

func _on_ColorPickerButton_color_changed(color):
	$Player1/AnimatedSprite.modulate = color
	Theworld.player1_color = color


func _on_Button_pressed():
	$CanvasLayer2/ColorRect/AnimationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene("res://Title_screen.tscn")


func _on_ColorPickerButton2_color_changed(color):
	$Player2/AnimatedSprite2.modulate = color
	Theworld.player2_color = color


func _on_START_pressed():
	get_tree().change_scene("res://Map_select.tscn")
