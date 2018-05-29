extends "res://Characters/States/_State.gd"

export var BUMP_DISTANCE = 20
export var BUMP_DURATION = 0.2
export var MAX_BUMP_HEIGHT = 5

var height = 0 setget set_height

func enter():
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_height', 0, 1, BUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.interpolate_method(self,'_animate_movement',Vector2(), BUMP_DISTANCE * -_Enity.look_direction,BUMP_DURATION,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_Tween.start()
	
func update(delta):
	pass
	
func exit():
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	
func _animate_height(progress):
	self.height = pow(sin(progress * PI), 0.4) * MAX_BUMP_HEIGHT

func _animate_movement(progress):
	move(progress)

func _on_tween_finished(object,key):
	if key == ":_animate_movement":
		return PREVIOUS_STATE
	if key == ":_animate_height":
		return PREVIOUS_STATE
		
func move(value):  
	return _Enity.move_and_slide(value * 5)
	
func set_height(value):
	height = value
	_BodyPivot.position.y = -value
