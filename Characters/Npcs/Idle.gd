extends "res://Characters/States/Idle.gd"

func enter():
	$Timer.connect("timeout",_Enity,"_on_timer_timeout")
	$Timer.start()
	.enter()

func _on_timer_timeout():
	return JUMP