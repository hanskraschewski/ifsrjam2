extends CanvasLayer

@export
var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score()


func set_score(amount: int) -> void:
	Globals.score = amount
	update_score()
	
	
func update_score() -> void:
	label.text = "SCORE: " + str(Globals.score)


func increase_score(amount: int) -> void:
	Globals.score += amount
	update_score()

	
