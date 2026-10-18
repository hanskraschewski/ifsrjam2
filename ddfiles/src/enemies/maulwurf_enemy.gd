extends Node2D

@export
var move_speed: float = 33
@export
var range: float = 600
var player_dir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_dir = get_player_pos() - self.global_position
	if player_dir.length() < range:
		self.global_position = self.global_position + player_dir / player_dir.length() * move_speed * delta


func get_player_pos() -> Vector2:
	return Globals.player.global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Block:
		body.break_block()
	elif body is CharacterBody2D:
		Globals.player.die()
