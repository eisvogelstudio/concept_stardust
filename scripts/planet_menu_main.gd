extends Area2D
var planet_type_names = ["Rural", "City", "Lava", "Ice"]
var planet_menu_fleetpanel_scene = preload("res://scenes/planet_menu_fleetpanel.tscn")
var fleetpanels = []

var scroll = 0


func _ready() -> void:
	$"PlanetName".text = get_parent().planet_name 
	$"PlanetControl".text = get_parent().planet_control 
	$"PlanetType".text = planet_type_names[get_parent().planet_type] 
	create_fleet_panels()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_down") && $"../../../Camera2D".cameracontrol == false && visible == true:
		scroll -= 0.3
	
	if Input.is_action_just_pressed("scroll_up") && $"../../../Camera2D".cameracontrol == false && visible == true && scroll <= -0.3:
		scroll += 0.3
	
	
	
	update_fleet_panels()
	
	
	pass

func create_fleet_panels():
	var start = Vector2(430, -350)
	var offset = Vector2(-80, 275)
	var planet_menu_fleetpanel_count = get_parent().fleetlist.size()
	
	for i in range(planet_menu_fleetpanel_count):
		var fleet_panel = planet_menu_fleetpanel_scene.instantiate()  # Neues Panel instanziieren
		var pos = start +(i * offset)
		
		fleet_panel.position = pos
		add_child(fleet_panel)  # Panel zum Node hinzufügen
		fleet_panel.panel_number = i
		fleet_panel.add_panel_info()
		fleetpanels.append(fleet_panel)

func update_fleet_panels():
	if fleetpanels.size() == 0:
		return
	var start = Vector2(430, -350)
	var direction = Vector2(-80, 275)
	var planet_menu_fleetpanel_count = get_parent().fleetlist.size()

	for i in range(planet_menu_fleetpanel_count):
		fleetpanels[i].position = start + (i + scroll) * direction

func delete_fleet_panels():
	for panel in fleetpanels:
		panel.queue_free()  # Löscht das Panel
	fleetpanels.clear()  # Leert die Liste der Panels
	pass
