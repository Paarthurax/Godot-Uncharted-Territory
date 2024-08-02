extends Node

var namePlayer = null
var perk = "Bone B Gun"
var money := 10
var endings := [0,0,0]
var description = null
var current_scene = null
var victim = null
var forest_walk :int = 0
var encounters = []
var has_gun: bool = false
var romanian: bool = false
var koopa_badge: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Global singleton is ready.")

func resetStats():
	current_scene = null
	namePlayer = null
	description = null
	victim = null
	money = 10
	forest_walk = 0
	encounters = []
	has_gun = false
	romanian = false
	koopa_badge = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
