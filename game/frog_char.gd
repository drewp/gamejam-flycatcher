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

		# if true:
		if randf() < .01:
			maybe_jump()
		elif randf() < .01:
			maybe_attack()

	# if attacking:
	# 	extend_tongue(1.0)
	always_face_wasp()

	move_and_slide()
	# queue_redraw()

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
	
	var wasp = get_node("/root/Bg/CutoutWasp/%wasp-char")

	var grow_time = .4
	var grow_steps = 3.
	var lick_time = .8
	var lick_steps = 8.
	var damage = 1.

	for i in range(grow_steps):
		var frac = clamp(i / grow_steps, 0.0, 1.0)
		extend_tongue(frac)
		await get_tree().create_timer(grow_time / grow_steps, true, true).timeout

	for i in range(lick_steps):
		extend_tongue(1.0)
		wasp.hurt(damage / lick_steps)
		await get_tree().create_timer(lick_time / lick_steps, true, true).timeout
	
	extend_tongue(0.0)
	attacking = false

# func _draw() -> void:
# 	draw_circle(to_local(global_position), 100.0, Color.RED)
# 	var wasp = get_node("/root/Bg/CutoutWasp/%wasp-char/screen_pos")
# 	draw_circle(to_local(wasp.global_position), 100.0, Color.YELLOW)

func always_face_wasp():
	var wasp = get_node("/root/Bg/CutoutWasp/%wasp-char/screen_pos")
	var wasp_global = to_local(wasp.global_position)
	var self_global = (position)
	if wasp_global.x < self_global.x:
		scale.x = 1.0
	else:
		scale.x = -1

func extend_tongue(frac):
	var s: Line2D = get_node("body/head/tongue")
	assert(s.points.size() == 2)

	var e = get_node("/root/Bg/CutoutWasp/%wasp-char/screen_pos/Wasp3Body/wasp2head")
	if not e:
		return
		
	var s_vp = s.get_global_transform_with_canvas() * s.position
	var e_vp = e.get_global_transform_with_canvas() * e.position
	
	e_vp += Vector2(50, -15)
	var wasp = get_node("/root/Bg/CutoutWasp/%wasp-char/screen_pos")
	if wasp.scale.x < 0:
		e_vp += Vector2(-100, -15)


	var s_out = (s.get_global_transform_with_canvas()).affine_inverse() * (e_vp) * frac
	s.points[1] = s_out
	#print(' global=', s.global_position, ' vp=', s_vp, '    ',
		  #' global=', e.global_position, ' vp=', e_vp, ' s_out=', s_out,
		  #' xf=')
