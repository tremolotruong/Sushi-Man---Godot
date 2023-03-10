extends KinematicBody2D

var motion = Vector2()

var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position)/100  # dividing this number (currently 50) by smaller numbers will make the enemies approach the player at a faster speed.
	look_at(Player.position)
	print(rotation_degrees)
	
	move_and_collide(motion)

func _on_HitboxArea_body_entered(body):
	if "Knife" in body.name:
		queue_free()

func _on_HitboxArea_area_entered(area):
	if "meleehit" in area.name:
		queue_free()
