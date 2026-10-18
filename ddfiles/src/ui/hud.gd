extends CanvasLayer


@onready var death_screen: TextureRect = %DeathScreen
@onready var shop: TextureRect = %Shop

@onready var balls_up_button: Button = %BallsUPButton
@onready var tnt_up_button: Button = %TntUpButton
@onready var return_button: Button = %ReturnButton

@onready var balls_up_label: Label = %BallsUPLabel
@onready var tnt_up_label: Label = %TntUpLabel



func show_death_screen() -> void:
	death_screen.modulate = Color.TRANSPARENT
	death_screen.show()
	
	var tween: Tween = self.create_tween()
	tween.tween_property(death_screen, "modulate", Color.WHITE, 0.5)


func show_shop() -> void:
	shop.show()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		if shop.visible:
			shop.hide()
		
		if death_screen.visible:
			death_screen.hide()
			get_tree().get_first_node_in_group("GM").restart()


func _on_return_button_pressed() -> void:
	shop.hide()


func _on_tnt_up_button_pressed() -> void:
	Globals.tnt_probability *= 2.0
	get_tree().get_first_node_in_group("BlockMap").generate_level()
	var balls = get_tree().get_first_node_in_group("Balls")
	if balls:
		if balls.remove_gold(5):
			Globals.tnt_probability *= 2.0
	print("TODO")


func _on_balls_up_button_pressed() -> void:
	print("TODO")
