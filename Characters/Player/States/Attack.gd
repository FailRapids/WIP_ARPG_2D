extends "res://Characters/Player/States/_State.gd"

func enter():
	_AnimationPlayer.connect("animation_finished",_Enity,"_on_animation_finished")
	_update_sprite()

func exit():
	_AnimationPlayer.disconnect("animation_finished",_Enity,"_on_animation_finished")
	_AnimationPlayer.stop()

func _update_sprite():
	var look_direction = _Enity.get_look_direction()
	if look_direction.y == -1:
		_AnimationPlayer.play("Attack_Up")
	elif look_direction.y == 1:
		_AnimationPlayer.play("Attack_Down")
	if look_direction.x == -1:
		_AnimationPlayer.play("Attack_Left")
	elif look_direction.x == 1:
		_AnimationPlayer.play("Attack_Right")
	if look_direction == Vector2():
		_AnimationPlayer.play("Attack_Right")
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
			