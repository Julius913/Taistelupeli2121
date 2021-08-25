extends Area2D



func _ready():
	

func _process(delta):
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "break":
		queue_free()


func _on_bridge_body_entered(body):
	if body.is_in_group("zombie") and body.is_on_floor():
		$AnimationPlayer.play("break")
