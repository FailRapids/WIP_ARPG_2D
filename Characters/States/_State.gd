extends Node

signal status_changed(_dict)

enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, MOVE, BUMP, JUMP, ATTACK}

onready var _Enity = $"../.."
onready var _AnimationPlayer = $"../..".get_node("AnimationPlayer")
onready var _Tween = $"../..".get_node("Tween")
onready var _BodyPivot = $"../..".get_node("Body")
onready var _EnvCollision = $"../..".get_node("Env")
onready var _Weapon =$"../..".get_node("Body/WeaponPivot/WeaponSpawn")

var speed = 0 setget set_speed,get_speed
var air_speed = 0 setget set_air_speed,get_air_speed

var velocity = Vector2() setget set_velocity,get_velocity
var air_velocity = Vector2() setget set_air_velocity,get_air_velocity

var height = 0.0 setget set_height

var mass = 0



export var MAX_SPEED = 60
export var ACCELRATION = 35
export var DECCELERATION = 60

export(int,1,10) var STRENGTH = 5

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
	
##MAKE GUI TO VIS NO MORE CONSLOE SPAM
func get_speed():
	speed = _Enity.speed
	return speed
	

func set_speed(value):
	speed = value
	_Enity.speed = value
	
func get_air_speed():
	air_speed = _Enity.air_speed
	return air_speed

func set_air_speed(value):
	air_speed =  clamp(value,0,MAX_SPEED)
	_Enity.air_speed =  clamp(air_speed,0,MAX_SPEED)
	
func get_velocity():
	velocity = _Enity.velocity
	return velocity
	
func set_velocity(value):
	velocity = value
	_Enity.velocity = value
	
func get_air_velocity():
	air_velocity = _Enity.air_velocity
	return air_velocity
	
func set_air_velocity(value):
	air_velocity = value
	_Enity.air_velocity = value
	_Enity.velocity = value
	

func get_height():
	height = _Enity.height
	return height

func set_height(value):
	height = clamp(value,0,999)
	_Enity.height = height
	_BodyPivot.position.y = -height

func get_mass():
	mass = _Enity.mass
	return mass
	
func set_mass(value):
	if value < 0:
		value = 0
	mass = value
	_Enity.mass = value
	