extends TileMapLayer


@export var depth: int = 100
@export var width: int = 6
@export var prob_row: float = 0.3
@export var prob_block: float = 0.3
@export var prob_gold: float = 0.1
@export var prob_explosion: float = 0.05
@export var prob_block_enemy: float = 0.05
@export var prob_spike_enemy: float = 0.03


func _ready() -> void:
	for y: int in depth:
		if randf() > prob_row:
			continue
		for x: int in width:
			if randf() < prob_block:
				if randf() < prob_explosion:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 3)
					continue
				if randf() < prob_gold:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 2)
				if y > 50 and randf() < prob_block_enemy:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 4)
				else:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 1)
