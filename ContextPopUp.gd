extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
var wait_time = 10


func _ready():
	pass


func _process(delta):
	timer += delta
	if timer > wait_time:
		timer = 0
		emit_signal("timeout")

func _on_Timer_timeout():
	$ContextPopUp.hide()
