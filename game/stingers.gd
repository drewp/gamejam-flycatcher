extends Node2D

var stinger_scene = preload("res://scene/stinger.tscn")

func _ready() -> void:
	create_children(stinger_scene.instantiate().get_node("body"))


func create_children(obj: Node2D) -> void:
	for i in range(8):
		var c = obj.duplicate()
		var pos_parent = Node2D.new()
		pos_parent.add_child(c)
		pos_parent.position = Vector2(300 + i * 100, 50)
		add_child(pos_parent)

func _process(_delta: float) -> void:
	var now = Time.get_unix_time_from_system()
	var column = 0
	for s in get_children():
		s.position.y = 50 + fmod(now * 90 + 300 * column, 500)
		column += 1
