class_name SpikeBlock
extends Block


@onready var blood_particles: CPUParticles2D = %BloodParticles
@onready var gold_particles: CPUParticles2D = %GoldParticles
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D



func break_block() -> void:
	get_tree().get_first_node_in_group("Camera").add_shake()
	animated_sprite_2d.play("death")
	animated_sprite_2d.reparent(self.get_parent())
	blood_particles.restart()
	blood_particles.reparent(self.get_parent())
	gold_particles.restart()
	gold_particles.reparent(self.get_parent())
	self.queue_free()
