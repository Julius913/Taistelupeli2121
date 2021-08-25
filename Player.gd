extends KinematicBody2D

const UP = Vector2(0, -1)
var velocity = Vector2()
var move_speed = 180
var move_speed_normal
var gravity = 1000
var gravity_normal
var direction
var is_grounded
var jump_velocity = -500
var jump_velocity2
var anim = "idle"
var frame = 0.1633
var animation_stop = false
var move_direction2
var move_direction = 1
var triple_jump = 2
var no_direction_change = false
var crounching = false
var enable_jump = true
var enable_crouching = true
var lag_time = 0
var getting_hit = false
var energy = 100
var health = 100
var death = 0
var rng = RandomNumberGenerator.new()
var random_position
var rolling = false
onready var test_tween = get_node("TEST_TWEEN")
onready var anim_sprite = get_node("Body/AnimatedSprite")
onready var anim_player = $AnimationPlayer


func _ready():
	#bbodsbosdbjsldbjk
	jump_velocity2 = jump_velocity
	gravity_normal = gravity
	move_speed_normal = move_speed
func _physics_process(delta):
	animation()
	_get_input()
	velocity.y += gravity * delta
	is_grounded = is_on_floor()
	
	rng.randomize()
	random_position = rng.randf_range(-20.0, 20.0)
	$Position2D.position.x = random_position
	
	
	if getting_hit == true:
		velocity.x = lerp(velocity.x, 0, 0.01)
	
	if crounching == false:
		energy += Theworld.energy_regenerate
	else:
		energy += Theworld.energy_regenerate * 1.20
	
	if energy >= 100:
		energy = 100
	
	if health >= 100:
		health = 100
	
	if health <= 0 and death == 0:
		dead()
	
	lag_time -= Theworld.lag_time_minus
	if lag_time <= 0:
		lag_time = 0
	if lag_time >= 1.5:
		lag_time = 1.5
	
	anim_player.get_animation("hit").length = lag_time
	
	if move_direction2 == 1:
		move_direction = 1
	if move_direction2 == -1:
		move_direction = -1
	if is_grounded:
		triple_jump = 1
	
	velocity = move_and_slide(velocity, UP)

	if Input.is_action_just_pressed("jump") and triple_jump > 0 and enable_jump == true and getting_hit == false and crounching == false:
		if is_grounded == true:
			velocity.x = 0
			animation_stop = true
			enable_crouching = false
			enable_jump = false
			no_direction_change = true
			anim = "jump_squat"
		else:
			triple_jump -= 1
			velocity.y = jump_velocity
		
	if Input.is_action_just_pressed("down") and !is_grounded and animation_stop == false and getting_hit == false:
		velocity.y = -jump_velocity
		$Node/star.position = $Position2D.global_position
		$for_star.play("flash")
		
	if Input.is_action_pressed("down") and is_grounded and enable_crouching == true and getting_hit == false and rolling == false:
		move_speed = 0
		crounching = true
		animation_stop = true
		anim = "crouch"
	if Input.is_action_just_pressed("right") and crounching == true and is_grounded:
		rolling = true
		crounching = false
		animation_stop = true
		no_direction_change = true
		anim = "roll2"
		move_speed = move_speed_normal
		enable_jump = false
		velocity.x = 0
		velocity.x = 200
	if Input.is_action_just_pressed("left") and crounching == true and is_grounded:
		rolling = true
		crounching = false
		animation_stop = true
		no_direction_change = true
		anim = "roll2"
		move_speed = move_speed_normal
		enable_jump = false
		velocity.x = 0
		velocity.x = -200
	if Input.is_action_just_released("down") and crounching == true and rolling == false:
		move_speed = move_speed_normal
		crounching = false
		animation_stop = false
		anim = "idle"
	
	if Input.is_action_just_pressed("Q_punch") and animation_stop == false and getting_hit == false and energy >= 40:
		energy -= 35
		animation_stop = true
		enable_crouching = false
		enable_jump = false
		anim = "shurjuken"
		no_direction_change = true
		gravity = 0
		velocity.y = 0
		velocity.y = lerp(velocity.y, -300, 0.5)
		move_speed = 0
		velocity.x = 0
		no_direction_change = true
	if Input.is_action_just_pressed("E_punch") and animation_stop == false and energy >= 10:
		energy -= 7.5
		enable_crouching = false
		animation_stop = true
		no_direction_change = true
		anim = "punch"
		enable_jump = false
		velocity.x = 0
		move_speed = 0
	if Input.is_action_just_pressed("punch_barrage") and animation_stop == false and is_grounded and getting_hit == false and energy >= 30:
		animation_stop = true
		energy -= 30
		anim = "punch_barrage"
		enable_crouching = false
		enable_jump = false
		no_direction_change = true
		velocity.y = 0
		velocity.x = 0
		move_speed = 10
		no_direction_change = true
	if Input.is_action_just_pressed("punch_barrage") and animation_stop == false and !is_grounded and getting_hit == false and energy >= 30:
		animation_stop = true
		energy -= 30
		anim = "punch_barrage"
		enable_crouching = false
		no_direction_change = true
		move_speed = 30
		gravity = 75
		jump_velocity = -100
		velocity.y = 0
		velocity.x = 25 * move_direction2
		no_direction_change = true
	if Input.is_action_just_pressed("kick") and animation_stop == false and is_grounded and getting_hit == false and energy >= 15:
		animation_stop = true
		energy -= 15
		anim = "kick"
		no_direction_change = true
		enable_crouching = false
		enable_jump = false
		move_speed = 0
		velocity.x = 0
		velocity.x = 5 * -move_direction2
		velocity.y = 0
	if Input.is_action_just_pressed("down"):
		
		print(lag_time)

func _get_input():
		if no_direction_change == false and getting_hit == false:
			move_direction2 = -int(Input.is_action_pressed("left")) + int(Input.is_action_pressed("right"))
			velocity.x = lerp(velocity.x, move_speed * move_direction2, 1)
			if move_direction2 != 0 and is_grounded: #might broke
				$Body.scale.x = move_direction2

	
func animation():
	
	anim_player.play(anim)
	if animation_stop == false:
		if velocity.x != 0 and velocity.y == 0 and is_on_floor():
				anim = "walk"
		elif velocity.y != 0 and !is_grounded:
			anim = "jump"
		else:
			anim = "idle"

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		print("lag ended")
		enable_jump = true
		enable_crouching = true
		getting_hit = false
		animation_stop = false
		print(lag_time, "_CURRENT LAG_TIME_END_2")
		print(anim_player.get_animation("hit").length, "__CURRENT_ANIMATION_LENGHT_END_2")
		
	if anim_name == "punch" or "kick" or "punch_barrage" or "shurjuuken":
		animation_stop = false
		anim = "idle"
		move_speed = move_speed_normal
		enable_jump = true
		enable_crouching = true
		jump_velocity = jump_velocity2
		gravity = gravity_normal
		no_direction_change = false
		
	if anim_name == "jump_squat":
		enable_jump = true
		enable_crouching = true
		animation_stop = false
		no_direction_change = false
		triple_jump -= 1
		velocity.y = jump_velocity
	if anim_name == "roll2":
		no_direction_change = false
		enable_jump = true
		rolling = false
		crounching = false
		animation_stop = false


func dead():
	print("DEAD")
	velocity.x = 0
	velocity.y = 0
	gravity = 0
	$AudioStreamPlayer2.play()
	animation_stop = true
	getting_hit = true
	enable_crouching = false
	enable_jump = false
	anim = "dead"
	death = 1
	$respawn.start()


func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box"):
			getting_hit = true
			enable_jump = false
			enable_crouching = false
			animation_stop = true
			$AudioStreamPlayer2.play()
			anim_player.stop()
			anim_player.get_animation("hit").length = lag_time
			anim_player.play("hit")
			anim = "hit"
			print(anim_player.get_animation("hit").length, "__CURRENT_ANIMATION_LENGHT_START_1")
			print(lag_time, "__CURRENT_LAGTIME_START_1")


func _on_respawn_timeout():
	self.position = get_parent().get_node("Spawn1").global_position
	health = 100
	energy = 100
	gravity = gravity_normal
	animation_stop = false
	getting_hit = false
	enable_crouching = true
	enable_jump = true
	lag_time = 0
	death = 0
	print("RESPAWNED")


func _on_Punch_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 150
		body.velocity.x += 100 * move_direction
		body.lag_time += 0.20
		body.health -= 2


func _on_Shurjuken_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.y -= 225
		body.velocity.x = 50 * -move_direction
		body.lag_time += 0.2
		body.health -= 6


func _on_Shurjuken_finisher_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.lag_time += 0.25
		body.velocity.y = 0
		body.velocity.y -= 400
		body.health -= 10


func _on_kick_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.y -= 300
		body.velocity.x += 50 * move_direction2
		body.lag_time += 0.75
		body.health -= 5


func _on_punch_barrage_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y = 0
		body.velocity.y -= 10
		body.velocity.x = 0
		body.velocity.x += 2 * move_direction2
		body.lag_time += 0.2
		body.health -= 0.5


func _on_punch_barrage_finish_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("zombie"):
		body.velocity.y -= 400
		body.velocity.x += 200 * move_direction
		body.lag_time += 0.5
		body.health -= 5
