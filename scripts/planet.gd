extends Area2D

enum planet_types {Rural, City, Lava, Ice}

@export var planet_name : String
@export var planet_control : String
@export var planet_type : planet_types


var fleetlist = []
var Fleet = load("res://scripts/fleet.gd")

var iszoomed = false

func _ready() -> void: 
	fleetlist.append(Fleet.new("Tango-Flotte", 1, ["ISD-1234"]))
	fleetlist.append(Fleet.new("Delta-Flotte", 2, ["X-Wing", "Y-Wing"]))
	fleetlist.append(Fleet.new("Lima-Flotte", 7, ["ISD-3325", "ISD-9843", "ISD-7622", "Gozanti-6659", "Gozanti-9421", "Victory-3353", "Victory-3677"]))
	$planet_menu_main.visible = false
	$AnimatedSprite2D.frame = planet_type
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("interact_main"):
		var cam = $"../../Camera2D"
		
		
		# Tween erstellen und starten
		if iszoomed == false:
			var tween = cam.create_tween()
			tween.tween_property(cam, "position", position, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(cam, "zoom", Vector2(0.2, 0.2), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			iszoomed = true
			
			await tween.finished
			cam.cameracontrol = false
			cam.position = position
			$planet_menu_main.visible = true
		else:
			iszoomed = false
			cam.cameracontrol = true
			cam.position = position
			$planet_menu_main.visible = false
		
		
