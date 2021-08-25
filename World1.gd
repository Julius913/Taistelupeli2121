extends Node2D


const PLAYER = preload("res://Player.tscn")
const ENEMY = preload("res://Enemy.tscn")
const CAMERA = preload("res://Camera.tscn")


func _ready():
	var player = PLAYER.instance()
	self.add_child(player)
	player.position = $Spawn1.global_position
	
	var enemy = ENEMY.instance()
	self.add_child(enemy)
	enemy.position = $Spawn2.global_position
	
	var camera = CAMERA.instance()
	player.add_child(camera)
	
	
	Theworld.camera_area_x = -100
	#left
	
	Theworld.camera_area_y = -350
	#top
	
	Theworld.camera_area_x2 = 3000
	#right
	
	Theworld.camera_area_y2 = 500
	#bottom
	camera.limit_left = Theworld.camera_area_x
	camera.limit_right = Theworld.camera_area_x2
	camera.limit_top = Theworld.camera_area_y
	camera.limit_bottom = Theworld.camera_area_y2
