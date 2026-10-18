extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#const LANES: int = 6


@export var limit: float = 144.0
@export var explosion_impact_on_player: float = 600.0

var dead: bool = true

var current_lane: int = 0
var switching_lane: bool = false

var prev_vel_x: float
var vel_alpha: float = 0.3

# stunts
var input_buffer = []


@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D


func _ready() -> void:
	Globals.player = self

func _physics_process(delta: float) -> void:
	if dead: return
	# Add the gravity.
	if not is_on_floor():
		animated_sprite.play("fall")
		velocity += get_gravity() * delta
	
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED * vel_alpha + (1.0 - vel_alpha) * prev_vel_x
	
	prev_vel_x = velocity.x
	#velocity.x = 0.0
	#if (self.global_position.x as int - 16) % 32 != 0 and not switching_lane:
		#self.global_position.x = current_lane * 32 + 16
	
	self.global_position.x = clamp(self.global_position.x, -limit, limit)
	
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("move_left"):
		#@warning_ignore("integer_division")
		#if current_lane >= -(LANES - LANES / 2) + 1:
			#move(-1)
	#if event.is_action_pressed("move_right"):
		#@warning_ignore("integer_division")
		#if current_lane < (LANES - LANES / 2) - 1:
			#move(1)
	if event.is_action_pressed("arrow_left"):
		input_buffer.append(0)
	if event.is_action_pressed("arrow_up"):
		input_buffer.append(1)
	if event.is_action_pressed("arrow_right"):
		input_buffer.append(2)
	if event.is_action_pressed("arrow_down"):
		input_buffer.append(3)


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
	if dead: return
	if body is ExplosiveBlock:
		animated_sprite.play("impact")
		body.break_block()
		velocity = explosion_impact_on_player * (global_position - body.global_position).normalized()
		return
	if body is SkullBlock:
		velocity.y = JUMP_VELOCITY
		return
	if body is SpikeBlock:
		#:TODO: damage player
		velocity.y = JUMP_VELOCITY
		return
	if body is Block:
		animated_sprite.play("impact")
		body.break_block()
		velocity.y = JUMP_VELOCITY



func _on_headbutt_area_body_entered(body: Node2D) -> void:
	if dead: return
	if body is ExplosiveBlock:
		animated_sprite.play("impact")
		velocity.y = 0
		body.break_block()
		velocity = explosion_impact_on_player * (global_position - body.global_position).normalized()
		return
	if body is SkullBlock or body is SpikeBlock:
		animated_sprite.play("impact")
		velocity.y = 0
		body.break_block()
		velocity.y = -JUMP_VELOCITY


func die() -> void:
	dead = true
	animated_sprite.play("death")
	await animated_sprite.animation_finished
	get_tree().get_first_node_in_group("HUD").show_death_screen()
