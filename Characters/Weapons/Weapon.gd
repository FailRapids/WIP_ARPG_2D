extends Area2D

var states = []

enum STATE_IDS {NULL, PREVIOUS_STATE, IDLE, LISTENING, REGISTERED,ATTACK}

onready var States = {
	IDLE: $"States/Idle",
	ATTACK: $"States/Attack"
}


func _enter_tree():
	print("Im here")

func _exit_tree():
	print("Im goon")
	
func _ready():
	states.push_front(States[IDLE])
	states[0].enter()


func _physics_process(delta):
	if not states[0].has_method('update'):
		return
	var new_state = states[0].update(delta)
	if new_state:
		go_to_state(new_state)

func go_to_state(new_state):
	match new_state:
		PREVIOUS_STATE:
			states.pop_front().exit()
		IDLE:
			states.push_front(States[new_state])
		ATTACK:
			states.push_front(States[new_state])
		_:
			states[0] = States[new_state]
	
	emit_signal("state_changed",self.states)
	states[0].enter()


func _on_animation_finished( Anim ):
	if not states[0].has_method('_on_animation_finished'):
		return
	var new_state = states[0]._on_animation_finished(Anim)
	if new_state:
		go_to_state(new_state)