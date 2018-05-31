extends "res://Characters/Player/States/Move.gd"

export(float) var WALK_MASS = 10.0
export(float) var RUN_MASS = 3.0

var velocity = Vector2()
var speed = 0 setget set_speed
const STOP_THRESHOLD = 3.0 # stop if the movement speed speed falls below 3 px/s

const ANIM_SLIDE_THRESHOLD = 5 # stop the animation if the movement speed speed falls below 120 px/s

func update(delta):
			# Movement
	_Enity.move_direction = Vector2()

	if Input.is_action_pressed("Player_Up"):
		_Enity.move_direction.y = -1
	elif Input.is_action_pressed("Player_Down"):
		_Enity.move_direction.y = 1	
	if Input.is_action_pressed("Player_Left"):
		_Enity.move_direction.x = -1
	elif Input.is_action_pressed("Player_Right"):
		_Enity.move_direction.x = 1
	if Input.is_action_pressed("Player_Run"):
		_Enity.speed = MAX_RUN_SPEED
	else:
		_Enity.speed = MAX_WALK_SPEED
	return move(_Enity.speed,_Enity.move_direction)
	
func move(speed, direction):
	_update_sprite()
	var desired_velocity = direction.normalized() * speed
	var steering = desired_velocity - velocity
	var current_mass = RUN_MASS if Input.is_action_pressed('Player_Run') else WALK_MASS
	velocity += steering / current_mass
	_Enity.move_and_slide(velocity, Vector2(), 5, 2)
	
	var current_speed = velocity.length()
	if current_speed > ANIM_SLIDE_THRESHOLD:
		_AnimationPlayer.playback_speed = lerp(0.4, 1.0, current_speed / MAX_RUN_SPEED)
	if current_speed < STOP_THRESHOLD:
		return 1

func exit():
	.exit()
	speed = 0 
	
func set_speed(value):
	speed = value
	_Enity.speed = value