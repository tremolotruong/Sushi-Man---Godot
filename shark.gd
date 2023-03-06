extends KinematicBody2D

var motion = Vector2()
var knockback_direction
var knockback_delay = 1000
var knockback = false
var direction = 1
var health = 10
var speed = 4
var move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()

func _physics_process(_delta):
	if move:
		var Player = get_parent().get_node("Player")
		
		motion = position.direction_to(Player.position) * speed
		if motion.x > 0:
			$AnimatedSprite.flip_h = true
			direction = -1
		else:
			$AnimatedSprite.flip_h = false
			direction = 1
			
		if knockback:
			#should be knockback_direction vv
			motion.x = 150 * knockback_direction
			knockback = false
			knockback_delay = 1000
			
		knockback_delay -= 1
		
		move_and_collide(motion)
		
		
func knockback():
	var enemy_direction = get_parent().get_node("Player").direction
	knockback_direction = enemy_direction
	knockback = true

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		move = true

func _on_hitboxarea_area_entered(area):
	if "meleehit" in area.name:
		health -= 1
		knockback()
		if health <= 0:
			queue_free()


func _on_hitboxarea_body_entered(body):
	if "Knife" in body.name:
		health -= 1
		knockback()
		if health <= 0:
			queue_free()
		body.queue_free()
