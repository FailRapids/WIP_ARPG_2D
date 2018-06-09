extends "res://Characters/States/_State.gd"
var weapon_path = "res://Characters/Weapons/Weapon.tscn"

var weapon = null

func enter():
	var weapon_instance = load(weapon_path).instance()
	weapon = _Enity.get_node("Body").add_child(weapon_instance)


func exit():
	pass

func update():
	pass
	
