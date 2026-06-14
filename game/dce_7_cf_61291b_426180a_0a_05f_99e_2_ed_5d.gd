extends Sprite2D

var initial = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial = position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var now = Time.get_unix_time_from_system()
	position.x = initial + 70*sin(now/6.2*3)
	scale.x = 1.47 + .001 * sin(now/6.2*2)
	scale.y = scale.x
