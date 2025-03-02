extends Area2D
@export var planet_name : String
@export var planet_control : String
var fleetlist = []
var Fleet = load("res://scripts/fleet.gd")

func _ready() -> void: 
	fleetlist.append(Fleet.new("Tango-Flotte", 1, ["ISD-1234"]))
	fleetlist.append(Fleet.new("Delta-Flotte", 2, ["X-Wing", "Y-Wing"]))
	
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("interact_main"):
		print("Klick auf CollisionShape2D registriert!")
