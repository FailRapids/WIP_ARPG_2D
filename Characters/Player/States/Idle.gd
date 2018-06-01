extends "res://Characters/Player/States/_State.gd"


func enter():
	_AnimationPlayer.play("Idle")

func update(delta):
	if _Enity.get_move_direction():	return MOVE

func exit():
	_AnimationPlayer.stop()
	
func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP
	if event.is_action_pressed("Player_Attack"):
		return ATTACK