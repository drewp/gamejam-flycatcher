# finds CutoutMouse and slides it left and right

extends Node2D


@export var START_POS = Vector2(890, 420)
@export var END_POS = Vector2(210, 420)
@export var DURATION = 2.0
@export var WAIT_TIME = 1.0

var current_time = 0.0
var moving_forward = true
var is_waiting = false
var wait_timer = 0.0


func _process(delta):
	if is_waiting:
		wait_timer += delta
		if wait_timer >= WAIT_TIME:
			is_waiting = false
			wait_timer = 0.0
		return

	current_time += delta
	var t = clamp(current_time / DURATION, 0.0, 1.0)
	var blend = smoothstep(0.0, 1.0, t)

	var mouse_body = get_node("%CutoutMouse")	
	if moving_forward:
		mouse_body.position = START_POS.lerp(END_POS, blend)
	else:
		mouse_body.position = END_POS.lerp(START_POS, blend)

	if t >= 1.0:
		current_time = 0.0
		moving_forward = !moving_forward
		is_waiting = true
