extends Area2D


func _on_lava_area_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.lag_time += 0.25
		body.velocity.y += -550
		body.velocity.x += 250 * body.move_direction
		body.health -= 25
