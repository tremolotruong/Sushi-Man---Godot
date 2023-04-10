extends KinematicBody2D
var motion = Vector2()
var action = "none"
var direction = -1
var speed = 3
var Player
var health = 20
var curr_frame = 0
var hitboxlst = [[-88, -42], [-93, -47], [-100, -52], [-110, -57], [-115, -62], [-123, -64], [-135, -72], [-143, -74], [-155, -79], [-175, -84], [-187, -87], [-207, -91], [-222, -89], [-239, -87], [-264, -79], [-286, -72], [-311, -64], [-336, -52], [-356, -37], [-378, -17], [-400, 8], [-425, 33], [-435, 50]]
var attacking = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("move")
	$anchorhitbox.disabled = true


func _process(delta):
	Player = get_parent().get_node("Player")
	if action == "move":
		if Player.position.x <= self.position.x:
			direction = -1
			$AnimatedSprite.flip_h = false
		else:
			direction = 1
			$AnimatedSprite.flip_h = true
	
		motion.x = speed * direction
		move_and_collide(motion)
	elif action == "movetoattack":
		if direction == -1:
			if 19495 < self.position.x:
				motion.x = speed * direction * 2
				move_and_collide(motion)
			else:
				if Player.position.x <= self.position.x:
					direction = -1
					$AnimatedSprite.flip_h = false
				else:
					direction = 1
					$AnimatedSprite.flip_h = true
				action = "attack"
				$attacktimer.start()
		if direction == 1:
			if 19495 > self.position.x:
				motion.x = speed * direction * 2
				move_and_collide(motion)
			else:
				if Player.position.x <= self.position.x:
					direction = -1
					$AnimatedSprite.flip_h = false
				else:
					direction = 1
					$AnimatedSprite.flip_h = true
				action = "attack"
				$attacktimer.start()
				
	elif action == "attack":
		if not attacking:
			attack()
			attacking = true

func attack():
	$AnimatedSprite.play("attack")
	if direction == -1:
		$AnimatedSprite.position.x = -312
		$AnimatedSprite.position.y = -32
	else:
		$AnimatedSprite.position.x = 312
		$AnimatedSprite.position.y = -32
	$anchorhitbox.disabled = false
	

func _on_Area2D_area_entered(area):
	if "HitboxArea" in area.name and action != "move":
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").show()
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").get_node("bossname").text = "NoEye Tuna:"
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").max_value = health
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		action = "move"
		$movetimer.start()


func _on_hitbox_area_entered(area):
	if "meleehit" in area.name:
		health -=1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			queue_free()


func _on_AnimatedSprite_frame_changed():
	if attacking:
		if direction == -1:
			$anchorhitbox.position.x = hitboxlst[curr_frame][0]
			$anchorhitbox.position.y = hitboxlst[curr_frame][1]
		else:
			$anchorhitbox.position.x = hitboxlst[curr_frame][0] * -1
			$anchorhitbox.position.y = hitboxlst[curr_frame][1]
		curr_frame += 1
	

func _on_AnimatedSprite_animation_finished():
	curr_frame = 0


func _on_movetimer_timeout():
	action = "movetoattack"
	if 19495 < self.position.x:
		direction = -1
		$AnimatedSprite.flip_h = false
	elif 19495 > self.position.x:
		direction = 1
		$AnimatedSprite.flip_h = true
	else:
		if Player.position.x <= self.position.x:
			direction = -1
			$AnimatedSprite.flip_h = false
		else:
			direction = 1
			$AnimatedSprite.flip_h = true
		action = "attack"
		$attacktimer.start()
		

func _on_attacktimer_timeout():
	action = "move"
	$AnimatedSprite.play("move")
	$AnimatedSprite.position.x = 0
	$AnimatedSprite.position.y = 0
	$anchorhitbox.disabled = true
	$movetimer.start()
	attacking = false
