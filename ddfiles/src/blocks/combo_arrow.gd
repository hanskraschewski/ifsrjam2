class_name ComboArrow
extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Arrow.visible = true
	$BrokenArrow.visible = false
	$DoneArrow.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func init(dir: int) -> void:
	$".".visible = true
	rotation = deg_to_rad(180 + 90 * dir)
	
func correct() -> void:
	$Arrow.visible = false
	$BrokenArrow.visible = false
	$DoneArrow.visible = true
	$".".modulate = Color("#6bc96c")
	
func wrong() -> void:
	$Arrow.visible = false
	$BrokenArrow.visible = true
	$DoneArrow.visible = false
	$".".modulate = Color("#c42430")
