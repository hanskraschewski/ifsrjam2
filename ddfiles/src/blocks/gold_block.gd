class_name GoldBlock
extends Block


var blink_time: float = 3.0
var time: float = 0.0


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _process(delta: float) -> void:
	time += delta
	if time > blink_time:
		time = 0.0
		animated_sprite_2d.play("blink")
