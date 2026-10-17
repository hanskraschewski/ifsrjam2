extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BORDER: int = 96
const LANES: int = 6


var current_lane: int = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = 0.0

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		@warning_ignore("integer_division")
		if current_lane >= -(LANES - LANES / 2) + 1:
			move(-1)
	if event.is_action_pressed("move_right"):
		@warning_ignore("integer_division")
		if current_lane < (LANES - LANES / 2) - 1:
			move(1)


func move(dir: int) -> void:
	if self.test_move(self.global_transform, Vector2(dir * 10.0, 0.0)):
		return
	var tween: Tween = self.create_tween()
	tween.tween_property(self, "global_position:x", global_position.x + dir * 32, 0.2)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	current_lane += dir


func _on_block_detection_area_body_entered(body: Node2D) -> void:
	if body is Block:
		velocity.y = JUMP_VELOCITY
		body.break_block()
