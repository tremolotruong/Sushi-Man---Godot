extends KinematicBody2D
var movement = Vector2()
var direction = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	movement.x = -100

func _physics_process(_delta):
	$AnimatedSprite.play()
	var Player = get_parent().get_node("Player")
	if not is_on_floor():
		movement.y += 50
	if is_on_wall():
		movement.x *= -1
		direction *= -1
#	
	move_and_slide(movement, Vector2.UP)
	
	
	
	

func _on_Area2D_body_entered(body):
	if "enemy" in body.name or "Player" in body.name:
		movement.x *= -1
		direction *= -1
	
