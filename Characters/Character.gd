extends KinematicBody2D

var states = []

enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, MOVE, BUMP, JUMP, ATTACK}
signal state_changed(STATE_ID)
onready var States = {
	IDLE: $'States/Idle',
	MOVE: $'States/Move',
	BUMP: $'States/Bump',
	JUMP: $'States/Jump',
	ATTACK: $'States/Attack'
}

var look_direction = Vector2()
var height = 0.0 setget set_height
var velocity = Vector2()
var move_direction = Vector2()
var speed = 0
func _ready():
	states.push_front(States[IDLE])
	states[0].enter()


func _physics_process(delta):
	if not states[0].has_method('update'):
		return
	var new_state = states[0].update(delta)
	if new_state:
		go_to_state(new_state)
	


func _input(event):
	if not states[0].has_method('handle_input'):
		return
	
	var new_state = states[0].handle_input(event)
	if new_state:
		go_to_state(new_state)



func go_to_state(new_state):
	states[0].exit()
	match new_state:
		PREVIOUS_STATE:
			states.pop_front()
	
		ATTACK:
			print("Entering %s"%States[new_state].name)
			states.push_front(States[new_state])
		BUMP,JUMP:
			states.push_front(States[new_state])
		MOVE:
			states.push_front(States[new_state])
		
		_:
			states[0] = States[new_state]
	
	emit_signal("state_changed",self.states)
	states[0].enter()


func _on_animation_finished( Anim ):
	if not states[0].has_method('_on_animation_finished'):
		return
	print("Animation_finished %s"%states[0].name)
	var new_state = states[0]._on_animation_finished(Anim)
	if new_state:
		go_to_state(new_state)

func _on_tween_finished(object,key):
	if not states[0].has_method('_on_tween_finished'):
		return
	var new_state = states[0]._on_tween_finished(object,key)
	if new_state:
		go_to_state(new_state)

	
	
func set_height(value):
	height = value
	$BodyPivot.position.y = -value


