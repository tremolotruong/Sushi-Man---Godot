extends Node2D
var cursor_type = 'sword'
var on_dialogue = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	self.position = self.get_global_mouse_position()
#	if Input.is_action_pressed("melee"):
	if cursor_type == 'sword':
		$AnimatedSprite.scale.x = 4
		$AnimatedSprite.scale.y = 4
		$AnimatedSprite.play('sword')
		if $AnimatedSprite.frame == 3:
			$AnimatedSprite.stop()
			$AnimatedSprite.frame = 0
	elif cursor_type == 'dialogue':
		self.get_parent().get_node("Player").get_node("knife").can_melee = false
		$AnimatedSprite.scale.x = 2
		$AnimatedSprite.scale.y = 2
		$AnimatedSprite.play("dialogue")
		if Input.is_action_just_pressed("melee"):
			self.get_parent().get_node('turtle').get_node('textbox').show()
			self.get_parent().get_node('turtle').get_node('textbox').get_node('text_timer').start()
			
			
		


func _on_Area2D_area_entered(area):
	if 'dialogue' in area.name:
		cursor_type = 'dialogue'
		




func _on_Area2D_area_exited(area):
	if 'dialogue' in area.name:
		self.get_parent().get_node("Player").get_node("knife").can_melee = true
		cursor_type = 'sword'
