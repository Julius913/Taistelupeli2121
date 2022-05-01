extends Control


func _ready():
	$Timer.start()
	
func _on_hit():
	$CanvasLayer/AnimationPlayer.stop()
	$CanvasLayer/AnimationPlayer.play("hit")

func dead():
	$CanvasLayer/AnimationPlayer.stop()
	$CanvasLayer/AnimationPlayer.play("dead")

func _on_Timer_timeout():
	get_node("../Player1/Player").connect("hitted", self, "_on_hit")
	get_node("../Player2/Player").connect("hitted", self, "_on_hit")

	get_node("../Player1/Player").connect("dead", self, "dead")
	get_node("../Player2/Player").connect("dead", self, "dead")
