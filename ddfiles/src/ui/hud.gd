extends CanvasLayer


@onready var death_screen: TextureRect = %DeathScreen


func show_death_screen() -> void:
	death_screen.modulate = Color.TRANSPARENT
	death_screen.show()
	
	var tween: Tween = self.create_tween()
	tween.tween_property(death_screen, "modulate", Color.WHITE, 0.5)
