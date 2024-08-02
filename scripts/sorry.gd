extends Node2D

var grow = false
var growth_speed: float = 0.035
# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.has_gun):
		$Mistake.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(grow):
		$Paarthurax.scale -= Vector2(-growth_speed, growth_speed) * delta


func _on_leave_pressed():
	$Leave.visible = false
	$Leave2.visible = false
	$Arrow1.visible = true
	$Right.visible = true
	$Paarthurax.texture = load("res://images/characters/Paarthurax/Kirby-happy.png")
	$PaarthText.text = "Safe travels!"


func _on_right_pressed():
	Global.encounters.append("4")
	get_tree().change_scene_to_file("res://scenes/game/search_forest/scaryforest.tscn")


func _on_mistake_pressed():
	$Leave.visible = false
	$Leave2.visible = false
	$Arrow1.visible = false
	$Right.visible = false
	$Mistake.visible = false
	$ColorRect.color = Color(0, 0, 0, 1)
	$Paarthurax.texture = load("res://images/characters/Paarthurax/kirby-gun.png")
	$PaarthText.text = "I Guess Sorry Was Not Enough..."
	Global.description = "Hihi, better start over again"
	Global.victim = str(Global.namePlayer)
	grow = true
	
	$"Sweet Grace".play()
	$Timer.start()


func _on_timer_timeout():
	#GetshotEffect
	#GetDisplayedOnTombstone
	get_tree().change_scene_to_file("res://scenes/game/endings/Tombstone/tombstone.tscn")
