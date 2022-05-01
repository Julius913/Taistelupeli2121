extends TextureProgress

var player = 1
export var parent_path : NodePath

func _ready():
	print(get_tree().current_scene)

func _physics_process(delta):
	if player == 1:
		value = get_parent().get_parent().get_parent().get_node("Player1").get_node("Player").health
	else:
		value = get_parent().get_parent().get_parent().get_node("Player2").get_node("Player").health
