extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	update_endings()
	$RestaurantNoises.play()
	if(Global.money < 10):
		$Zimburger.visible = false
		$QuestionLabel.text = "You had less than $10. No Zimburger for you."
	if(!Global.encounters.has("4")):
		$Koopa.visible = false
		$MostDeaf.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_secret_button_pressed():
	if(Global.money < 100):
		$QuestionLabel.text = "You had less than $100. No secret sauce."
	else:
		get_tree().change_scene_to_file("res://scenes/game/endings/Secret/Secret.tscn")

func update_endings():
	if Global.has_gun:
		Global.endings[0] = 1
	if Global.romanian:
		Global.endings[1] = 1
	if Global.koopa_badge:
		Global.endings[2] = 1

func _on_left_pressed():
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
