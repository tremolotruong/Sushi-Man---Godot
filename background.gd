extends Sprite

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if position.x <= 2777:
		position.x += .6
	else:
		position.x = 1777
	
