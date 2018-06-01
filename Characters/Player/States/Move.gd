extends 'res://Characters/States/Move.gd'

func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP
	if event.is_action_pressed("Player_Attack"):
		return ATTACK
	
	if event.is_action_pressed("Player_Run"):
		RUN = true
	elif Input.is_action_just_released("Player_Run"):
		RUN = false




