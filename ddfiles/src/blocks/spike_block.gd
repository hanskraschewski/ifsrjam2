class_name SpikeBlock
extends Block


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func break_block() -> void:
	get_tree().get_first_node_in_group("Camera").add_shake()
	$AnimatedSprite2D.play("death")
	$BloodParticles.restart()
	$BloodParticles.reparent(self.get_parent())
	%GoldParticles.restart()
	%GoldParticles.reparent(self.get_parent())
	self.queue_free()

	
func _on_idle_timer_timeout() -> void:
	$AnimatedSprite2D.play("idle")
	$IdleTimer.wait_time = randf_range(1.0, 10.0)
	$IdleTimer.start()
