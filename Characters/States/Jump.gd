extends "res://Characters/States/_State.gd"

export var JUMP_DURATION = 0.2
export var MAX_JUMP_HEIGHT = 10
export var MAX_JUMP_SPEED = 40

export var ACCELERATION = 5
export var DECCELERATION = 10

export var STRENGTH = 25


func enter():
	_Enity.air_speed = _Enity.speed
	_EnvCollision.set_disabled(true)
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_jump_height', 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func update(delta):
	var exit = jump(delta)
	if exit:
		return exit
func exit():
	_EnvCollision.set_disabled(false)
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	_Enity.speed = _Enity.air_speed
	
func jump(delta):
	if _Enity.move_direction:
		_Enity.air_speed += ACCELERATION * delta
	else:
		_Enity.air_speed -= DECCELERATION * delta
	_Enity.air_speed = clamp(_Enity.air_speed, 0, MAX_JUMP_SPEED)

	var steered_velocity = (_Enity.air_speed * _Enity.move_direction) - _Enity.velocity
	_Enity.velocity += (steered_velocity / _Enity.mass) * STRENGTH
	_Enity.move_and_slide(_Enity.velocity)
	
	

func _animate_jump_height(progress):
	_Enity.set_height(pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)

func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return PREVIOUS_STATE

