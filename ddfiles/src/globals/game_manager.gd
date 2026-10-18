extends Node


var level: PackedScene = preload("res://src/level/test_level.tscn")


func restart() -> void:
	self.get_child(0).call_deferred("queue_free")
	self.add_child(level.instantiate())
	
	Globals.player.global_position = Vector2(0.0, -64.0)
