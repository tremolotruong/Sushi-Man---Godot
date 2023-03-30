extends KinematicBody2D
var motion = Vector2()
var action = "move"
var direction = -1
var speed = 2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if action == "move":
		var Player = get_parent().get_node("Player")
		if Player.position.x <= self.position.x:
			direction = -1
		else:
			direction = 1
	motion.x = speed * direction
	move_and_collide(motion)
#func jump():
#
