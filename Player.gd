extends KinematicBody2D

const UP = Vector2(0, -1)
const BULLET = preload("res://Bullet.tscn")
const STAR = preload("res://star_glitter.tscn")
const SMOKE = preload("res://SMOKE.tscn")
var velocity = Vector2()
var move_speed = 180 #running speed
var move_speed_normal #for setting running speed back to normal
var gravity = 1200 #just gravity
var gravity_normal #sets gravity back to normal
var is_grounded #same as is on floor()
var jump_velocity = -500 #jump high
var jump_velocity2
var anim = "idle" #sets animation
var animation_stop = false #sets off constantly running animations so you can play other animations
var move_direction2
var move_direction = 1
var triple_jump = 2 #triple/double jump
var no_direction_change = false #cant change direction if set to true
var crounching = false #if player is crouching this is set to true
var enable_jump = true #if set to false player cant jump
var enable_crouching = true #if set to false player cant crouch
var lag_time = 0.001 #if something hits the player the player goes to lagtime where he cant move
var getting_hit = false #if player gets hit this is set to true
var energy = 100 #if energy is at 0 player cant make fight moves
var health = 50 #players health
var health_normal
var death = 0 #if player dies this is set to 1 and after respawn its back to 0
var rng = RandomNumberGenerator.new() #randomnumbergenerator for fastfall effect
var random_position #for rng generator
var rolling = false #if player rolls this is set to true
var regenerate_energy = true #if false energy doesnt regenerate
var start_regenating_again
var player = 1
var invisible = false
var hit_air_timer = 0

signal hitted
signal dead
"""ONREADY VARIABLES"""

onready var test_tween = get_node("TEST_TWEEN")
onready var anim_sprite = get_node("Body/AnimatedSprite")
onready var anim_player = $AnimationPlayer
onready var e_timer = get_node("EnergyTimer")
onready var color_anim = $ModulateAnimPlayer

#controls

var jump = "jump"
var down = "down"
var right = "right"
var left = "left"
var punch = "punch"
var kick = "kick"
var shoot = "shoot"
var punch_barrage = "punch_barrage"

func _ready():
	
	$Area2D/CollisionShape2D.disabled = false
	
func _physics_process(delta):
	if player == 1:
		$Body/AnimatedSprite.self_modulate = Theworld.player1_color
		$Body/fists.self_modulate = Theworld.player1_color
		$Body/fists2.self_modulate = Theworld.player1_color
	if player == 2:
		$Body/AnimatedSprite.self_modulate = Theworld.player2_color
		$Body/fists.self_modulate = Theworld.player2_color
		$Body/fists2.self_modulate = Theworld.player2_color
	animation()
	_get_input()
	
	velocity.y += gravity * delta
	is_grounded = is_on_floor()
	
	
	"""RANDOMIZER FOR FASTFALL EFFECT"""
	rng.randomize()
	random_position = rng.randf_range(-20.0, 20.0)
	$START_POS.position.x = random_position
	
	
	
	"""SETS PLAYER COLORS"""
	
	if getting_hit == false and death != 1:
		if invisible == false:
			color_anim.play("default")  
		else:
			color_anim.play("invisible")
	
	
	if is_grounded == false:
		move_speed = 150
	else:
		move_speed = move_speed_normal
		if anim == "air_forward_attack":
			anim = "air_forward_attack_get_up"
			velocity.x = 0
		if anim == "hit_on_air":
			if hit_air_timer >= 2:
				$fire.emitting = true
				getting_hit = false
				no_direction_change = true
				anim = "air_forward_attack_get_up"
				velocity.x = 0
			else:
				anim = "hit"
		if anim == "shoot_in_air" or anim == "nair" or anim == "down_air":
			anim = "sia_get_up"
			velocity.x = 0
	
	if anim == "hit_on_air":
		hit_air_timer += 0.1
	else:
		if is_grounded:
			hit_air_timer = 0
	
	if is_grounded:
		triple_jump = 2
	
	velocity = move_and_slide(velocity, UP)
	
	"""JUMP INPUT"""
	
	if Input.is_action_just_pressed(jump) and triple_jump > 0 and enable_jump == true and getting_hit == false and crounching == false: #jump
		if is_grounded == true:
			velocity.x = velocity.x/2
			animation_stop = true
			enable_crouching = false
			enable_jump = false
			no_direction_change = true
			anim = "jump_squat"
		else:
			if triple_jump == 2:
				triple_jump -= 1
				velocity.y = jump_velocity
			elif triple_jump == 1:
				triple_jump -= 1
				velocity.y = jump_velocity / 1.25
		
		
	"""MOVES FROM CROUCH"""
	if Input.is_action_pressed(down) and is_grounded and getting_hit == false and rolling == false: #crouch
		if enable_crouching == true:
			animation_stop = false
			move_speed = 0
			crounching = true
			anim = "crouch"
	if Input.is_action_just_pressed(right) and getting_hit == false and crounching == true and is_grounded == true and start_regenating_again == true: #roll right
		energy -= 9
		move_speed = move_speed_normal
		enable_jump = false
		enable_crouching = false
		rolling = true
		crounching = false
		animation_stop = true
		no_direction_change = true
		velocity.x = 200
		anim = "roll2"

	if Input.is_action_just_pressed(left) and getting_hit == false and crounching == true and is_grounded == true and start_regenating_again == true: #roll left
		energy -= 9
		rolling = true
		crounching = false
		animation_stop = true
		no_direction_change = true
		move_speed = move_speed_normal
		enable_jump = false
		enable_crouching = false
		velocity.x = -200
		anim = "roll2"
	if crounching == true and is_grounded and start_regenating_again == true and no_direction_change == false and getting_hit == false and animation_stop == false: #crouch moves
		if Input.is_action_just_pressed(punch):
			if anim != "crouch_jab":
				crounching = true
				enable_crouching = false
				energy -= 9
				$punch_sound.play()
				enable_crouching = false
				animation_stop = true
				no_direction_change = true
				anim = "crouch_jab"
				enable_jump = false
				velocity.x = 0
				move_speed = 0
		if Input.is_action_just_pressed(kick):
			if anim != "crouch_kick":
				energy -= 14
				enable_crouching = false
				animation_stop = true
				no_direction_change = true
				anim = "crouch_kick"
				enable_jump = false
				velocity.x = 0
				move_speed = 0
		if Input.is_action_just_pressed(shoot):
			if anim != "crouch_shoot_new":
				energy -= 7
				animation_stop = true
				enable_crouching = false
				enable_jump = false
				anim = "crouch_shoot_new"
				no_direction_change = true
				move_speed = 0
				no_direction_change = true
				$ShootAbullet.start()
	
	if Input.is_action_just_released(down) and crounching == true: #crouch released
		if anim != "crouch_jab" and anim != "crouch_kick" and anim != "crouch_shoot_new":
				crounching = false
				enable_crouching = false
				animation_stop = true
				no_direction_change = true
				enable_jump = false
				velocity.x = 0
				move_speed = 0
				anim = "into_crouch"
		else:
			pass
	
	if Input.is_action_pressed(shoot) and animation_stop == false and !is_grounded and getting_hit == false and start_regenating_again == true: #shurjuuken #fight_move
		energy -= 9
		gravity = gravity_normal / 1.3
		animation_stop = true
		enable_crouching = false
		enable_jump = false
		anim = "shoot_in_air"
		no_direction_change = true
		move_speed = 0
		no_direction_change = true
		$ShootAbulletAIR.start()
		
	if Input.is_action_just_pressed(shoot) and animation_stop == false and is_grounded and getting_hit == false and start_regenating_again == true and crounching == false: #gun shoot #fight_move
		energy -= 10
		move_speed = 0
		velocity.x = 0
		animation_stop = true
		enable_crouching = false
		enable_jump = false
		anim = "shoot"
		no_direction_change = true
		
		$ShootAbullet.start()
		
	if Input.is_action_just_pressed(punch) and is_grounded and animation_stop == false and start_regenating_again == true and getting_hit == false: #fight_move #normal_punch
		energy -= 10
		enable_crouching = false
		animation_stop = true
		no_direction_change = true
		anim = "punch"
		enable_jump = false
		velocity.x = 0
		move_speed = 0
	if Input.is_action_just_pressed(punch) and !is_grounded and animation_stop == false and start_regenating_again == true and $Body.scale.x == move_direction and getting_hit == false: #fight_move #air forward
		if Input.is_action_pressed(right) and move_direction == 1:
			velocity.x += 50
			energy -= 7.5
			enable_crouching = false
			animation_stop = true
			no_direction_change = true
			anim = "air_forward_attack"
			enable_jump = false
			move_speed = 0
		elif Input.is_action_pressed(left) and move_direction == -1:
			velocity.x -= 50
			energy -= 7.5
			enable_crouching = false
			animation_stop = true
			no_direction_change = true
			anim = "air_forward_attack"
			enable_jump = false
			move_speed = 0
	if Input.is_action_pressed(down) and !is_grounded and animation_stop == false and start_regenating_again == true and getting_hit == false: #downair
		if Input.is_action_pressed(kick):
			anim = "down_air"
			energy -= 11
			enable_crouching = false
			animation_stop = true
			no_direction_change = true
			enable_jump = false
			
	if Input.is_action_just_pressed(punch) and !is_grounded and animation_stop == false and start_regenating_again == true and getting_hit == false:
		if !Input.is_action_pressed(left) and !Input.is_action_pressed(right):
			energy -= 7.5
			enable_crouching = false
			animation_stop = true
			no_direction_change = true
			anim = "nair"
			enable_jump = false
	if Input.is_action_pressed(punch_barrage) and animation_stop == false and is_grounded and getting_hit == false and start_regenating_again == true: #punch barrage #fight_move
		animation_stop = true
		energy -= 70
		anim = "punch_barrage"
		enable_crouching = false
		enable_jump = false
		no_direction_change = true
		velocity.y = 0
		velocity.x = 0
		move_speed = 10
		no_direction_change = true

	if Input.is_action_just_pressed(kick) and animation_stop == false and is_grounded and getting_hit == false and start_regenating_again == true: #normal_kick #fight_move
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
	
	if Input.is_action_just_released(down) and !is_grounded and animation_stop == false and getting_hit == false: #fast_fall
		if anim != "crouch" or anim != "into_crouch":
			velocity.y = -jump_velocity / 2
			var star = STAR.instance()
			get_node("FAST_FALL_STAR").add_child(star)
			star.position = $START_POS.global_position
			star.emitting = true


"""IF MOVE HITS PART"""


func _on_air_forward_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 350
		body.velocity.x += 300 * $Body.scale.x
		body.lag_time += 0.4
		body.health -= 7

func _on_air_forward_weak_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 100
		body.velocity.x += 250 * $Body.scale.x
		body.lag_time += 0.3
		body.health -= 5

func _on_Punch_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 150
		body.velocity.x += 100 * $Body.scale.x
		body.lag_time += 0.13
		body.health -= 4

func _on_kick_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 400
		body.velocity.x += 100 * $Body.scale.x
		body.lag_time += 0.25
		body.health -= 5

func _on_punch_barrage_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.y -= 10
		body.velocity.x = 0
		body.velocity.x += 2 * $Body.scale.x
		body.lag_time += 0.3
		body.health -= 0.5


func _on_punch_barrage_finish_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y -= 500
		body.velocity.x += 250 * $Body.scale.x
		body.lag_time += 0.1
		body.health -= 5

func _on_crouch_punch_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 225
		body.velocity.x += 50 * $Body.scale.x
		body.lag_time += 0.11
		body.health -= 1

func _on_nair_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 275
		body.velocity.x += 50 * $Body.scale.x
		body.lag_time += 0.24
		body.health -= 4

func _on_down_air_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.lag_time += 0.3
		body.health -= 7
		if body.is_on_floor():
			body.velocity.y -= 400
		else:
			body.velocity.y += 300
		
func _on_crouch_kick_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 100
		body.velocity.x += 200 * $Body.scale.x
		body.lag_time += 0.25
		body.health -= 6
		
func _on_roll_hitbox_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("entity"):
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 200
		body.velocity.x += 100 * $Body.scale.x
		body.lag_time += 0.20
		body.health -= 3
"""PLAYER MOVEMENT"""

func _get_input():
		if no_direction_change == false and getting_hit == false:
			move_direction2 = -int(Input.is_action_pressed(left)) + int(Input.is_action_pressed(right))
			velocity.x = lerp(velocity.x, move_speed * move_direction2, velocity_change())
			if move_direction2 != 0 and is_grounded: #might broke
				$Body.scale.x = move_direction2

func velocity_change():
	if is_grounded:
		return 0.3
	else:
		return 0.1


"""ANIMATION"""

func animation():
	anim_player.play(anim)
	if animation_stop == false and getting_hit == false and crounching == false:
		
		if !is_grounded and triple_jump == 2:
			anim = "jump_start"
		elif !is_grounded and triple_jump != 2:
			anim = "jump"
		
		elif velocity.x >= 35 or velocity.x <= -35 and is_grounded:
			anim = "walk"
		elif velocity.x <= 35 or velocity.x >= -35 and is_grounded:
			anim = "idle"

func _on_AnimationPlayer_animation_finished(anim_name): #WHEN MOVES ANIMATION IS FINSIHED
	if anim != "crouch":
		if anim_name == "hit":
			$fire.emitting = true
			getting_hit = false
			anim = "idle"
		if anim_name == "hit_on_air":
			$fire.emitting = true
			getting_hit = false
			anim = "idle"

		if anim_name == "air_forward_attack_get_up":
			anim = "idle"
			
		if anim_name == "jump_squat":
			if Input.is_action_pressed(jump):
				triple_jump -= 1
				velocity.y = jump_velocity
			else:
				triple_jump -= 1
				velocity.y = jump_velocity/1.5
			
		if anim_name == "sia_get_up":
			anim = "idle"
		
		if anim == "into_crouch":
			move_speed = move_speed_normal
			crounching = false
			animation_stop = false
			anim = "idle"
		
		rolling = false
		no_direction_change = false
		crounching = false
		enable_jump = true
		enable_crouching = true
		animation_stop = false
		rolling = false



"""DEATH, RESPAWN AND HIT PART"""

func dead():
	if death == 0:
		velocity.x = 0
		velocity.y = 0
		gravity = 0
		$dead_sound.play()
		animation_stop = true
		getting_hit = true
		enable_crouching = false
		enable_jump = false
		anim = "dead"
		death = 1
		emit_signal("dead")
		$Area2D/CollisionShape2D.disabled
		$death_effect/blood_splash.global_position = self.global_position
		$death_effect/blood_splash.emitting = true
		$respawn.start()
		color_anim.stop()
		color_anim.play("dead")


func _on_respawn_timeout():
	$death_effect/blood_splash.emitting = false
	$invisibility_timer.set_wait_time(4)
	invisibility()
	anim = "idle"
	health = health_normal
	energy = 100
	gravity = gravity_normal
	animation_stop = false
	crounching = false
	getting_hit = false
	enable_crouching = true
	enable_jump = true
	triple_jump = 2
	lag_time = 0
	death = 0
	self.global_position = get_parent().get_parent().find_node("Spawn1").global_position


func _on_Area2D_area_entered(area):
	if area.is_in_group("hit_box"):
		gravity = gravity_normal
		getting_hit = true
		enable_jump = false
		enable_crouching = false
		animation_stop = true
		$frame.stop()
		$frame.start()

func _on_frame_timeout(): #sets hit settings (hitlag)
	get_hit()

func get_hit():
	if death == 0:
		$Hit_sound_randomizer.play_sound()
		emit_signal("hitted")
		anim_player.get_animation("hit").length = lag_time
		anim_player.get_animation("hit_on_air").length = lag_time
		anim_player.stop()
		anim_player.get_animation("hit").length = clamp(anim_player.get_animation("hit").length, 0 , 1.5)
		anim_player.get_animation("hit_on_air").length = clamp(anim_player.get_animation("hit_on_air").length, 0 , 1.5)
		if is_grounded:
			anim_player.play("hit")
			anim = "hit"
			color_anim.play("hit")
		elif !is_grounded:
			anim_player.play("hit_on_air")
			anim = "hit_on_air"
			color_anim.play("hit")

"""REGENERATE ENERGY"""

func _on_EnergyTimer_timeout():
	#print("energy is regenerating again")
	regenerate_energy = true


"""CREATE A BULLET"""

func _on_ShootAbullet_timeout():
	$gun_shoot.play()
	var bullet = BULLET.instance()
	bullet.shooting_player = player
	get_parent().add_child(bullet)
	var smoke = SMOKE.instance()
	get_node("Body/for_smoke").add_child(smoke)
	bullet.set_collision_mask_bit(2, false)
	if sign ($Body.scale.x) == -1:
		bullet.set_bullet_direction(-1)
		smoke.scale.x = -1
	else:
		bullet.set_bullet_direction(1)
		
	bullet.global_position = $Body/BulletPosition.global_position
	smoke.global_position = $Body/smoke_pos/smoke_position.global_position
	smoke.emitting = true

func _on_ShootAbulletAIR_timeout():
	if anim == "shoot_in_air":
		$gun_shoot.play()
		var bullet = BULLET.instance()
		bullet.shooting_player = player
		get_parent().add_child(bullet)
		var smoke = SMOKE.instance()
		get_node("Body/for_smoke").add_child(smoke)
		bullet.set_collision_mask_bit(2, false)
		if  ($Body.scale.x) == -1:
			bullet.set_bullet_direction(-1)
			bullet.bullet_direction = 1
			smoke.scale.x = -1
		else:
			bullet.bullet_direction = 1
			bullet.set_bullet_direction(1)
			
		bullet.global_position = $Body/BulletPosition.global_position
		smoke.global_position = $Body/smoke_pos/smoke_position.global_position
		smoke.emitting = true


"""PLAYER INVISIBILITY"""

func invisibility():
	invisible = true
	$invisibility_timer.start()
	$Area2D/CollisionShape2D.disabled
	print("set disabled")
	
	
func _on_invisibility_timer_timeout():
	invisible = false
	$Area2D/CollisionShape2D.disabled = false


func _on_void_area_entered(area):
	dead()
	print("killed on void")


func _on_pass_thru_timeout():
	$CollisionShape2D.disabled = false


