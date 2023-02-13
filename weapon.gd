extends Sprite

var knife_speed = 2000
var knife = preload("res://Knife.tscn")

func _ready():
	pass
	
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		throw()
		
func throw():
	var knife_instance = knife.instance()
	knife_instance.position = get_global_position()
	knife_instance.rotation_degrees = rotation_degrees
	knife_instance.apply_impulse(Vector2(),Vector2(knife_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",knife_instance)
