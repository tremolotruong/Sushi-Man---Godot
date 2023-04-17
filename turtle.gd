extends Node2D
var numtext = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()
	$textbox.hide()


func _on_text_timer_timeout():
	if numtext == 1:
		$textbox.hide()
	elif numtext == 2:
		$textbox.get_node("dialogue").text = " TUTORIAL TURTLE:\n There's an avocado tree down below\n rumored to grow magical avocados,\n           BUT BE WARNED......\n many chefs before you have tried,\n only to meet their doom at it's trunk!"
		$textbox/text2_timer.start()



func _on_dialogue1_area_entered(area):
	if "HitboxArea" in area.name:
		$textbox.show()
		$textbox.get_node("dialogue").text = " TUTORIAL TURTLE:\n\n be careful when walking near crabs!\n they have sharp claws and invincible\n shells that can't be broken"
		$textbox/text_timer.start()


func _on_dialogue2_area_entered(area):
	print(area)
	if "HitboxArea" in area.name:
		numtext = 2
		$textbox.show()
		$textbox.get_node("dialogue").text = " TUTORIAL TURTLE:\n Hey, I'm tutorial turtle!\n It's been a while since we've seen\n a chef around here...  You must be\n looking for the magical ingredients!"
		$textbox/text_timer.start()


func _on_text2_timer_timeout():
	$textbox.hide()
