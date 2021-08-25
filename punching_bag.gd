extends KinematicBody2D
const UP = Vector2(0, -1)
var velocity = Vector2()
var gravity = 1000
var lag_time = 0
var move_direction = 1
var health = 100
func _physics_process(delta):
	$AnimationPlayer.get_animation("hit").length = lag_time
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, UP)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 0.8)
	get_parent().scale.x = move_direction
	
	if lag_time >= 2:
		lag_time = 2
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hit")
		$AudioStreamPlayer.play()
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		$AnimationPlayer.play("idle")
		gravity = 1000
