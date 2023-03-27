extends KinematicBody2D
var movement = Vector2()
var direction = -1
var health = 3
var movespeed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	movement.x = -movespeed

func _physics_process(_delta):
	$AnimatedSprite.play()
	var Player = get_parent().get_node("Player")
	if not is_on_floor():
		movement.y += movespeed
	if is_on_wall():
		$AnimatedSprite.flip_h = true
		movement.x *= -1
		direction *= -1
#	
	move_and_slide(movement, Vector2.UP)
	
	
	
	

func _on_Area2D_body_entered(body):
	if "Knife" in body.name:
		health -=1
		if health <= 0:
			queue_free()
		if health == 2:
			movement.x *= -2.5
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.speed_scale = 2
			direction *= -1
	


func _on_Area2D_area_entered(area):
	if "meleehit" in area.name:
		health -=1 
		if health <= 0:
			queue_free()
		if health == 2:
			movement.x *= -2.5
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.speed_scale = 2
			direction *= -1
		
