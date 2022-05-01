extends KinematicBody2D

const UP = Vector2(0, -1)
var velocity = Vector2()
var gravity = 1200
var direction = 1
var lag_time = 1
var is_grounded
var health = 2
var getting_hit = false
signal hitted
onready var anim_player = $AnimationPlayer


func _physics_process(delta):
	$Body.scale.x = direction
	
	velocity = move_and_slide(velocity, UP)
	velocity.y += gravity * delta
	
	is_grounded = is_on_floor()
	
	
	lag_time = clamp(lag_time, 0, Theworld.max_lag_time)
	lag_time -= Theworld.lag_time_minus
	
	if health <= 0:
		queue_free()
func _on_sword_attack_1_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("player"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 200
		body.velocity.x += 350 * $Body.scale.x
		body.lag_time += 0.3
		body.health -= 5

func _on_sword_attack_2_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("player"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 200
		body.velocity.x += 350 * $Body.scale.x
		body.lag_time += 0.3
		body.health -= 5

func _on_AnimationPlayer_animation_finished(anim_name):
	
	getting_hit = false
	$AnimationPlayer.play("idle")


func _on_Detector_area_entered(area):
	if getting_hit == false:
		var body = area.get_parent()
		if body.is_in_group("entity"):
			direction = 1
			$AnimationPlayer.play("attack")


func _on_DetectorRight2_area_entered(area):
	if getting_hit == false:
		var body = area.get_parent()
		if body.is_in_group("entity"):
			direction = -1
			$AnimationPlayer.play("attack")


func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box"):
		gravity = 1200
		$frame.stop()
		$frame.start()


func _on_frame_timeout():
	get_hit()

func get_hit():
	getting_hit = true
	emit_signal("hitted")
	anim_player.get_animation("hit").length = lag_time
	anim_player.get_animation("hit_on_air").length = lag_time
	anim_player.stop()
	anim_player.get_animation("hit").length = clamp(anim_player.get_animation("hit").length, 0 , 1.5)
	anim_player.get_animation("hit_on_air").length = clamp(anim_player.get_animation("hit_on_air").length, 0 , 1.5)
	if is_grounded:
		anim_player.play("hit")
	elif !is_grounded:
		anim_player.play("hit_on_air")
