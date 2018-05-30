extends 'res://Characters/States/_State.gd'

var speed = 0

export var MAX_SPEED = 40


var velocity = Vector2()
var move_direction = Vector2()

enum DIRECTIONS {UP,DOWN,LEFT,RIGHT}
var WALK_ANIMATIONS = {
						UP:'Walk_Up',
						DOWN:'Walk_Down',
						LEFT:'Walk_Left',
						RIGHT:'Walk_Right'
					}


func enter():
	if _Enity.look_direction.y == -1:
		_AnimationPlayer.play(WALK_ANIMATIONS[UP])
	elif _Enity.look_direction.y == 1:
		_AnimationPlayer.play(WALK_ANIMATIONS[DOWN])
	elif _Enity.look_direction.x == -1:
		_AnimationPlayer.play(WALK_ANIMATIONS[LEFT])
	elif _Enity.look_direction.x == 1:
		_AnimationPlayer.play(WALK_ANIMATIONS[RIGHT])

func handle_input(event):
	pass
	


func update(delta):
	
	if move_direction != Vector2():
		if _Enity.look_direction != move_direction:
			_Enity.look_direction = move_direction
			if move_direction.y == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[UP])
			elif move_direction.y == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[DOWN])
			elif move_direction.x == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[LEFT])
			elif move_direction.x == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[RIGHT])
	
	# velocity
	velocity = MAX_SPEED * move_direction.normalized()
	_Enity.move_and_slide(velocity)
	
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env'):
				return BUMP
	
	# State management
	if move_direction == Vector2():
		return IDLE