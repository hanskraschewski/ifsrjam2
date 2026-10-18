extends Camera2D
@export var random_strength: float = 30.0
# hoeher = schneller shake weg
@export var shake_decay: float = 5.0


var bg_begin_y: float = 0
var bg_begin: int = 0
var bg: Array[Node2D]

var shake: float = 0.0
var shake_power: int = 2

func _ready() -> void:
	for i in range(3):
		var scene = preload("res://src/level/level_background.tscn").instantiate()
		$"..".add_child.call_deferred(scene)
		bg.append(scene)
		bg[i].position.y += 360 * i
		#bg_end_y = 360 * i
	pass


func _process(delta: float) -> void:
	position.y = Globals.get_player_pos().y	
	
	if shake > 0:
		shake = max(shake - shake_decay * delta, 0.0)
		calc_offset()
	else:
		# offset ist ein nativer cam component 
		offset.y = lerp(offset.y, 0.0, 10.0 * delta)
	
	#if abs(position.y - bg_begin_y) > 1800:
		#for i in range(3):
			#bg[i].position.y = (round(position.y) - (roundi(position.y) % 720) + 720 * (i - 1))
		#print(bg_begin_y)
	# shift background down
	if position.y - bg_begin_y > 720:
		#print(abs(position.y - bg[bg_begin].position.y))
		bg[bg_begin].position.y = bg_begin_y + 720
		bg_begin_y += 360
		bg_begin = (bg_begin + 1) % 3
	# shift up
	elif position.y - bg_begin_y < 360 && bg_begin_y > 0:
		bg_begin_y -= 360
		bg[(bg_begin + 2) % 3].position.y = bg_begin_y
		bg_begin = (bg_begin - 1) % 3


func add_shake(amount: float = 0.8) -> void:
	shake = clamp(shake + amount, 0.0, 1.0)


func calc_offset() -> void:
	var shake_amount = pow(shake, shake_power)
	offset.y = random_strength * shake_amount * randf_range(-1.0, 1.0)
