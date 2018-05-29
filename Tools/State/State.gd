extends Position2D

var states = ["Idle","Walk","Attack"]

func _ready():
	pass

func _on_Player_state_changed(new_state):
	$Container/Label.set_text(states[new_state])
