class_name ExplosiveBlock
extends Block


@export var knockback_strenght: float = 3200.0


var is_exploded: bool = false


@onready var explosion_area: Area2D = %ExplosionArea
@onready var smoke_particles: GPUParticles2D = %SmokeParticles
@onready var explosion_particles: GPUParticles2D = %ExplosionParticles
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var explosion_audio_stream: AudioStreamPlayer2D = %ExplosionAudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func break_block() -> void:
	if is_exploded: return
	is_exploded = true
	for body: PhysicsBody2D in explosion_area.get_overlapping_bodies():
		if body is Block: body.break_block()
	for area in explosion_area.get_overlapping_areas():
		if area.get_parent() is Maulwurf: area.get_parent().die()
		#elif body is CharacterBody2D:
			#body.velocity = (body.global_position - self.global_position).normalized() * knockback_strenght
			#print((self.global_position - body.global_position).normalized() * knockback_strenght)
	
	explosion_audio_stream.play()
	explosion_audio_stream.reparent(self.get_parent())
	explosion_audio_stream.destroy()
	
	animated_sprite.show()
	animated_sprite.play("default")
	animated_sprite.reparent(self.get_parent())
	smoke_particles.restart()
	smoke_particles.reparent(self.get_parent())
	explosion_particles.restart()
	explosion_particles.reparent(self.get_parent())
	get_tree().get_first_node_in_group("Camera").add_shake()
	break_particles.restart()
	break_particles.reparent(self.get_parent())
	self.queue_free()
