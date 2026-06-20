extends Node2D


var enter_phase_time = 0.0
var health = 5.

func set_phase(new_phase: String):
	set_meta("phase", new_phase)
	enter_phase_time = Time.get_unix_time_from_system()

func _process(_delta: float) -> void:
	var now = Time.get_unix_time_from_system()
	var phase = get_meta("phase")

	var area: Area2D = get_node("area")
	get_node("debug").text = 'H=' + str(health) + ' phase=' + phase + ' cl=' + str(area.collision_layer)
	
	var touching_mouse = false
	for ovl in area.get_overlapping_bodies():
		if ovl.name == "mouse-char":
			touching_mouse = true

	if phase == 'ready':
		if touching_mouse:
			set_phase("notice")
		set_mad_legs(0.0)
		set_strike_flash(0.0)
		area.collision_layer = 0

	elif phase == 'notice':
		if now > enter_phase_time + 0.5:
			if touching_mouse:
				set_phase("mad")
			else:
				set_phase("ready")

	elif phase == 'mad':
		set_mad_legs(1.0)
		if now > enter_phase_time + 2.0:
			set_phase("strike")

	elif phase == 'strike':
		set_mad_legs(1.0)
		set_strike_flash(randf())
		
		if touching_mouse:
			pass

		area.collision_layer = 2
		if now > enter_phase_time + 0.3:
			set_phase("ready")

	else:
		print("bad phase: ", phase)
		assert(false)

func hurt(hp):
	health -= hp
	
func set_mad_legs(frac):
	var body = get_node('Wasp3Body')
	body.get_node("wasp3legs").ampdeg = frac * 15
	body.get_node("wasp3legs").periodsec = frac * 0.3
	
func set_strike_flash(frac):
	var body = get_node('Wasp3Body')
	body.color = Color(1.0, 1.0 - frac, 1.0 - frac)
