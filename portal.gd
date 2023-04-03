extends Node2D

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name == "World1":
		level = 1
	elif get_tree().current_scene.name == "World2":
		level = 2
	$AnimatedSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):

	if body.name == "Player":
		if level == 1:
			get_tree().change_scene("res://World2.tscn")
			Checkpoint.last_position = Vector2(-1918,-811)
		elif level == 2:
			get_tree().change_scene("res://World1.tscn")
