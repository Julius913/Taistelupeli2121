extends TextureProgress


var player = 1


func _physics_process(delta):
	if player == 1:
		value = get_parent().get_parent().get_parent().get_node("Player1").get_node("Player").lag_time
	else:
		value = get_parent().get_parent().get_parent().get_node("Player2").get_node("Player").lag_time
