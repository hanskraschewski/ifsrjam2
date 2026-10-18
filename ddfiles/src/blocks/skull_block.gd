class_name SkullBlock
extends Block


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var gold_particles: CPUParticles2D = %GoldParticles


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func break_block() -> void:
	get_tree().get_first_node_in_group("Camera").add_shake()
	animated_sprite_2d.play("death")
	animated_sprite_2d.reparent(self.get_parent())
	break_particles.restart()
	break_particles.reparent(self.get_parent())
	gold_particles.restart()
	gold_particles.reparent(self.get_parent())
	self.queue_free()
