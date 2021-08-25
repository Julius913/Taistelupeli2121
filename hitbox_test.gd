extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_hitbox_test_body_entered(body):
	if body.is_in_group("zombie"):
		body.lag_time += 0.5
		body.velocity.x = 0
		body.velocity.y = 0
		body.velocity.x += 200 * body.move_direction
		body.velocity.y -= 200
		
