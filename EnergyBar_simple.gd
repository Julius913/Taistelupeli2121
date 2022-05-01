extends HBoxContainer

export var player = 1
var value

func _ready():
	if player == 2:
		$TextureProgress/Icon.position.x = -20
	else:
		$TextureProgress/Icon.position.x = 420

func _physics_process(delta):
	if player == 1:
		value = get_parent().get_parent().get_parent().get_parent().get_node("Player1").get_node("Player").energy
	elif player == 2:
		value = get_parent().get_parent().get_parent().get_parent().get_node("Player2").get_node("Player").energy
	
	$TextureProgress.value = value
	
	

