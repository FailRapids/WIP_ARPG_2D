extends "res://Characters/Player/States/_State.gd"

func enter():
	_AnimationPlayer.connect("animation_finished",_Enity,"_on_animation_finished")
	if _Enity.get_look_direction():
		if _Enity.look_direction.y == -1:
			_AnimationPlayer.play("Attack_Up")
		elif _Enity.look_direction.y == 1:
			_AnimationPlayer.play("Attack_Down")
		if _Enity.look_direction.x == -1:
			_AnimationPlayer.play("Attack_Left")
		elif _Enity.look_direction.x == 1:
			_AnimationPlayer.play("Attack_Right")
	else:
		_AnimationPlayer.play("Attack_Down")

func exit():
	_AnimationPlayer.disconnect("animation_finished",_Enity,"_on_animation_finished")
	_AnimationPlayer.stop()

func _on_animation_finished(Anim):
	match Anim:
		"Attack_Up":
			return PREVIOUS_STATE
		"Attack_Down":
			return PREVIOUS_STATE
		"Attack_Left":
			return PREVIOUS_STATE
		"Attack_Right":
			return PREVIOUS_STATE
			