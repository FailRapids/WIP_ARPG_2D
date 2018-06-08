extends "res://Characters/Player/States/_State.gd"


func enter():
	_AnimationPlayer.play("Idle")

func update(delta):
	if _Enity.move_direction != Vector2():return MOVE

func exit():
	_AnimationPlayer.stop()
	
func handle_input(event):
	if event.is_action_pressed("Player_Jump"):
		return JUMP
	elif event.is_action_pressed("Player_Attack"):
		return ATTACK