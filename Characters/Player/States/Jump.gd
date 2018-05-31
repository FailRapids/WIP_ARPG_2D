extends "res://Characters/States/Jump.gd"
func update(delta):
	.update(delta)
	update_sprite()
#REMOVE!!!!!	
func update_sprite():
	$"../Move"._update_sprite()
