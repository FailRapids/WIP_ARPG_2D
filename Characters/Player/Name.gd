extends Position2D



func _on_Player_state_changed(STATE_ID):
	print(STATE_ID)
	var s = ""
	for i in STATE_ID:
		print(i.name)
		s = s +"%s\n"%i.name
	$Label.text = s