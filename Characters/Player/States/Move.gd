extends 'res://Characters/Player/States/_State.gd'

export var MAX_WALK_SPEED = 40
export var MAX_RUN_SPEED = 80
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
	if event.is_action_pressed("Player_Jump"):
		_Enity.look_direction = _Enity.move_direction
	
		return JUMP
	if event.is_action_pressed("Player_Attack"):
		return ATTACK

func exit():
	pass
	
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
	var hit = move()
	
	if hit:
		return BUMP
		
	if _Enity.move_direction == Vector2():
		return PREVIOUS_STATE
		
func move():
	if Input.is_action_pressed("Player_Run"):
		_Enity.speed = MAX_RUN_SPEED
	else:
		_Enity.speed = MAX_WALK_SPEED
		
	_Enity.velocity = _Enity.speed * _Enity.move_direction.normalized()
	_Enity.move_and_slide(_Enity.velocity )
	_update_sprite()
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env'):
				return BUMP
	
func _update_sprite():
	if _Enity.move_direction != Vector2():
		if _Enity.look_direction != _Enity.move_direction:
			_Enity.look_direction = _Enity.move_direction
			if _Enity.move_direction.y == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[UP])
			elif _Enity.move_direction.y == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[DOWN])
			if _Enity.move_direction.x == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[LEFT])
			elif _Enity.move_direction.x == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[RIGHT])
		