extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var wasp_hit_time = 0.0
var wasp_leave_time = 0.0
var touching_wasp = false

func _physics_process(delta: float) -> void:
	char_movement(delta)
	touches()

func char_movement(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x *= (.9)
		if abs(velocity.x) < 0.001:
			velocity.x = 0
			

	move_and_slide()

func touches():
	var body = get_parent().get_node("/root/Bg/CutoutWasp")
	body.set_meta('phase', 'ready')
	var now = Time.get_unix_time_from_system()
	
	if wasp_hit_time > 0.0 and now > wasp_hit_time + 0.0:
		body.set_meta('phase', 'mad')

	if wasp_hit_time > 0.0 and now > wasp_hit_time + 1.2:
		var area: Area2D =get_node("/root/Bg/CutoutWasp/anim/wasp_area")
		area.set_collision_layer_value(2, true)
		if touching_wasp:
			deadly_item_touching_mouse()

	if wasp_hit_time > 0.0 and now > wasp_hit_time + 1.2:
		wasp_hit_time = 0.0


func deadly_item_touching_mouse():
	get_tree().reload_current_scene()


func _on_mouse_area_area_entered(area: Area2D) -> void:
	var now = Time.get_unix_time_from_system()
	if area.name == "wasp_area":
		wasp_hit_time = now
		wasp_leave_time = 0.0
		touching_wasp=true
	if area.collision_layer == 2:
		deadly_item_touching_mouse()

func _on_mouse_area_area_exited(area: Area2D) -> void:
	var now = Time.get_unix_time_from_system()
	if area.name=="wasp_area":
		touching_wasp = false
	if area.name == "robot":
		deadly_item_touching_mouse()
