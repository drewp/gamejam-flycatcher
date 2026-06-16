extends Polygon2D

@export var periodsec = 3.0
@export var offsetsec = 0.0
@export var offsetdeg = 0.0
@export var ampdeg = 15.0
@export var ampx = 15.0
@export var ampy = 15.0
var startps
func _ready() -> void:
	startps=position


func _process(delta: float) -> void:
	if periodsec ==0.0:
		return
	var now = Time.get_unix_time_from_system() 
	var ang = (PI*2)*(now+offsetsec)/periodsec
	rotation_degrees = offsetdeg + ampdeg * sin(ang)
	position=startps+Vector2(ampx,ampy)*sin(ang)
