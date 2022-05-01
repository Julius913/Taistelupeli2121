extends Node2D

signal nekru



func _physics_process(delta):
	if Input.is_action_just_pressed("H"):
		$Sprite.connect("nekru", self, "ok")
		emit_signal("nekru")
