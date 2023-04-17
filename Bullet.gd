extends KinematicBody2D
var target_pos = Vector2()
var motion = Vector2()
var Player
var speed = 8
var shooting = false
var just_shot = false
var bullet_pos = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.flip_h = true
	$Sprite.flip_v = true
	Player = get_parent().get_parent().get_node("Player")
	
#	print(get_path_to(Player))
	
func _process(_delta):
	if just_shot:
		self.position = get_parent().get_node("bulletlocation").position
		self.rotation = get_parent().get_node("weapon").rotation
		just_shot = false
		target_pos = Player.get_position()
		bullet_pos = self.position
	if shooting:
		motion = bullet_pos.direction_to(target_pos) * speed
		move_and_collide(motion)


func _on_hitbox_area_entered(area):
	print(area.name)
#	self.hide()
	self.position.x = 2000
