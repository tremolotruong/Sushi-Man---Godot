extends Node2D

func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position
		
func _ready():
	$portal.get_node("Area2D/CollisionShape2D").disabled = true
	$portal.hide()
	$exitportal.hide()



func _on_exitportal_animation_finished():
	$portal.show()
	$exitportal.hide()
	$portal.get_node("Area2D/CollisionShape2D").disabled = false
