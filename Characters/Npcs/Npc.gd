extends "res://Characters/Character.gd"

func _on_timer_timeout():
	if not states[0].has_method('_on_timer_timeout'):
		return
	var new_state = states[0]._on_timer_timeout()
	if new_state:
		go_to_state(new_state)
		