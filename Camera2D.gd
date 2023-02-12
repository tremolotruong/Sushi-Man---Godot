extends Camera2D



var player

func _ready():
	player= get_node("res://Player.gd")
	

func _process(delta):
	position.x=player.position.xdsad
	position.y=player.position.y
