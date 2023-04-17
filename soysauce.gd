extends KinematicBody2D
var Player
var dir = Vector2()
var bullet = preload("res://Bullet.tscn")
var shooting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_parent().get_node("Player")


func _process(_delta):
	if not shooting:
		shoot()
		$shoot_timer.start()
		shooting = true

func shoot():
	$Bullet.shooting = true
	$Bullet.just_shot = true
	$shoot_timer.start()


func _on_shoot_timer_timeout():
	shooting = false
	$Bullet.shooting = false
