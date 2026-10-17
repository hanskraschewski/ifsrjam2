class_name Block
extends StaticBody2D


@export var texture: int = 0
@export var grass: bool = false
@export var depth_based: bool = true
@export var depth_0: int = 1
@export var depth_1: int = 15
@export var depth_2: int = 30

var combo_arrows: Array[Node2D]


@onready var base_sprite: Sprite2D = %BaseSprite
@onready var grass_sprite: Sprite2D = %GrassSprite

var input_sequence: Array[int] = []

func _ready() -> void:
	combo_arrows = [$ComboArrow, $ComboArrow2, $ComboArrow3, $ComboArrow4]
	for i in randi_range(0, 3):
		var dir: int = randi_range(0, 3)
		input_sequence.append(dir)
		combo_arrows[i].init(dir)
		
	if depth_based:
		if self.global_position.y < 32.0 * depth_0:
			grass = true
		if self.global_position.y < 32.0 * depth_1:
			texture = 0
		elif self.global_position.y < 32.0 * depth_2:
			texture = 1
		else:
			texture = 2
	
	match texture:
		0:
			base_sprite.texture.region = Rect2(2.0, 2.0, 32.0, 32.0)
		1:
			base_sprite.texture.region = Rect2(38.0, 2.0, 32.0, 32.0)
		2:
			base_sprite.texture.region = Rect2(74.0, 2.0, 32.0, 32.0)
	
	grass_sprite.visible = grass


func break_block(input_buffer):
	self.queue_free()
	
func check_sequence(input_buffer) -> bool:
	# trick break logic stuff
	var correct = true
	print(input_sequence)
	print(input_buffer)

	for i in input_sequence.size():
		if input_sequence[i] != input_buffer[i]:
			combo_arrows[i].wrong()
			correct = false
		else:
			combo_arrows[i].correct()
	print("correct")
	return correct
