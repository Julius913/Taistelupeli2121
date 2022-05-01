extends Area2D

const CLANK = preload("res://BulletClank.tscn")
const SPEED = 500
var stop = false
var direction = 1
var velocity = Vector2()
var bullet_direction = 0
var shooting_player = 1
var number = 0
var body_or_area_ent = false

func _ready():
	$Timer.start()
func _physics_process(delta):
	if stop == false:
		if shooting_player == 2:
			set_collision_layer_bit(2, false)
			set_collision_layer_bit(3, true)
			set_collision_mask_bit(2, true)
			set_collision_mask_bit(3, false)
		$AnimatedSprite.play("bullet")
		translate(velocity)
		if bullet_direction == 0:
			velocity.x = SPEED * delta * direction
		else:
			velocity.x = SPEED * delta * direction
			velocity.y = SPEED * delta
			if direction == -1:
				self.rotation_degrees = -45
			else:
				self.rotation_degrees = 45
func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	

func _on_Timer_timeout():
	destroy()
	stop = true

func destroy():
	if number == 0:
		number = 1
		$AnimatedSprite.play("destroy")
		$CollisionShape2D.queue_free()
		var c = CLANK.instance()
		$EFFECT.add_child(c)
		c.global_position = self.global_position
		$destroy.set_wait_time(c.lifetime)
		$destroy.start()
		
		if body_or_area_ent == true:
			c.emitting = true

func _on_Bullet_area_entered(area):
	var body = area.get_parent()
	body_or_area_ent = true
	if body.is_in_group("entity"):
		stop = true
		body.velocity.y = 0
		body.velocity.x = 0
		body.velocity.y -= 150
		body.velocity.x += 150 * get_parent().get_node("Player").get_node("Body").scale.x
		body.lag_time += 0.1
		body.health -= 4
		destroy()

func _on_Bullet_body_entered(body):
	body_or_area_ent = true
	if stop == false:
		destroy()
		stop = true


func _on_destroy_timeout():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.visible = false
