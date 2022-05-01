extends Particles2D

onready var p = get_parent()

func _physics_process(delta):
	if p.death == 0:
		if p.energy > 0:
			self.emitting = true
		else:
			self.emitting = false
		if p.getting_hit == true:
			self.emitting = false
	else:
		self.emitting = false
	
	if p.move_direction2 == 1:
		p.move_direction = 1
	if p.move_direction2 == -1:
		p.move_direction = -1
