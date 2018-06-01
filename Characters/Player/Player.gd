extends "res://Characters/Character.gd"
#Player.gd

enum INPUTS {UP,DOWN,LEFT,RIGHT,SPRINT,ATTACK,JUMP}
var INPUT_MAP = {UP:"Player_Up",DOWN:"Player_Down",LEFT:"Player_Left",RIGHT:"Player_Right",
				SPRINT:"Player_Run",ATTACK:"Player_Attack",JUMP:"Player_Jump"}

func _input(event):
	if not states[0].has_method('handle_input'):
		return
	var new_state = states[0].handle_input(event)
	if new_state:
		go_to_state(new_state)

func get_look_direction():
	var last = look_direction
	look_direction = Vector2()
	
	if Input.is_action_pressed(INPUT_MAP[UP]):
		look_direction.y = -1
	elif Input.is_action_pressed(INPUT_MAP[DOWN]):
		look_direction.y = 1
	if Input.is_action_pressed(INPUT_MAP[LEFT]):
		look_direction.x = -1
	elif Input.is_action_pressed(INPUT_MAP[RIGHT]):
		look_direction.x = 1
	
	if look_direction != Vector2():
		return look_direction
	else:
		return last
	
func get_move_direction():
	var last = move_direction
	move_direction = Vector2()

	if Input.is_action_pressed(INPUT_MAP[UP]):
		move_direction.y = -1
	elif Input.is_action_pressed(INPUT_MAP[DOWN]):
		move_direction.y = 1
	if Input.is_action_pressed(INPUT_MAP[LEFT]):
		move_direction.x = -1
	elif Input.is_action_pressed(INPUT_MAP[RIGHT]):
		move_direction.x = 1
	
	if move_direction != Vector2():
		return move_direction
	else:
		return last
		