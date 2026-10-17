extends Area2D

@export var particles : CPUParticles2D
var clicks : int
var time : int
var rng = RandomNumberGenerator.new()
var hovered : bool

func _process(delta: float) -> void:
	if 3 <= clicks:
		if hovered && Time.get_ticks_msec() - time > 300:
			print(Time.get_ticks_msec() - time)
			var x = rng.randf_range(-400.0, 400.0)
			var y = rng.randf_range(-400.0, 400.0)

			position += Vector2(x, y)
			
			time = 0
			
			hovered = false

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		clicks += 1

		if event.button_index == MOUSE_BUTTON_LEFT:
			print("penis")
			particles.emitting = true
			
			if(clicks == 3):
				hovered = true
				time = Time.get_ticks_msec()


func _on_mouse_entered() -> void:
	print("enter")
	if clicks >= 3:
		hovered = true
		time = Time.get_ticks_msec()
		


func _on_mouse_exited() -> void:
	print("exit")
	hovered = false
	time = 0
