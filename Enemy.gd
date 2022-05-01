extends KinematicBody2D

const UP = Vector2(0, -1)
var move_speed = 50
var gravity = 1000
var velocity = Vector2()
var move_direction = 1
var getting_hit = false
var lag_time = 0.001
var anim = "walk"
var detected = false
var health = 20
var energy = 100
var dead = 0
var punish = false
export var respawn_set = false
onready var animation = $AnimationPlayer
onready var raycast = $Body/RayCast2D

func _physics_process(delta):
	velocity.y += gravity * delta
	
	
	if getting_hit == false and detected == false:
		animation()
		if is_on_floor():
			velocity.x = move_speed * move_direction
		else:
			velocity.x = move_speed/2 * move_direction
	
	velocity = move_and_slide(velocity, UP)
	energy += Theworld.energy_regenerate
	
		
	if energy >= 100:
		energy = 100
		
	if health >= 100:
		health = 100
	
	if health <= 0 and dead == 0:
		dead()
	
	if getting_hit == false and detected == false:
		$Body.scale.x = move_direction
	
	lag_time -= Theworld.lag_time_minus
	if lag_time <= 0:
		lag_time = 0
	
	if lag_time >= 1.5:
		lag_time = 1.5
	
	if $Body/RayCast2D.is_colliding() == false and is_on_floor():
		move_direction *= -1
	if move_direction == 1:
		$Body/RayCast2D.position.x = 16
	else:
		$Body/RayCast2D.position.x = -16
	
	
	if getting_hit == false:
		if is_on_wall() == true:
			move_direction *= -1
		
func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box") and dead == 0:
		$frame.start()
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit" and getting_hit == true:
		print("ENEMY_LAG_ENDED")
		getting_hit = false
		gravity = 1000
		detected = false
	if anim_name == "punch":
		detected = false
	
func dead():
	dead = 1
	velocity.x = 0
	velocity.y = 0
	gravity = 0
	$dead_sound.play()
	$blood_splash.emitting = true
	getting_hit = true
	detected = true
	$AnimationPlayer.play("dead")
	#$Particles2D.emitting = true
	if respawn_set == true:
		$respawn.start()

func animation():
	if is_on_floor():
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("on_air")

func _on_punch_detect_body_entered(body):
	if getting_hit == false and detected == false and $AnimationPlayer.current_animation != "hit":
		print("DETECTED")
		punch()

func punch():
	if getting_hit == false:
		detected = true
		$AudioStreamPlayer2.play()
		$AnimationPlayer.play("punch")
		energy -= 10
		velocity.y = 0
		velocity.x = 0


func _on_respawn_timeout():
	self.position = get_parent().get_node("Spawn2").global_position
	dead = 0
	health = 20
	energy = 100
	gravity = 1000
	lag_time = 0
	getting_hit = false
	detected = false


func _on_punch_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 150
		body.velocity.x += 100 * $Body.scale.x
		body.lag_time += 0.15
		body.health -= 4

func get_hit():
	if dead == 0:
		print("lag started")
		getting_hit = true
		$AudioStreamPlayer.play()
		animation.get_animation("hit").length = lag_time
		if animation.get_animation("hit").length >= 1.5:
			animation.get_animation("hit").length = 1.5
			animation.stop()
			animation.play("hit")
		else:
			animation.stop()
			animation.play("hit")
func _on_frame_timeout():
	if dead == 0:
		get_hit()
