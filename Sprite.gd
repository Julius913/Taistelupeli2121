extends TextureRect

func _ready():
	modulate = "ffffff"

func _on_Select_mouse_entered():
	modulate = "898989"


func _on_Select_mouse_exited():
	modulate = "ffffff"
