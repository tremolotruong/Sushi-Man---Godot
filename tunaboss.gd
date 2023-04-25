extends KinematicBody2D
var motion = Vector2()
var action = "none"
var direction = -1
var speed = 3
var Player
var health = 15
var curr_frame = 0
var hitboxlst = [[-96, 20], [-103, 21], [-126, -31], [-84, -154], [97, -151], [200, 34], [190, -4], [179, -16], [154, -118], [47, -166], [-105, -147], [-239, -88], [-286, -72], [-336, -52], [-378, -19], [-420, 24], [-443, 47], [-443, 47], [-443, 47], [-443, 47], [-443, 47], [-443, 47], [-443, 47], [-431, 47], [-414, 47], [-395, 47], [-380, 48], [-362, 48], [-341, 48], [-319, 47], [-305, 48], [-284, 48], [-259, 48], [-240, 48], [-222, 48], [-201, 48], [-176, 47], [-145, 47], [-124, 48], [-109, 48], [-98, 39], [-78, 36]]
var attacking = false
var invincible = false
var last_pos = "left"
var switch_time = false
var deactivate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("move")
	$anchorhitbox.disabled = true
	Player = get_parent().get_node("Player")

func _process(delta):
	
	if action == "move":
		if Player.position.x <= self.position.x and last_pos == "left":
			last_pos = "left"
			direction = -1
			$AnimatedSprite.flip_h = false
		elif Player.position.x >= self.position.x and last_pos == "right":
			last_pos = "right"
			direction = 1
			$AnimatedSprite.flip_h = true
		else:
			if not switch_time:
				$switchtimer.start()
				switch_time = true
			
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
	if action == "switch":
		$switchtimer.start()
		motion.x = speed * direction
		move_and_collide(motion)

func attack():
	invincible = true
	$AnimatedSprite.play("attack")
	if direction == -1:
		$AnimatedSprite.position.x = -133
		$AnimatedSprite.position.y = -78.5
	else:
		$AnimatedSprite.position.x = 133
		$AnimatedSprite.position.y = -78.5
	$anchorhitbox.disabled = false
	

func _on_Area2D_area_entered(area):
	if "HitboxArea" in area.name and action != "move" and not deactivate:
		print("activate")
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").show()
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").get_node("bossname").text = "NoEye Tuna:"
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").max_value = health
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		action = "move"
		$movetimer.start()
		deactivate = true
		


func _on_hitbox_area_entered(area):
	if "meleehit" in area.name and not invincible:
		health -=1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			self.get_parent().get_node("exitportal").show()
			self.get_parent().get_node("exitportal").play()
			self.get_parent().get_node("exitportal").finished = true
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
		invincible = true
		

func _on_attacktimer_timeout():
	invincible = false
	action = "move"
	$AnimatedSprite.play("move")
	$AnimatedSprite.position.x = 0
	$AnimatedSprite.position.y = 0
	$anchorhitbox.disabled = true
	$movetimer.start()
	attacking = false


func _on_switchtimer_timeout():
	switch_time = false
	if last_pos == "left":
		last_pos = "right"
	else:
		last_pos = "left"
