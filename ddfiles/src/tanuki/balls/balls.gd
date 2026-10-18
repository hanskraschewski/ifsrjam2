extends Node2D

var balls_size = 1
var max_gold_amount = 100
@export var nugget_scene: PackedScene

var current_gold: int = 0

@onready
var handle_position: Vector2 = %Handle.position

# Called when the node enters the scene tree fior the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("arrow_up"):
		add_gold(20)
	if event.is_action_pressed("arrow_down"):
		remove_gold(10)
	if event.is_action_pressed("arrow_right"):
		jiggle()
		
func add_gold(amount: int) -> void:
	for i in amount:
		#TODO: play sound
		var new_nugget = nugget_scene.instantiate()
		new_nugget.position = %NuggetSpawn.global_position + Vector2(randi_range(-25, 25), randi_range(025, 25))
		$NuggetContainer.add_child(new_nugget)
		current_gold += 1
		await get_tree().create_timer(0.1).timeout

func remove_gold(amount: int) -> bool:
	var net_worth: int = 0
	for nugget in $NuggetContainer.get_children():
		if nugget.position.y > 2000:
			nugget.queue_free()
		else:
			net_worth += 1
	if net_worth < amount: 
		return false
	for i in amount:
		#TODO: play sound
		$NuggetContainer.get_child(i).queue_free()
		await get_tree().create_timer(0.1).timeout
	current_gold = net_worth - amount
	return true


func jiggle() -> void:
	#TODO: play coin jiggle sound
	var tween = get_tree().create_tween()
	tween.tween_property(%Handle, "position", %Handle.position + Vector2(0, -50), 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_property(%Handle, "position", handle_position , 0.1).set_ease(Tween.EASE_OUT)
