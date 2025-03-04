extends Area2D
var planet_type_names = ["Rural", "City", "Lava", "Ice"]

func _ready() -> void:
	$"PlanetName".text = get_parent().planet_name 
	$"PlanetControl".text = get_parent().planet_control 
	$"PlanetType".text = planet_type_names[get_parent().planet_type] 
