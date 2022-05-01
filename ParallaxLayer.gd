extends ParallaxLayer

export var speed = 0.5
var up_down = 50
var negus = true

func _physics_process(delta):
	motion_offset.x += speed
