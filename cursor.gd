extends Node2D
var cursor_type = 'sword'
var on_dialogue = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimatedSprite.play()
	

func _process(delta):
	self.position = get_global_mouse_position()
