extends 'res://Characters/States/Move.gd'

func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP
	elif event.is_action_pressed("Player_Attack"):
		return ATTACK




