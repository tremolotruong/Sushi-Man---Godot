extends KinematicBody2D
var motion = Vector2()
var action = "none"
var direction = -1
var speed = 2
var health = 10
var Player


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	Player = self.get_parent().get_node("Player")


func _process(delta):
	if action == "move":
		if Player.position.x <= self.position.x:
			direction = -1
		else:
			direction = 1
		motion.x = speed * direction
		move_and_collide(motion)


func _on_alertarea_area_entered(area):
	if "HitboxArea" in area.name and action != "move":
		action = "move"
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").show()
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").max_value = health
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		

func _on_hitboxarea_body_entered(body):
	if "Knife" in body.name:
		health -= 1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			self.get_parent().get_node("exitportal").show()
			self.get_parent().get_node("exitportal").play()
			queue_free()
		body.queue_free()

func _on_hitboxarea_area_entered(area):
	if "meleehit" in area.name:
		health -= 1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			self.get_parent().get_node("exitportal").show()
			self.get_parent().get_node("exitportal").play()
			queue_free()
