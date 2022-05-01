extends Node2D

func _ready():
	if get_parent().player == 2:
		get_parent().get_node("Area2D").set_collision_layer_bit(2, false)
		get_parent().get_node("Area2D").set_collision_layer_bit(3, true)
		$Punch_hitbox.set_collision_layer_bit(2, false)
		$Punch_hitbox.set_collision_layer_bit(3, true)
		$Punch_hitbox.set_collision_mask_bit(2, true)
		$Punch_hitbox.set_collision_mask_bit(3, false)
		
		$down_air.set_collision_layer_bit(2, false)
		$down_air.set_collision_layer_bit(3, true)
		$down_air.set_collision_mask_bit(2, true)
		$down_air.set_collision_mask_bit(3, false)
		
		$crouch_punch.set_collision_layer_bit(2, false)
		$crouch_punch.set_collision_layer_bit(3, true)
		$crouch_punch.set_collision_mask_bit(2, true)
		$crouch_punch.set_collision_mask_bit(3, false)

		$upper_punch.set_collision_layer_bit(2, false)
		$upper_punch.set_collision_layer_bit(3, true)
		$upper_punch.set_collision_mask_bit(2, true)
		$upper_punch.set_collision_mask_bit(3, false)

		$kick_hitbox.set_collision_layer_bit(2, false)
		$kick_hitbox.set_collision_layer_bit(3, true)
		$kick_hitbox.set_collision_mask_bit(2, true)
		$kick_hitbox.set_collision_mask_bit(3, false)

		$punch_barrage.set_collision_layer_bit(2, false)
		$punch_barrage.set_collision_layer_bit(3, true)
		$punch_barrage.set_collision_mask_bit(2, true)
		$punch_barrage.set_collision_mask_bit(3, false)
		
		$punch_barrage_finish.set_collision_layer_bit(2, false)
		$punch_barrage_finish.set_collision_layer_bit(3, true)
		$punch_barrage_finish.set_collision_mask_bit(2, true)
		$punch_barrage_finish.set_collision_mask_bit(3, false)
		
		$crouch_kick.set_collision_layer_bit(2, false)
		$crouch_kick.set_collision_layer_bit(3, true)
		$crouch_kick.set_collision_mask_bit(2, true)
		$crouch_kick.set_collision_mask_bit(3, false)
		
		$air_forward.set_collision_layer_bit(2, false)
		$air_forward.set_collision_layer_bit(3, true)
		$air_forward.set_collision_mask_bit(2, true)
		$air_forward.set_collision_mask_bit(3, false)

		$air_forward_weak.set_collision_layer_bit(2, false)
		$air_forward_weak.set_collision_layer_bit(3, true)
		$air_forward_weak.set_collision_mask_bit(2, true)
		$air_forward_weak.set_collision_mask_bit(3, false)

		$nair.set_collision_layer_bit(2, false)
		$nair.set_collision_layer_bit(3, true)
		$nair.set_collision_mask_bit(2, true)
		$nair.set_collision_mask_bit(3, false)

		$roll_hitbox.set_collision_layer_bit(2, false)
		$roll_hitbox.set_collision_layer_bit(3, true)
		$roll_hitbox.set_collision_mask_bit(2, true)
		$roll_hitbox.set_collision_mask_bit(3, false)
		
	if get_parent().player == 1:
		get_parent().get_node("Area2D").set_collision_layer_bit(2, true)
		get_parent().get_node("Area2D").set_collision_layer_bit(3, false)
		$Punch_hitbox.set_collision_layer_bit(2, true)
		$Punch_hitbox.set_collision_layer_bit(3, false)
		$Punch_hitbox.set_collision_mask_bit(2, false)
		$Punch_hitbox.set_collision_mask_bit(3, true)
		
		$crouch_punch.set_collision_layer_bit(2, true)
		$crouch_punch.set_collision_layer_bit(3, false)
		$crouch_punch.set_collision_mask_bit(2, false)
		$crouch_punch.set_collision_mask_bit(3, true)

		$upper_punch.set_collision_layer_bit(2, true)
		$upper_punch.set_collision_layer_bit(3, false)
		$upper_punch.set_collision_mask_bit(2, false)
		$upper_punch.set_collision_mask_bit(3, true)

		$kick_hitbox.set_collision_layer_bit(2, true)
		$kick_hitbox.set_collision_layer_bit(3, false)
		$kick_hitbox.set_collision_mask_bit(2, false)
		$kick_hitbox.set_collision_mask_bit(3, true)

		$punch_barrage.set_collision_layer_bit(2, true)
		$punch_barrage.set_collision_layer_bit(3, false)
		$punch_barrage.set_collision_mask_bit(2, false)
		$punch_barrage.set_collision_mask_bit(3, true)
		
		$punch_barrage_finish.set_collision_layer_bit(2, true)
		$punch_barrage_finish.set_collision_layer_bit(3, false)
		$punch_barrage_finish.set_collision_mask_bit(2, false)
		$punch_barrage_finish.set_collision_mask_bit(3, true)

		$crouch_kick.set_collision_layer_bit(2, true)
		$crouch_kick.set_collision_layer_bit(3, false)
		$crouch_kick.set_collision_mask_bit(2, false)
		$crouch_kick.set_collision_mask_bit(3, true)

		$air_forward.set_collision_layer_bit(2, true)
		$air_forward.set_collision_layer_bit(3, false)
		$air_forward.set_collision_mask_bit(2, false)
		$air_forward.set_collision_mask_bit(3, true)

		$air_forward_weak.set_collision_layer_bit(2, true)
		$air_forward_weak.set_collision_layer_bit(3, false)
		$air_forward_weak.set_collision_mask_bit(2, false)
		$air_forward_weak.set_collision_mask_bit(3, true)

		$nair.set_collision_layer_bit(2, true)
		$nair.set_collision_layer_bit(3, false)
		$nair.set_collision_mask_bit(2, false)
		$nair.set_collision_mask_bit(3, true)

		$roll_hitbox.set_collision_layer_bit(2, true)
		$roll_hitbox.set_collision_layer_bit(3, false)
		$roll_hitbox.set_collision_mask_bit(2, false)
		$roll_hitbox.set_collision_mask_bit(3, true)

		$down_air.set_collision_layer_bit(2, true)
		$down_air.set_collision_layer_bit(3, false)
		$down_air.set_collision_mask_bit(2, false)
		$down_air.set_collision_mask_bit(3, true)
