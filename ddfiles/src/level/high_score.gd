extends CanvasLayer

@export
var label: Label

@onready
var scores: Array = [
	"Mysterious Juice", 23000, 
	"Zerschnetzloar", 15000, 
	"Zaubergurke", 23000, 
	"Goendyr", 15000]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass

func write_scores() -> void:
	# absteigend nach greosse sortieren
	var bs: String
	var bi: int
	for i in range(1, scores.size() - 1, 2):
		for j in range(1, scores.size() - 1, 2):
			if j + 2 < scores. size():
				if scores[j] < scores[j + 2]:
					bs = scores[j - 1]
					bi = scores[j]
					scores[j] = scores[j + 2]
					scores[j - 1] = scores[j + 1]
					scores[j + 2] = bi
					scores[j + 1] = bs
	
	for idx in range(0, scores.size() - 1, 2):
		label.text += "\n" + scores[idx] + " " + str(scores[idx + 1])
	
	


func add_score(player_name: String, score: int) -> void:
	scores.append_array([player_name, score])
	
