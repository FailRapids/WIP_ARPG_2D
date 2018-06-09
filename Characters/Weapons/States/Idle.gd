extends "res://Characters/Weapons/States/_State.gd"


func enter():
	print("IN_IDLE")
	self.combo_count = 0
	_AnimationPlayer.play('Idle')
	_Enity.monitoring = false


	