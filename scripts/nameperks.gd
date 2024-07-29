extends Node2D

@onready var choiceContainer: Container = $ChoiceContainer
@onready var info_label: Label = $info_label

var checkbox_descriptions = {
	"Bone B Gun": "You get a gun (you can shoot up to 3 creatures)",
	"Hell Ygar Skill": "You can speak a cursed language",
	"Koo Pa Coin": "You start with 5000 dollars instead of 5"
}

func _ready():
	# Display the description of the first button initially
	if choiceContainer.get_child_count() > 0:
		var first_button = choiceContainer.get_child(0)
		if first_button is Button:
			var first_button_text = first_button.text
			print("First button text: " + first_button_text)
			update_label(first_button_text)

func _input(event):
	# Check if the event is a mouse button click
	if event is InputEventMouseButton and event.pressed:
		# Get the mouse position
		var mouse_pos = event.position

		# Loop through each button to check if the mouse click was on it
		for button in choiceContainer.get_children():
			if button is Button and button.get_global_rect().has_point(mouse_pos):
				# Update the label based on the button's text
				update_label(button.text)
				print(button.text)
				Global.perk = button.text
				break

func update_label(button_text):
	# Update the info label with the corresponding description
	if button_text in checkbox_descriptions:
		info_label.text = checkbox_descriptions[button_text]
	else:
		info_label.text = "Congrats! You broke the game!"


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")


func _on_continue_pressed():
	if(Global.perk == "Bone B Gun"):
		Global.has_gun = true
	elif(Global.perk == "Hell Ygar Skill"):
		Global.romanian = true
	elif(Global.perk == "Koo Pa Coin"):
		Global.money == 5000
	else:
		Global.has_gun = true
		Global.perk = "Bone B Gun"
	if($Name.text == ""):
		Global.namePlayer = "The one with no name"
	else:
		Global.namePlayer = $Name.text
	get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")


func _on_name_text_changed():
	var cursor_position = $Name.get_caret_column()
	var line_position = $Name.get_caret_line()
	
	
	if $Name.get_text().length() > 18:
		var text = $Name.text.substr(0, 18)
		$Name.text = text
		$Name.set_caret_column(18)
		$Name.set_caret_line(18)
		 
