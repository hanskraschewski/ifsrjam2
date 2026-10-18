extends TileMapLayer


@export var depth: int = 100
@export var width: int = 6

@export var prob_row: float = 0.3
@export var prob_block: float = 0.3

@export var prob_gold: float = 0.1
@export var prob_explosion: float = 0.05

@export var prob_block_enemy: float = 0.05
@export var block_enemy_depth: float = 50.0

@export var prob_spike_enemy: float = 0.03
@export var spike_enemy_depth: float = 50.0

@export var prob_mw_enemy: float = 0.1
@export var mw_enemy_depth: float = 50.0


var maulwurf: PackedScene = preload("res://src/enemies/maulwurf_enemy.tscn")


func _ready() -> void:
	generate_level()


func generate_level() -> void:
	self.clear()
	
	for y: int in depth:
		if randf() > prob_row:
			continue
		for x: int in width:
			if randf() < prob_block:
				if randf() < Globals.tnt_probability:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 3)
					continue
				elif randf() < prob_gold:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 2)
					continue
				elif y > block_enemy_depth and randf() < prob_block_enemy:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 4)
					continue
				elif y > 100 and randf() < prob_spike_enemy:
					@warning_ignore("integer_division")
					self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 5)
					continue
				elif y > mw_enemy_depth and randf() < prob_mw_enemy:
					var maulwurf_scene: Node2D = maulwurf.instantiate()
					self.add_child(maulwurf_scene)
					@warning_ignore("integer_division")
					maulwurf_scene.global_position = self.map_to_local(Vector2i(x - width / 2, y))
					continue
				
				@warning_ignore("integer_division")
				self.set_cell(Vector2i(x - width / 2, y), 0, Vector2i(0, 0), 1)
