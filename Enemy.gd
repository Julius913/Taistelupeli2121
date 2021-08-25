extends KinematicBody2D

const UP = Vector2(0, -1)
var move_speed = 100
var gravity = 1000
var velocity = Vector2()
var move_direction = 1
var getting_hit = false
var lag_time = 0
var anim = "walk"
var detected = false
var health = 25
var energy = 100
var dead = 0
export var respawn_set = false
onready var animation = $AnimationPlayer
onready var raycast = $Body/RayCast2D

func _physics_process(delta):
	velocity.y += gravity * delta
	if getting_hit == false and detected == false:
		velocity.x = move_speed * move_direction
	velocity = move_and_slide(velocity, UP)
	
	energy += Theworld.energy_regenerate
	
	if getting_hit == true:
		velocity.x = lerp(velocity.x, 0, 0.01)
		anim = "hit"
	if energy >= 100:
		energy = 100
		
	if health >= 100:
		health = 100
	
	if health <= 0 and dead == 0:
		dead()
	
	if getting_hit == false and detected == false:
		$Body.scale.x = move_direction
	
	animation.get_animation("hit").length = lag_time
	if lag_time >= 1.5:
		lag_time = 1.5
	
	if getting_hit == false:
		if is_on_wall() == true:
			move_direction *= -1
		
func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box") and dead == 0:
			getting_hit = true
			$AudioStreamPlayer.play()
			$AnimationPlayer.stop()
			$AnimationPlayer.play("hit")
			
			
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		print("ENEMY_LAG_ENDED")
		getting_hit = false
		gravity = 1000
		detected = false
		$AnimationPlayer.play("walk")
		
	if anim_name == "punch":
		detected = false
		$AnimationPlayer.play("walk")
	
func dead():
	dead = 1
	velocity.x = 0
	velocity.y = 0
	gravity = 0
	$dead_sound.play()
	getting_hit = true
	detected = true
	$AnimationPlayer.play("dead")
	$Particles2D.emitting = true
	if respawn_set == true:
		$respawn.start()

func _on_punch_detect_body_entered(body):
		if getting_hit == false and detected == false and anim != "hit":
			print("DETECTED")
			punch()

func punch():
	detected = true
	$AudioStreamPlayer2.play()
	$AnimationPlayer.play("punch")
	energy -= 10
	velocity.y = 0
	velocity.x = 0

func _on_punch_hitbox_body_entered(body):
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 250
		body.velocity.x += 150 * move_direction
		body.lag_time += 0.9
		body.health -= 9


func _on_respawn_timeout():
	self.position = get_parent().get_node("Spawn2").global_position
	$AnimationPlayer.play("walk")
	dead = 0
	health = 50
	energy = 100
	gravity = 1000
	lag_time = 0
	getting_hit = false
	detected = false
