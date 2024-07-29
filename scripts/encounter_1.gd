extends Node2D

var pressed = 0
var elapsed_time_countdown = 2.0
var first = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time_countdown -= 0.009
	if elapsed_time_countdown < 0:
	# Stop the audio playback
		$AudioStreamPlayer.stop()
func _on_bet_button_pressed():
	pressed += 1
	if(pressed < 3):
		$"Lucky 7_1".visible = true
		$"Lucky 7_2".visible = true
		$"Lucky 7_3".visible = true
		$Zimba.visible = false
		$AudioStreamPlayer.stream = load("res://sounds/Coins Drop Sound Effect (HD).mp3")
		elapsed_time_countdown = 5
		$AudioStreamPlayer.play()
	else:
		$"Lucky 7_1".visible = true
		$"Lucky 7_2".visible = true
		$"Lucky 7_3".visible = false
		$Zimba.visible = true
		$AudioStreamPlayer.stream = load("res://sounds/Lets Go Gambling.mp3")
		$"Bet_Button".visible = false
		$AudioStreamPlayer.play()
		$AudioStreamPlayer.seek(10.8)
		elapsed_time_countdown = 0.96
		$Name.text = "By Zimba"



func _on_leave_pressed():
	Global.encounters.append("1")
	get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")



