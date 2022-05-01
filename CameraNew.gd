extends Camera2D

var CAMERA_MARGIN = 64 # Number of pixels to expand the rectangle
var MIN_ZOOM = 0.45 # Minimum zoom, so if players are close, it wont zoom in too much
var pl1
var pl2

var player1
var player2

func _ready():
	set_process(true)
func _process(delta):
	
	pl1 = player1.position
	pl2 = player2.position
	
	# Create rectangle at pl1, then expand to fit pl2
	var rect = Rect2(pl1, Vector2())
	rect = rect.expand(pl2)
	
	# Grow rectangle
	rect = rect.grow(CAMERA_MARGIN)
	
	# Find the width and height scale, then choose the smallest one
	var window_size = OS.get_window_size()
	var scale_w = window_size.x / rect.size.x
	var scale_h = window_size.y / rect.size.y
	var scale = 1 / min(scale_w, scale_h)
	
	# Limit the zoom
	scale = max(MIN_ZOOM, scale)
	# Set zoom and position
	set_zoom(Vector2(scale, scale))
	set_position(rect.position + (rect.size * 0.5))


func set_max_limit():
	limit_right = Theworld.camera_area_right
	limit_top = Theworld.camera_area_up
	limit_bottom = Theworld.camera_area_down
	limit_left = Theworld.camera_area_left
