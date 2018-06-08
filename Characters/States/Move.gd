extends 'res://Characters/States/_State.gd'


enum DIRECTIONS {UP,DOWN,LEFT,RIGHT}
var WALK_ANIMATIONS = {UP:'Walk_Up',DOWN:'Walk_Down',
						LEFT:'Walk_Left',RIGHT:'Walk_Right'}

export(int,1,40) var MAX_WALK_SPEED = 35

export(float) var WALK_MASS = 20.0
export(float) var RUN_MASS = 15.0





func enter():
	_AnimationPlayer.play("Walk")
	
	
func update(delta):
	var exit_state = move_and_collide(delta)
	var status = {"Speed":self.speed,"Velocity":self.velocity}
	emit_signal("status_changed",status)
	if exit_state:
		return exit_state
	
func exit():
	self.speed = 0
	self.mass = 0
	self.velocity = Vector2()
	_AnimationPlayer.stop()
	
func debug_move(delta,direction):
	if _Enity.move_direction != Vector2():
		if speed < MAX_WALK_SPEED:
			speed = clamp(speed + (ACCELRATION * delta),15,MAX_WALK_SPEED)
		else:
			speed = clamp(speed +(ACCELRATION * delta),MAX_WALK_SPEED,MAX_SPEED)
	else:
		speed -= DECCELERATION * delta
		direction -= direction * delta
		
	velocity = speed * direction 
	_Enity.move_and_slide(velocity )
	
func move(delta,direction):
	if _Enity.move_direction != Vector2():
		if self.speed < MAX_WALK_SPEED:
			self.speed = clamp(self.speed + (ACCELRATION * delta),15,MAX_WALK_SPEED)
			self.mass  = clamp(self.mass + (10 * delta),15,WALK_MASS)
		else:
			self.speed = clamp(self.speed +(ACCELRATION * delta),MAX_WALK_SPEED,MAX_SPEED)
			self.mass =  clamp(self.mass + (10 * delta),15,RUN_MASS)
	else:
		self.speed -= DECCELERATION * delta
		self.mass -= 10 * delta
		direction -= direction * delta
	
	
	var steered_velocity = (direction * self.speed) - velocity
	
	self.velocity += (steered_velocity / self.mass) * STRENGTH
	_Enity.move_and_slide(self.velocity)
	
	
	
func move_and_collide(delta): 
	move(delta,_Enity.look_direction)
	var slide_count = _Enity.get_slide_count()
	var collision =  _Enity.get_slide_collision(slide_count - 1) if slide_count else null
	if collision:
			var collider = collision.collider
			if collider.is_in_group('env') and speed >= MAX_WALK_SPEED:
				return BUMP
	
	if _Enity.move_direction == Vector2() and speed <= 5:
		return PREVIOUS_STATE
