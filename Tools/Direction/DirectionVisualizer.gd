extends Position2D

export(NodePath) onready var character = $".."

func _ready():
	character.connect("direction_changed", self, '_on_target_direction_changed')
	set_process(false)

func _on_target_direction_changed(direction):
	rotation = direction.angle()

