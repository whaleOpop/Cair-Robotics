extends Node

class_name LineSensor

var sensors: Array[RayCast3D] = []

var white = Color.WHITE
var black = Color.BLACK

var white_material: StandardMaterial3D = load("res://Scene/Car/Material/white_transperent.tres") as StandardMaterial3D
var black_transperent: StandardMaterial3D = load("res://Scene/Car/Material/black_transperent.tres") as StandardMaterial3D


func _ready():
	for i in get_children():
		sensors.append(i)

func get_line_state():
	var line_state = []
	for sensor in sensors:
		var state = get_sensor_state(sensor)
		line_state.append(state)
		change_sensor_color(sensor, state)
	return line_state

func change_sensor_color(sensor, state):
	
	if state == 1:
		sensor.get_child(0).set("material_override", white_material)
	else:
		sensor.get_child(0).set("material_override", black_transperent)
		
		
	

func get_sensor_state(sensor):
	if sensor.is_colliding():
		var col = sensor.get_collider()
		if col and col.has_method("_get_color"):
			if col._get_color() == white:
				return 1
			elif col._get_color() == black:
				return 0
	return 0
