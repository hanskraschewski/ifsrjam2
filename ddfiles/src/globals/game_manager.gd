extends Node


var level: PackedScene = preload("res://src/level/test_level.tscn")
var game_paused: bool = true


@onready var hud: CanvasLayer = %Hud


func _unhandled_key_input(event: InputEvent) -> void:
	if not game_paused:
		return
	if event.is_action_pressed("start_game"):
		game_paused = false
		Globals.player.dead = false


func restart() -> void:
	self.get_child(0).call_deferred("queue_free")
	self.add_child(level.instantiate())
	
	Globals.player.global_position = Vector2(0.0, -64.0)
	hud.show_shop()
