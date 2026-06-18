extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var wasp_hit_time = 0.0
func _physics_process(delta: float) -> void:
	# Add the gravity.
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
	var Area=get_node("%CutoutWasp").get_node("Area") as Area2D
	var body=get_node("%CutoutWasp").get_node("%Wasp3Body")
	body.get_node("wasp3legs").ampdeg = 0
	body.get_node("wasp3legs").periodsec = 0
	var now = Time.get_unix_time_from_system()
	for i in Area.get_overlapping_bodies():
		if i.name == "wasparea":

			if wasp_hit_time == 0.0:
				wasp_hit_time = now
	else:
		if wasp_hit_time > 0.0 and now > wasp_hit_time + 2.0:
			wasp_hit_time = 0.0
	if wasp_hit_time > 0.0 and now > wasp_hit_time + 0.5:
		body.get_node("wasp3legs").ampdeg = 15
		body.get_node("wasp3legs").periodsec = 0.3
	
