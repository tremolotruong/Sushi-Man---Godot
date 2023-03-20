extends Node
var last_position




func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Checkpoint.last_position = self.global_position
		$AnimatedSprite.play()
