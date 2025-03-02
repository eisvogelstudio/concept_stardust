extends Area2D


func _ready() -> void:
	$"PlanetName".text = get_parent().planet_name 
	$"PlanetControl".text = get_parent().planet_control 
