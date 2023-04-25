extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Button_pressed():
	self.get_parent().get_node("Player").position.x = -2552
	self.get_parent().get_node("Player").position.y = -394
	self.get_parent().get_node("Button").disabled = true
