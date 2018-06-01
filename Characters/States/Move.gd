extends 'res://Characters/States/_State.gd'


var RUN = false

enum MOVE_TYPE {DEBUG,NORMAL}
export(bool) var _move_type = DEBUG

enum DIRECTIONS {UP,DOWN,LEFT,RIGHT}
var WALK_ANIMATIONS = {UP:'Walk_Up',DOWN:'Walk_Down',
						LEFT:'Walk_Left',RIGHT:'Walk_Right'}

export(int,1,40) var MAX_WALK_SPEED = 40
export(int,30,60) var MAX_RUN_SPEED = 60

export(float) var WALK_MASS = 20.0
export(float) var RUN_MASS = 15.0

export(int,1,10) var STRENGTH = 5



func enter():
	_update_sprite()
	
func update(delta):
	var exit_state = move_and_collide(delta)
	if exit_state:
		return exit_state
	
func exit():
	RUN = false
	_AnimationPlayer.stop()
	
func debug_move(delta):
	
	_Enity.speed = MAX_RUN_SPEED if RUN else MAX_WALK_SPEED
	_Enity.velocity = _Enity.speed * _Enity.move_direction
	_Enity.move_and_slide(_Enity.velocity )

func move(delta):
	_Enity.speed = MAX_RUN_SPEED if RUN else MAX_WALK_SPEED
	_Enity.mass = RUN_MASS if RUN else WALK_MASS
	
	var steered_velocity = (_Enity.move_direction * _Enity.speed) - _Enity.velocity
	
	_Enity.mass = RUN_MASS if RUN else WALK_MASS
	_Enity.velocity += (steered_velocity / _Enity.mass) * STRENGTH
	_Enity.move_and_slide(_Enity.velocity)
	
	
	
func move_and_collide(delta): 
	if _move_type:
		move(delta)
	else:
		debug_move(delta)
	
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env') and _Enity.speed > MAX_WALK_SPEED:
				return BUMP
	
	if _Enity.move_direction == Vector2():
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
