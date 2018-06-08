extends Control

func _ready():
	pass
	

func _on_Move_status(_dict):
	var s = ""
	for i in _dict:
		s = s + "%s\n"%[_dict[i]]
	$Output.text = s 

func _on_Jump_status(_dict):
	var s = ""
	for i in _dict:
		s = s + "%s\n"%[_dict[i]]
	$Output2.text = s
	