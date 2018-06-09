extends "res://Characters/Player/States/_State.gd"

var weapon_path = "res://Characters/Weapons/Weapon.tscn"
var weapon = null

func enter():
	self.weapon = _Weapon.spawn(weapon_path)
	
func update(delta):
	return PREVIOUS_STATE
	
func exit():
	self.weapon.queue_free()

func _on_animation_finished(Anim):
	pass


