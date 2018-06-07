extends Position2D



func _on_state_changed(STATE_ID):
	var s = ""
	for i in STATE_ID:
		s = s +"%s\n"%i.name
	$PanelContainer/Label.text = "State\n"+s