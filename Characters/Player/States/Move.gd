extends 'res://Characters/States/Move.gd'

export var MAX_WALK_SPEED = 40
export var MAX_RUN_SPEED = 80

func enter():
	pass
	
func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP


func update(delta):
			# Movement
	move_direction = Vector2()

	if Input.is_action_pressed("Player_Up"):
		move_direction.y = -1
	elif Input.is_action_pressed("Player_Down"):
		move_direction.y = 1	
	if Input.is_action_pressed("Player_Left"):
		move_direction.x = -1
	elif Input.is_action_pressed("Player_Right"):
		move_direction.x = 1
	
	var hit = move()
	
	if hit:
		return BUMP
		
	if move_direction == Vector2():
		return PREVIOUS_STATE
		
func move():
	if Input.is_action_pressed("Player_Run"):
		speed = MAX_RUN_SPEED
	else:
		speed = MAX_WALK_SPEED
		
	velocity = speed * move_direction.normalized()
	_Enity.move_and_slide(velocity )
	_update_sprite()
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env'):
				return BUMP
	
func _update_sprite():
	if move_direction != Vector2():
		if _Enity.look_direction != move_direction:
			_Enity.look_direction = move_direction
			if move_direction.y == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[UP])
			elif move_direction.y == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[DOWN])
			if move_direction.x == -1:
				_AnimationPlayer.play(WALK_ANIMATIONS[LEFT])
			elif move_direction.x == 1:
				_AnimationPlayer.play(WALK_ANIMATIONS[RIGHT])
		