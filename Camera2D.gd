extends Camera2D

export var speed = 0.5
func _physics_process(delta):
	
		offset_h += speed
		print(offset_h)
