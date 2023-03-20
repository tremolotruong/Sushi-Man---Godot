extends Node2D


func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sun.play()
