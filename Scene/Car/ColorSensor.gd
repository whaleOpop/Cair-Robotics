extends Node3D

class_name ColorSensor

var sensors: Array[RayCast3D] = []

func _ready():
	for i in get_children():
		if i is RayCast3D:
			sensors.append(i)
	pass 


func change_sensor_color(sensor, color):
	
	pass

func get_sensor_color(sensor):
	if sensor.is_colliding():
		var col = sensor.get_collider()
		if col and col.has_method("_get_color"):
				return col._get_color()
	return null

	
func _process(delta):
	pass
