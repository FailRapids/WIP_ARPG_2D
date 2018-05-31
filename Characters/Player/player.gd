extends KinematicBody2D

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 700

enum STATES { IDLE, MOVE }
var state = null

export(float) var WALK_MASS = 10.0
export(float) var RUN_MASS = 3.0
var velocity = Vector2()
const STOP_THRESHOLD = 10.0 # stop if the movement speed speed falls below 3 px/s

const ANIM_SLIDE_THRESHOLD = 120.0 # stop the animation if the movement speed speed falls below 120 px/s

func _ready():
	_change_state(IDLE)


func _change_state(new_state):
	var current_state = state
	match current_state:
		# Don't forget to clean up the move state and reset the animation speed
		MOVE:
			$AnimationPlayer.playback_speed = 1.0

	match new_state:
		IDLE:
			$AnimationPlayer.play('idle')
		MOVE:
			$AnimationPlayer.play('walk')
	state = new_state


func _physics_process(delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)

	var current_state = state
	match current_state:
		IDLE:
			if input_direction:
				_change_state(MOVE)
		MOVE:
			# You could calculate the speed in the move() method instead
			var speed = 0.0
			if input_direction:
				speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED

			var go_to_idle = move(speed, input_direction)
			if go_to_idle:
				_change_state(IDLE)



func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func update_look_direction(input_direction):
	if not input_direction.x in [-1, 1]:
		return
	$BodyPivot.set_scale(Vector2(input_direction.x, 1))


func move(speed, direction):
	var desired_velocity = direction.normalized() * speed
	var steering = desired_velocity - velocity
	var current_mass = RUN_MASS if Input.is_action_pressed('run') else WALK_MASS
	velocity += steering / current_mass
	move_and_slide(velocity, Vector2(), 5, 2)

	var current_speed = velocity.length()
#	if current_speed > ANIM_SLIDE_THRESHOLD:
#		$AnimationPlayer.playback_speed = lerp(0.4, 1.0, current_speed / MAX_RUN_SPEED)
	return current_speed < STOP_THRESHOLD

# Extra function added to improve the animation feel
# If the character speed falls below a threshold when one walk animation
# loop is over, the animation will stop playing and the character will slide
# This function is called back from the AnimationPlayer, using a call func animation track
func _on_walk_anim_bounce_over():
	return
	if velocity.length() < ANIM_SLIDE_THRESHOLD:
		$AnimationPlayer.playback_speed = 0.0