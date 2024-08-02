extends Node2D

var toggle = false
var timesShot = 0
var EnglishText = [
	"Go right here",
	"Go left here",
	"Go back"
]

var RomanianText = [ "Du-te la stânga aici", "Du-te chiar aici", "Întoarce-te"]

var random_index

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.has_gun):
		$Gun.visible = true
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


func _on_gun_pressed():
	$Right.visible = false
	$Straight.visible = false
	$Left.visible = false
	$Arrow1.visible = false
	$Arrow2.visible = false
	$Arrow3.visible = false
	$AudioStreamPlayer.stop()
	$GunShoot.visible = true
	$GunTimer.start()


func _on_right_pressed():
	Global.encounters.append("2")
	if(random_index == 0):
		get_tree().change_scene_to_file("res://scenes/game/endings/LeadingUpTo.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")

func _on_left_pressed():
	Global.encounters.append("2")
	if(random_index == 1):
		get_tree().change_scene_to_file("res://scenes/game/endings/LeadingUpTo.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")

func _on_straight_pressed():
	Global.encounters.append("2")
	if(random_index == 2):
		get_tree().change_scene_to_file("res://scenes/game/endings/LeadingUpTo.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")


func _on_gun_timer_timeout():
	$WhiteBlackScreen.visible = true
	$AudioStreamPlayer.stream = load("res://sounds/AR-15 Sound Effect.mp3")
	Global.description = "Last words: The road to McDonald's is..."
	Global.victim = "Here lies: Poor road sign"
	$LightDark.start()


func _on_light_dark_timeout():
	$AudioStreamPlayer.play()
	if(!toggle):
		$WhiteBlackScreen.color = Color(1, 1, 1, 1)
		toggle = !toggle
	else:
		$WhiteBlackScreen.color = Color(0, 0, 0, 1)
		toggle = !toggle
	if(timesShot > 3):
		Global.encounters.append("2")
		get_tree().change_scene_to_file("res://scenes/game/endings/Tombstone/tombstone.tscn")
	else:
		timesShot += 1
		$LightDark.start()
