extends KinematicBody2D

const UP = Vector2(0, -1)
var velocity = Vector2()
var health = 25
var lag_time = 0

var gravity = 100

func _ready():
	pass


func _physics_process(delta):
	
	
	
	if health <= 0:
		death()

	if $RayCast2D.is_colliding():
		scale.x * -1
	else:
		pass

func death():
	queue_free()

func hit():
	$modulate.play("hit")


func _on_Hitbox_area_entered(area):
	if area.is_in_group("hit_box"):
		$frame.start()


func _on_frame_timeout():
	hit()

