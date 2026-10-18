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
	player_dir = get_player_pos() - position
	if player_dir.length() < range:
		position = position + player_dir / player_dir.length() * move_speed * delta

func get_player_pos() -> Vector2:
	return Globals.player.position
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Block:
		if 1: #TODO: access blocks needed stunt sequence
			body.break_block()
			
			
	if body is CharacterBody2D:
		Globals.player.die()
