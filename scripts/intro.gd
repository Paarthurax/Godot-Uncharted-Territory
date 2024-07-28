extends Node2D

@onready var cat = $"Cat"
static var has_visited_scene: bool
func _ready():
	print("Global has_visited_scene:", has_visited_scene)
	if has_visited_scene:
		cat.hide()
	else:
		has_visited_scene = true
	print("Cat visibility:", cat.visible)

func _process(delta):
	pass

func _on_back_pressed():
	print("Back pressed, changing scene...")
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
