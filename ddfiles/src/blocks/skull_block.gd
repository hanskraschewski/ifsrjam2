class_name SkullBlock
extends Block


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var gold_particles: CPUParticles2D = %GoldParticles



func break_block() -> void:
	var balls = get_tree().get_first_node_in_group("Balls")
	balls.add_gold(50)
	get_tree().get_first_node_in_group("Camera").add_shake()
	animated_sprite_2d.play("death")
	animated_sprite_2d.reparent(self.get_parent())
	break_particles.restart()
	break_particles.reparent(self.get_parent())
	gold_particles.restart()
	gold_particles.reparent(self.get_parent())
	self.queue_free()
