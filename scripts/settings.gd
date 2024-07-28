extends Node2D

var audio_player
var volume_slider

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = $AudioStreamPlayer
	volume_slider = $MarginContainer/CenterContainer/ButtonContainer/HBoxContainer/Volume  # Replace with the actual path to your slider node
	var master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	volume_slider.value = master_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_volume_value_changed(value):
	if(value <= -20):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -120)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_sound_test_pressed():
	audio_player.play()
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
