extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Victim.text = Global.victim
	$Description.text = Global.description
	if(str(Global.victim) == str(Global.namePlayer)):
		$MoveOn.visible = false
		$MoveOnArrow.visible = false
		$ExitArrow.visible = true
		$Exit.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_move_on_pressed():
	get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
