extends CharacterBody2D

var direction = 0
var attacking = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x *= (.9)
		if abs(velocity.x) < 0.001:
			velocity.x = 0

		if randf() < .01:
			maybe_jump()
		elif randf() < .01:
			maybe_attack()

	if attacking:
		extend_tongue(1.0)

	move_and_slide()

func maybe_jump():
	if attacking:
		return
	var mid_y = get_viewport().get_visible_rect().size.x
	direction = -1. if global_position.x > mid_y / 2 else 1.
	velocity.x = direction * 200.0
	velocity.y = -600.0

func maybe_attack():
	if not is_on_floor():
		return

	if attacking:
		return

	attacking = true
	velocity.x = 0
	extend_tongue(1.0)
	# await get_tree().create_timer(2.0).timeout
	# extend_tongue(0.0)
	attacking = false

func extend_tongue(frac):
	var s = get_node("/root/Bg/CutoutWasp/%wasp-char/Wasp3Body/wasp2head")
	var e: Line2D = get_node("body/head/tongue")
	assert(e.points.size() == 2)
	
	var m1 = get_viewport().get_screen_transform()

	var s_vp = m1 * s.get_global_transform_with_canvas() * s.position
	var e_vp = m1 * e.get_global_transform_with_canvas() * e.position
	
	var s_out = (m1 * s.get_global_transform_with_canvas()).inverse() * (e_vp - s_vp)
	e.points[1] = s_out
	print('tlocal=', e.position, ' global=', e.global_position, ' vp=', s_vp, '    ',
	'wasplocal=', s.position, ' global=', s.global_position, ' vp=', e_vp)
