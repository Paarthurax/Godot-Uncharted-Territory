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
