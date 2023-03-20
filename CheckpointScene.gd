extends Area2D


func _ready():
	$AnimatedSprite.stop()


func _on_Area2D_body_entered(body):
	Checkpoint.last_position = global_position
	$AnimatedSprite.play()
