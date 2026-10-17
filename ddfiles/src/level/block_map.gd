extends TileMapLayer


@export var depth: int = 100
@export var width: int = 6
@export var prob_row: float = 0.3
@export var prob_block: float = 0.3
@export var prob_gold: float = 0.1


func _ready() -> void:
	for y: int in depth:
		if randf() > prob_row:
			continue
		for x: int in width:
			if randf() < prob_block:
				if randf() < prob_gold:
					self.set_cell(Vector2i(x - 3, y), 0, Vector2i(0, 0), 2)
				else:
					self.set_cell(Vector2i(x - 3, y), 0, Vector2i(0, 0), 1)
