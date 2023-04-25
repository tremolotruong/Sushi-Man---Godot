extends KinematicBody2D
var Player
var dir = Vector2()
var bullet = preload("res://Bullet.tscn")
var shooting = false
var health = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_parent().get_node("Player")


func _process(_delta):
	if not shooting:
		shoot()
		$shoot_timer.start()
		shooting = true

func shoot():
	$enemybullet.shooting = true
	$enemybullet.just_shot = true
	$shoot_timer.start()


func _on_shoot_timer_timeout():
	shooting = false
	$enemybullet.shooting = false

func _on_alertarea_area_entered(area):
	if "HitboxArea" in area.name:
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").show()
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").get_node("bossname").text = "Soyclops"
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").max_value = health
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		

func _on_hitboxarea_body_entered(body):
	if "Knife" in body.name:
		health -= 1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			self.get_parent().get_node("exitportal").show()
			self.get_parent().get_node("exitportal").play()
			queue_free()
		body.queue_free()

func _on_hitboxarea_area_entered(area):
	if "meleehit" in area.name:
		health -= 1
		Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").value = health
		if health <= 0:
			Player.get_node("gamecamera").get_node("UI").get_node("bosshealthbar").hide()
			queue_free()
