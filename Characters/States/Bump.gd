extends "res://Characters/States/_State.gd"

export(int,10,30) var BUMP_DISTANCE = 25
export(float,0.01,5) var BUMP_DURATION = .5
export(int,1,10) var MAX_BUMP_HEIGHT = 4

enum Directions {UP,DOWN,LEFT,RIGHT}

var BUMP_ANIMATIONS = {UP:"Hit_Up",DOWN:"Hit_Down",LEFT:"Hit_Left",RIGHT:"Hit_Right"}

func enter():
	
	_Tween.connect('tween_completed', _Enity,'_on_tween_finished')
	_Tween.interpolate_method(self, '_animate_height', 0, 1, BUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_Tween.interpolate_method(self,'_animate_movement',Vector2(), BUMP_DISTANCE * -_Enity.look_direction,BUMP_DURATION,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_Tween.start()
	_update_sprite(-_Enity.look_direction)
	
func update(delta):
	pass
	
func exit():
	_Tween.disconnect('tween_completed',_Enity,'_on_tween_finished')
	
func _animate_height(progress):
	_Enity.height = pow(sin(progress * PI), 0.4) * MAX_BUMP_HEIGHT

func _animate_movement(progress):
	move(progress)

func _on_tween_finished(object,key):
	if key == ":_animate_movement":
		return PREVIOUS_STATE
	if key == ":_animate_height":
		return PREVIOUS_STATE
		
func move(value):  
	#use movement from move state
	return _Enity.move_and_slide(value*4)
	
func _update_sprite(direction):
	if direction != Vector2():
		if direction.y == -1:
			_AnimationPlayer.play(BUMP_ANIMATIONS[UP])
		elif direction.y == 1:
			_AnimationPlayer.play(BUMP_ANIMATIONS[DOWN])
		if direction.x == 1:
			_AnimationPlayer.play(BUMP_ANIMATIONS[LEFT])
		elif direction.x == -1:
			_AnimationPlayer.play(BUMP_ANIMATIONS[RIGHT])
	

