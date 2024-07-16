extends Node3D

class_name ColorSensor

var sensors: Array[RayCast3D] = []

func _ready():
	for i in get_children():
		if i is RayCast3D:
			sensors.append(i)
	pass 

func get_color_state():
	var color_state:Array[Color]=[Color(255,255,255,255)]
	for sensor in sensors:
		var state = get_sensor_color(sensor)
		if state:
			color_state[0]=state
			change_sensor_color(sensor, state)
	return color_state

	
func change_sensor_color(sensor, color):
	
	if color:
		sensor.get_child(0).get("material_override").set("albedo_color",color)
	pass

func get_sensor_color(sensor):
	if sensor.is_colliding():
		var col = sensor.get_collider()
		if col and col.has_method("_get_color"):
				return col._get_color()
	return null

	
func _process(delta):
	pass
