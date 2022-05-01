extends Node2D

const PLAYER = preload("res://Player.tscn")
const ENEMY = preload("res://Enemy.tscn")
const CAMERA = preload("res://Camera.tscn")
const FS = preload("res://Flying_Shooter.tscn")
func _ready():
	var player = PLAYER.instance()
	get_node("Player1").add_child(player)
	player.position = $Spawn1.global_position
	
	var fs = FS.instance()
	self.add_child(fs)
	fs.position = $Spawn3.global_position
	
	var enemy = ENEMY.instance()
	self.add_child(enemy)
	enemy.position = $Spawn2.global_position
	enemy.respawn_set = true
	
	var camera = CAMERA.instance()
	player.add_child(camera)
	camera.current = true
	camera.zoom.x = 0.5
	camera.zoom.y = 0.5
