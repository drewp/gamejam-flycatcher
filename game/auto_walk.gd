extends Polygon2D

var scl = 1.
func _ready() -> void:
	scl = scale.x

var prev_pos = Vector2.ZERO
const top_speed = 100. # px/sec

var smoothed_speed = 0.0

func _physics_process(delta: float) -> void:
	var speed = analyze_motion(delta)
	smoothed_speed = lerp(smoothed_speed, speed, .9)

	print(speed, ' ', smoothed_speed)

	var ampdeg = 0
	var per = 0

	if smoothed_speed > .1:
		ampdeg = lerp(0, 70, smoothed_speed)
		per = lerp(.7, .4, smoothed_speed)

	set_foot(get_node('foot1'), ampdeg, per, per / 2.0)
	set_foot(get_node('foot2'), ampdeg, per, 0.0)
	set_foot(get_node('foot3'), ampdeg, per, 0.0 + per / 8.)
	set_foot(get_node('foot4'), ampdeg, per, per / 2.0 + per / 8.)

func analyze_motion(delta):
	var dx = (global_position.x - prev_pos.x) / delta # px/sec
	prev_pos = global_position
	if dx > 0:
		scale.x = - scl
	elif dx < 0:
		scale.x = scl
	var speed = clamp(abs(dx) / top_speed, 0., 1.)
	
	return speed

func set_foot(obj, ampdeg, periodsec, offsetsec):
	obj.ampdeg = ampdeg
	obj.offsetsec = offsetsec
	obj.periodsec = periodsec
