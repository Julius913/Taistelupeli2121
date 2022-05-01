extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$health_bar.player = 1
	$ENERGY.player = 1
	$LAGTIME.player = 1
