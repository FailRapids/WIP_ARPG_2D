extends "res://Characters/States/_State.gd"

export var BUMP_DISTANCE = 20
export var BUMP_DURATION = 0.2
export var MAX_BUMP_HEIGHT = 5

var pos = Vector2() setget set_pos
var y = 0 setget set_y

func enter():
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_bump', 0, 1, BUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.interpolate_method(self,'set_pos',_Enity.position,_Enity.position + BUMP_DISTANCE * -_Enity.look_direction,BUMP_DURATION,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_Tween.start()

func update(delta):
	pass
	
func exit():
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	
func _animate_bump(progress):
	self.y = pow(sin(progress * PI), 0.4) * MAX_BUMP_HEIGHT

func _on_tween_finished(object,key):
	if key == ":_animate_bump":
		return PREVIOUS_STATE

func set_pos(value):
	pos = value
	_Enity.position = value
	
func set_y(value):
	y = value
	_BodyPivot.position.y = -value
