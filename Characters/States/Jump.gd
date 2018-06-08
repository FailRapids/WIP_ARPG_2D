extends "res://Characters/States/_State.gd"

export var JUMP_DURATION = 0.50
export var MAX_JUMP_HEIGHT = 8



func enter():
	self.air_speed = self.speed 
	self.air_velocity = self.velocity
	
	_EnvCollision.set_disabled(true)
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_jump_height', 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.start()

func update(delta):
	var direction = _Enity.look_direction
	jump(delta,direction)
	var status = {"Speed":self.air_speed,"Velocity":self.air_velocity}
	emit_signal("status_changed",status)

func exit():
	_EnvCollision.set_disabled(false)
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	
	
func jump(delta,direction):
	if _Enity.move_direction != Vector2():
		self.air_speed = clamp(self.air_speed + (ACCELRATION * delta),15,MAX_SPEED)
	else:
		self.air_speed -= DECCELERATION * delta
	
	var steered_velocity = (direction * self.air_speed) - self.air_velocity
	self.air_velocity += (steered_velocity / 5) * STRENGTH
	_Enity.move_and_slide(self.air_velocity)
	

func _animate_jump_height(progress):
	self.height = (pow(sin(progress * PI), 0.5) * MAX_JUMP_HEIGHT)
	
	
func _on_tween_finished(object,key):
	if key == ":_animate_jump_height":
		return PREVIOUS_STATE
