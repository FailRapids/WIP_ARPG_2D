extends "res://Characters/States/Idle.gd"




func update(delta):
	var input_direction = Vector2()
	if Input.is_action_pressed("Player_Up"):
		input_direction.y = -1
	elif Input.is_action_pressed("Player_Down"):
		input_direction.y = 1
	if Input.is_action_pressed("Player_Left"):
		input_direction.x = -1
	elif Input.is_action_pressed("Player_Right"):
		input_direction.x = 1
	
		
	if input_direction != Vector2():
		return MOVE

	
func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP
	