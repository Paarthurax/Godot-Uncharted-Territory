extends Node2D

var transparency = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	load_and_rescale_texture("res://images/encounters/LeadingUpTo/JoshuaDudleyGreer_10.webp")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(str($"White".color))
	if(!$TimerWhite.is_stopped()):
		transparency += delta*0.2
		$"White".color = Color(1,1,1, 0 + transparency)
		print(str($"White".color))

func _on_straight_pressed():
	var current_texture_path = "res://images/encounters/LeadingUpTo/JoshuaDudleyGreer_10.webp"
	var next_texture_path = "res://images/encounters/LeadingUpTo/path-is-a-dirt-road-that-leads-up-the-hill-straight-ahead-background-of-two-side-with-bamboo-and-banana-trees-and-blurred-of-green-forest-free-photo.jpg"
	var final_texture_path = "res://images/encounters/LeadingUpTo/McDonald's.webp"
	
	if $Background.texture == load(current_texture_path):
		load_and_rescale_texture(next_texture_path)
	elif $Background.texture == load(next_texture_path):
		load_and_rescale_texture(final_texture_path)
	else:
		$Arrow.visible = false
		$White.visible = true
		$TimerWhite.start()



func load_and_rescale_texture(texture_path: String):
	var texture = load(texture_path)
	$Background.texture = texture
	var desired_size = Vector2(1152, 647)
	var texture_size = texture.get_size()
	var scale = Vector2(desired_size.x / texture_size.x, desired_size.y / texture_size.y)
	$Background.scale = scale

func _on_timer_white_timeout():
	get_tree().change_scene_to_file("res://scenes/game/endings/McDonald/McDonald's.tscn")
