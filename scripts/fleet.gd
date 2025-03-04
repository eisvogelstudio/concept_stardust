class_name Fleet

var fleet_name = "UNKOWN"
var fleet_shipcount = 0
var ships = []

func _init(name: String, shipcount: int, ships_list: Array) -> void:
	fleet_name = name
	fleet_shipcount = shipcount
	ships = ships_list
