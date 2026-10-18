extends CanvasLayer


@onready var death_screen: TextureRect = %DeathScreen


func show_death_screen() -> void:
	death_screen.modulate = Color.TRANSPARENT
	death_screen.show()
	
	var tween: Tween = self.create_tween()
	tween.tween_property(death_screen, "modulate", Color.WHITE, 0.5)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		if death_screen.visible:
			death_screen.hide()
			get_tree().get_first_node_in_group("GM").restart()
