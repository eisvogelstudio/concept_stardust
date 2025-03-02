extends Camera2D

const camspeed = 500
const zoomspeed = 0.005  # Kleinere Werte für sanfteres Zoomen
const maxzoom = 0.2
const minzoom = 0.01
const camrestrictionright = 40000
const camrestrictionleft = -40000
const camrestrictionup = 40000
const camrestrictiondown = -40000

var recentclicks = 0


func _process(delta: float) -> void:
	
	# Bewegung der Kamera mit Begrenzung
	var updown := Input.get_axis("cam_up", "cam_down")
	var leftright := Input.get_axis("cam_left", "cam_right")
	
	# Dynamische Anpassung der Bewegungsgeschwindigkeit basierend auf dem Zoom
	var adjusted_speed = camspeed * (1 / zoom.x)  # Je kleiner der Zoomwert, desto schneller die Kamera

	if updown:
		position.y = clamp(position.y + updown * adjusted_speed * delta, camrestrictiondown, camrestrictionup)
	
	if leftright:
		position.x = clamp(position.x + leftright * adjusted_speed * delta, camrestrictionleft, camrestrictionright)

	# Zoom der Kamera mit Begrenzung, jetzt durch Action-Events
	if Input.is_action_just_pressed("zoom_out"):
		var new_zoom = zoom.x - zoomspeed  # Ranzoomen
		new_zoom = clamp(new_zoom, minzoom, maxzoom)  # Begrenze den Zoom
		zoom = Vector2(new_zoom, new_zoom)  # X und Y synchron ändern
	
	if Input.is_action_just_pressed("zoom_in"):
		var new_zoom = zoom.x + zoomspeed  # Herauszoomen
		new_zoom = clamp(new_zoom, minzoom, maxzoom)  # Begrenze den Zoom
		zoom = Vector2(new_zoom, new_zoom)  # X und Y synchron ändern
	
		
	
	
	if Input.is_action_just_pressed("interact_main"):
		recentclicks += 1
		$DoubleClick.start(0.3)
		if recentclicks == 2:
			zoomonmouse()




func _on_double_click_timeout() -> void:
	recentclicks = 0

const zoom_speed = 0.005  # Geschwindigkeit der Zoom-Interpolation
const move_speed = 5000  # Geschwindigkeit der Positions-Interpolation
const threshold = 5  # Der Abstand, bei dem die Kamera als am Ziel angekommen betrachtet wird

func zoomonmouse():
	var target_position = get_global_mouse_position()  # Zielposition der Maus
	position = target_position  # Sofort die Kamera auf die Zielposition setzen
	zoom = Vector2(0.2, 0.2)  # Sofortigen Zoom auf den gewünschten Wert setzen
