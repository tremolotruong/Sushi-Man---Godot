extends Node2D

func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position
		
func _ready():
	$Sun.play()
	$enterportal.play()



func _on_enterportal_animation_finished():
	$enterportal.stop()
	$enterportal.hide()


	
