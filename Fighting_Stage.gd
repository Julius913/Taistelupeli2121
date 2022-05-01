extends Node2D
onready var camera = get_node("CameraNew")
const player = preload("res://Player.tscn")
const pl_script = preload("res://Player.gd")
onready var p_bag = get_node("Punching_bag")
signal hitted

func _ready():
	$"/root/MusicController".music = load("res://music/piraatti_musiikki_v2.wav")
	$"/root/MusicController".play_music()
	
	var player1 = player.instance()
	player1.player = 1 #player settings
	self.get_node("Player1").add_child(player1) #adds player
	player1.global_position = $Spawn1.global_position #sets position
	
	
	
	var player2 = player.instance()
	player2.player = 2 #player settings
	self.get_node("Player2").add_child(player2) #adds player
	
	player2.global_position = $Spawn2.global_position #sets position
	
	
	camera.player1 = get_node("Player1").get_node("Player")
	camera.player2 = get_node("Player2").get_node("Player")
	
	Theworld.camera_area_right = 1210
	Theworld.camera_area_left = -100
	Theworld.camera_area_up = 0
	Theworld.camera_area_down = 800
	camera.set_max_limit()
func _on_Timer_timeout():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("H"):
		emit_signal("hitted")
