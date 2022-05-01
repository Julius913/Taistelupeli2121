extends Node2D


func _on_void_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.dead()
