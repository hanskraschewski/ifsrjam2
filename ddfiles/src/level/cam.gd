extends Camera2D
@export var random_strength: float = 30.0
# hoeher = schneller shake weg
@export var shake_decay: float = 5.0

var background = "res://src/level/level_background.tscn"
var bg_begin_y: float

var shake: float = 0.0
var shake_power: int = 2

func add_shake(amount: float = 0.8) -> void:
	shake = clamp(shake + amount, 0.0, 1.0)

func _process(delta: float) -> void:
	position.y = Globals.get_player_pos().y
	if shake > 0:
		shake = max(shake - shake_decay * delta, 0.0)
		calc_offset()
	else:
		# offset ist ein nativer cam component 
		offset.y = lerp(offset.y, 0.0, 10.0 * delta)

func calc_offset() -> void:
	var shake_amount = pow(shake, shake_power)
	offset.y = random_strength * shake_amount * randf_range(-1.0, 1.0)
