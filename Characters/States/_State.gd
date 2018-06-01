extends Node

enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, MOVE, BUMP, JUMP, ATTACK}

onready var _Enity = $"../.."
onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")
onready var _Tween = $"../..".get_node("Tween")
onready var _BodyPivot = $"../..".get_node("BodyPivot")


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

func _on_tween_finshed(object,key):
	pass
