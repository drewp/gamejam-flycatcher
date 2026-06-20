extends Node2D


var enter_phase_time = 0.0

func _process(_delta: float) -> void:
	var now = Time.get_unix_time_from_system()
	var phase = get_meta("phase") 

	var area: Area2D = get_node("area")

	for ovl in area.get_overlapping_bodies():
		if ovl.name == "mouse-char":
			if phase == 'ready':
				set_meta("phase", "notice")
				enter_phase_time = now

	if phase == 'mad' and now > enter_phase_time + 0.5:
		set_meta("phase", "ready")

	var body = get_node('Wasp3Body')
	if phase == 'ready':
		body.get_node("wasp3legs").ampdeg = 0
		body.get_node("wasp3legs").periodsec = 0
	elif phase == 'mad':
		body.get_node("wasp3legs").ampdeg = 15
		body.get_node("wasp3legs").periodsec = 0.3
	else:
		assert(not ("unknown phase "+phase))
	# var body = get_parent()
	# var now = Time.get_unix_time_from_system()
	
	# if wasp_hit_time > 0.0 and now > wasp_hit_time + 0.5:
