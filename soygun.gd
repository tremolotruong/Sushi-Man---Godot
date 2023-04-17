extends Sprite
var Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.flip_h = true
	self.flip_v = true
	Player = get_parent().get_parent().get_node("Player")

func _process(delta):
	look_at(Player.position)
