extends AnimatedSprite


var finished = false


func _ready():
	finished = false
	self.hide()


func _on_Area2D_area_entered(area):
	if finished:
		self.get_parent().get_node("Player").position.x = 24912
		self.get_parent().get_node("Player").position.y = 2177
		self.get_parent().get_node("Player").get_node("gamecamera").get_node("UI").hide()
