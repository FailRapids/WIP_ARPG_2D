extends Position2D

var z_index_start = 0

func _ready():
	z_index_start = z_index


func _on_direction_changed(direction):
	rotation = direction.angle()
	match direction:
		Vector2(0, -1):
			z_index = z_index_start - 1
		_:
			z_index = z_index_start
