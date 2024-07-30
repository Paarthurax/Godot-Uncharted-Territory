extends Node2D

var EnglishText = [
	"Go right here",
	"Go left here",
	"Go back"
]

var RomanianText = [ "Du-te la stânga aici", "Du-te chiar aici", "Întoarce-te"]

var random_index

# Called when the node enters the scene tree for the first time.
func _ready():
	if(EnglishText.size() == RomanianText.size()):
		random_index = randi() % EnglishText.size()
		var chosenText
		if(Global.romanian):
			chosenText = EnglishText[random_index]
			$QuestionLabel.text = "The magical text says..."
		else:
			chosenText = RomanianText[random_index]
		$Sign.self_modulate = Color(0.3, 0.3, 0.3, 1.0)
		$Romanian.text = chosenText


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_right_pressed():
	Global.encounters.append("2")
	if(random_index == 0):
		get_tree().change_scene_to_file("res://scenes/game/endings/McDonald/McDonald's.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")

func _on_left_pressed():
	Global.encounters.append("2")
	if(random_index == 1):
		get_tree().change_scene_to_file("res://scenes/game/endings/McDonald/McDonald's.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")

func _on_straight_pressed():
	Global.encounters.append("2")
	if(random_index == 2):
		get_tree().change_scene_to_file("res://scenes/game/endings/McDonald/McDonald's.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")
