extends Control

var size_y = 16
func on_life_change(player_hearts):
	$hearts.rect_size.x = player_hearts * size_y
	
