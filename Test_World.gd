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
