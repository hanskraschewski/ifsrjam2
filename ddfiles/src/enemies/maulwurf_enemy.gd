extends Node2D
class_name Maulwurf


@export var move_speed: float = 33
@warning_ignore("shadowed_global_identifier")
@export var range: float = 600.0


var player_dir: Vector2
var dead: bool = false


@onready var sprite: AnimatedSprite2D = %Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dead: return
	player_dir = Globals.player.global_position - self.global_position
	if player_dir.length() < range:
		self.global_position = self.global_position + player_dir / player_dir.length() * move_speed * delta
	
	if abs(player_dir.y) > abs(player_dir.x):
		sprite.play("default")
	elif player_dir.x <= 0.0:
		sprite.play("left")
	elif player_dir.x > 0.0:
		sprite.play("right")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if dead: return
	if body is Block:
		body.break_block()
	elif body is CharacterBody2D:
		Globals.player.die()


func die() -> void:
	dead = true
	sprite.play("die")
	await sprite.animation_finished
	self.queue_free()
