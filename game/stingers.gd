extends Node2D

var stinger_scene = preload("res://scene/stinger.tscn")

func _ready() -> void:
	create_children(stinger_scene.instantiate().get_node("body"))


func create_children(obj: Node2D) -> void:
	for i in range(0):
		var c = obj.duplicate()
		var pos_parent = Node2D.new()
		pos_parent.add_child(c)
		pos_parent.position = random_start()
		add_child(pos_parent)
func random_start():
	return Vector2(lerp(100, 900, randf()),
				   lerp(-400, 0, randf()))
func _process(delta: float) -> void:
	var now = Time.get_unix_time_from_system()
	var column = 0
	for s in get_children():
		s.position.y += 200*delta 
		if s.position.y>650:
			s.position = random_start()
		column += 1
