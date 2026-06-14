extends Polygon2D

@export var periodsec = 3
@export var offsetdeg = 0
@export var ampdeg = 15

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	rotation_degrees = offsetdeg + ampdeg * sin(Time.get_unix_time_from_system()*(PI/2)/periodsec)
