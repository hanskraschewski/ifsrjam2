extends CanvasLayer

@export
var label: Label

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score()


func set_score(amount: int) -> void:
	score = amount
	update_score()
	
	
func update_score() -> void:
	label.text = "SCORE: " + str(score)


func increase_score(amount: int) -> void:
	score += amount
	update_score()

	
