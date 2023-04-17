extends KinematicBody2D
var motion = Vector2()
var action = "none"
var direction = -1
var speed = 2
var Player
var health = 20
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	pass # Replace with function body.


func _process(delta):
	Player = get_parent().get_node("Player")
	if action == "move":
		if Player.position.x <= self.position.x:
			direction = -1
		else:
			direction = 1
	motion.x = speed * direction
#	move_and_collide(motion)
#func jump():
#


func _on_Area2D_area_entered(area):
	if "HitboxArea" in area.name and action != "move":
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").show()
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").get_node("bossname").text = "NoEye Tuna:"
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").max_value = health
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		


func _on_hitbox_area_entered(area):
	if "meleehit" in area.name:
		health -=1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			queue_free()
