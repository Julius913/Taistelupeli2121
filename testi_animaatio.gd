extends Node2D

func _ready():
	$AnimationPlayer.play("hasutus")


func _process(delta):
	
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.get_animation("hasutus").length = 5
	if Input.is_action_just_pressed("left"):
		$AnimationPlayer.get_animation("hasutus").length = 1
	if Input.is_action_just_pressed("right"):
		$AnimationPlayer.get_animation("hasutus").length = 3
		
