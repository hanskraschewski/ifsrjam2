extends Node


var level: PackedScene = preload("res://src/level/test_level.tscn")


func restart() -> void:
	self.get_child(0).queue_free()
	self.add_child(level.instantiate())
