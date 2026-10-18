extends CanvasLayer

var showing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		if !showing:
			$".".show()
			get_tree().paused = true
		else:
			$".".hide()
			get_tree().paused = false

func _on_music_slider_value_changed(value: float) -> void:
	Globals.music_volume = value  * 0.5
	var bus_index= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(Globals.music_volume)
	)


func _on_sfx_slider_value_changed(value: float) -> void:
	Globals.sfx_volume = value  * 0.5
	var bus_index= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(Globals.sfx_volume)
	)


func _on_return_button_pressed() -> void:
	$".".hide()
	get_tree().paused = false
