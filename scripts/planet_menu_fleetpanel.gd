extends Node2D
var panel_number


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if position.y < -470 || position.y > 490:
		visible = false
	else:
		visible = true 

func add_panel_info():
	$PanelNumber.text = str(panel_number + 1)
	$FleetName.text = get_parent().get_parent().fleetlist[panel_number].fleet_name
	$FleetShipCount.text = str(get_parent().get_parent().fleetlist[panel_number].fleet_shipcount)
	pass
