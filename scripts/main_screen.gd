extends Control

var audio_player: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = $AudioStreamPlayer  # Assuming the AudioStreamPlayer node is a direct child of this node
	if not audio_player.is_playing():
		audio_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not audio_player.is_playing():
		audio_player.play()


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn");


func _on_exit_pressed():
	get_tree().quit();


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/game/nameperks.tscn");


func _on_intro_pressed():
	get_tree().change_scene_to_file("res://scenes/intro.tscn");
