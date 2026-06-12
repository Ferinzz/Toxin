extends Node

func _process(_delta):
	var thing = Engine.get_singleton("muhsingle")
	print(thing.get_window())
	thing.set_window(Vector2(46,92))
