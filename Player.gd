extends KinematicBody2D

var movespeed = 600
var knife_speed = 2000


var speed = Vector2()
var knife = preload("res://Knife.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1


	motion = motion.normalized()
	motion = move_and_slide(motion*movespeed)


	look_at(get_global_mouse_position())


	if Input.is_action_just_pressed("shoot"):
		throw()

func throw():
	var knife_instance = knife.instance()
	knife_instance.position = get_global_position()
	knife_instance.rotation_degrees = rotation_degrees
	knife_instance.apply_impulse(Vector2(),Vector2(knife_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",knife_instance)
	

func kill():
	get_tree().reload_current_scene()  # this will likely be changed, as this is to make the game reload every time the player dies.

func _on_HitboxArea_body_entered(body):
	if "Enemy" in body.name:
		kill()
	if "Tomato" in body.name:
		kill()
