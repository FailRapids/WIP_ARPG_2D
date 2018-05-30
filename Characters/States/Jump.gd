extends "res://Characters/States/_State.gd"

export var JUMP_DURATION = 0.2
export var MAX_JUMP_HEIGHT = 6

export var AIR_ACCELERATION = 20
export var AIR_DECCELERATION = 5
export var AIR_STEERING_POWER = 20

var max_air_speed = 0
var air_speed = 0
var air_velocity = Vector2()
var air_steering = Vector2()

func enter():
	air_speed = _Enity.speed
	max_air_speed = $'../Move'.MAX_WALK_SPEED
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_jump_height', 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func update(delta):
	jump(delta)

func exit():
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	
func jump(delta):
	if _Enity.move_direction:
		air_speed += AIR_ACCELERATION * delta
	else:
		air_speed -= AIR_DECCELERATION * delta
	air_speed = clamp(air_speed, 0, max_air_speed)

	var target_velocity = air_speed * _Enity.move_direction
	print("Move:%s"%_Enity.move_direction)
	var steering_velocity = (target_velocity - air_velocity).normalized() * AIR_STEERING_POWER
	air_velocity += steering_velocity
	
	_Enity.move_and_slide(air_velocity)
	

func _animate_jump_height(progress):
	_Enity.set_height(pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)

func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return PREVIOUS_STATE

