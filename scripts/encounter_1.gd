extends Node2D

var pressed = 0
var elapsed_time_countdown = 2.0
var first = true

var symbol_paths = [
	"res://images/encounters/casino_encounter_1/symbols/cherry-logo-icon.png",
	"res://images/encounters/casino_encounter_1/symbols/diamond-icon.png",
	"res://images/encounters/casino_encounter_1/symbols/lucky-7-icon.png"
]

var desired_scale_normal = Vector2(0.139, 0.204)
var desired_scale_strong = Vector2(0.139/5, 0.204/5)
var desired_scale: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	$"Symbol_1".visible = false
	$"Symbol_2".visible = false
	$"Symbol_3".visible = false

	$CurrentMoney.text = "Current amount of money:\n$" + str(Global.money)
	if Global.money <= 0:
		$Bet_Button.visible = false
		$GambleMoney.visible = false
		$InfotextSpin.visible = false
	
	else:
		$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time_countdown -= 0.009
	if elapsed_time_countdown < 0:
	# Stop the audio playback
		$AudioStreamPlayer.stop()
func _on_bet_button_pressed():
	pressed += 1
	var random_index = randi() % symbol_paths.size()
	var chosen_symbol_path = symbol_paths[random_index]
	if(random_index == 2):
		desired_scale = desired_scale_normal
	else:
		desired_scale = desired_scale_strong
	# Load the texture
	var chosen_texture = load(chosen_symbol_path)
	
	assign_texture_to_symbol($"Symbol_1", chosen_texture)
	assign_texture_to_symbol($"Symbol_2", chosen_texture)
	assign_texture_to_symbol($"Symbol_3", chosen_texture)
	
	if(pressed < 3):
		Global.money += int($GambleMoney.text)
		$"Symbol_1".visible = true
		$"Symbol_2".visible = true
		$"Symbol_3".visible = true
		$Zimba.visible = false
		$AudioStreamPlayer.stream = load("res://sounds/Coins Drop Sound Effect (HD).mp3")
		elapsed_time_countdown = 5
		$AudioStreamPlayer.play()
	else:
		Global.money -= int($GambleMoney.text)
		_on_gamble_money_text_changed()
		$"Symbol_1".visible = true
		$"Symbol_2".visible = true
		$"Symbol_3".visible = false
		$Zimba.visible = true
		$AudioStreamPlayer.stream = load("res://sounds/Lets Go Gambling.mp3")
		$"Bet_Button".visible = false
		$GambleMoney.visible = false
		$InfotextSpin.visible = false
		$AudioStreamPlayer.play()
		$AudioStreamPlayer.seek(10.8)
		elapsed_time_countdown = 0.96
		$Name.text = "By Zimba"
		
	$CurrentMoney.text = "Current amount of money:\n$" + str(Global.money)

func assign_texture_to_symbol(symbol, texture):
	symbol.texture = texture
	symbol.scale = desired_scale

func _on_leave_pressed():
	Global.encounters.append("1")
	print(str(Global.encounters))
	get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")


func _on_gamble_money_text_changed():
	var text = $GambleMoney.text
	var filtered_text = ""
	
	# Filter out all non-numeric characters
	for character in text:
		if character >= '0' and character <= '9':
			filtered_text += character
	
	var number = int(filtered_text)
	if Global.money <= 0:
		$Bet_Button.visible = false
		$GambleMoney.visible = false
		$InfotextSpin.visible = false
	# Ensure the number is below Global.money and not below 0
	elif number > Global.money:
		number = Global.money

	elif number <= 0:
		number = 1
	
	# Update the text with the filtered and validated number
	$GambleMoney.text = str(number)



