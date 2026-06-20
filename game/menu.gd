extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_node("Button4/AudioStreamPlayer2D").play()
	await get_tree().create_timer(.30).timeout
	get_tree().change_scene_to_file("res://scene/level.tscn")


func _on_button_2_pressed() -> void:
	get_node("Button4/AudioStreamPlayer2D").play()
	await get_tree().create_timer(.30).timeout
	get_tree().change_scene_to_file("res://scene/Credits.tscn")


func _on_button_4_pressed() -> void:
	get_node("Button4/AudioStreamPlayer2D").play()


func _on_button_3_pressed() -> void:
	get_node("Button4/AudioStreamPlayer2D").play()
	await get_tree().create_timer(.30).timeout
	get_tree().change_scene_to_file("res://scene/Quit.Troll.tscn")
