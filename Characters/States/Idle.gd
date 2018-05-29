extends 'res://Characters/States/_State.gd'


func enter():
	_AnimationPlayer.play('Idle')


func handle_input(event):
	pass


func update(delta):
	var input_direction = Vector2()
	if input_direction != Vector2():
		return MOVE