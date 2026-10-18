extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if randf() > 0.5:
		$AnimatedSprite2D.play("blink")
	else:
		$AnimatedSprite2D.play("eye_roll")
