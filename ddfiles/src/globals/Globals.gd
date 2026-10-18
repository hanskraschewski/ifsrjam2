extends Node


var score: int = 0

var player: CharacterBody2D


# audio volume
var music_volume: float = 0.25
var sfx_volume: float = 0.25
func get_player_pos() -> Vector2:
	return player.position

var tnt_probability: float = 0.01
