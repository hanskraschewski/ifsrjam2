extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const LANES: int = 6


var current_lane: int = 0
var switching_lane: bool = false

# stunts
var input_buffer: Array[int] = [-1, -1, -1, -1]
var input_number: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity += get_gravity() * delta
	
	velocity.x = 0.0
	if (self.global_position.x as int - 16) % 32 != 0 and not switching_lane:
		self.global_position.x = current_lane * 32 + 16
	
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
	if event.is_action_pressed("arrow_left"):
		input_buffer[input_number] = 0
		input_number += 1
	if event.is_action_pressed("arrow_up"):
		input_buffer[input_number] = 1
		input_number += 1
	if event.is_action_pressed("arrow_right"):
		input_buffer[input_number] = 2
		input_number += 1
	if event.is_action_pressed("arrow_down"):
		input_buffer[input_number] = 3
		input_number += 1


var wish_pos_x: float
var tween: Tween
func move(dir: int) -> void:
	if self.test_move(self.global_transform, Vector2(dir * 10.0, velocity.y * 0.1)):
		return
	if switching_lane: 
		self.global_position.x = wish_pos_x
	switching_lane = true
	
	if tween:
		tween.kill()
	
	tween = self.create_tween()
	tween.set_parallel(false)
	wish_pos_x = global_position.x + dir * 32
	tween.tween_property(self, "global_position:x", wish_pos_x, 0.2)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): switching_lane = false)
	
	current_lane += dir


func _on_block_detection_area_body_entered(body: Node2D) -> void:
	if body is Block and body.check_sequence(input_buffer):
		$AnimatedSprite2D.play("impact")
		velocity.y = 0
		body.break_block(input_buffer)
	else:
		velocity.y = JUMP_VELOCITY
	input_buffer = [-1, -1, -1, -1]
	input_number = 0
