extends Position2D

func spawn(what):
	if what:
		self.add_child(load(what).instance())
		return get_children().front()
	