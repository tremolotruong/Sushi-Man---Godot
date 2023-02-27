extends KinematicBody2D

var max_hearts = 5
var num_hearts = 5

var knockback_direction
var knockback_delay = 40
var knockback = false
var movespeed = 600 * 60
var extravelo = Vector2()
var in_hitbox = false
var body_in_hitbox
var direction = 1

export var jump_height : float
export var jump_peak_t : float
export var jump_desc_t : float

onready var jump_grav : float = ((-2.0 * jump_height) / (jump_peak_t * jump_peak_t)) * -1.0
onready var jump_velo : float = ((2.0 * jump_height) / jump_peak_t) * -1.0
onready var fall_grav : float = ((-2.0 * jump_height) / (jump_desc_t * jump_desc_t)) * -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$gamecamera/UI/life/hearts.rect_size.x = max_hearts * 16
#	connect("life_changed", $gamecamera/UI/life/hearts, "on_life_change")
#	emit_signal("life_changed", max_hearts)

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.x = 0
	var gravity = fall_grav
	if velocity.y < 0.0:
		gravity = jump_grav
	
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		direction = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		direction = 1
	velocity.x *= movespeed * delta
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false
			
	if velocity.y != 0 and not is_on_floor():
		$AnimatedSprite.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite.play("run")
		
	else:
		$AnimatedSprite.play("idle")
	
#	$AnimatedSprite.play()
	
	if knockback_delay <= 0 and in_hitbox:
		damage()
		knockback(body_in_hitbox)
		knockback_delay = 40
		
	knockback_delay -= 1
	
	
	if knockback:
		velocity.y += -400
		velocity.x += 10000 * knockback_direction
		knockback = false
		
			
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velo
		
	if knockback:
		extravelo.y = -500 * movespeed
		extravelo.x = 500 * movespeed * knockback_direction * -1
		velocity = move_and_slide(velocity + extravelo, Vector2.UP)
		extravelo = lerp(extravelo, Vector2.ZERO, 0.9)
	else:
		velocity = move_and_slide(velocity, Vector2.UP)
	
	
	

func kill():
	get_tree().reload_current_scene()  # this will likely be changed, as this is to make the game reload every time the player dies.
func knockback(name):
	var enemy_direction = get_parent().get_node("{enemy}".format({"enemy": name})).direction
	knockback_direction = enemy_direction
	knockback = true
	
	
func damage():

	num_hearts -= 1
	$gamecamera/UI/life/hearts.rect_size.x = num_hearts * 16
	if num_hearts == 0:
		kill()
	
func _on_HitboxArea_body_entered(body):
	if "enemy" in body.name:
		in_hitbox = true
		body_in_hitbox = body.name
		

func _on_HitboxArea_body_exited(body):
	if "enemy" in body.name:
		in_hitbox = false
