extends Area2D
var planet_type_names = ["Rural", "City", "Lava", "Ice"]
var planet_menu_fleetpanel_scene = preload("res://scenes/planet_menu_fleetpanel.tscn")

func _ready() -> void:
	$"PlanetName".text = get_parent().planet_name 
	$"PlanetControl".text = get_parent().planet_control 
	$"PlanetType".text = planet_type_names[get_parent().planet_type] 

	

func _process(delta: float) -> void:
	
	create_fleet_panels()
	
	pass

func create_fleet_panels():
	var start_y = -350  # Anfangskoordinate Y
	var y_offset = 275  # Y-Abstand zwischen den Panels (negativ verschieben)
	var x_start = 430  # Startwert für X der ersten Flotte
	var x_offset = -80  # X-Abstand zwischen den Panels (+275 pro Panel)
	var planet_menu_fleetpanel_count = get_parent().fleetlist.size()
	
	for i in range(planet_menu_fleetpanel_count):
		var fleet_panel = planet_menu_fleetpanel_scene.instantiate()  # Neues Panel instanziieren
		var y_pos = start_y + (i * y_offset)  # Neue Y-Koordinate berechnen (mit -90 Verschiebung)
		var x_pos = x_start + (i * x_offset)  # Neue X-Koordinate berechnen (+275 pro Panel)

		# Setze die Position des Panels
		fleet_panel.position = Vector2(x_pos, y_pos)
		add_child(fleet_panel)  # Panel zum Node hinzufügen
