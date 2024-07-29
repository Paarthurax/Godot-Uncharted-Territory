extends Node2D

@onready var streamPlayer: AudioStreamPlayer = $Walking
@onready var forestPlayer: AudioStreamPlayer = $ForestNoise
@onready var background: Sprite2D = $Background

static var forest_walk := 0

func _ready():
	Global.current_scene = ""
	forestPlayer.play()
	forest_walk += 1
	print(str(Global.encounters.size()))
	if(Global.encounters.size() < 3):
		randomBackground()
	else:
		print("Exit to McDonald's")
	play_last_seconds(3)

func play_last_seconds(seconds: float):
	var duration_to_play_from_end = seconds
	var total_length = streamPlayer.stream.get_length()
	
	if seconds > total_length:
		duration_to_play_from_end = total_length
	
	var start_position = total_length - duration_to_play_from_end
	
	streamPlayer.stop()  # Ensure the player is stopped before seeking
	streamPlayer.seek(start_position)
	streamPlayer.play()

func randomBackground():
	var new_background_name = ""
	var rand = RandomNumberGenerator.new()
	rand.randomize()

	# Ensure the new background is different from the current one
	while new_background_name == Global.current_scene or new_background_name == "":
		new_background_name = "res://images/forest/unsettling_forest_" + str(rand.randi_range(1, 7)) + ".jpg"
	
	var new_texture = load(new_background_name)
	background.texture = new_texture
	
	var desired_size = Vector2(1152, 647)
	var texture_size = new_texture.get_size()
	var scale = Vector2(desired_size.x / texture_size.x, desired_size.y / texture_size.y)
	background.scale = scale
	Global.current_scene = new_background_name

func randomArrows():
	var arrow_buttons = ["Right", "Left", "Straight"]
	var arrow_images = ["ArrowRight", "ArrowLeft", "ArrowStraight"]
	var num_arrows = arrow_buttons.size()
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	# Ensure at least one arrow is shown
	var at_least_one_visible = false
	for i in range(num_arrows):
		var button = get_node(arrow_buttons[i])
		var image = get_node(arrow_images[i])
		if rand.randf() < 0.8:
			button.visible = true
			image.visible = true
			at_least_one_visible = true
		else:
			button.visible = false
			image.visible = false
	
	# Make sure at least one arrow is visible
	if not at_least_one_visible:
		var index = rand.randi_range(0, num_arrows - 1)
		get_node(arrow_buttons[index]).visible = true
		get_node(arrow_images[index]).visible = true

func FourToFive():
	var rand = RandomNumberGenerator.new()
	rand.randomize()

	if rand.randf() < 0.5 or forest_walk >= 5:
		print("Load a new scene")
		# Reset forest_walk and load a new scene
		forest_walk = 0
		get_tree().change_scene_to_file("res://scenes/game/encounters/encounter_1.tscn")  # Update with your actual new scene path
	else:
		forest_walk += 1
		randomBackground()
		randomArrows()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	if forest_walk > 3:
		FourToFive()
	else:
		forest_walk += 1
		randomBackground()
		randomArrows()
