extends CanvasLayer

@export
var label: Label

@onready
var scores: Array = [
	"Mysterious Juice", 23000, 
	"Zerschnetzloar", 15000, 
	"Zaubergurke", 23000, 
	"Goender", 15000]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	for idx in range(0, scores.size() - 1, 2):
		print(idx)
		label.text += "\n" + scores[idx] + " " + str(scores[idx + 1])
	




func add_score(player_name: String, score: int) -> void:
	scores.append([player_name, score])
	label.text += "\n" + scores[-2] + " " + str(scores[-1])
	
