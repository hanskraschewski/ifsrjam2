class_name Block
extends StaticBody2D


func break_block() -> void:
	self.queue_free()
