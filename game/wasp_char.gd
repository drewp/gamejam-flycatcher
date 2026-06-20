extends Node2D

func _process(delta: float) -> void:
	var phase = get_parent().get_meta("phase")
	var body = get_node('%Wasp3Body')
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

func start_mad_phase():
	get_parent().set_meta("phase", "mad")
