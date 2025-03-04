extends Camera2D

const camspeed = 500
const zoomspeed = 0.01  # Kleinere Werte für sanfteres Zoomen
const maxzoom = 0.2
const minzoom = 0.01
const camrestrictionright = 40000
const camrestrictionleft = -40000
const camrestrictionup = 40000
const camrestrictiondown = -40000

var recentclicks = 0
var cameracontrol = true


func _process(delta: float) -> void:
	
	# Bewegung der Kamera mit Begrenzung
	var updown := Input.get_axis("cam_up", "cam_down")
	var leftright := Input.get_axis("cam_left", "cam_right")
	
	# Dynamische Anpassung der Bewegungsgeschwindigkeit basierend auf dem Zoom
	var adjusted_speed = camspeed * (1 / zoom.x)  # Je kleiner der Zoomwert, desto schneller die Kamera

	if updown && cameracontrol == true:
		position.y = clamp(position.y + updown * adjusted_speed * delta, camrestrictiondown, camrestrictionup)
	
	if leftright && cameracontrol == true:
		position.x = clamp(position.x + leftright * adjusted_speed * delta, camrestrictionleft, camrestrictionright)

	# Zoom der Kamera mit Begrenzung, jetzt durch Action-Events
	if Input.is_action_just_pressed("zoom_out") && cameracontrol == true:
		var new_zoom = zoom.x - zoomspeed  # Ranzoomen
		new_zoom = clamp(new_zoom, minzoom, maxzoom)  # Begrenze den Zoom
		zoom = Vector2(new_zoom, new_zoom)  # X und Y synchron ändern
	
	if Input.is_action_just_pressed("zoom_in") && cameracontrol == true:
		var new_zoom = zoom.x + zoomspeed  # Herauszoomen
		new_zoom = clamp(new_zoom, minzoom, maxzoom)  # Begrenze den Zoom
		zoom = Vector2(new_zoom, new_zoom)  # X und Y synchron ändern
	
		
	
	
	if Input.is_action_just_pressed("interact_main"): #Doppelklick Detection
		recentclicks += 1
		$DoubleClick.start(0.3)
		if recentclicks == 2:
			zoomonmouse()

func _on_double_click_timeout() -> void: #Doppelklick Detection
	recentclicks = 0


var dragging := false
var last_mouse_position := Vector2()

func _input(event): #Kamera dragging mit der Maus
	if event is InputEventMouseButton && cameracontrol == true:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			dragging = event.pressed
			last_mouse_position = event.position
	elif event is InputEventMouseMotion and dragging && cameracontrol == true:
		var delta: Vector2 = (last_mouse_position - event.position) * (camspeed * 0.010) * (1/zoom.x)
		position += delta
		position.x = clamp(position.x, camrestrictionleft, camrestrictionright)
		position.y = clamp(position.y, camrestrictiondown, camrestrictionup)
		last_mouse_position = event.position






const zoom_speed = 0.005  # Geschwindigkeit der Zoom-Interpolation
const move_speed = 5000  # Geschwindigkeit der Positions-Interpolation
const threshold = 5  # Der Abstand, bei dem die Kamera als am Ziel angekommen betrachtet wird

func zoomonmouse():
	if cameracontrol == true:
		var tween = create_tween()
		var target_position = get_global_mouse_position()  # Zielposition der Maus
		var target_zoom = Vector2(0.2, 0.2)  # Zielzoom-Wert
		
		# Bewege die Kamera zur Zielposition und ändere gleichzeitig den Zoom
		tween.tween_property(self, "position", target_position, 1.0)  # Bewege die Kamera
		tween.tween_property(self, "zoom", target_zoom, 1.0)  # Ändere den Zoom
		
		# Setze die Übergangstypen (für beide Animationen)
		tween.set_trans(Tween.TRANS_LINEAR)  # Übergangstyp setzen
		tween.set_ease(Tween.EASE_IN_OUT)    # Ease setzen
