extends 'res://Characters/States/_State.gd'



export var MAX_WALK_SPEED = 40
export var MAX_RUN_SPEED = 80
var RUN = false
enum DIRECTIONS {UP,DOWN,LEFT,RIGHT}

var WALK_ANIMATIONS = {
						UP:'Walk_Up',
						DOWN:'Walk_Down',
						LEFT:'Walk_Left',
						RIGHT:'Walk_Right'
					}

func enter():
	_update_sprite()
	
func update(delta):
	if _Enity.move_direction == Vector2():
		return PREVIOUS_STATE
	var exit_state = move_and_collide(delta)
	if exit_state:
		return exit_state
	
func exit():
	_AnimationPlayer.stop()
	
func move(delta):
	if RUN:
		_Enity.speed = MAX_RUN_SPEED
	else:
		_Enity.speed = MAX_WALK_SPEED
	
	_Enity.velocity = _Enity.speed * _Enity.get_move_direction()
	_Enity.move_and_slide(_Enity.velocity )
	
func move_and_collide(delta): 
	move(delta)
	
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env'):
				return BUMP
	
	if _Enity.get_move_direction() == Vector2():
		return PREVIOUS_STATE
	
func _update_sprite():
	var move_direction = _Enity.get_move_direction()
	var look_direction = _Enity.get_look_direction()
	
	if move_direction != Vector2():
		if _Enity.move_direction.y == -1:
			_AnimationPlayer.play(WALK_ANIMATIONS[UP])
		elif _Enity.move_direction.y == 1:
			_AnimationPlayer.play(WALK_ANIMATIONS[DOWN])
		if _Enity.move_direction.x == -1:
			_AnimationPlayer.play(WALK_ANIMATIONS[LEFT])
		elif _Enity.move_direction.x == 1:
			_AnimationPlayer.play(WALK_ANIMATIONS[RIGHT])
