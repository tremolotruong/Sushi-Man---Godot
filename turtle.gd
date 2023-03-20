extends Node2D
var hovering = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	$textbox.hide()


func _on_text_timer_timeout():
	$textbox.hide()
