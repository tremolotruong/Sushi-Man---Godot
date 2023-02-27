extends KinematicBody2D
var movement = Vector2()
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	movement.x = -3

func _physics_process(_delta):
	$AnimatedSprite.play()
	var Player = get_parent().get_node("Player")
	if position.x <= -1026:
		movement.x = 3
		direction = 1
	if position.x >= 2182:
		movement.x =-3
		direction = -1
	move_and_collide(movement)
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

