extends Node2D

@onready var _animated_sprite = $Thief
var growth_speed: float = 0.1
var original_modulate : Color
var moving = true
var rob = false
var flee = false
var dead = false
var count  = 0
var click = 0
var stolenMoney = -5
var poor = false
var nextScene = "res://scenes/game/search_forest/scaryforest.tscn"
var funeralScene
var description = "We could never understand what he was saying"
var nameVictim = "Yell Ygar"
# Called when the node enters the scene tree for the first time.
func _ready():
	original_modulate = _animated_sprite.modulate
	if(Global.money < 5):
		poor = true
		stolenMoney = 15 - Global.money
		$QuestionLabel.text = "The man in the woods wants to give you \n something. Do you accept?"
	if(Global.romanian):
		$Greetings.visible = true
	_animated_sprite.play("default")
	$MoveOn.visible = false
	$MoveOnArrow.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dead):
		_animated_sprite.stop()
		rob = false
		flee = false
		moving = false
		_animated_sprite.rotation = -30
	
	elif(click >= 20):
		flee = true
		rob = false
		moving = false
		$QuestionLabel.text = "He is fleeing."
		if(click >= 30):
			dead = true
			$QuestionLabel.text = "Uhoh..."
			$MoveOn.visible = true
			$MoveOnArrow.visible = true
	if(rob || flee && !dead):
		if(_animated_sprite.scale.x > 0 && _animated_sprite.scale.y > 0):
			_animated_sprite.scale -= Vector2(growth_speed, growth_speed) * delta * 2
		else:
			_animated_sprite.visible = false
			$StopButton.visible = false
			$Greetings.visible = false
			if(rob && !flee):
				if(poor):
					$QuestionLabel.text = "He gave you " + str(stolenMoney) + " dollars!"
				else:
					$QuestionLabel.text = "He stole " + str(stolenMoney) + " dollars from you!"
				Global.money += stolenMoney
			else:
				$QuestionLabel.text = "You scared the thief away."
			$MoveOn.visible = true
			$MoveOnArrow.visible = true
	
	elif(moving):
		if(count < 1000):
			_animated_sprite.scale += Vector2(growth_speed, growth_speed) * delta
		else:
			rob = true
			moving = false
			$Greetings.visible = false
			Global.money -= stolenMoney
	

	else:
		_animated_sprite.stop()
	count += 1

func _on_greetings_pressed():
	moving = false
	rob = false
	flee = false
	$Greetings.visible = false
	$QuestionLabel.text = "Oh! It is your brother Yell Ygar."
	$Wealth.visible = true
	$Wisdom.visible = true
	$"Big Booty".visible = true
	$"ThiefText".visible = true


func _on_stop_button_pressed():
	if(!dead):
		_animated_sprite.self_modulate = Color(227.0, 0.0, 0.0, 255.0)
		$Timer.start()
		click += 1



func _on_move_on_pressed():
	Global.encounters.append("3")
	get_tree().change_scene_to_file(nextScene)
	print(str(Global.encounters))


func _on_timer_timeout():
	_animated_sprite.self_modulate = original_modulate


func _on_wealth_pressed():
	$Wealth.visible = false
	$Wisdom.visible = false
	$"Big Booty".visible = false
	$MoveOn.visible = true
	$MoveOnArrow.visible = true
	Global.encounters.append("3")
	$ThiefText.text =  "<Thou will findeth Donald's Mac soon!>"

func _on_wisdom_pressed():
	$Wealth.visible = false
	$Wisdom.visible = false
	$"Big Booty".visible = false
	$MoveOn.visible = true
	$MoveOnArrow.visible = true
	$ThiefText.text =  "<Zimba can be slain. Allergic to bullets, content and clicks.>"
	
func _on_big_booty_pressed():
	$Wealth.visible = false
	$Wisdom.visible = false
	$"Big Booty".visible = false
	$MoveOn.visible = true
	$MoveOnArrow.visible = true
	Global.money += 5
	$ThiefText.text =  "<Here! Thou now hast $" + str(Global.money) + ". What did thou expect?>"
