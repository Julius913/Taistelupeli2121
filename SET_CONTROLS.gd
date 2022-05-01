extends Node

onready var p = get_parent()

func _ready():
	
	
	"""SETS PLAYER 2 CONTROLS"""
	
	if p.player == 2:
		p.jump = "player2_jump"
		p.down = "player2_down"
		p.right = "player2_right"
		p.left = "player2_left"
		p.punch = "player2_punch"
		p.kick = "player2_kick"
		p.shoot = "player2_shoot"
		p.punch_barrage = "player2_punch_barrage"
	
	
	
	"""NORMAL VALUES"""
	
	p.jump_velocity2 = p.jump_velocity
	p.gravity_normal = p.gravity
	p.move_speed_normal = p.move_speed
	p.health_normal = p.health

func _physics_process(delta):
	
	if p.regenerate_energy == true:
		if p.crounching == false:
			p.energy += Theworld.energy_regenerate
		else:
			p.energy += Theworld.energy_regenerate * 2
	
	
	p.energy = clamp(p.energy, -100, 100)
	if p.energy > 0:
		p.start_regenating_again = true
	
	if p.energy <= 0 and p.regenerate_energy == true and p.start_regenating_again == true:
		p.e_timer.wait_time = (p.energy/4) * -1
		p.e_timer.start()
		p.regenerate_energy = false #stops regenating energy
		p.start_regenating_again = false
	
	p.health = clamp(p.health, 0, 100)
	if p.health <= 0 and p.death == 0:
		p.dead()
	
	p.lag_time = clamp(p.lag_time, 0, Theworld.max_lag_time)
	p.lag_time -= Theworld.lag_time_minus
