extends Sprite

var knife_speed = 2000
var knife = preload("res://Knife.tscn")

func _ready():
	$meleeani.hide()
	$meleeani/meleehit/CollisionShape2D.set_deferred('disabled', true)
	
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("throw"):
		throw()
	if Input.is_action_pressed("melee"):
		melee()
		
func throw():
	var knife_instance = knife.instance()
	knife_instance.position = get_global_position()
	knife_instance.rotation_degrees = rotation_degrees
	$swing2.play()
	$woosh.play()
	knife_instance.apply_impulse(Vector2(),Vector2(knife_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",knife_instance)
func melee():
	$swing2.play()
	$woosh.play()
	$meleeani.show()
	$meleeani.play()
	$meleeani/meleehit/CollisionShape2D.set_deferred('disabled', false)
	

func _on_meleeani_animation_finished():
	$meleeani.stop()
	$meleeani.hide()
	$meleeani/meleehit/CollisionShape2D.set_deferred('disabled', true)
	$meleeani.frame = 0
