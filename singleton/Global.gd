extends Node

var namePlayer = null
var perk = null
var death_count := 0
var money := 15
var endings := [0,0,0]
var has_visit_scene := false
var current_scene = null
var forest_walk :int = 0
var encounters = []
var has_gun: bool = false
var romanian: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Global singleton is ready.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
