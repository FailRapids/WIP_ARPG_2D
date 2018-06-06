extends Position2D



func _on_Player_state_changed(STATE_ID):
	var s = ""
	for i in STATE_ID:
		s = s +"%s\n"%i.name
	$PanelContainer/Label.text = s

func _on_Character_state_changed(STATE_ID):
	var s = ""
	for i in STATE_ID:
		s = s +"%s\n"%i.name
	$PanelContainer/Label.text = s
