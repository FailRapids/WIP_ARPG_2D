extends "res://Characters/Character.gd"
#Player.gd

func get_look_direction():
	var last = look_direction
	look_direction = Vector2()
	if Input.is_action_pressed("Player_Up"):
		look_direction.y = -1
	elif Input.is_action_pressed("Player_Down"):
		look_direction.y = 1
	if Input.is_action_pressed("Player_Left"):
		look_direction.x = -1
	elif Input.is_action_pressed("Player_Right"):
		look_direction.x = 1
	else:
		look_direction = last
		return last
	return look_direction