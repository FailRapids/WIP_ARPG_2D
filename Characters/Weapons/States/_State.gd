extends Node

signal status_changed(_dict)

enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, ATTACK}

onready var _Enity = $"../.."
onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")

var combo_count = 0

func enter():
	pass

func exit():
	pass
	
func update(delta):
	pass
	
func handle_input(event):
	pass

func _on_animation_finished(name):
	pass

