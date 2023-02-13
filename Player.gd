extends KinematicBody2D

var movespeed = 600
var direction


export var jump_height : float
export var jump_peak_t : float
export var jump_desc_t : float

onready var jump_grav : float = ((-2.0 * jump_height) / (jump_peak_t * jump_peak_t)) * -1.0
onready var jump_velo : float = ((2.0 * jump_height) / jump_peak_t) * -1.0
onready var fall_grav : float = ((-2.0 * jump_height) / (jump_desc_t * jump_desc_t)) * -1.0

var speed = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var velocity = Vector2.ZERO
func _physics_process(delta):
	velocity.x = 0
	var gravity = fall_grav
	if velocity.y < 0.0:
		gravity = jump_grav
	
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	velocity.x *= movespeed

	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velo
	velocity = move_and_slide(velocity, Vector2.UP)
	

func kill():
	get_tree().reload_current_scene()  # this will likely be changed, as this is to make the game reload every time the player dies.

func _on_HitboxArea_body_entered(body):
	if "Enemy" in body.name:
		kill()
	if "Tomato" in body.name:
		kill()
