extends RigidBody2D


func _ready():
	$dissapear.start()


func _on_dissapear_timeout():
	queue_free()
