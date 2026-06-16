extends Polygon2D

@export var periodsec = 3.0
@export var offsetsec = 0.0
@export var offsetdeg = 0.0
@export var ampdeg = 15.0
@export var ampx = 15.0
@export var ampy = 15.0
var startps
func _ready() -> void:
	startps = position

var cycle_frac = 0
func _process(delta: float) -> void:
	if periodsec == 0.0:
		return
	cycle_frac += fmod(delta / periodsec, 1.0)
	var offset_frac = offsetsec / periodsec
	var scl = sin(PI * 2 * (cycle_frac + offset_frac))
	rotation_degrees = offsetdeg + ampdeg * scl
	position = startps + Vector2(ampx, ampy) * scl
