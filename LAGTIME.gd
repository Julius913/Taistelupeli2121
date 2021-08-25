extends TextureProgress



func _physics_process(delta):
	value = get_parent().get_parent().get_node("Player").lag_time
