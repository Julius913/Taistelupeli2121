extends KinematicBody2D
const UP = Vector2(0, -1)
var velocity = Vector2()
var gravity = 1000
var lag_time = 0
var move_direction = 1
var health = 50
var death = 0
onready var animation = $AnimationPlayer
onready var hit_sound = $AudioStreamPlayer
onready var hit_timer = $hit_timer

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, UP)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, 0.8)
	get_parent().scale.x = move_direction
	
	if death == 1:
		gravity = 0
		velocity.y = 0
		velocity.x = 0
	
	lag_time -= Theworld.lag_time_minus
	if lag_time <= 0:
		lag_time = 0
	
	if lag_time >= 1.5:
		lag_time = 1.5
	
	if health <= 0 and death == 0:
		dead()
func get_hit():
	if death == 0:
		animation.stop()
		animation.play("hit")
		hit_sound.play()
		hit_timer.set_wait_time(lag_time)
		print(lag_time)
		hit_timer.start()

func dead():
	if death == 0:
		velocity.x = 0
		velocity.y = 0
		gravity = 0
		hit_sound.play()
		death = 1
		health = 0
		$effects/firework.global_position = self.global_position
		$effects/firework.emitting = true
		$Sprite.visible = false
		$Area2D/CollisionShape2D.disabled = true
		self.global_position = get_parent().get_node("Spawn2").global_position
		$respawn.start()

func _on_hit_timer_timeout():
	print("hit_lag_ended")
	animation.play("idle")
	gravity = 1000
func grabbed():
	pass

func _on_Area2D_area_entered(area):
	area.is_in_group("hit_box")
	$frame.start()


func _on_frame_timeout():
	get_hit()
	gravity = 1000


func _on_respawn_timeout():
	gravity = 1000
	health = 50
	death = 0
	$Sprite.visible = true
	$Area2D/CollisionShape2D.disabled = false
